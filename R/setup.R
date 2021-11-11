#' Helper function to setup a local directory instead of `tempInstance`.
#'
#' @param path to copy tgve instance in
#' @param create whether to create new directory at path, detaults to `TRUE`
#'
#' @examples {
#' p = file.path(tempdir(), "tgve")
#'
#' }
#' @export
setup = function(path = NULL, create = TRUE) {
  if(!is.character(path) || length(path) != 1) {
    stop("Error: setup takes one character variable.")
  }
  if(dir.exists(path)) {
    inst.copied = file.copy(list.files(system.file("tgve", package = "tgver"),
                                       full.names = TRUE),
                            path, recursive = TRUE)
    if(!file.exists(path))
      stop("Error: could not create temp directory.")

    message("A TGVE instance has been created at: ", path)
  } else {
    pare.path = dirname(path)
    if(dir.exists(pare.path) && create) {
      dir.create(path)
      setup(path, create = FALSE)
    }
  }
}
