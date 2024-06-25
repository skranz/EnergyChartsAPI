
#' Get public power from the energy-charts.info API
#'
#' Simple wrapper to energy_charts_get_data using "public_power" as the endpoint.
#' @param ... Additional parameters to pass to energy_charts_get_data
energy_charts_get_public_power = function(...) {
 energy_charts_get_data(endpoint="public_power",...)
}



#' Get total power from the energy-charts.info API
#'
#' Simple wrapper to energy_charts_get_data using "total_power" as the endpoint.
#' @param ... Additional parameters to pass to energy_charts_get_data
energy_charts_get_total_power = function(...) {
 energy_charts_get_data(endpoint="total_power",...)
}



#' Get public power from the energy-charts.info API
#'
#' Simple wrapper to energy_charts_get_data using "public_power" as the endpoint.
#' @param ... Additional parameters to pass to energy_charts_get_data
energy_charts_get_price = function(bzn="DE-LU", ...) {
 energy_charts_get_data(endpoint="price",bzn=bzn,...)
}

