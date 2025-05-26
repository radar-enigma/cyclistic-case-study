# step_01_remove_ride_id_duplicates.R
# Cleans ride_id and removes duplicates, based on merged_2025.rds

library(dplyr)
library(stringr)
library(here)

# Load raw data from RDS
merged_data_raw <- readRDS(here("raw_2025/merged", "merged_2025.rds"))
start_rows <- nrow(merged_data_raw)

# Clean ride_id (trim and remove spaces)
cleaned_data <- merged_data_raw %>%
  mutate(ride_id = str_trim(ride_id),
         ride_id = str_replace_all(ride_id, "[[:space:]]", ""))

# Remove duplicate ride_id (keep first)
cleaned_data_no_dups <- cleaned_data %>%
  distinct(ride_id, .keep_all = TRUE)

end_rows <- nrow(cleaned_data_no_dups)
affected_rows <- start_rows - end_rows

# Create step_01_report
step_01_report <- data.frame(
  Cleaning_Step = "step_01_remove_ride_id_duplicates",
  Start_No_Rows = start_rows,
  End_No_Rows = end_rows,
  Affected_Rows = affected_rows,
  Deleted = ifelse(affected_rows > 0, "Y", "N")
)

# Save report and cleaned output
write.csv(step_01_report, here("clean_2025", "step_01_report.csv"), row.names = FALSE)
saveRDS(cleaned_data_no_dups, here("clean_2025", "cleaned_step_01.rds"))

cat("Step 01 complete: Removed", affected_rows, "duplicate rows based on ride_id.\n")
