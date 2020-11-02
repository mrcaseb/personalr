
<!-- README.md is generated from README.Rmd. Please edit that file -->

# personalr <img src='man/figures/logo.png' align="right" height="139" />

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
<!-- badges: end -->

## Preface

If you work with R or any other programming language for a while, you
will come to the point where you want to use already written code when
developing a script and often need the same packages to do your work.The
easiest solution is to save the loading of the regularly used packages
and maybe some helper functions in a separate script and then load this
script with `source(...)` into the Global Environment. However, this
approach has two disadvantages:

1.  Over time, the Global Environment becomes littered, making it harder
    to find important objects and
2.  The `source` script must either be available and up-to-date on the
    local machine or be made available on the Internet.

## Package Purpose

The goal of personalr is to …

## Installation

You can install the released version of personalr from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("personalr")
```

And the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("mrcaseb/personalr")
```
