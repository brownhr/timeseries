library(tidyverse)
library(zoo)
library(lubridate)

ftse_zoo <- EuStockMarkets[, "FTSE"] %>%
  as.zoo()

ftse <- data.frame(
  Date = index(ftse_zoo),
  Price = coredata(ftse_zoo)
)

# Rolling Window
ftse %>%
  ggplot(aes(x = Date, y = Price)) +
  geom_line() +
  geom_hline(
    yintercept = mean(ftse$Price),
    color = "blue",
    linetype = "dashed"
  ) +
  theme_light()
# ggsave(filename = "fig/rolling-window-3.png")


ftse_rollmean <- ftse_zoo %>%
  rollmean(
    k = 30,
    align = "right"
  )
ftse_rollmean2 <- data.frame(
  Date = index(ftse_rollmean),
  Price = coredata(ftse_rollmean)
)



ftse_rm_right <-
  rollmean(ftse,
           k = 7,
           align = "right",
           fill = NA)

ftse %>%
  ggplot(aes(x = Date, y = Price)) +
  geom_line() +
  geom_line(
    data = ftse_rollmean2, aes(x = Date, y = Price),
    color = "red",
    size = 1
  ) + 
  labs(x = 'Index') + 
  theme_light()
# ggsave(filename = "fig/rolling-window-4.png")
