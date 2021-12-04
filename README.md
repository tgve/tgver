
<!-- README.md is generated from README.Rmd. Please edit that file -->

[![tic](https://github.com/tgve/tgver/actions/workflows/tic.yml/badge.svg)](https://github.com/tgve/tgver/actions/workflows/tic.yml)
[![Project Status: Active – The project has reached a stable, usable
state and is being actively
developed.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)
[![codecov](https://codecov.io/gh/tgve/tgver/branch/master/graph/badge.svg?token=WAR82Q7597)](https://codecov.io/gh/tgve/tgver)

# tgver

This is the R package for TGVE front end `npm` package `tgve`. The R
package is developed to: (1) do interactive geospatial analysis and
visualization fast. (2) use R’s echo-system to drive (1) and (3)
facilitate web application deployment for production.

## Install

For now whilst working towards submitting it to CRAN, please use
devtools:

``` r
# install.packages("devtools")
devtools::install_github("tgve/tgver")
```

## Use

This is a Markdown (GitHub) document generated using an Rmarkdown (Rmd)
document, if the Rmd is rendered to a HTML output, then using
`knitr::include_url` we should see the TGVE embedded. Please see the
live examples in the
[vignette](https://tgve.github.io/tgver/articles/tgver.html).

The embedded front-end within the R package can be used like:

``` r
# this is the most basic use
# tgver::tgve()
# to embed in a html rendered Rmd
html.file = tgver::tgve(browse = FALSE)
knitr::include_url(html.file)
```

The similar function, with the back-end as a `plumber` API and serving
the same instance, would be like:

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

The simplest way to use the TGVE is using an instance running at a
local/remote server. As of version `1.3.5-beta.0` of the TGVE (eatlas)
npm package, it takes URL “query parameter” based API variables
provided. Therefore, we can simply run an instance such as the
`eatlas-template` instance as follows without doing anything else (again
not in this Markdown doc):

``` r
knitr::include_url("https://tgve.github.io/eatlas-template?defaultURL=https://raw.githubusercontent.com/layik/eatlas-data/main/casualties_100.geojson")
```

What is happening there? We grab the instance, but instead of its
internal values, the URL parameters takes precedence. That means the
value given as `defaultURL` is parsed by the TGVE.

## Explore `sf` objects

For these purposes, the package relies on the `plumber` API to serve
data. So, again within HTML outputs we can explore `sf` objects like so:

``` r
# using sf
nc = sf::st_read(system.file("shape/nc.shp", package="sf"))
tgver::explore_sf(nc)
```

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
