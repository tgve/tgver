#' Explore an sf R object using TGVE.
#'
#'
#'
#' @param sf a valid sf object that can be converted to geojson
#' @param background boolean to decide whether plumber should run in the
#' background
#' @param static boolean to decide whether data is written to disk and self
#' contained application is built
#' @param path path of a TGVE instance, defaults to one in `tempdir()`
#'
#' @examples \dontrun{
#' explore_sf()
#' }
#' @export
explore_sf = function(sf = NULL, background = FALSE, static = FALSE,
                      path = tempInstance()) {
  if(is.null(sf) || !inherits(sf, "sf")) {
    stop("Error: explore_sf requires an sf object.")
  }

  # data
  geojson = geojsonsf::sf_geojson(sf, simplify = FALSE, factors_as_string=FALSE)

  # if writing data to index.html
  if(static) {
    html = file.path(path, "index.html")
    # clean copy
    file.copy(file.path(path, "index.original"), html, overwrite = TRUE)
    # write data
    file_replace(html, "</head>", paste0(
      "<script id='tgve-data' type='application/json'>",
      geojson, "</script></head>"
    ))
    message("Attempting to browse TGVE from: ", path)
    openURL(html)
    return(path)
  } else {
    # prepare back-end
    endpoint = "/explore_sf"
    explore_geojson(endpoint, geojson, background)
  }
}

explore_geojson = function(endpoint, geojson, background, path = tempInstance()) {
  stopifnotonecharacter(endpoint)
  if(!is.character(geojson) || !is.atomic(geojson)) {
    stop("explore_geojsoin requires geoson object.")
  }

  if(!is.logical(background))
    stop("Error: background value must be logical")

  base = "http://127.0.0.1:8000"
  endpoint.url = paste0(base, endpoint)
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
  message("Browsing ", nav.url)
  openURL(url = nav.url)
  server$run(port = 8000, docs = FALSE)
}
