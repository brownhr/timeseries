library(tidyverse)
library(zoo)
library(lubridate)

card_prices <- read_rds("data/card_prices.Rds")

card_window <- window(x = card_prices,
                      start = "2013-05-01",
                      end = "2013-07-31")


window_start <- "2013-05-01"
window_end <- "2013-07-31"

subset <-
  index(card_prices) >= window_start &
  index(card_prices) <= window_end


subs_2 <- index(card_prices) %>% {
  . > window_start & . < window_end
}
assertthat::are_equal(subset, subs_2)

card_subset <- card_prices[subset]

cw <- c(head(card_subset, 3), tail(card_subset, 3))
print(cw, "v")
