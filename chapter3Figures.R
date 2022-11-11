# Maunaloa Yearly


library(tidyverse)
library(zoo)
library(xts)
library(lubridate)
maunaloa <- read_rds("data/maunaloa.rds") %>%
  as.zoo() %>% 
  `index<-`(date_decimal(index(.)))


yearly_mean <- apply.yearly(x = maunaloa, FUN = mean)

autoplot(yearly_mean) + 
  theme_light() + 
  labs(
    title = "Yearly Mean of CO2 Concentration",
    x = "Year",
    y = "CO2 Concentration (PPM)"
  )

autoplot(maunaloa) + 
  theme_light() + 
  labs(
    title = "Mauna Loa CO2 Concentration",
    x = "Year",
    y = "CO2 Concentration (PPM)"
  )
