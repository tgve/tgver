#' Launch a webserver via plumber to serve TGVE static files.
#'
#' The function accepts a `path` to get a directory containing an instance of
#' TGVE, by default this is done via `TEMP_DIR_ENV` env variable. If neither
#' is given then the function copies a clean copy of the bundled
#' TGVE version into a temporary directory.
#'
#' @param path location of TGVE path to be served by plumber.
#' @param port to serve from.
#' @param host host to pass to plumber default `http://127.0.0.1`
#' to `FALSE`.
#' @param background run the R process in the background using `callr`,
#' defaults to `TRUE`.
#' @param run whether to start the server, defaults to `TRUE`. If
#' not, then the created server will be returned.
#'
#' @export
#' @examples {
#' }
tgve = function(path = Sys.getenv("TEMP_path_ENV"),
                 port = 8000,
                 host = "127.0.0.1",
                 background = FALSE,
                 run = TRUE) {
  if(!dir.exists(path)) {
    path = tempInstance()
  }

  server = plumber::pr() %>%
    plumber::pr_static("/", path)

  if(!run) {
    return(server)
  }

  # clean build if running
  build(path)

  if(background) {
    f <- function(s, p, h) {s$setDocs(FALSE); s$run(port = p, host = h)}
    # TODO: try killing if process is running
    ps <- callr::r_bg(f, list(s = server, p = port, h = host))
    return(ps)
  }
  openURL(host, port)
  message("Serving TGVE instance located at ", path)
  server$run(port = port, host = host, docs = FALSE)
}
