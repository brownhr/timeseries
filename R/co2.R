co2 <- read_csv("data/co2_mm_mlo.csv")[c(-(1:10), -(767:770)),] %>% 
  rowwise() %>% 
  mutate(
    time = as.yearmon(paste(month, year), "%m %Y") %>% as.Date()
  ) %>% 
  select(
    time, average
  ) %>% tsbox::ts_ts()


log_co2 <- log(co2)

laglog <- stats::lag(log_co2, -1)
dlaglog <- diff(laglog, 1)
