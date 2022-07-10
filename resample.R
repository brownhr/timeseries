library(zoo)
library(tidyverse)
library(lubridate)

EU_DAX <- EuStockMarkets[,"DAX"] %>% as.zoo()
write_rds(EU_DAX, "data/EU_DAX.Rds")


airpassengers <- read_rds("data/airpassengers.Rds") %>% 
  as.zoo()

parse_date_time("2022-01-20", orders = list("%Y-%m-%d"))


lubridate::is.Date("2020-02-02")

start <- as.Date("2019-01-01")

dates <- seq.Date(start, by = "day", length.out = 365)

airpassengers[interval(start = as.yearmon("Jan 1952"), end = as.yearmon("Dec 1952"))]
window(airpassengers, start = as.yearmon("Jan 1952"), end = as.yearmon("Dec 1952"))

df <- as.data.frame(airpassengers)
df$date <- index(airpassengers)

air2 <- rollmeanr(airpassengers, k = 7)
df2 <- data.frame(date = index(air2), rmean = coredata(air2))

df3 <- left_join(df, df2, by = "date")

ggplot(df, aes(x = date, y = airpassengers)) + 
  geom_line()
