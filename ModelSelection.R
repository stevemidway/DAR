
### Supplementary code for Model Selection

### Data Analysis in R; OCS 7313

### Midway, 2024

library(MASS)
library(dplyr)
library(MuMIn)
library(DAAG)
library(bootstrap)

##################
# 1. IT Model selection Examples
##################

birds <- read.csv('birds.csv', header = TRUE)
# Metadata: http://www.stat.ufl.edu/~winner/data/insular.txt

head(birds)

# Global (full) model
glm1 <- glm(EndemicTaxa ~ AreaKM2 + Altitude + Elevation + DistFromParamo + DistNearIsVeg + DistNearIsSouth + DistNearLargeIS, 
            data = birds, family = poisson, na.action = "na.fail")

summary(glm1)
plot(residuals(glm1) ~ fitted(glm1), pch=16, col="black")
abline(0,0)
hist(residuals(glm1))


AIC(glm1)

AICc(glm1)
BIC(glm1)

# Stepwise Regression with stepAIC()
# ?stepAIC
backward.step <- stepAIC(glm1, direction="backward")
both.step <- stepAIC(glm1, direction="both")

# Relative Importance
glm1.dredge <- dredge(glm1, rank = "AIC") # With great power comes great responsibility
glm1.dredge

glm1.avg <- model.avg(glm1.dredge, cumsum(weight) <= .5) # Average all models in 95% confidence set
summary(glm1.avg) # Full = all terms (0s); conditional = only those included
coefs <- glm1.avg$coefficients[2,]
glm1.ci <- confint(glm1.avg, level=0.95) # Calculate 95% CI
glm1.ci


AIC <- glm1.dredge$AIC

glm1.BIC.dredge <- dredge(glm1,rank = "BIC")
BIC <- glm1.BIC.dredge$BIC

glm1.AICc.dredge <- dredge(glm1,rank = "AICc")
AICc <- glm1.AICc.dredge$AICc

plot(AIC ~ AICc)
points(y = 50:100, x = 50:100, type = "l")
plot(AIC ~ BIC)
points(y = 50:100, x = 50:100, type = "l")
plot(AICc ~ BIC)
points(y = 50:100, x = 50:100, type = "l")


##################
# 1. Cross-validation Model selection Examples
##################

Hg <- read.csv("fishermen_mercury.csv", header = T)
# Metadata: http://www.stat.ufl.edu/~winner/data/fishermen_mercury.txt

head(Hg)
names(Hg)

hist(Hg$MeHg, breaks = 25)

lm1 <- lm(MeHg ~ age + restime + height + weight + fishmlwk + fishpart, data = Hg)
summary(lm1)

# K-fold Cross Validation
cv.lm(data=Hg, lm1, m=10) # 10 fold cross-validation
# ms = Mean square error, which is sum of squares X (1/n)

# Compare to a poor model
lm2 <- lm(MeHg ~ age + restime, data = Hg)
summary(lm2)
cv.lm(data=Hg, lm2, m=10) # 10 fold cross-validation

# Leave-out-out cross-validation
LOO <- dim(Hg)[1] 

# This takes a long time
#cv.lm(data=Hg, lm1, m=LOO) # LOO

# Manual Example

# Methyl Mercury > 4 mg/ml is a threshold for serious mercury levels.
# Can you code a cross-validation model to find the best model among 
# the predictors restime, weight, and fishmlwk in predicting serious 
# methyl mercury levels for screening?

# Step 1: Transform predictor
Hg$serious <- ifelse(Hg$MeHg > 4, 1, 0)

glm2 <- glm(serious ~ restime, data = Hg, family = binomial) # One model to test
coefficients(glm2) # view coefficients, if curious
n <- dim(Hg)[1] # length of dataset (same as LOO)
preds <- rep(0, n) # create empty storage vector for predictions

# Loop for predictions
for(i in 1:n){
preds[i] <- 1 / (1 + exp(coefficients(glm2)[1] + coefficients(glm2)[2] * Hg$weight[i] ))
}

# With a cutoff of 50% for success, let's evlaute how this model predicted individuals with serious MeHg
compare <- abs(Hg$serious - preds)
success <- ifelse(compare < 0.5, 1, 0)
(sum(success)/length(success)) * 100 # View Cross validation as a percentage

