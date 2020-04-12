library(mxnet)
concrete <- read.csv(file = "concrete.csv")

y = as.matrix(concrete[1:773,9])
y = as.numeric(y)
x = as.numeric(as.matrix(concrete[1:773,1:8]))
x = matrix(as.numeric(x),ncol=8)
xtest = as.numeric(as.matrix(concrete[774:1030,1:8]))
xtest = matrix(as.numeric(xtest),ncol=8)
ytest = as.matrix(concrete[774:1030,9])
ytest = as.numeric(ytest)

mx.set.seed(0)
model <- mx.mlp(x, y, hidden_node=c(1), out_node=1, out_activation="rmse",
                num.round=20, array.batch.size=15, learning.rate=1e-4, momentum=0.9,
                eval.metric=mx.metric.rmse)


preds = predict(model, xtest)
summary(as.vector(preds))
sprintf("test RMSE = %f", sqrt(mean((preds-ytest)^2)))


model2 <- mx.mlp(x, y, hidden_node=c(5), out_node=1, out_activation="rmse",
                num.round=20, array.batch.size=15, learning.rate=1e-4, momentum=0.9,
                eval.metric=mx.metric.rmse)


preds2 = predict(model2, xtest)
summary(as.vector(preds2))
sprintf("test RMSE = %f", sqrt(mean((preds2-ytest)^2)))