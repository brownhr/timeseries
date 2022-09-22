library(tidyverse)
library(zoo)
library(lubridate)
library(xts)

set.seed(1234)

car_sales_alice <- matrix(rpois(750 * 30, 8), ncol = 30) %>%
  rowMeans() %>% 
  rollmeanr(k = 48)

set.seed(2345)

car_sales_bob <- matrix(rpois(750 * 30, 8), ncol = 30) %>%
  rowMeans() %>% 
  rollmeanr(k = 48)

index <- seq.Date(from = as_date("2002-05-01"), by = "day", along.with = car_sales_alice)

car_sales <- zoo(x = matrix(c(car_sales_alice, car_sales_bob), ncol = 2, dimnames = list(NULL, c("Alice", "Bob"))),
                 order.by = index)
autoplot(car_sales)


biweekly_eps <- endpoints(car_sales[,1], "weeks", k = )
biweekly_data <- period.apply(car_sales[,1], biweekly_eps, FUN = mean)
