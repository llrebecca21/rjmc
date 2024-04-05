
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rjmc

<!-- badges: start -->
<!-- badges: end -->

The goal of rjmc is to …

## Installation

You can install the development version of rjmc from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("llrebecca21/rjmc")
```

## Example

We will walk through how to use this package to implement Example 1.2
from Robert and Casella’s “Efficient Construction of reversible jump
Markov chain Monte Carlo proposal distributions” (2003) and Example 2.7
in Godsill’s “On the Relationship Between Markov Chain Monte Carlo
Methods for Model Uncertainty” (2001).

First need to create a time series of length `maxT`.

``` r
library(rjmc)
```

You’ll still need to render `README.Rmd` regularly, to keep `README.md`
up-to-date. `devtools::build_readme()` is handy for this.

You can also embed plots, for example:

<img src="man/figures/README-pressure-1.png" width="100%" />

In that case, don’t forget to commit and push the resulting figure
files, so they display on GitHub and CRAN.
