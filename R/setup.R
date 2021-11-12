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
    stop("Error: setup takes one character variable.")
  }
  if(dir.exists(path)) {
    inst.copied = file.copy(list.files(system.file("tgve", package = "tgver"),
                                       full.names = TRUE),
                            path, recursive = TRUE)
    if(!all(inst.copied))
      stop("Error: could not create TGVE instance.")

    message("A TGVE instance has been created at: ", path)
  } else {
    pare.path = dirname(path)
    if(dir.exists(pare.path) && create) {
      dir.create(path)
      setup(path, create = FALSE)
    }
  }
}
