library(tidyverse)
library(xts)

ftse <- read_rds("data/ftse.Rds") %>% head(20)

ftse_rm_right <- rollmean(
  ftse,
  k = 7,
  align = 'right'
)

idx1 <- length(ftse_rm_right)

idx2 <- length(ftse_rm_right) - 7

ggplot(ftse, aes(x = Index, y = ftse)) + 
  geom_line(color = 'grey',
            linetype = 'longdash',
            size = 1) + 
  theme_minimal() + 
  geom_line(data = ftse_rm_right,
            aes(y = ftse_rm_right),
            size = 1) + 
  geom_vline(xintercept = index(ftse_rm_right)[idx1],
             linetype = 'dashed',
             color = 'grey30',
             size = 1) +
  geom_vline(xintercept = index(ftse_rm_right)[idx2],
             linetype = 'dashed',
             color = 'grey30',
             size = 1) + 
  geom_point(aes(y = ftse_rm_right[idx1],
                 x = index(ftse_rm_right)[idx1]),
             color = 'red',
              size = 3)
