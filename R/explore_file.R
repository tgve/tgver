#' A function to explore a spatial csv or geojson file
#'
#' Current version can only read geojson/csv files using the given `file.uri`.
#'
#' @param file.uri character path of file to explore
#' @param background Boolean to run the process in the background,
#' defaults to `FALSE`
#'
#' @export
explore_file = function(file.uri, background = FALSE) {
  if(!is.character(file.uri) || length(file.uri) != 1) {
    stop("Error: explore_file takes only one character parameter.")
  }

  if(!file.exists(file.uri)) {
    stop("Error: file does not exist.")
  }

  fi = file.info(file.uri)
  # any geojson/csv file would above 100bytes
  if(is.na(fi$size) || fi$size < 10L)
    stop("Error: given file is empty, is it a wrong file path?")
  # only geojson || csv
  if(!any(grepl("json|csv", basename(file.uri)))) {
    stop("Error: explore_file can only read .geojson and .csv files.")
  }

  geojson = NULL

  if(grepl("geojson", basename(file.uri))) {
    geojson = readLines(file.uri)
  } else {
    # TODO: convert csv to geojson (via sf?)

  }

  # prepare back-end
  endpoint = "/explore_file"
  explore_geojson(endpoint, geojson, background)
}
