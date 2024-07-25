#' Data processing prelude
#'
#' This script *needs* to be loaded at the top of each
#' project '_targets.R' file, along with a call to `library(targets)`
#'
#' For example:
#'
#' library(targets)
#' source(here::here("projects/prelude.R"))
#'
#' # ... extra code + targets pipeline below
NULL

# Just in case `source(here::here("projects/prelude.R"))` is being invoked interactively
library(targets)

## ------ COMMON ------
# Load common R functions
src_files <- list.files(
  here::here("R"),
  pattern = "\\.[rR]$",
  full.names = TRUE
)

for (f in src_files) {
  source(f)
}

rm(src_files)
