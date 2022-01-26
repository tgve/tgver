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
  if(!is.character(geojson) || !is.atomic(geojson)) {
    stop("explore_geojsoin requires geoson object.")
  }

  if(!is.logical(background))
    stop("Error: background value must be logical")

  base = "http://127.0.0.1:8000"
  endpoint.url = paste0(base, endpoint)
  path = tempInstance()
  server = tgve_server(path = path, run = FALSE)
  # flexible variable names
  server$handle("GET", endpoint, function(res){
    res$headers$`Content-type` = "application/json"
    res$body = geojson
    res
  })

  # url with `defaultURL` API variable
  nav.url = get_url(base, defaultURL = endpoint.url)

  if(background) {
    return(background_run(server))
  }

  message("Serving data from ", endpoint.url)
  openURL(url = nav.url)
  server$run(port = 8000, docs = FALSE)
}
