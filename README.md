
<!-- README.md is generated from README.Rmd. Please edit that file -->

[![tic](https://github.com/tgve/tgver/actions/workflows/tic.yml/badge.svg)](https://github.com/tgve/tgver/actions/workflows/tic.yml)
[![Project Status: Active – The project has reached a stable, usable
state and is being actively
developed.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)

# tgver

This is the R package for TGVE front end npm package `tgve`. The R
pacakge is developed to: 1. do interactive geospatial analysis and
visuaulization fast 2. use R’s echosystem to drive (1) 3. facilitate
application deployment for production

## Install

For now whilst working towards submitting it to CRAN, please use
devtools:

``` r
# install.packages("devtools")
devtools::install_github("tgve/tgver")
```

## Example

This is a Markdown (GitHub) document generatd using an Rmarkdown (Rmd)
document, if the Rmd is rendered to a HTML output, then using
`knitr::include_url` we should see the TGVE embeded (see the live
examples in the vignette).

``` r
# start a tgve instance before embedding it
tgver::tgve(background = TRUE)
knitr::include_url("http://127.0.0.1:8000")
# or use the public one
# knitr::include_url("https://tgve.github.io/eatlas-template/")
```

## TGVE interactive

Similarly, within HTML outputs we can explore (current version) `sf`
objects:

``` r
# using sf
nc = sf::st_read(system.file("shape/nc.shp", package="sf"))
tgver::explore(nc)
```

# Development plan

Please see the vignette called “dev-plan” for details.

# Preview

![tgve-vignette](https://user-images.githubusercontent.com/408568/141796882-2cf68f6b-a6e4-4836-9efa-bf1973f5cab9.png)

## Funding

The project is led by Dr [Nik
Lomax](https://environment.leeds.ac.uk/geography/staff/1064/dr-nik-lomax)
and Dr [Roger
Beecham](https://environment.leeds.ac.uk/geography/staff/1003/dr-roger-beecham)
and funded by the EPSRC via the Alan Turing Institute AI for Science and
Government Programme, Grant/Award Number: EP/T001569/1.

## Contribution

Please note that the `RpackageTemplate` project is released with a
[Contributor Code of Conduct](CODE_OF_CONDUCT.md). By contributing to
this project, you agree to abide by its terms.

## Package Status

This package is part of ongoing research at the University of Leeds, it
is provided “as is” and is likely to be updated and changed without
warning to meet the research needs of the University.
