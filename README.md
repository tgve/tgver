[![tic](https://github.com/tgve/tgver/actions/workflows/tic.yml/badge.svg)](https://github.com/tgve/tgver/actions/workflows/tic.yml)
[![Project Status](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)
[![codecov](https://codecov.io/gh/tgve/tgver/branch/master/graph/badge.svg?token=WAR82Q7597)](https://app.codecov.io/gh/tgve/tgver)

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

# Preview

![tgve-vignette](https://user-images.githubusercontent.com/408568/141796882-2cf68f6b-a6e4-4836-9efa-bf1973f5cab9.png)

## Contribution

Please note that the `tgve` package is released with a [Contributor Code
of Conduct](CODE_OF_CONDUCT.md) copied from the template package
`RpackageTemplate`. We will work on these docs later.

## Package Status

This package is part of ongoing research at the University of Leeds, it
is provided “as is” and is likely to be updated and changed without
warning to meet the research needs of the University.

## Other notes

The application is a fully decoupled R + JavaScript two tier application
which is built on top RStudio’s plumber APIs using an R package called
[geoplumber](https://github.com/ATFutures/geoplumber), which is not yet on CRAN. That means it is an R powered backend API (think Flask in Python) and a ReactJS front end. In future the R backend may be replaced with other choices of backend such as
Python or NodeJS.

Once the dependencies of `geoplumber` and particularly the NodeJS system
dependencies are all in place. An example of visualizing R’s `sf` object
format in `geoplumber` using eAtlas is as simple as following lines:

``` r
# installing the R package from github requires 
# R package devtools
devtools::install_github("ATFutures/geoplumber")
# load the libray
library(geoplumber)
# create new project at temporary directory called `reprex`
p = file.path(tempdir(),"reprex")
gp_create(p)
# making it the working directory
setwd(p)
# build the application (front-end)
gp_build()
# gp_explore uses eAtlas by default
gp_explore()
```

In RStudio you should now be able to see something like following
screenshot:
<img width="100%" alt="RStuio viewer showing eAtlas" src="https://user-images.githubusercontent.com/408568/81685038-9452c100-944f-11ea-946c-795ef70791b3.png">

You can also use the "full-template" repository to run on your local/production environment:
https://github.com/tgve/full-template.

Here are some additional R instructions that for running the app using `geoplumber`; not sure how they relate to the above:

  - (optional) will be looking for a Mapbox API key, having obtained a
    Mapbox API key in `.env.local` file using variable name:
    `REACT_APP_MAPBOX_ACCESS_TOKEN = 'API_KEY'`

  - change the `PRD_URL` in the `Constants.js` file to `localhost:8000`.
    Default value is `https://layik.github.io/eAtlas` for this repo to
    publish on GitHub pages.

Then you can run

``` r
library(geoplumber)
gp_plumb()
```

visit `localhost:8000`
