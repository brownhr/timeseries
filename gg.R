library(tidyverse)
library(zoo)
library(lubridate)

set.seed(1234)

sample_dates <-
  seq(as_date("2022-01-20"), by = "day", length.out = 2000)
sample_values <-
  (cos(1:2000 * (1 / 24)) * 4) +
  (runif(1:2000, min = -1, max = 1)) +
  (sqrt(1:2000))

sample_values <- round(sample_values, digits = 3)


my_zoo <- zoo(x = sample_values, order.by = sample_dates)


my_plot <-
  ggplot(data = my_zoo,
         aes(x = Index, y = my_zoo)) +
  geom_line(color = "blue",
            size = 2,
            linetype = "dotted")


my_plot + 
  theme_bw() + 
  labs(x = "Index",
       y = "Value",
       title = "Plotting a zoo Object")
