example = function() {
  energy_charts_get_data(start = "2024-06-15")
  price_dat = energy_charts_get_data("price", start = "2024-06-15")

  energy_charts_get_data("does_not_work", start = "2024-06-15")
}



#' Get data from the energy-charts.info API
#'
#' This function allows you to get data from the energy-charts.info API and return as data frame. See https://api.energy-charts.info/ for more information.
#'
#' @param endpoint The endpoint to use, e.g. "public_power". See  https://api.energy-charts.info/ for a list of end points.
#' @param country The country to get data for. Default is "de" (Germany).
#' @param start The start date for the data as a string, e.g. "2024-01-01"
#' @param end The end date for the data as a string, e.g. "2024-01-01". Default is today.
#' @param bzn The bidding zone to get data for. Default is "DE-LU" (Germany-Luxembourg) used for price data.
#' @param simplify If TRUE, the data is simplified to a data frame. If FALSE, the raw JSON is returned.

energy_charts_get_data = function(endpoint="public_power", country="de",start = NULL, end = as.character(Sys.Date()), bzn="DE-LU", simplify=TRUE) {
  library(httr)
  url = paste0("https://api.energy-charts.info")
  if (endpoint != "price") {
    query = list(country=country)
  } else {
    query = list(bzn=bzn)
  }
  if (!is.null(start)) {
    query$start = as.character(start)
  }
  if (!is.null(end)) {
    query$end = as.character(end)
  }

  url = paste0("https://api.energy-charts.info/", endpoint)
  response <- GET(url,query = query, add_headers(Accept = "application/json"))

  json = content(response, "text", encoding="UTF-8")
  res = jsonlite::fromJSON(json)
  res$status_code = response$status_code
  if (response$status_code >= 300) {
    if (!simplify) return(res)
    cat(paste0("\nError when trying to access api.energy-charts.info. Status code: ", res$status_code, " ", res$detail,"\n"))
    return(invisible(NULL))
  }
  res$country = country
  if (!simplify) return(res)
  energy_charts_simplify_results(res)
}

energy_charts_simplify_results = function(res) {
  #restorepoint::restore.point("energy_charts_simplify_results")
  date_time <- as.POSIXct(res$unix_seconds, origin = "1970-01-01")
  names(res)
  fields = setdiff(names(res), c("deprecated","unix_seconds","country","status_code","unit","license_info"))

  f = fields[[1]]
  dat = bind_cols(lapply(fields, function(f) {
    li = res[[f]]

    if (setequal(names(li), c("data","name"))) {
      dat = li$data
      names(dat) = li$name
      df = as.data.frame(dat,check.names = FALSE)
    } else {
      df = as.data.frame(res[f])
    }
    df
  }))
  all_dat = bind_cols(data.frame(date_time=date_time, country=res$country), dat)
  all_dat
}
