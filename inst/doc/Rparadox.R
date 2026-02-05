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
# # Example for an encrypted file
# db_path <- "path/to/encrypted_file.db"
# my_data <- read_paradox(db_path, password = "my_secret_password")

## ----eval=FALSE---------------------------------------------------------------
# # Example for a file known to be in the CP866 encoding
# my_data <- read_paradox("path/to/your/file.db", encoding = "cp866")

## ----advanced-example---------------------------------------------------------
# This chunk uses the db_path defined in the previous chunk
# Open the file handle
pxdoc <- pxlib_open_file(db_path)

if (!is.null(pxdoc)) {
  # Get and print metadata
  # This is fast and doesn't read the full table content
  metadata <- pxlib_metadata(pxdoc)
  
  cat("Records:", metadata$num_records, "\n")
  cat("Encoding:", metadata$encoding, "\n")
  
  # Inspect field definitions (names, types, sizes)
  print(head(metadata$fields))
  
  # Read the data
  # Note: If using pxlib_get_data directly with encrypted files, 
  # ensure you have set the password via appropriate C-calls or use read_paradox() wrapper.
  data <- pxlib_get_data(pxdoc)
  
  # Close the file handle
  pxlib_close_file(pxdoc)
  
  head(data)
}

