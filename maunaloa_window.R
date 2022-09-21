library(zoo)
library(tidyverse)
library(lubridate)


maunaloa <- read_rds("data/maunaloa.Rds") %>% as.zoo()

maunaloa_window <- window(maunaloa, start = 1980, end = 1990)

index_date <- date_decimal(index(maunaloa_window))

index(maunaloa_window) <- index_date

autoplot(maunaloa_window) + 
  labs(y = "CO2 Concentration")
