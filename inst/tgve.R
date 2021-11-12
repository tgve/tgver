#' For the first version of the app, we want to avoid building JS as
#' done in geoplumber R package. Therefore we bundle a clean instance of
#' TGVE using eatlas_template and use it.
#'
#' We can do some grep in the instance before we run the application to add the
#' API values, i.e. we do some grep based builds without npm toolchains.
#' To make this easier we could also replace these values in the main entry,
#' as special placeholders to be consumed in the R package/elsewhere.
#'
#' Create a clean build from https://github.com/tgve/eatlas_template
#' Copy it into the inst/tgve folder
#' cp -R path/eatlas_template/build/. package/inst/tgve

#' UPDATE VERSION/build
#' in order to update bundled version
unlink("./inst/tgve/*", recursive = TRUE)
#' Then copy files back
path = "~/code/eatlas-template/build"
file.copy(list.files(path, full.names = TRUE),
          "./inst/tgve/", recursive = TRUE)
# get TGVE version
version = jsonlite::parse_json(readLines("~/code/eatlas-template/package.json"))$dependencies$eatlas
version = sub(".", "", version)
names(version) <- "version"
usethis::use_data(version)
