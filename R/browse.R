#' Function to browse TGVE front end in R environments.
#'
#'@export
browse = function() {
  print(system.file("tgve/index.html", package = "tgver"))
}
