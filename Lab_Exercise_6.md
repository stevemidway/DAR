Exercise 6: Random Effects
================
DAR Lab
Spring 2025

This exercise will provide you practice in fitting and interpreting a
random effects model. The model you need to create using hurricane winds
to predict human deaths, with a random effect for decade in which the
storm occurred.

In terms of a hypothesis, on one hand we might expect deaths to decrease
by decade because hurricane forecasting is better and we have many more
ways to keep people safe. On the other hand, there are more and more
people living in coastal areas each decade, so the possibility of deaths
increases with increasing population. A model should be able shine light
on which pattern (or another) is supported by the data.

## Step 1: Load the data

First, we need to load the libraries that will be used.

``` r
# Load necessary packages
library(DAAG)
library(lme4)
library(tidyverse)

# Load the dataset
data(hurricNamed)
```

## Step 2: Data manipulation

Next, you need to create a new variable for *decade*. Each storm in the
data (starting with the 1950s) should be aggregated by its decade. And
because this new variable will be a random effect, it needs to be a
factor (even if you create it as a number, which is fine).

## Step 3: Fit the model

Fit the model as described above. `LF.WindsMPH` is the predictor and
`deaths` is the response. Note that deaths should probably be modeled
with Poisson response, but for this case we will use a normal
distribution so we can use `lmer`. (But you are welcome to try other
libraries that model random effects in a generalized linear framework.)
Add the new `decade` variable for a random intercept and random slope.

## Step 4: Interpret the model

This step is largely up to you. Take a few lines and comment on anything
about the model that you think is important.

- Do you think this was a good choice of model in the first place?
- Are the residuals tolerable?
- Or might a transformation help?
- How do you interpret the slopes?
- I realize there are not *p*-values for the different decades, but do
  you think this model is better than a model without a random effect?

Feel free to run other models, such as a disaggregated model or OLS
models if you feel like you need to compare the random effect model to
something else.

## Step 5: Make a picture (Optional)

This last step is optional because we have not covered how to model the
actual random effect coefficient. However, you should have the tools and
knowledge to figure out how to use plotting commands in our to show
different intercepts and slopes. Be aware that if you use something like
`stat_smooth()` and color by decade, you’ll be getting OLS estimates and
not random effects, so you need to figure out a way to model and show
the data based on the LMER output.

### Note

I am not looking for a correct answer to parts of this. Yes, there is a
correct way to set up the random effects model; however, random effects
is where you really start to see the art of modeling and the choices you
have to make as the modeler. Think about what we have done in class.
Think about what you identify as important to the model and model
performance, and what you might be able to live without. Much of
modeling is tradeoffs and balance, particularly as the data and models
get more complex. In this exercise, please just do your best to try
things and understand why you are trying them.

**Deliverable: Show your work through the steps outlined here, and
submit a clean analysis in HTML (from R Markdown). Please upload an file
to Moodle by 9am Thursday, March 20.**
