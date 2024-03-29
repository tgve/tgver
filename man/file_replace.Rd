% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/replace.R
\name{file_replace}
\alias{file_replace}
\title{Function to replace patterns in given files.}
\usage{
file_replace(files = NULL, pattern, replacement)
}
\arguments{
\item{files}{character vector of full paths where pattern to be replaced.}

\item{pattern}{character pattern to replace using `gsub`.}

\item{replacement}{character to replace pattern with using `gsub`.}
}
\description{
Function to replace patterns in given files.
}
