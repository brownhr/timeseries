library(tidyverse)
library(xts)

hourly_temp <- read_rds("data/hourly_temp.Rds")

weekly_average <- apply.monthly(hourly_temp, mean)

weekly_average_df <- fortify(weekly_average)



ggplot(weekly_average_df,
       aes(x = Index, y = weekly_average)) +
  geom_col(fill = "red") +
  theme_light() + 
  labs(
    y = "Degrees Celsius",
    title = "Average Monthly Temperature"
  )
