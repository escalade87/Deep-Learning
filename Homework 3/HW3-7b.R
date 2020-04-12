concrete <- read.csv("concrete.csv")
str(concrete)

normalise <- function(x){
  return((x-min(x))/(max(x)-min(x)))
}
data <- as.data.frame(lapply(concrete,normalise))
str(data)

library(h2o)
h2o.init(max_mem_size = "2G", nthreads = 2, ip="localhost", port=54321)

d.hex <- as.h2o(data,destination_frame = "d.hex")
head(d.hex)

set.seed(99)
split <-h2o.splitFrame(data=d.hex,ratios = 0.75)
train <- split[[1]] 
test <- split[[2]]

model_nn <- h2o.deeplearning(x=1:8,y="strength", training_frame = train,hidden =5,model_id = "model_nn")

perf <- h2o.performance(model_nn,test)
perf

pred<- as.data.frame(h2o.predict(model_nn, test))
test1 <- as.data.frame(test)
cor(pred,test1$strength)

model_nn2 <- h2o.deeplearning(x=1:8,y="strength", training_frame = train,hidden = 1,model_id = "model_nn2")

perf2 <- h2o.performance(model_nn2,test)
perf2

pred2 <- as.data.frame(h2o.predict(model_nn2, test))
test2 <- as.data.frame(test)
cor(pred2,test2$strength)