library(tidyverse)
library(zoo)
library(lubridate)

maunaloa_raw <- read_csv(
  "data/co2_weekly_mlo.csv",
  col_types = cols(
    ndays = col_skip(),
    `1 year ago` = col_skip(),
    `10 years ago` = col_skip(),
    `increase since 1800` = col_skip()
  ),
  skip = 47
) %>% 
  mutate(time = lubridate::date_decimal(decimal) %>% as.Date()) %>% 
  select(time, average)

write_rds(maunaloa_raw, "data/maunaloa_raw.Rds")

maunaloa_raw <- read_csv(
  "data/co2_weekly_mlo.csv",
  col_types = cols(
    ndays = col_skip(),
    `1 year ago` = col_skip(),
    `10 years ago` = col_skip(),
    `increase since 1800` = col_skip()
  ),
  skip = 47
) %>% 
  mutate(time = lubridate::date_decimal(decimal) %>% as.Date()) %>% 
  select(time, average) %>% 
  naniar::replace_with_na_all(condition = ~.x < 0) %>%
  tsbox::ts_ts() %>% 
  zoo::na.approx()

write_rds(maunaloa, "data/maunaloa.Rds")


maunaloa <- readRDS("data/maunaloa.Rds")

maunaloa_missing <- maunaloa
maunaloa_missing[sample(length(maunaloa_missing),100)] <- NA
saveRDS(maunaloa_missing, "data/maunaloa_missing.Rds")
