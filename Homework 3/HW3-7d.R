library(tensorflow)
library(kerasR)

data <- read.csv("concrete.csv")

X_train = as.matrix(data[1:773,1:8])
X_test = as.matrix(data[774:1030,1:8])
y_train = as.matrix(data[1:773,9])
y_test = as.matrix(data[774:1030,9])
if(keras_available()) {

  mod <- Sequential()
  mod$add(Dense(units = 1, input_shape = dim(X_train)[2]))
  mod$add(Activation("relu"))
  mod$add(Dense(units = 1))
  
  keras_compile(mod,  loss = 'mse', optimizer = RMSprop())
  
  keras_fit(mod, X_train, y_train,
            batch_size = 32, epochs = 15,
            verbose = 1, validation_split = 0.1)
  
  #Validation
  pred <- keras_predict(mod, normalize(X_test))
  sd(as.numeric(pred) - Y_test) / sd(Y_test)
}