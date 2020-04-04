data <- read.table("tvsales.dat")
model <- lm(V2 ~ V3+V4+V5+V6+V7+V8+V9+V10, data = data)
summary(model)

