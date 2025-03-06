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

TukeyHSD(iris_model)

# Pre-fitting ----

## Log transformation ----
library(Stat2Data)

# Raw data
data(SpeciesArea)

ggplot(SpeciesArea, aes(x = Area, y = Species)) +
  geom_point() +
  geom_smooth(method = "lm") +
  theme_classic(base_size = 15)

summary(lm(Species ~ Area, data = SpeciesArea))

# Transformed data
ggplot(SpeciesArea, aes(x = log(Area), y = Species)) +
  geom_point() +
  geom_smooth(method = "lm") +
  theme_classic(base_size = 15)

summary(lm(Species ~ log(Area), data = SpeciesArea))

# Intercept: When x = 1, y = -28.89...?
# Slope: a 1-unit increase in log(x) increases y by 10.107

## Standardized Predictor ----

# Raw data
data(BirdNest)

ggplot(BirdNest, aes(x = Length, y = No.eggs)) +
  geom_point() +
  geom_smooth(method = "lm") +
  theme_classic(base_size = 15)

summary(lm(No.eggs ~ Length, data = BirdNest))

# Transformed data
BirdNest$z.length <- (BirdNest$Length - mean(BirdNest$Length))/sd(BirdNest$Length)
mean(BirdNest$z.length)
sd(BirdNest$z.length)

ggplot(BirdNest, aes(x = z.length, y = No.eggs)) +
  geom_point() +
  geom_smooth(method = "lm") +
  theme_classic(base_size = 15)

summary(lm(No.eggs ~ z.length, data = BirdNest))

# Intercept: 4.58 eggs for mean bird length
# Slope: For a 1 SD increase in length results in -0.56 change in eggs

# Comparing Predictors
summary(lm(No.eggs ~ Length + Nestling, data = BirdNest))

# Standardize Nestling
BirdNest$z.nestling <- (BirdNest$Nestling - mean(BirdNest$Nestling))/sd(BirdNest$Nestling)

summary(lm(No.eggs ~ z.length + z.nestling, data = BirdNest))

# Post-fitting ----

bird <- lm(No.eggs ~ Length, data = BirdNest)
summary(bird)

resid(bird)

res <- resid(bird)
fit <- fitted(bird)
plot(res ~ fit, pch=19, las=1); abline(0,0, col="red")
hist(res)

# GLMs ----

## Poisson GLM ----
BirdNest$No.eggs.i <- as.integer(BirdNest$No.eggs)

pois_mod <- glm(No.eggs.i ~ Length, 
                data = BirdNest,
                family = 'poisson')

summary(pois_mod)

ggplot(BirdNest, aes(x = Length, y = No.eggs.i)) +
  geom_point() +
  geom_smooth(method = "glm",
              method.args = list(family = "poisson")) +
  labs(y = "No of eggs",
       caption = "Poisson GLM") +
  theme_classic(base_size = 25)

# Intercept: e^1.928
exp(1.928)
# 6.8 eggs species at bird length = 0

# Slope: e^-0.0277
exp(-0.0277)
# For each 1-unit increase in x, y is multiplied by 0.97, or...
# Decrease of 2.7% eggs for each 1-unit increase in x


## Binomial GLM ----
data(SampleFG)

ggplot(SampleFG, aes(x = Yards, y = Result)) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "glm", #se = F,
              method.args = list(family = "binomial")) +
  theme_classic(base_size = 15)

binom_mod <- glm(Result ~ Yards, 
                data = SampleFG,
                family = 'binomial')

summary(binom_mod)

# Intercept
binom_mod$coefficients[1] # log odds scale

#...but we want probability scale
exp(binom_mod$coefficients[1]) / (1 + exp(binom_mod$coefficients[1])) # intercept
# or
plogis(6.2)

# 99.8% probability of making a field goal at 0 yards

# Slope
binom_mod$coefficients[2] # log odds

# ...it gets complicated because the slope is non-linear

# Inflection (e.g., L50)
-binom_mod$coefficients[1]/binom_mod$coefficients[2]

new_data <- data.frame(Yards = c(20, 30, 40, 50))
predict(binom_mod, newdata = new_data, type = "response")

