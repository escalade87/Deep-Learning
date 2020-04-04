data <- read.table("lsd.dat")
lm = lm(V2~V1, data = data)
plot(data,xlab="Tissue Concentration",ylab="Math Score")
abline(lm)
eq <- lm$coefficients
(eqn <- paste("Y =", paste(round(eq[1],2), paste(round(eq[-1],2), "X", sep=" * ", collapse=" + "), sep=" + "), "+ e"))

