# Load necessary libraries
library(readr)
library(here)

# Define the path to the raw data
raw_data_path <- "raw_2025"

# List all CSV files in the raw data directory
all_files <- list.files(path = here(raw_data_path), pattern = "\\.csv$", full.names = TRUE)

# Check if any CSV files were found
if (length(all_files) == 0) {
  stop("No CSV files found in the specified raw data directory.")
}

# Read first file to get schema
first_schema <- colnames(read_csv(all_files[1], n_max = 1, show_col_types = FALSE))

# Function to check schema compatibility
check_schema <- function(file) {
  cols <- colnames(read_csv(file, n_max = 1, show_col_types = FALSE))
  identical(cols, first_schema)
}

# Run schema check on all files
schema_results <- sapply(all_files, check_schema)
names(schema_results) <- basename(all_files) # Use filenames for results

# Report
cat("--- Schema Check ---\n")
if (all(schema_results)) {
  cat("✅ All raw files have compatible schemas.\n")
} else {
  cat("⚠️ Schema mismatch detected in the following files:\n")
  print(names(schema_results)[!schema_results])
}
cat("\n")

# Define the path for clean data
clean_data_path <- "clean_2025"

# Save schema check result summary
saveRDS(schema_results, here(clean_data_path, "schema_check_results.rds"))