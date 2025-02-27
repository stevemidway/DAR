# Load libraries
library(tidyverse)

# Load data from Kery ----
mass <- c(6,8,5,7,9,11)
pop <- factor(c(1,1,2,2,3,3))
region <- factor(c(1,1,1,1,2,2))
hab <- factor(c(1,2,3,1,2,3))
svl <- c(40,45,39,50,52,57)

# Model of the Mean ----
lm(mass ~ 1)

mean(mass)

summary(lm(mass ~ 1))

sd(mass)

model.matrix(mass ~ 1)


# t-test ----
lm(mass ~ region)

model.matrix(mass ~ region)

summary(lm(mass ~ region))

t.test(mass ~ region)

## Means parameterization ----
model.matrix(mass ~ region - 1)
lm(mass ~ region - 1)

# Simple Linear Regression ----
lm(mass ~ svl)
summary(lm(mass ~ svl))

# ANOVA
aov_model <- aov(mass ~ pop)
summary(aov_model)

## Iris Model ----
data(iris)
iris_model <- aov(Petal.Length ~ Species, iris)
summary(iris_model)
str(iris_model)
iris_model$coefficients

ggplot(iris, aes(x = Species, y = Petal.Length)) +
  geom_boxplot(fill = "#fff68a", col = "#886efc") +
  theme_classic(base_size = 15)

TukeyHSD(diam_model)
