
<!-- README.md is generated from README.Rmd. Please edit that file -->

# reohelpers

<!-- badges: start -->
<!-- badges: end -->

The goal of reohelpers is to make te reo easier to use in R.

## Installation

reohelpers is not yet released on [CRAN](https://CRAN.R-project.org) but
you can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("joevalalipin/reohelpers")
```

## Overview

-   `add_macron()` adds macrons appropriately to vowels in te reo words
    or phrases.
-   `macron_vowel()` adds macrons to single or multiple vowels in a
    given string.
-   `meaning()` returns a dataframe of meanings of each word in a given
    string.

## Examples

### add\_macron()

``` r
ggplot(mtcars, aes(x = cyl, y = hp, group = cyl)) +
  geom_boxplot() +
  labs(title = add_macron("Number of cylinders and horsepower in motoka dataset")) +
  theme_classic()
```

<img src="man/figures/README-unnamed-chunk-2-1.png" width="100%" />

### macron\_vowels()

``` r
# data.frame(vowel = c("a", "e", "i", "o", "u")) %>% 
#   mutate(macrons = macron_vowel(vowel))
```

### meaning()
