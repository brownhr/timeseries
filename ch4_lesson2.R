library(tidyverse)
library(zoo)

ftse <- read_rds("data/ftse.Rds")

frmin <- rollapply(
  data = ftse,
  width = 60,
  FUN = min,
  align = 'right',
  fill = NA
)

hourly_temperatures <- read_rds('data/htemp.rds')

daily_temp <- xts::apply.daily(hourly_temperatures, mean)

index(daily_temp) <- format.Date(index(daily_temp), format = '%Y-%m-%d') %>% as.Date()

daily_temp %>% autoplot()

calc_range <- function(x){
  max(x) - min(x)
}

daily_temp_range <- rollapply(daily_temp,
          FUN = calc_range,
          width = 30,
          align = 'right',
          fill = NA) 

autoplot(daily_temp_range) + 
  theme_light() + 
  labs(y = 'Temperature Range')
