#' Launch a webserver via plumber to serve TGVE static files.
#' Currently the function also copies the bundled
#' TGVE version into a temporary directory.
#'
#' @param dir location of TGVE dir consumed by plumber
#' @param port to serve from
#' @param host host to pass to plumber default `http://127.0.0.1`
#' to `FALSE`.
#' @param background run the R process in the background using callr,
#' defaults to `TRUE`.
#'
#'
#' @export
#' @examples {
#' }
serve = function(dir = Sys.getenv("TEMP_DIR_ENV"),
                 port = 8000,
                 host = "127.0.0.1",
                 background = FALSE) {
  if(!dir.exists(dir)) {
    dir = tempInstance()
  }

  # clean build
  build(dir)

  server = plumber::pr() %>%
    plumber::pr_static("/", dir)

  if(background) {
    f <- function(s, p, h) {s$setDocs(FALSE); s$run(port = p, host = h)}
    ps <- callr::r_bg(f, list(s = server, p = port, h = host))
    return(ps)
  }
  openURL(host, port)
  server$run(port = port, host = host, docs = FALSE)
}
