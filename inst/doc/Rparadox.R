## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
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

# Read the data directly into a tibble
# This automatically finds 'biolife.mb' and handles data types.
biolife_data <- read_paradox(db_path)

# View the data
print(biolife_data)

## ----magick-plot, eval = requireNamespace("magick", quietly = TRUE)-----------
# Plot raw image data
library(magick)

as.raw(biolife_data$Graphic[[1]]) |> image_read() |> plot()

## ----eval=FALSE---------------------------------------------------------------
# library(Rparadox)
# # Read a password-protected file
# secure_data <- read_paradox("path/to/encrypted.db", password = "secret_password")

## ----eval=FALSE---------------------------------------------------------------
# library(Rparadox)
# # This tells the package to interpret the source data as CP866
# data <- read_paradox("path/to/your/file.db", encoding = "cp866")

## ----advanced-example---------------------------------------------------------
db_path <- system.file("extdata", "biolife.db", package = "Rparadox")

# Open the file and get a handle
pxdoc <- pxlib_open_file(db_path)

if (!is.null(pxdoc)) {
  # Get metadata without reading all the data
  metadata <- pxlib_metadata(pxdoc)

  # Metadata includes human-readable field types and detected encoding
  cat("Encoding:", metadata$encoding, "\n")
  cat("Number of records:", metadata$num_records, "\n")
  print(head(metadata$fields))

  # Read the actual data
  data_table <- pxlib_get_data(pxdoc)

  # Always close the file when you're done
  pxlib_close_file(pxdoc)

  print(data_table)
}

