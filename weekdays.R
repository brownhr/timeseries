library(lubridate)
dates_seq <- seq.Date(
  from = as_date("2019-01-01"),
  to = as_date("2019-12-31"),
  by = "day"
)


weekends <- dates_seq[weekdays(dates_seq) %in% c("Saturday", "Sunday")]
