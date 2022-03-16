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
date: 9 March 2022
bibliography: paper.bib
---

# Summary

The Turing Geovisualisation Engine (TGVE) is an open source, web-based, interactive visual analytics tool for geospatial data analysis, built using R and React. The R package **tgver** is developed to be used with the TGVE front end npm package [`tgvejs`](https://www.npmjs.com/package/@tgve/tgvejs). The R package aims to facilitate interactive geospatial analysis and visualization in R, using R’s ecosystem to drive advanced data processing, and facilitate deployment of geospatial web applications in production. A design principle in the TGVE is to bring the reproducibility of data science workflows into Graphic User Interfaces (GUI). The approach is to use web standards to allow R users to use the TGVE's API (Application Programming Interface) to generate visualizations that can be reproduced. 

## Statement of need

The package is needed because data scientists and researchers who want to rapidly perform spatiotemporal querying of a dataset would need to learn various concepts and R packages that might operate very differently to their usual data analysis and processing workflows. Using the **tgver** package they still need to learn how the TGVE works, but in a typical scenario when a data scientist has a `.geojson` geography file and a `csv` data file and want to generate geospatial visualizations, they can bypass some of the workflows required. The TGVE front-end npm package can process these two files, search for a matching column between them and generate visualizations based on the data in either or both of the data sources. If the `.geojson` or the `csv` file contains the geography, in the case of the csv `latitude` and `longitude` columns, the TGVE can process it as well. Users can also do this either in Rmarkdown notebooks or indeed in Jupyter notebooks. This is one of the main features of the TGVE and has been driven by the work in the **tgver** R package. If the data sources are hosted remotely and are available for processing, the TGVE can take the URLs (Unified Resource Locator) as URL parameters. 

For example the UK's Local Authority District boundaries can be found at this URL: https://raw.githubusercontent.com/saferactive/tgve/main/las-only-code.geojson. And school ranking data published by the UK government processed can be found at this URL: https://raw.githubusercontent.com/tgve/example-data/main/schools/data.csv. An instance of the TGVE is available at: https://tgve.github.io/app/. We can then construct a URL as follows and see the data sources being pulled and processed by the TGVE using some of the API variables of the TGVE like `defaultURL`, `geographyURL` etc.:

```r
# using knitr R package
knitr::include_url(
   paste0(
   "https://tgve.github.io/app/?",
   "defaultURL=https://raw.githubusercontent.com/tgve/example-data/main/schools/data.csv&",
   "geographyURL=https://raw.githubusercontent.com/saferactive/tgve/main/las-only-code.geojson&",
   "geographyColumn=la_code&",
   "column=ranking_count"))
```

![](https://pbs.twimg.com/media/FNZvMolX0AclK4l?format=jpg)
*Figure 1: A screenshot from the above URL renderd on Firefox v97.0 on an Ubuntu 20.04. The figure shows school rankings from the `csv` data source using the `.geojson` geography file. The data has been subset further with rankings showing "Outstanding" school rankings only.*

A screenshot of the above link is shown in Figure 1. Likewise if the data is not available remotely and we are working with local dataset, such as an `sf` object, then a TGVE based workflow would be like the following using the R package:

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
```

Finally, the **tgver** takes a different approach of bringing JavaSCript (JS) applications into R but specifically bringing modern libraries like React into R. Some R packages (such as Shiny [@beeley2013web]) rely on a coupled method of using R and JS. There are other mapping packages which drive JS from R. The **tgver** uses a production built output from a React application and relies on RESTful client-server communication using the `plumber` [@plumber] R package. 

# References

