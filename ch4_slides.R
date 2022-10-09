library(tidyverse)
library(xts)

ftse <- read_rds("data/ftse.Rds")

ftse_window <- window(ftse, start = 1992, end = 1993)

ftse_df = fortify.zoo(ftse)
ggplot(data = ftse_df, aes(x = Index, y = ftse)) + 
  scale_y_continuous() + 
  theme_light() + 
  labs(y = 'Price') + 
  geom_line(linetype = 'longdash',
            color = '#cc7777') + 
  geom_line(data=ftse_window, aes(y = ftse_window)) + 
  coord_cartesian(xlim=c(1992, 1993), ylim=c(min(ftse_window), max(ftse_window)))


autoplot(ftse) + 
  theme_light() + 
  labs(y='Price') +
  geom_hline(yintercept = mean(ftse),
             linetype = 'longdash',
             color = 'blue') + 
  geom_text(aes(x = 1992, y = 3700, label = "Global Mean"), color = 'blue', check_overlap=TRUE) 
#+ 
  theme(
  plot.margin = margin(rep(20, 4))
)

ftse_window <- rollmeanr(ftse, k = 30) %>% fortify.zoo()

ggplot(ftse, aes(x = Index, y = ftse)) + 
  geom_line() + 
  theme_light() + 
  labs(y = 'Price') + 
  geom_line(data = ftse_window, aes(y = ftse_window), color='red')


rollmean(ftse, k=30, align='right') %>% 
  autoplot() + 
  theme_light() + 
  labs(y = 'Price')
  
car_sales <- read_rds('data/car_sales.rds') %>% na.fill(0)

rollsum(car_sales, k=7, align='right') %>% 
  autoplot() + 
  theme_light() + 
  labs(y='Rolling Sum of Sales')
