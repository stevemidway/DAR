Exercise 8: Random Effects
================
DAR Lab
Spring 2024

This exercise asks you to become familiar with random effects through
some simple steps.

1.  Find a dataset with a factor that could be considered a random
    effect.

- Note that this putative random effect may not turn out to be a great
  random effect after you analyze it, but all you need is to be able to
  make a case for examining it.
- I am not picky as to where you get this data set. Consider using your
  own data, using one of the hundreds of datasets available in R
  packages (many listed
  [here](https://vincentarelbundock.github.io/Rdatasets/datasets.html)),
  or even simulating your own data.

2.  Using the `lme4` library, run a simple model of your data.

- Consider either a mixed model (random intercept and fixed slope, or
  fixed slope and random intercept) or a fully random model (random
  intercept and random slope).
- Include the model you ran and any relevant reporting.

3.  Include a figure of your data and model.

- Consider colors and/or shapes to distinguish different groups.
- Plot separate models (fitted lines) for each random effect level.
- Base plotting can do much of this, as can `ggplot` and others (also,
  consider additional plots of the coefficients, if relevant, with a
  package like `sjplot`).

**Please upload an html file (RMarkdown-rendered) to Moodle by 5pm
Friday, March 29, 2024.**
