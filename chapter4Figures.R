# FTSE

library(tidyverse)
library(zoo)
library(lubridate)

ftse <- read_rds("data/ftse.rds")


# Window Alignment

library(tidyverse)
library(xts)

set.seed(1234)
data <- runif(7)


idx <- seq.Date(from = as.Date("2012-01-01"), by= 'day', along.with = data)

data <- zoo(data, 1:7)
data_rm <- rollmean(
  data,
  k = 7,
  fill = NA,
  align = 'right'
)

autoplot(data) + 
  coord_cartesian(xlim = c(0, 8)) +
  theme_light(
  )
