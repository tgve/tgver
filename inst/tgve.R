#' TGVE.R script will check out and build the package tgve/app and create a zip
#' file from the contents of the build folder. This zip file is then copied to
#' inst/tgve.zip in order to let this package use the app.
#'
#' Here we host tgve locally and tgver.* is the placeholder for API variables.
#'
#' In order to replicate by hand the steps done in this script:
#' git clone https://github.com/tgve/app
#' cd app
#' yarn
#' yarn run build
#'
#' Copy the build into the inst/tgve folder
#' From R package directory
#'
#' mkdir inst/tgve
#' zip -r path/to/app/build inst/tgve.zip

#'######### UPDATE VERSION/build ###############
#' Step 1: setup environment
currentdir = getwd()
td = tempdir()
build.dir = file.path(td,"app")

# Step 2: clone repo
system(paste("git clone https://github.com/tgve/app", build.dir))

# Step 3: get TGVE version to avoid not necessary build
# checkout package for local/build
version = jsonlite::parse_json(
  readLines(file.path(build.dir, "package.json")))$dependencies['@tgve/tgvejs'][[1]]
version = sub(".", "", version)
names(version) <- "version"
# not implemented for now
devtools::install_github("tgve/tgver")
###### compare the values ####
if (tgver::version != version) {
    # IF versions are different, continue to Step 4: build app
    setwd(build.dir)
    system("yarn; yarn run build-local")

    # Step 5: replace zip/copy in build
    current.zip = file.path(currentdir, "inst", "tgve.zip")
    if (file.exists(current.zip)) file.remove(current.zip)
    #' Then copies files back and renames build to tgve:
    file.rename(file.path(build.dir, "build"),
                file.path(build.dir, "tgve"))
    #' if you do not cd into the directory
    #' zip command will preserve parent dir structure back to / (root)
    #' therefore need to cd into build location and out after zip
    zip(current.zip,
        list.files("tgve", full.names = TRUE, recursive = TRUE))
    setwd(currentdir)
    # print("Contents of inst/ directory: ")
    # print(list.files("inst"))

    # Step 6 (final): update version
    usethis::use_data(version, overwrite = TRUE)
} else {
    print("tgvejs version has not changed - will not replace inst/tgve.zip")
}
