library(tidyverse)
library(zoo)
library(lubridate)

total_index <-
  seq.Date(
    from = as_date("2022-08-01"),
    by = "day",
    length.out = 8
  )


set.seed(1234)

values <- (sin(1:8 * (48 / 180)) * 20 + rnorm(1:8)) %>% round(2)


first_zoo <- zoo(values, total_index) %>% head(6)
second_zoo <- zoo(values, total_index) %>% tail(6)

subset <- !index(first_zoo) %in% index(second_zoo)

total_zoo <- c(first_zoo[subset], second_zoo)

maunaloa <- read_rds("data/maunaloa.Rds") %>% as.zoo()

maunaloa_df <- fortify(maunaloa)
