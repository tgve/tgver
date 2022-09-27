---
title: 'Turing Geovisualization Engine R package'
tags:
  - geovisualization
  - visualization
  - spatiotemporal data
authors:
 - name: L Hama
   orcid: 0000-0003-1912-4890
   affiliations: 1
 - name: R Beecham
   orcid: 0000-0001-8563-7251
   affiliations: 2
 - name: N Lomax
   orcid: 0000-0001-9504-7570
   affiliations: 2
affiliations:
 - name: Leeds Institute for Data Analytics (LIDA), University of Leeds
   index: 1
 - name: School of Geography and Leeds Institute for Data Analytics (LIDA), University of Leeds
   index: 2
date: 18 March 2022
bibliography: paper.bib
---

# Summary

The Turing Geovisualisation Engine (TGVE) is an open source, web-based, interactive visual analytics tool for geospatial data analysis, built using R and React. The R package **tgver** is developed to utilize the TGVE front end npm package [`tgvejs`](https://www.npmjs.com/package/@tgve/tgvejs). The aim of the R package (published on CRAN - Comprehensive R Archive Network) is to facilitate interactive geospatial analysis and visualization using R, and facilitate deployment of geospatial web applications. The **tgver** takes a different approach of bringing JavaScript (JS) applications into R, specifically bringing modern libraries like React into R. Some R packages (such as Shiny [@beeley2013web]) rely on a coupled method of using R and JS. There are other mapping packages which drive web pages (HTML, JS and CSS) from R. The **tgver** uses a production built output from a React application and relies on RESTful [@restful] client-server communication using the `plumber` [@plumber] R package.

## Statement of need

Geospatial data is complex and require advance tools as they are different from other data [@saraee2018new]. In order to process spatial data in R there are various packages to use to generate maps and visualizationas. Packages like `tmap`, `sf`, `ggplot` and others are widely used for generating static graphics. This complexity of geospatial data requires users to learn how to use such packages, the underlying system libraries and also structure of the data, too.

The **tgver** package is needed because it enables data scientists and researchers to rapidly perform spatiotemporal querying of a dataset. The package users still need to learn how the TGVE works, but in a typical scenario we believe this package can save them time and effort.

For instance, a data scientist has some geography data (e.g. a GeoJSON file) and a referenced tabular data (e.g a `csv` file) and need to see the data on a map, they can bypass defer the learning burdon and get on with generating some meaningful visualizations much faster compared to alternatives. Learners can do this without learning about concepts like data sctructure (e.g. Simple Features) whilst advanced users can also use the tool to save time.

The other aspect of the need is interactivity in geospatial data visualization. Data scientists can also do this in HTML files (web pages), Rmarkdown or Jupyter notebooks. Integrating the TGVE front-end is one of the aims of this package. Another aspect of the need is to decrease the need for downloading remote data into data scientist's workflows by passing the URL's of the datasets directly to the TGVE front-end with required API variables.

To demonstrate how the above mentioned learner data scientist can use the package, let us assume our user has a `.geojson` file which contains some geography and a `.cvs` file that is said to have the data. We also assume the files are in folder named `data` and have installed the **tgver** package. Then all they have to do is:

```r
# assume the path is /home/user/data
path = "/home/user/data"
tgver::explore_dir(path)
```

For a simple scenario like this, the package sets up a web application using the TGVE front-end and R package `plumber` under the hood. The two files are processed in R, and served via a `plumber` API to the TGVE front-end. This R package saves users doing these:

* Read: using packages like `sf` which is a dependancy of the **tgver**
* Match geography: find matching column name which contains the geography
* Visualize: use packages such as `ggplot2`, `tmap`, `leaflet` etc.

For a medium/advanced R users, the package enables interactive R based workflow of the same scenario using other geospatial R packages and objects. For instance, this early version of the package supports `sf`[@pebesma2018sf] objects. Working with `sf` objects, a **tgver** R package based workflow could be:

```r
require(weathercan)
require(sf)
require(geojsonsf)
# get some weather stations
w = w = weathercan::stations()[1:1000,]
# clean up the data
w = w[!is.null(w$lat) & !is.null(w$lon), ]
# turn the points into an sf object
w.sf = st_as_sf(w, coords = c("lon", "lat"))
# explore it in TGVE
tgver::explore_sf(w.sf)
#> Serving data from http://127.0.0.1:8000/explore_sf
#> Browsing http://127.0.0.1:8000?defaultURL=http://127.0.0.1:8000/explore_sf
#> Running plumber API at http://127.0.0.1:8000
```

The package can also work with a remote instance of the front-end TGVE. This can be useful when embedding TGVE in an Rmarkdown (or a Jupyter notebook). An instance of the TGVE front-end is available at: https://tgve.github.io/app/. We can construct a URL as follows and see a `.geojson` file and a `.csv` file being pulled and processed by the TGVE front-end using its API variables:

```r
# tgver can use a local instance if no `base` is provided
base = "https://tgve.github.io/app/"
# data source
defaultURL = "https://raw.githubusercontent.com/tgve/example-data/main/schools/data.csv"
# separate geography source
geographyURL = "https://raw.githubusercontent.com/saferactive/tgve/main/las-only-code.geojson"
# tgver makes sure the variables are valid
# TGVE API values. See help for `tgver::get_url`
url = tgver::get_url(
  base = base,
  defaultURL = defaultURL,
  geographyURL= geographyURL,
  geographyColumn = "la_code", # optional
  column = "ranking_count"
)
# using knitr R package
knitr::include_url(url)
```

![](https://pbs.twimg.com/media/FNZvMolX0AclK4l?format=jpg)
*Figure 1: A screenshot from the above URL rendered on Firefox v97.0 on an Ubuntu 20.04. The figure shows school rankings [@edubase] from the `csv` data source using the `.geojson` geography file (UK's Local Authority District boundaries). The data has been subset further with (using TGVE's filtering user interface) rankings showing "Outstanding" school rankings only.*

Figure 1 shows how the `knitr::include_url` function can be used in Rmarkdowns if the output of the document is set to `output: html_document`.


## Acknowledgement
This work was supported by Towards Turing 2.0 under the EPSRC Grant EP/W037211/1 & The Alan Turing Institute.

# References

