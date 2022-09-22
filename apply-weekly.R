library(tidyverse)
library(lubridate)
library(xts)

maunaloa <- read_rds("data/maunaloa.Rds") %>% as.zoo() %>% 
  `index<-`(date_decimal(index(.)))

apply.yearly(maunaloa, mean) %>% 
  autoplot() +
  theme_light() + 
  labs(
    x = "Index",
    y = "CO2 Concentration (PPM)",
    title = "Yearly mean of CO2"
  )


