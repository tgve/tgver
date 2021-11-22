#' Open static TGVE instance
#'
#' This is the main and most basic function to run an instance of TGVE without
#' back-end. Compared to \link[tgver]{tgve_server}, this function only uses
#' \link[tgver]{build} to setup an instance then opens the entry HTML file.
#' If a path of an instance is provided it opens it, otherwise creates an
#' instance at the `tempdir`.
#'
#' @param path character directory of a current instance to browse. Defaults to
#' `TEMP_PATH_ENV` environment variable.
#' @param browse boolean to decide whether to browse the instance or not.
#'
#' @return directory of the new instance if `path` is not provided.
#'
#' @examples {
#' tgve()
#' # just get the path of the HTML
#' p = tgve(browse = FALSE)
#' file.exists(p)
#' }
#'
#' @export
tgve = function(path = Sys.getenv("TEMP_path_ENV"), brwose = TRUE) {
  new.path = path
  if(!dir.exists(path)) {
    new.path = tempInstance()
  }

  build(new.path)

  new.path = file.path(new.path, "index.html")

  if(!browse) {
    return(new.path)
  }

  openURL(new.path)
}
