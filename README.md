
<!-- README.md is generated from README.Rmd. Please edit that file -->

[![tic](https://github.com/tgve/tgver/actions/workflows/tic.yml/badge.svg)](https://github.com/tgve/tgver/actions/workflows/tic.yml)
[![Project Status: Active – The project has reached a stable, usable
state and is being actively
developed.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)
[![codecov](https://codecov.io/gh/tgve/tgver/branch/master/graph/badge.svg?token=WAR82Q7597)](https://app.codecov.io/gh/tgve/tgver)

# What is TGVE?

The Turing Geovisualisation Engine (TGVE or eAtlas) is a web-based,
interactive visual analytics tool for geospatial data analysis, built
using R & React. The visual views and interaction mechanisms designed
into the tool is underpinned by empirically-informed guidelines around
visualization design and techniques from Geographic Information Science
(GIScience).

# tgver

This is the R package for TGVE front end `npm` package
[`tgve`](https://www.npmjs.com/package/eatlas). The R package is
developed to facilitate interactive geospatial analysis and
visualization in R, use R’s echo-system to drive advanced data
processing, and facilitate deployment of geospatial web applications in
production.

## Install

For now whilst working towards submitting it to CRAN, please use
devtools:

``` r
# install.packages("devtools")
devtools::install_github("tgve/tgver")
```

## Use

Overall, as of this pre-CRAN release, the package takes advantage of how
TGVE can be used (see this
[Wiki](https://github.com/tgve/eAtlas/wiki/Using-TGVE) entry) and
provides options to R users.

For instance, this document is a Markdown (GitHub) document generated
using an Rmarkdown (Rmd) document, if the Rmd is rendered to a HTML
output, then using `knitr::include_url` we should see an instance of the
TGVE embedded in the document. Please see the live examples in the
[vignette](https://tgve.github.io/tgver/articles/tgver.html) which is
rendered to HTML.

To do this we can go:

``` r
# this is the most basic use
# tgver::tgve()
# to embed in a html rendered Rmd
html.file = tgver::tgve(browse = FALSE)
knitr::include_url(html.file)
```

The first function `tgver::tgve(browse=FALSE)` prepares an instance of
the TGVE but does not run/open it, it returns its path (a `tempdir()`
path). The second line is `knitr` function to embed the first line’s
output.

That was the simplest way of running an instance of TGVE on the local
machine. The more advanced but similar function of this package, with
the back-end as a `plumber` API and serving the same instance, would be
like:

``` r
# start a tgve instance before embedding it
ps = tgver::tgve_server(background = TRUE)
#> Attempting to serve TGVE instance from: /tmp/Rtmpevq9TT/tgve
#> Running plumber at: http://127.0.0.1/8000
knitr::include_url("http://127.0.0.1:8000")
# kill the process returned from underlying `callr`
ps$kill()
# or use the public one
# knitr::include_url("https://tgve.github.io/eatlas-template/")
```

## Explore `sf` objects

For these purposes, the package relies on the `plumber` API to serve
data. So, again within HTML outputs we can explore `sf` objects like so:

``` r
# using sf
nc = sf::st_read(system.file("shape/nc.shp", package="sf"))
tgver::explore_sf(nc)
```

For more see the
[vignette](https://tgve.github.io/tgver/articles/tgver.html).

# Development plan

Please see the vignette called
[“dev-plan”](https://tgve.github.io/tgver/articles/dev-plan.html) for
details.

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

Please note that the `tgve` package is released with a [Contributor Code
of Conduct](CODE_OF_CONDUCT.md) copied from the template package
`RpackageTemplate`. We will work on these docs later.

## Package Status

This package is part of ongoing research at the University of Leeds, it
is provided “as is” and is likely to be updated and changed without
warning to meet the research needs of the University.
