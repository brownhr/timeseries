library(tidyverse)
library(xts)


daily_temp <- read_rds('data/daily_temp.rds')

exp_widths = seq_along(daily_temp)

temp_expand <- 
  rollapply(
    data = daily_temp,
    FUN = max,
    width = exp_widths,
    align = 'right'
  )

temp_roll <- rollapply(
  daily_temp,
  FUN = mean,
  width = 30,
  align = 'right'
)

ggplot() + 
  # Original data
  geom_line(data = daily_temp,
            aes(x = Index,
                y = daily_temp),
            color = 'grey50') +
  # Expanding window plot
  geom_line(data = temp_expand,
            aes(x = Index,
                y = temp_expand),
            color = 'red') + 
  theme_light() + 
  labs(y = 'Degrees Celsius') + 
  geom_line(data = temp_roll,
            aes(x = Index,
                y = temp_roll),
            color = 'green',
            linetype = 'dashed') + 
  geom_hline(yintercept = max(daily_temp), 
             color = 'blue',
             linetype = 'dashed')
