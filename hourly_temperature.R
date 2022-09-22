library(tidyverse)
library(lubridate)
library(xts)

hourly_temperature <- read_table(
  "https://www.ncei.noaa.gov/pub/data/uscrn/products/hourly02/2019/CRNH0203-2019-NC_Asheville_8_SSW.txt",
  col_names = c(
    "WBANNO",
    "UTC_DATE",
    "UTC_TIME",
    "LST_DATE",
    "LST_TIME",
    "CRX_VN",
    "LONGITUDE",
    "LATITUDE",
    "T_CALC",
    "T_HR_AVG"
  )
)

hourly_temperature <- hourly_temperature %>% 
  rowwise() %>% 
  mutate(
    date = paste0(UTC_DATE, UTC_TIME),
    time = date %>% 
      as.POSIXlt(format = "%Y%m%d%H%M")
  )

hourly_temperature <- hourly_temperature %>% 
  select(temp = T_HR_AVG,
         time) %>% 
  mutate(
    temp = ifelse(temp < -1000, NA, temp)
  )

hourly_temp <- zoo(hourly_temperature$temp,
                   hourly_temperature$time) %>%
  na.approx()
hourly_temp <- head(hourly_temp, length(hourly_temp) - 1)

autoplot(hourly_temp) + theme_light() + labs(y = "Degrees Celsius")

write_rds(hourly_temp, "data/hourly_temperature.Rds")
