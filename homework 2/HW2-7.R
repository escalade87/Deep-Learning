data <- read.table("manuf_learn.dat")
y <- as.matrix(data[6])
# Matrix of feature variables from Boston
X <- as.matrix(data[7:8])

# vector of ones with same length as rows in Boston
int <- rep(1, length(y))

# Add intercept column to X
X <- cbind(int, X)

# Implement closed-form solution
betas <- solve(t(X) %*% X) %*% t(X) %*% y

# Round for easier viewing
betas <- round(betas, 2)

