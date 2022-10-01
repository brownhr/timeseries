library(tidyverse)
library(xts)

hourly_temperature <-
  read_rds(
    "https://assets.datacamp.com/production/repositories/6083/datasets/fe545011e9b6eae11dc14e0c46f31f5dad240c08/htemp.rds"
  )

weekly_avg <- apply.weekly(hourly_temperature, mean)

hourly_plot <- ggplot(hourly_temperature,
                      aes(x = Index, y = hourly_temperature)) +
  scale_y_continuous() +
  geom_line() + 
  labs(y = "Degrees Celsius",
    title = "Temperature Readings")

hourly_plot +
  geom_line(data = weekly_avg,
    aes(x = Index, y = weekly_avg),
    color = "red",
    size = 1)
