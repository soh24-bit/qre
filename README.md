
<!-- README.md is generated from README.Rmd. Please edit that file -->

# qre

<!-- badges: start -->

<!-- badges: end -->

In classic game theory, the Nash Equilibrium concept assumes that
players are perfectly rational and will always choose the strategy that
maximizes their payoff, given their opponents’ actions. However,
empirical studies of human behavior show that players often make
mistakes. The Quantal Response Equilibrium (QRE) is a widely used model
that relaxes the assumption of perfect rationality by introducing
probabilistic choice. The goal of qre is to solve for the QRE of a game
by finding the rationality parameter, lambda, that best explains a set
of observed outcomes. Additionally, “plot” s3 object helps users
visualize and assess the model’s fit.

## Installation

You can install the development version of qre from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("soh24-bit/qre")
```

## What’s Left?

I still have to implement the “plot” s3 object and organize the roxygen
skeleton better.

## Example

This is a basic example which shows you how to solve a common problem:

``` r
## basic example code
```

What is special about using `README.Rmd` instead of just `README.md`?
You can include R chunks like so:

``` r
summary(cars)
#>      speed           dist       
#>  Min.   : 4.0   Min.   :  2.00  
#>  1st Qu.:12.0   1st Qu.: 26.00  
#>  Median :15.0   Median : 36.00  
#>  Mean   :15.4   Mean   : 42.98  
#>  3rd Qu.:19.0   3rd Qu.: 56.00  
#>  Max.   :25.0   Max.   :120.00
```

You’ll still need to render `README.Rmd` regularly, to keep `README.md`
up-to-date. `devtools::build_readme()` is handy for this.

You can also embed plots, for example:

<img src="man/figures/README-pressure-1.png" width="100%" />

In that case, don’t forget to commit and push the resulting figure
files, so they display on GitHub and CRAN.
