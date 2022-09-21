library(tidyverse)
library(zoo)
library(lubridate)


# Select first series from the dataset
card_prices <-
  read_rds(
    "https://assets.datacamp.com/production/repositories/6083/datasets/702f54c11ff894bc0180ad03a2b5e31a83438c69/card_prices.Rds"
  )[, 1]

bad_card_df <- data.frame(
  Index = format.Date(card_prices, "%m/%d/%Y"),
  card_prices = coredata(card_prices)
)

bad_card_prices <-
  zoo(bad_card_df$card_prices, bad_card_df$Index)
