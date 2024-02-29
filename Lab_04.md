Exercise 4: The Tidyverse
================
DAR Lab
Spring 2024

## The `tidyverse`

The `tidyverse` is a family of packages written and developed by Hadley
Wickham, in order to provide advanced and consistet functionality to
`R`. Many of the things in the `tidyverse` can be done in base `R` or
with other packages; however, packages and functions within `tidyverse`
offer new and often more efficient ways to do them. See an overview of
`tidyverse` packages [here](https://www.tidyverse.org/packages/).
Information and cheat sheets to all the `tidyverse` packages can be
found at that website.

You can load all the tidyverse packages with the following commands:

``` r
#install.packages("tidyverse")
library(tidyverse)
```

    ## ── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
    ## ✔ dplyr     1.1.3     ✔ readr     2.1.4
    ## ✔ forcats   1.0.0     ✔ stringr   1.5.0
    ## ✔ ggplot2   3.4.4     ✔ tibble    3.2.1
    ## ✔ lubridate 1.9.3     ✔ tidyr     1.3.0
    ## ✔ purrr     1.0.2     
    ## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
    ## ✖ dplyr::filter() masks stats::filter()
    ## ✖ dplyr::lag()    masks stats::lag()
    ## ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors

1.  `tidyr` is a useful package for manipulating large dataframes into
    more usable formats. Consider the dataset created below. That
    dataset may be better off without individual `years` as columns
    headers, and rather one single `year` column with year values in
    that column. Use the `pivot_longer()` function to turn the following
    dataframe into one with a single column for `year`. Note: this is
    also referred to as making wide data narrow.

``` r
Species <- c(rep("A",3),rep("B",3),rep("C",3))
set.seed(16)
Year2017 <- rpois(n = 9, lambda = 1)
Year2018 <- rpois(n = 9, lambda = 3)
Year2019 <- rpois(n = 9, lambda = 5)
Year2020 <- rpois(n = 9, lambda = 7)
wide.df <- as.data.frame(cbind(Species, Year2017, Year2018, Year2019, Year2020))
head(wide.df)
```

    ##   Species Year2017 Year2018 Year2019 Year2020
    ## 1       A        1        1        6       13
    ## 2       A        0        2        2        9
    ## 3       A        1        3        9        7
    ## 4       B        0        1        7        3
    ## 5       B        2        4        5       10
    ## 6       B        0        3        4        8

``` r
long.df <- wide.df %>% 
  pivot_longer(c(Year2017, Year2018, Year2019, Year2020), 
               names_to = "Year", 
               values_to = "Counts")
head(long.df)
```

    ## # A tibble: 6 × 3
    ##   Species Year     Counts
    ##   <chr>   <chr>    <chr> 
    ## 1 A       Year2017 1     
    ## 2 A       Year2018 1     
    ## 3 A       Year2019 6     
    ## 4 A       Year2020 13    
    ## 5 A       Year2017 0     
    ## 6 A       Year2018 2

2.  The `stringr` library has a lot of good functions for dealing with
    strings, which are defined as any values that are bound by single or
    double quotations. The `str_sub()` function is useful for modifying
    strings. For example, in the database you gathered for the question
    above, you successfully created a column for year, but the term
    `year` was still appended to the date, making it a (character)
    string. It is likely you would want to use the numeric date. Use the
    `str_sub()` function to remove the term `Year` from data in the
    `Year` column.

``` r
long.df$Year.no <- as.numeric(str_sub(long.df$Year,-4,-1))
head(long.df$Year.no)
```

    ## [1] 2017 2018 2019 2020 2017 2018

3.  We discussed `dplyr` in class and reviewed some of its functions.
    Continuing with the dataframe in this exercise, use the
    `summarise()` function to report the mean number of each `species`
    for each `Year`. You may want to consider the `group_by()` function
    as well.

``` r
long.df.g <- long.df %>% 
  group_by(Year.no, Species) %>%
  summarise(yrct = mean(as.numeric(Counts)))
```

    ## `summarise()` has grouped output by 'Year.no'. You can override using the
    ## `.groups` argument.

``` r
head(long.df.g)
```

    ## # A tibble: 6 × 3
    ## # Groups:   Year.no [2]
    ##   Year.no Species  yrct
    ##     <dbl> <chr>   <dbl>
    ## 1    2017 A       0.667
    ## 2    2017 B       0.667
    ## 3    2017 C       1.33 
    ## 4    2018 A       2    
    ## 5    2018 B       2.67 
    ## 6    2018 C       3.67

4.  Finally, `ggplot` is the well known `tidyverse` package for
    plotting. Consider an appropriate plot type to show species `Counts`
    plotted against `Year`. Add some information, like color or shape,
    to indicate specific species. You are welcome to play with other
    `ggplot` themes, aesthetics, etc.

``` r
p <- ggplot(long.df, aes(as.numeric(Year.no), as.numeric(Counts), color=Species))
p + geom_jitter(size = 3, alpha = 0.5) + theme_classic(base_size = 15)
```

![](Lab_04_files/figure-gfm/unnamed-chunk-6-1.png)<!-- -->

**To complete this Exercise, please answer all questions showing code
and appropriate output. I don’t have to see everything (code and output)
if the output is correct and you are comfortable with what you coded.
But you are welcome to share anything you would like me to review.
Please upload an html document (RMarkdown-rendered) to Moodle by 9am
Thursday, February 29, 2024.**
