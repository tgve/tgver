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

copy_tgve = function(path) {
  if(!is.character(path) || length(path) != 1) {
    stop("Error: setup takes one character variable.")
  }
  if(!dir.exists(path))
    stop("Error: destination directory does not exist.")

  m = "Error: could not copy TGVE bundled version."
  inst.copied = file.copy(
    system.file("tgve.zip", package = "tgver"),
    path)
  if(!inst.copied)
    stop(m)
  unzip(file.path(path, "tgve.zip"), exdir = path)
  unzipped = list.files(path, pattern = "*.js|*html")
  if(!length(unzipped) < 1)
    stop(m)
}

#' copy the inst/tgve to a temp in an R session
tempInstance = function() {
  temp.path = file.path(tempdir(), "tgve")
  dir.create(temp.path)
  if(!file.exists(temp.path))
    stop("Error: could not create temporary directory.")

  copy_tgve(temp.path)

  # a = list(temp.path)
  # names(a) = TEMP_DIR_ENV
  # do.call(Sys.setenv, a)
  temp.path
}

#' Package version included as data
#'
#' @name version
#' @docType data
#' @author L Hama \email{l.hama@@leeds.ac.uk}
#' @keywords data
NULL
