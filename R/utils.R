TEMP_DIR_ENV = "TEMP_DIR_ENV"

openURL = function(host = "127.0.0.1",
                    port = 8000,
                    browser = FALSE,
                    path = "") {
  u = paste0("http://", host,":", port, "/", path)
  viewer = getOption("viewer")
  if(identical(.Platform$GUI, "RStudio") &&
     !is.null(viewer) &&
     !browser) {
    viewer(u)
  } else {
    utils::browseURL(u)
  }
}

copy_tgve = function(path, over.write = TRUE) {
  if(!is.character(path) || length(path) != 1) {
    stop("Error: setup takes one character variable.")
  }
  if(!dir.exists(path))
    stop("Error: destination directory does not exist.")

  if(over.write) {
    # remove existing copy or folder named tgve
    d = file.path(path, "tgve")
    f = file.path(path, "tgve.zip")
    if(dir.exists(d)) unlink(d, recursive = TRUE)
    if(file.exists(f)) file.remove(f)
  }

  m = "Error: could not copy TGVE bundled version."
  inst.copied = file.copy(
    system.file("tgve.zip", package = "tgver"),
    path)
  if(!inst.copied)
    stop(m)
  unzip(file.path(path, "tgve.zip"), exdir = path)
  # there is now path/tgve
  unzipped = list.files(file.path(path, "tgve"), pattern = "*.js|*html")
  if(length(unzipped) < 1)
    stop(m)
}

#' copy the inst/tgve to a temp in an R session
tempInstance = function() {
  temp.path = tempdir()
  # copy_instance creates a tgve folder here
  copy_tgve(temp.path)

  # a = list(temp.path)
  # names(a) = TEMP_DIR_ENV
  # do.call(Sys.setenv, a)
  file.path(temp.path, "tgve")
}

#' Package version included as data
#'
#' @name version
#' @docType data
#' @author L Hama \email{l.hama@@leeds.ac.uk}
#' @keywords data
NULL
