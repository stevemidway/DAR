# Linear Model Basics

library(tidyverse)

# Some fake data
mass <- c(6,8,5,7,9,11)
pop <- factor(c(1,1,2,2,3,3))
region <- factor(c(1,1,1,1,2,2))
hab <- factor(c(1,2,3,1,2,3))
svl <- c(40,45,39,50,52,57)

# Model of the mean
lm(mass ~ 1)

# t-test
lm(mass ~ region)

t.test(mass ~ region)
# why different group means?

model.matrix(mass ~ region) # effects parameterization
model.matrix(mass ~ region - 1) # means parameterization

# Simple Linear Regression
lm(mass ~ svl)
model.matrix(mass ~ svl) # don't really need this
summary(lm(mass ~ svl))

# ANOVA
lm(mass ~ pop)
aov(mass ~ pop)
summary(aov(mass ~ pop))

# Iron example
depth <- c(0,0,0,10,10,10,30,30,30,40,40,40,
           50,50,50,100,100,100,100,100)
iron <-c(0.045,0.043,0.04,0.045,0.031,0.043,
         0.044,0.044,0.048,0.098,0.074,0.154,
         0.117,0.089,0.104,0.192,0.213,0.225,
         0.224,0.172)

boxplot(iron ~ depth, col="orange",
        xlab="Depth", ylab="[Iron]", las=1)           

iron.lm <- lm(iron ~ depth)
summary(iron.lm)

# better
iron.lm <- lm(iron ~ as.factor(depth))
summary(iron.lm)

iron.aov <- aov(iron ~ as.factor(depth) )
summary(iron.aov)

iron.aov$coefficients

#Multiple Comparisons: https://peerj.com/articles/10387/

TukeyHSD(iron.aov)

# Correlation
cor(mpg$cty, mpg$hwy)
cor(mpg$cyl, mpg$displ)


summary(lm(cty ~ cyl, data = mpg))
summary(lm(cty ~ displ, data = mpg))
summary(lm(cty ~ cyl + displ, data = mpg))

# Model diagnostics
n <- 15 # Number of years
a <- 0 # Intercept
b <- 1.5 # Slope
sigma2 <- 25 # Residual variance
x <- 1:15 # Values of covariate year
set.seed(15)
eps <-rnorm(n, mean=0, sd=sqrt(sigma2))
y <- a + b*x + eps

mod1 <- lm(y ~ x)
summary(mod1)

resid(mod1)

res <- resid(mod1)
fit <- fitted(mod1)
plot(res ~ fit, pch=19, las=1); abline(0,0, col="red")
