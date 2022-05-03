library(tseries)

data("EuStockMarkets")

smi <- EuStockMarkets[,"SMI"]
ts.plot(smi)

smi_decomp <- decompose(smi)

plot(smi_decomp)
adf.test(smi, k = 0)
