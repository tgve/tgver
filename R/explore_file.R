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
  stopifnotonecharacter(file.uri,
                        "explore_file takes only one character parameter.")

  stopifnotvalidfile(file.uri)

  # only geojson || csv
  if(!any(grepl("json|csv", basename(file.uri)))) {
    stop("explore_file can only read .geojson and .csv files.")
  }

  geojson = NULL

  if(grepl("geojson", basename(file.uri))) {
    geojson = paste(readLines(file.uri), collapse = "")
  } else {
    # TODO: convert csv to geojson (via sf?)

  }

  # prepare back-end
  endpoint = "/explore_file"
  explore_geojson(endpoint, geojson, background)
}
