library(xts)

eps <- endpoints(maunaloa, on = "months", k = 3)

period.apply(maunaloa, INDEX = eps, FUN = sd) %>% autoplot()
