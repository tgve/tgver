#' Explore an sf R object using TGVE npm package.
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

  # data
  geojson = geojsonsf::sf_geojson(sf, factors_as_string=FALSE)

  # prepare back-end
  endpoint = "/explore_sf"
  explore_geojson(endpoint, geojson, background)
}

explore_geojson = function(endpoint, geojson, background) {
  stopifnotonecharacter(endpoint)
  stopifnotonecharacter(geojson)

  if(!is.logical(background))
    stop("Error: background value must be logical")

  full.url = paste0("http://127.0.0.1:8000", endpoint)
  path = tempInstance()
  server = tgve(path = path, run = FALSE)
  # flexible variable names
  server$handle("GET", endpoint, function(res){
    res$headers$`Content-type` = "application/json"
    res$body = geojson
    res
  })

  # build with `defaultURL` API variable
  build(path, defaultURL = full.url)

  if(background) {
    return(background_run(server))
  }

  message("Serving data from ", full.url)
  openURL()
  server$run(port = 8000, docs = FALSE)
}
