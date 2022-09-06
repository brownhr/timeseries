library(tidyverse)
library(zoo)
library(lubridate)

index <- seq.Date(from = as_date("2015-01-01"), length.out = 1024, by = "day")

x <- seq(length(index))
y1 <- cos(x * (1/24)) * 40
y2 <- runif(x, -20, 20)

zoo(
  {y1 + y2 + x^(0.75)},
  index,
  frequency = 365
) %>% autoplot()
