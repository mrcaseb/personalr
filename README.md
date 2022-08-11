
<!-- README.md is generated from README.Rmd. Please edit that file -->

# personalr <img src='man/figures/logo.png' align="right" height="139" />

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version-ago/personalr)](https://CRAN.R-project.org/package=personalr)
[![CRAN
downloads](http://cranlogs.r-pkg.org/badges/grand-total/personalr)](https://CRAN.R-project.org/package=personalr)
[![Lifecycle:
stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable)
[![R-CMD-check](https://github.com/mrcaseb/personalr/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/mrcaseb/personalr/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

## Preface

If you work with R or any other programming language for a while, you
will come to the point where you want to use already written code when
developing a script and often need the same packages to do your work.The
easiest solution is to save the loading of the regularly used packages
and maybe some helper functions in a separate script and then load this
script with `source(...)` into the Global Environment.

However, this approach has two disadvantages:

1.  Over time, the Global Environment becomes littered, making it harder
    to find important objects and
2.  The `source` script must either be available and up-to-date on the
    local machine or be made available on the Internet.

## Package Purpose

The best solution for the above mentioned disadvantages is an own
(personal) package, but for the setup it needs a basic understanding of
how to develop packages.

The goal of personalr is to do exactly that. A basic setup of a personal
package, which loads a modifiable list of packages and some basic
functions.

## Installation

You can install the released version of personalr from
[CRAN](https://cran.r-project.org/package=personalr) with:

``` r
install.packages("personalr")
```

You can install the development version from
[GitHub](https://github.com/mrcaseb/personalr/) with:

``` r
if (!require("pak")) install.packages("pak")
pak::pak("mrcaseb/personalr")
```

## One more thing

personalr is open source and it builds on top of other open source
projects. However, maintaining this package will be a lot of work so I
kindly ask you to consider donating at
[patreon](https://www.patreon.com/mrcaseb).
