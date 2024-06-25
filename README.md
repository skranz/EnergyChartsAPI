# Simple R Wrapper to https://api.energy-charts.info/

Date: 2024-06-25

This package provides a simple R wrapper to the EnergyCharts API described here https://api.energy-charts.info/. Energy Charts is a great website and its API provides convinient access to a variety of energy data, including electricity generation, consumption, and prices. 

If have tested the package so far only for the endpoints: "public_power", "total_power" and "price" using the API version 1.3

## Usage Example

```r
library(EnergyChartsAPI)


power_dat = energy_charts_get_data("public_power", country="de", start = "2024-01-01",end="2024-01-01")


price_dat = energy_charts_get_data("price", start = "2024-01-01",end="2024-01-01", bzn="DE-LU")

```


## Installation
```
devtools::install_github("skranz/
```
