library(magrittr)
library(tensorflow)
library(keras)

concrete <- read.csv("concrete.csv")

X_train = as.matrix(concrete[1:773,1:8])
X_test = as.matrix(concrete[774:1030,1:8])
y_train = as.matrix(concrete[1:773,9])
y_test = as.matrix(concrete[774:1030,9])

build_model <- function() {
  
  model <- keras_model_sequential() %>%
    layer_dense(units = 1, activation = "relu",
                input_shape = dim(X_train)[2]) %>%
    layer_dense(units = 1, activation = "relu") %>%
    layer_dense(units = 1)
  
  model %>% compile(
    loss = "mse",
    optimizer = optimizer_rmsprop(),
    metrics = list("mean_absolute_error")
  )
  
  model
}

model <- build_model()
model %>% summary()

# Display training progress by printing a single dot for each completed epoch.
print_dot_callback <- callback_lambda(
  on_epoch_end = function(epoch, logs) {
    if (epoch %% 80 == 0) cat("\n")
    cat(".")
  }
)    

epochs <- 20

# Fit the model and store training stats
history <- model %>% fit(
  X_train,
  y_train,
  epochs = epochs,
  validation_split = 0.2,
  verbose = 0,
  callbacks = list(print_dot_callback)
)

c(loss, mae) %<-% (model %>% evaluate(X_test, y_test, verbose = 0))

paste0("Mean absolute error on test set: $", sprintf("%.2f", mae * 1000))

test_predictions <- model %>% predict(y_test)
test_predictions[ , 1]