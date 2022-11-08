library(lubridate)
ordered_dates <-
  c(
    "1990-03-10",
    "1976-11-24",
    "1982-11-06",
    "1977-03-01",
    "1995-06-09",
    "1970-06-10",
    "1985-02-15",
    "1982-10-12",
    "1971-01-16",
    "1973-07-28"
  ) %>% as_date() %>% 
  sort()



ordered_values <-
  c(1.03, 0.07, -1.53, -0.84, 0.57, -0.93, 1.07, 0.04, -0.61, -0.36) %>% 
  sort() %>% 
  `+`(10)

rand_index <- sample.int(10)

ordered_zoo <- zoo(ordered_values, 
                   ordered_dates)

unordered_values <- ordered_values[order(rand_index)]
unordered_dates <- ordered_dates[order(rand_index)]

autoplot(ordered_zoo)
