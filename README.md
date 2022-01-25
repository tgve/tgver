[![tic](https://github.com/tgve/tgver/actions/workflows/tic.yml/badge.svg)](https://github.com/tgve/tgver/actions/workflows/tic.yml)
[![Project Status](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)
[![codecov](https://codecov.io/gh/tgve/tgver/branch/master/graph/badge.svg?token=WAR82Q7597)](https://app.codecov.io/gh/tgve/tgver)

This is the R package for the TGVE front end `npm` package
[`tgve`](https://www.npmjs.com/package/eatlas). The R package is
developed to facilitate interactive geospatial analysis and
visualization in R, use R’s echo-system to drive advanced data
processing, and facilitate deployment of geospatial web applications in
production.

## Install

TGVE is not yet available on CRAN. For now please use
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
# knitr::include_url("https://tgve.github.io/app/")
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

## Preview

![tgve-vignette](https://user-images.githubusercontent.com/408568/141796882-2cf68f6b-a6e4-4836-9efa-bf1973f5cab9.png)

## Other instructions

You can clone the “master” branch or any other branch you want to run (except the npm branch).

``` r
tgve <- file.path(tempdir(), "eAtlas")
system(paste0("git clone https://github.com/layik/eAtlas ", tgve))
setwd(tgve)
```

Remember that the TGVE is a
[`geoplumber`](https://atfutures.github.io/geoplumber/index.html)
application, therefore we can check:

``` r
library(geoplumber)
# install.packages("devtools")
# get geoplumber from GitHub
# devtools::install_github("https://github.com/ATFutures/geoplumber.git")
setwd(tgve)
gp_is_wd_geoplumber()
```

    ## [1] TRUE

### Get some data

Let us get some data, this
[csv](https://raw.githubusercontent.com/layik/eatlas-data/main/ukcovid-0104-0505-2021.csv)
file containers few of the metrics from the UK COVID-19 API:

``` r
csv <- file.path(tgve, "R", "covid.csv")
download.file("https://raw.githubusercontent.com/layik/eatlas-data/main/ukcovid-0104-0505-2021.csv", destfile = csv)
names(read.csv(csv))
```

    ##  [1] "X"                            "regionCode"                  
    ##  [3] "regionName"                   "UtlaCode"                    
    ##  [5] "UtlaName"                     "LtlaCode"                    
    ##  [7] "LtlaName"                     "msoa11cd"                    
    ##  [9] "areaName"                     "areaType"                    
    ## [11] "date"                         "newCasesDateChange"          
    ## [13] "newCasesDateChangePercentage" "newCasesDateDirection"       
    ## [15] "newCasesDateRollingRate"      "newCasesDateRollingSum"

Note the `msoa11cd` in the above file. Now, let us get some geography to
visualize it. Again,
[this](https://github.com/layik/eAtlas/releases/download/0.0.1/msoa.geojson)
geojson file is processed from <https://geoportal.statistics.gov.uk> and
contains a matching column of `msoa11cd`:

``` r
geo <- file.path(tgve, "R", "msoa.geojson")
download.file("https://github.com/layik/eAtlas/releases/download/0.0.1/msoa.geojson", destfile = geo)
library(geojsonsf)
sf <- geojsonsf::geojson_sf(geo)
names(sf)
```

    ## [1] "msoa11cd"          "population"        "populationdensity"
    ## [4] "geometry"

``` r
# grepl("msoa11cd", names(sf))
## [1]  TRUE FALSE FALSE FALSE
```

Notes:

> We placed both files under the `R` directory for reasons you will see
> next.

### Run

We can start the backend, as documented elsewhere, using the simple
`run.R` file:

``` r
setwd(tgve)
tail(readLines("run.R"))
```

    ## [1] "}"                                                  
    ## [2] ""                                                   
    ## [3] "lapply(packages, library, character.only = TRUE)"   
    ## [4] ""                                                   
    ## [5] "r = plumber::plumb(file.path(\"R\", \"plumber.R\"))"
    ## [6] "r$run(port = 8000)"

We can do the same using `geoplumber`:

``` r
gp_plumb()
```

Now, there is a function defined in the TGVE `plumber.R` file which can
read either a local or remote file thanks to R’s `readLines` function.
The functions is as simple as this (as stated we skip `plumber`
details):

``` r
#' Get remote or local file and return it as json
#' @get /api/url
parse_url <- function(res, q = "") {
  if(q == '' || is.na(q) || is.null('') || nchar(q) < 5) {
    return(list(error=jsonlite::unbox("URL to parse is missing.")))
  }
  res$headers$`Content-type` <- "application/json"
  er <- try(res$body <- paste(readLines(q), collapse = '\n'), silent = TRUE)
  if(inherits(er, "try-error")) {
    msg <- paste0("Failed to read the URL: ", q)
    res$status <- 400 # Bad request
    list(error=jsonlite::unbox(msg))
  } else {
    return(res)
  }
}
```

This results in a `/api/url` API endpoint which we can use and takes one
argument named `q` with the file or remote file path/URI. You can test
the API with a remote/local file yourself by visiting the current
backend URL of `http://localhost:8000/api/url?q=covid.csv` and that
tells `R` to read the local file `covid.csv` which we downloaded above
and placed it next to the `plumber.R` file.

> we do not need to download the files, we can pass the URL to the API
> endpoint like:
> `http://localhost:8000/api/url?q=https://domain.com/file.csv`. This is
> to demonstrate how you can pass your own sensitive/protected data
> locally.

``` r
setwd(tgve)
list.files("R", pattern = "csv|json|plumber")
```

    ## [1] "covid.csv"    "msoa.geojson" "plumber.R"

Finally, as stated in this Wiki article, you can just assign two URLs to
the environmental variables:

``` sh
export REACT_APP_DEFAULT_URL=http://localhost:8000/api/url?q=covid.csv
export REACT_APP_GEOGRAPHY_URL=http://localhost:8000/api/url?q=msoa.geojson
export REACT_APP_GEOGRAPHY_COLUMN_NAME=msoa11cd 
export REACT_APP_COLUMN_NAME=newCasesDateChange
```

and start the front-end dev server:

``` r
setwd(tgve)
gp_plumb_front()
```

Or you can stop the `run.R` separate process above, build the app and
run:

``` r
setwd(tgve)
gp_build()
gp_plumb()
```

You should see something like this:
<img width="90%" src="https://user-images.githubusercontent.com/408568/118688312-db5f5900-b7fd-11eb-97ec-16ec32f391a2.png" />
