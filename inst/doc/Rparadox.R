## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----eval=FALSE---------------------------------------------------------------
# # install.packages("devtools")
# devtools::install_github("celebithil/Rparadox")

## ----basic-example------------------------------------------------------------
library(Rparadox)

# Get the path to an example database included with the package
db_path <- system.file("extdata", "biolife.db", package = "Rparadox")

# Open the file handle
pxdoc <- pxlib_open_file(db_path)

# Read data and close the handle
if (!is.null(pxdoc)) {
  biolife_data <- pxlib_get_data(pxdoc)
  pxlib_close_file(pxdoc)
}

# Display the first few rows of the resulting tibble
head(biolife_data)

## ----eval=FALSE---------------------------------------------------------------
# # Example for a file known to be in the CP866 encoding
# pxdoc <- pxlib_open_file("path/to/your/file.db", encoding = "cp866")

