#' Helper function to setup a local directory instead of `tempInstance`.
#'
#' @param path Character URI to copy tgve instance in.
#' @param create Boolean to create new directory at path, defaults to `TRUE`.
#'
#' @examples {
#' p = file.path(tempdir(), "tgve")
#' setup(p)
#' }
#' @export
setup = function(path = NULL, create = TRUE) {
  if(!is.character(path) || length(path) != 1) {
    stop("setup takes one character variable.")
  }

  if(dir.exists(path)) {
    d = file.path(path, "tgve")
    if(dir.exists(d)) {
      stop("directory named `tgve` exists at given path.")
    }
    copy_tgve(path)
    message("A TGVE instance has been created at: ", d)
  } else {
    pare.path = dirname(path)
    if(dir.exists(pare.path) && create) {
      dir.create(path)
      setup(path, create = FALSE)
    } else {
      stop("attempting to create destination parent directory failed.")
    }
  }
}
