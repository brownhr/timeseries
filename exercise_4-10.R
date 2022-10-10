library(tidyverse)
library(zoo)

card_price <- read_rds(
  "https://assets.datacamp.com/production/repositories/6083/datasets/702f54c11ff894bc0180ad03a2b5e31a83438c69/card_prices.Rds"
)[, 1]

price_windows <- seq_along(card_price)

price_exp_mean <-
  rollapply(card_price,
            FUN = mean,
            width = 7,
            align = 'left')





card_price_plot <-
  ggplot(card_price, aes(x = Index, y = card_price)) +
  scale_y_continuous() +
  theme_light() +
  geom_line(color = 'grey') +
  geom_line(data = price_exp_mean,
            aes(x = Index,
                y = price_exp_mean),
            color = 'blue')
