#' Explore an sf R object using Turing eAtlas.
#'
#'
#' @param sf a valid sf object that can be converted to geojson
#' @param background Boolean to decide whether plumber
#' should run in the background
#'
#' @examples \dontrun{
#' explore_sf()
#' }
#' @export
explore_sf = function(sf = NULL, background = FALSE) {
  if(is.null(sf) || !inherits(sf, "sf")) {
    stop("Error: explore_sf requires an sf object.")
  }

  path = tempInstance()
  server = tgve(path = path, run = FALSE)

  # data
  geojson <- geojsonsf::sf_geojson(sf, factors_as_string=FALSE)

  # prepare back-end
  endpoint = "/explore"
  full.url = "http://127.0.0.1:8000/explore"
  # flexible variable names
  server$handle("GET", endpoint, function(res, req, ...){
    qs <- c(...) # named vector
    res$headers$`Content-type` = "application/json"
    res$body = geojson
    res
  })
  # build with defaultURL
  build(path, defaultURL = full.url)

  if(background) {
    return(background_run(server))
  }

  message("Serving data from ", full.url)
  openURL()
  server$run(port = 8000, docs = FALSE)
}
