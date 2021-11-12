#' Helper function to replace particular variable in bundled minified TGVE JS.
#' The difference between this function and base::gsub is only finding those
#' files that contain the pattern, use gsub on them and write the fails back to
#' where they are.
#'
#'@param path where instance of TGVE is located.
#'@param pattern the pattern to replace using gsub.
#'@param replacement the string to replace pattern with using gsub.
replace = function(path = NULL, pattern, replacement) {
  if(is.null(path) || !dir.exists(path))
    stop("Error: valid tgve instance path is required.")
  # main.*.chunk.js*
  files = list.files(file.path(path, "static/js"),
                     pattern = "^main*",
                     full.names = TRUE)
  for(x in files){
    content = readLines(x)
    # grep("tgver.dark", content)
    content = gsub(pattern, replacement, content)
    writeLines(content, x)
  }
}

#' Set TGVE variables.
#'
#' The placeholders in the bundled version are named with patter: "tgver.*" in
#' the main component (eatlas-template). They can be replaced using the
#' `replace()` function.
#'@param path to be passed to `replace` function
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
  for (x in names(apis)) {
    if(x %in% given) {
      replace(path, apis[x], args[x])
    } else {
      replace(path, apis[x], "")
    }
  }
}
