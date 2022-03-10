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

The Turing Geovisualisation Engine (TGVE) is an open source, web-based, interactive visual analytics tool for geospatial data analysis, built using R and React. The R package **tgver** is developed to be used with the TGVE front end npm package [`tgvejs`](https://www.npmjs.com/package/@tgve/tgvejs). The R package aims to facilitate interactive geospatial analysis and visualization in R, using R’s ecosystem to drive advanced data processing, and facilitate deployment of geospatial web applications in production.

The package is needed because data scientists and researchers who want to rapidly perfrom spatiotemporal querying of a dataset would need to learn various concepts and R packages that might operate very differently to their usual data analysis and processing workflows. Using the **tgver** package all they need is a `.geojson` geography file and a `csv` data file (currently the npm package can only parse those two formats). They can do this either in Rmarkdown notebooks or indeed in Jupyter notebooks. The functions defined in the package facilitates the aims mentioned above.

Finally, the **tgver** takes a different approach of bringing JavaSCript (JS) applications into R but specifically bringing modern libraries like React into R. Some R packages (such as Shiny [@beeley2013web]) rely on a coupled method of using R and JS. There are other mapping packages which drive JS from R. The **tgver** uses a production built output from a React application and relies on RESTful client-server communication using the `plumber` [@plumber] R package. 

# References

