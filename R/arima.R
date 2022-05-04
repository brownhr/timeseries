library(forecast)
library(dplyr)

elec <- fma::uselec

elec_ets <- ets(elec)
fc <- forecast(elec_ets)
