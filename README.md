
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

## Example

This is a Markdown (GitHub) document, if it is rendered to a HTML
output, then using `knitr::include_url` we should see the TGVE embeded
(see the live examples in the vignette).

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
tgver::explore(sf)
```

# Development plan

The current plan is to do use a different approach of using the TGVE npm
package in this R package compared to how it is used in `geoplumber`.
This is done mainly by bundling latest releases of the npm package
within this package. This means not relying on npm/yarn tools for
JavaScript (JS) building and bundling. As the `tgve` npm package has
(see the docs) API settings to explore geospatial data, we can use R to
do this without relying on the underlying JS toolchains.

We can then look at the required functions to enable workflows. For
instance, a typical case would be for the package to look at a data
directory and understand the data format and serve it to the front end
to consume without JS builds.

Another use case would be to enable embedding `tgve` within Rmarkdowns
and indeed Jupyter notebooks (both with challenges). At the moment this
looks like it needs changes to be made to the npm package so that not
only API and environement variables are accepted but also URL (query)
variables are also accepted. If this can be achieved, then we can
theoretically embed the HTML bunlded in this package within Rmarkdowns
and any other browser based data science workflows.

The third use case would be to see how bundled/downloaded native apps
(see the docs) generated using Rust based Tauri apps can also be driven
from R or the platform (operating system) as this is not possible from
browsers (of course this is possible within NodeJS).

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
