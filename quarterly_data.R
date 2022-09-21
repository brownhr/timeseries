library(zoo)
library(lubridate)
library(tidyverse)
set.seed(1234)

x <- 0:119

sales <-  {
  200 + 
    seq(0, 40, length.out = length(x)) +
    rnorm(x, mean = 2) + 
    rpois(x, 2) + 
    6 * cos(x * (2 * pi / 12))
}

index = yearmon(1990 + (x / 12))


monthly_sales <- zoo(x = sales, order.by = index)

quarterly_sales <- aggregate(monthly_sales, by = zoo::yearqtr, FUN = sum)

write_rds(quarterly_sales, "data/quarterly_sales.Rds")

autoplot(quarterly_sales) + 
  labs(
    y = "Quarterly Sales ($100k)",
    title = "Corporate sales data"
  ) +
  theme_light() + 
  scale_x_yearqtr(format = "Q%q %Y") + 
  theme(plot.margin = margin(8, 8, 8, 8))
