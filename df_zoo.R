index <- seq.Date(from = as_date("1989-01-01"), length.out = 480, by = "day")
value <- coredata(maunaloa)[1:480] * runif(480, min = 0.99, max = 1)
value <- round(value, 2)

zoo(value, index) %>% autoplot()


data <- data.frame(date = index, value = value)

data_zoo <- zoo(data$value, data$date)

autoplot(data_zoo)

data_zoo