library(forecast)
library(dplyr)

ar <- auto.arima(
  y = AirPassengers
)


DAX <- EuStockMarkets[,"DAX"]

autoplot(DAX)

DAX_dc <- DAX %>% 
  mstl() %>% 
  seasadj()

autoplot(DAX_dc)

AirPassengers %>%
  mstl(
    # s.window = "periodic",
    # robust = TRUE
  ) %>%
  seasadj() %>%
  autoplot()
air_dc <- decompose(AirPassengers)

rem <- remainder(air_dc)
ses <- seasonal(air_dc)
1 - (var(rem)/var(rem + ses))


DAX_arima <- Arima(DAX, )
DAX_dc %>% 
  forecast(model = DAX_arima) %>% 
  autoplot()
