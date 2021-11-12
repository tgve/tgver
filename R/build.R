
#' Set TGVE variables.
#'
#' The placeholders in the bundled version are named with patter: "tgver.*" in
#' the main component (eatlas-template). They can be replaced using the
#' `file_replace()` function.
#'@param path to be passed to `file_replace` function
#'@param ... any or all of the TGVE API variables to replace/add values to.
build = function(path, ...) {
  apis = c(tooltipColumns="tgver.tooltipColumns",
           geographyURL="tgver.geographyURL",
           geographyColumn="tgver.geographyColumn",
           column="tgver.column",
           data="tgver.data",
           layerName="tgver.layerName",
           dark="tgver.dark",
           viewport="tgver.viewport",
           hideChartGenerator="tgver.hideChartGenerator",
           hideCharts="tgver.hideCharts")
  args = list(...)
  args.names = names(args)
  given = intersect(args.names, names(apis))
  files = list_api_files(path)
  for (x in names(apis)) {
    for (fname in files) {
      if(x %in% given) {
        file_replace(fname, apis[x], args[x])
      } else {
        # cat("replacing...", apis[x], "with", "\"\"\n")
        file_replace(fname, apis[x], "")
      }
    }
  }
}
