#' Set the TGVE variables.
#'
#' The placeholders in the bundled version are named with pattern: "tgver.*" in
#' the main component (eatlas-template). They can be replaced using the
#' `file_replace()` function.
#'
#' @param path to be passed to `file_replace` function
#' @param ... any or all of the TGVE API variables to replace/add values to.
#'
#' @examples \dontrun{
#' build(file.path(tempdir(), "tgve"))
#' }
#'@export
build = function(path, ...) {
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
