# 2_merge_raw_files.R
# Merges all CSVs from 'raw_2025', saves merged_2025.csv (local) and merged_2025.rds (for Git)

library(dplyr)
library(readr)
library(here)

# Define paths
raw_data_path <- "raw_2025"
merged_folder <- "raw_2025/merged"
csv_output_path <- here(merged_folder, "merged_2025.csv")
rds_output_path <- here(merged_folder, "merged_2025.rds")

# Create merged directory if it doesn't exist
if (!dir.exists(here(merged_folder))) {
  dir.create(here(merged_folder), recursive = TRUE)
}

# Get list of CSV files
csv_files <- list.files(path = here(raw_data_path), pattern = "\\.csv$", full.names = TRUE)

if (length(csv_files) == 0) {
  stop("No CSV files found in raw_2025 folder.")
}

# Merge all CSVs
merged_data <- csv_files %>%
  lapply(read_csv, col_types = cols(ride_id = col_character()), show_col_types = FALSE) %>%
  bind_rows()

# Save locally (for compliance, not tracked in Git)
write_csv(merged_data, csv_output_path)
cat("Saved merged CSV locally to:", csv_output_path, "\n")

# Save Git-friendly RDS version
saveRDS(merged_data, rds_output_path)
cat("Saved RDS to:", rds_output_path, "\n")
