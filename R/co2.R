library(tidyverse)
library(zoo)
library(lubridate)
library(tsbox)
library(tseries)
library(forecast)

co2 <- read_csv("data/co2_mm_mlo.csv")[c(-(1:10), -(767:770)),] %>% 
  rowwise() %>% 
  mutate(
    time = as.yearmon(paste(month, year), "%m %Y") %>% as.Date()
  ) %>% 
  select(
    time, average
  ) %>% ts_ts()

write_rds(co2, "data/co2_data.Rds")
