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
#' With special `tgver.*` placeholer for all API variables
#'
#' yarn run build
#'
#' Copy the build into the inst/tgve folder
#' From R package directory
#'
#' mkdir inst/tgve
#' zip -r path/eatlas_template/build. inst/tgve.zip

#'######### UPDATE VERSION/build ###############
#' in order to update bundled version
file.remove("./inst/tgve.zip")
build.dir = "~/code/tgve/app"
#' Then copy files back
#' rename CRA build to tgve
file.rename(file.path(build.dir, "build"),
            file.path(build.dir, "tgve"))
#' if you do not cd into the directory
#' zip command will preserve parent dir structure back to / (root)
#' therefore need to cd into build location and out after zip
ow = setwd(build.dir)
zip("~/code/tgve/tgver/inst/tgve.zip",
    list.files("tgve", full.names = TRUE, recursive = TRUE))
# undo
file.rename(file.path(build.dir, "tgve"),
            file.path(build.dir, "build"))
setwd(ow)
# get TGVE version
# checkout package for local/build
version = jsonlite::parse_json(
  readLines(file.path(build.dir, "package.json")))$dependencies['@tgve/tgvejs'][[1]]
version = sub(".", "", version)
names(version) <- "version"
usethis::use_data(version, overwrite = TRUE)
