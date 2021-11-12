TEMP_DIR_ENV = "TEMP_DIR_ENV"

openURL = function(host = "127.0.0.1",
                    port = 8000,
                    browser = FALSE,
                    path = "") {
  u = paste0("http://",host,":",port, "/", path)
  viewer = getOption("viewer")
  if(identical(.Platform$GUI, "RStudio") &&
     !is.null(viewer) &&
     !browser) {
    viewer(u)
  } else {
    utils::browseURL(u)
  }
}

#' copy the inst/tgve to a temp in an R session
tempInstance = function() {
  temp.path = file.path(tempdir(), "tgve")

  inst.copied = file.copy(system.file("tgve", package = "tgver"),
            tempdir(), recursive = TRUE)
  if(!file.exists(temp.path))
    stop("Error: could not create temp directory.")
  # a = list(temp.path)
  # names(a) = TEMP_DIR_ENV
  # do.call(Sys.setenv, a)
  if(!inst.copied)
    stop("Error: could not copy TGVE instance into temp directory.")
  temp.path
}

#' Package version included as data
#'
#' @name version
#' @docType data
#' @author L Hama \email{l.hama@@leeds.ac.uk}
#' @keywords data
NULL
