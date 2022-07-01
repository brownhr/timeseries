library(tidyverse)
library(zoo)
library(lubridate)


maunaloa <- read_csv(
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

# co2 <- read_csv("data/co2_weekly_mlo.csv")[c(-(1:47)),] #%>% 
#   rowwise() %>% 
#   mutate(
#     time = as.yearmon(paste(month, year), "%m %Y") %>% as.Date()
#   ) %>% 
#   select(
#     time, average
#   ) %>% ts_ts()
# 
# write_rds(co2, "data/co2_data.Rds")
