TEMP_DIR_ENV = "TEMP_DIR_ENV"

#' Internal helper function to "browse" a URL.
#'
#' @param host character host to pass to plumber
#' @param port integer port to pass to plumber
#' @param browser Boolean whether to specifically launch a browser
#' @param path character path to TGVE instance
#' @param protocol character protocol, this may change
openURL = function(host = "127.0.0.1",
                   port = 8000,
                   browser = FALSE,
                   path = "",
                   protocol = "http://") {
  # TODO: there must be better ways of doing this
  u = paste0(protocol, host,":", port, "/", path)
  viewer = getOption("viewer")
  if(identical(.Platform$GUI, "RStudio") &&
     !is.null(viewer) &&
     !browser) {
    viewer(u)
  } else {
    utils::browseURL(u)
  }
}

#' Internal helper function to:
#' 1. copy the bundled zip
#' 2. unzip
#' 3. cleanup as required.
#' TODO: return a value?
#'
#' @param path character path of TGVE instance
#' @param over.write boolean whether to cleanup the instance in `path`
copy_tgve = function(path, over.write = TRUE) {
  if(!is.character(path) || length(path) != 1) {
    stop("Error: setup takes one character variable.")
  }
  if(!dir.exists(path))
    stop("Error: destination directory does not exist.")

  d = file.path(path, "tgve")
  f = file.path(path, "tgve.zip")

  if(over.write) {
    # remove existing copy or folder named tgve
    if(dir.exists(d)) unlink(d, recursive = TRUE)
    if(file.exists(f)) file.remove(f)
  }

  m = "Error: could not copy TGVE bundled version."
  inst.copied = file.copy(
    system.file("tgve.zip", package = "tgver"),
    path)
  if(!inst.copied)
    stop(m)
  utils::unzip(f, exdir = path)
  # there is now path/tgve
  unzipped = list.files(d, pattern = "*.js|*html")
  if(length(unzipped) < 1)
    stop(m)
  # remove tgve.zip
  file.remove(f)
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
