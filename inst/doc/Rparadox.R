## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
# Load the package once for the entire vignette
library(Rparadox)

## ----eval=FALSE---------------------------------------------------------------
# # stable version from CRAN
# install.packages("Rparadox")

## ----eval=FALSE---------------------------------------------------------------
# # install.packages("devtools")
# devtools::install_github("celebithil/Rparadox")

## ----basic-example------------------------------------------------------------
# Get the path to an example database included with the package
db_path <- system.file("extdata", "biolife.db", package = "Rparadox")

# Read the data in a single step
biolife_data <- read_paradox(db_path)

# Display the first few rows of the resulting tibble
head(biolife_data)

## ----eval=FALSE---------------------------------------------------------------
# # Example for a file known to be in the CP866 encoding
# my_data <- read_paradox("path/to/your/file.db", encoding = "cp866")

## ----advanced-example---------------------------------------------------------
# This chunk uses the db_path defined in the previous chunk
# Open the file handle
pxdoc <- pxlib_open_file(db_path)

if (!is.null(pxdoc)) {
  # Get and print metadata
  metadata <- pxlib_metadata(pxdoc)
  print(metadata$fields)
  
  # Read the full dataset
  data_from_handle <- pxlib_get_data(pxdoc)
  
  # IMPORTANT: Always close the file handle
  pxlib_close_file(pxdoc)
}

