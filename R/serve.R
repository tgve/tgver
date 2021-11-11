#' Launch a webserver via plumber to serve TGVE static files.
#' Currently the function also copies the bundled
#' TGVE version into a temporary directory.
#'
#' @param port to serve from
#' @param file location of plumber.R file used by plumber
#' @param host host to pass to plumber default `http://127.0.0.1`
#' to `FALSE`.
#' @param background run the R process in the background using callr,
#' defaults to `TRUE`.
#'
#'
#' @export
#' @examples {
#' }
serve = function(port = 8000,
                 dir = Sys.getenv("TEMP_DIR_ENV"),
                 host = "127.0.0.1",
                 background = FALSE) {
  if(!dir.exists(dir)) {
    dir = tempInstance()
  }

  server = pr() %>%
    pr_static("/", dir)

  if(background) {
    f <- function(s, p, h) {s$setDocs(FALSE); s$run(port = p, host = h)}
    ps <- callr::r_bg(f, list(s = server, p = port, h = host))
    return(ps)
  }
  openURL(host, port)
  server$run(port = port, host = host, docs = FALSE)
}
