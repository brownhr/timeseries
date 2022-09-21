library(tidyverse)
library(zoo)
library(lubridate)

card_prices <- read_rds("https://assets.datacamp.com/production/repositories/6083/datasets/702f54c11ff894bc0180ad03a2b5e31a83438c69/card_prices.Rds")
card_prices['2013-09-25']

card_prices['2001-02-02']
