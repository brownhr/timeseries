library(tidyverse)
library(zoo)
library(lubridate)

set.seed(1234)

dates <- seq.Date(
  from = as_date("2013-01-01"),
  by = "day",
  length.out = 730
)

card1 <- rnorm(730, mean = 5.00, sd = 0.10) %>% round(2)
card2 <- rnorm(730, mean = 0.75, sd = 0.05) %>% round(2)
card3 <- rnorm(730, mean = 2.10, sd = 0.10) %>% round(2)

card_prices <- zoo(card1, dates, frequency = 365)
price_2 <- zoo(card2, dates, frequency = 365)
price_3 <- zoo(card3, dates, frequency = 365)

card_prices_all <- merge(card_prices, price_2, price_3)

# write_rds(card_prices, file = "data/card_prices.Rds")



# Fortify to data frame: cards_df
cards_df <- fortify.zoo(card_prices_all)

# Add the total_price column
cards_df$total_price <-
  cards_df$card_prices +
  cards_df$price_2 +
  cards_df$price_3

# Create the total_price_zoo time series
total_price_zoo <- zoo(
  x = cards_df$total_price,
  order.by = cards_df$Index
)

# Generate an autoplot of the new time series
autoplot(total_price_zoo)
