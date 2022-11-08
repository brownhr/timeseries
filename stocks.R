library(tidyverse)
library(lubridate)
library(xts)

dow_jones <- read_csv("data/PerformanceGraphExport.csv") %>% 
  mutate(
    Date = parse_date_time(Date, "%m/%d/%y")
  )

dow_jones <- zoo(dow_jones$Price, dow_jones$Date)
# index(dow_jones) <- decimal_date(index(dow_jones))

write_rds(dow_jones, "data/dowjones.rds")

dow_jones %>% 
  window(start = "2019-01-01",
         end = "2021-01-01") %>% 
  autoplot() + 
  theme_light() + 
  labs(
    y = "Price (USD)",
    title = "Dow Jones Industrial Average"
  )
