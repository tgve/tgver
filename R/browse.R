#' Function to browse TGVE front end in R environments.
#'
#'@export
brwose = function() {
  print(system.file("tgve/index.html", package = "tgver"))
}
