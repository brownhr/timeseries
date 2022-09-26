library(tidyverse)
library(xts)
library(lubridate)


set.seed(123456)

x1 <- rpois(365, 3)

table(x1)

index <- seq.Date(from=as.Date('2019-01-01'), by = 'day', along.with = x1)

index_wd <- weekdays(index)
index_subset <- !index_wd %in% c("Saturday", "Sunday")

x1[!index_subset] <- NA

car_sales <- zoo(x1, index)
write_rds(car_sales, 'data/car_sales.rds')
