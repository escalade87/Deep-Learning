concrete <- read.csv(file = "concrete.csv")

y = as.matrix(concrete[1:773,9])
x = as.matrix(concrete[1:773,1:8])
xtest = as.matrix(concrete[774:1030,1:8])
ytest = as.matrix(concrete[774:1030,9])

library(deepnet)
nn <- nn.train(x, y, hidden = c(5), output = "linear")
yy = nn.predict(nn, xtest)
print(head(yy))

