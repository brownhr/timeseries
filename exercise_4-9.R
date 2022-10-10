library(tidyverse)
library(zoo)

set.seed(1234)
daily_sales <- rpois(365, 0.1)
idx <- seq.Date(from = as.Date('2019-07-01'), by = 'day', along.with = daily_sales)

daily_sales <- zoo(daily_sales,
                   idx) %>% 
  write_rds("data/daily_house_sales.rdses.rds")

exp_window_width = seq_along(daily_sales)

sales_exp_sum <- rollapply(
  daily_sales,
  FUN = sum,
  width = exp_window_width,
  align = 'right'
)

ggplot(sales_exp_sum, aes(x = Index,
                          y = sales_exp_sum)) + 
  geom_line(color = 'red') + 
  scale_y_continuous() + 
  theme_light()
