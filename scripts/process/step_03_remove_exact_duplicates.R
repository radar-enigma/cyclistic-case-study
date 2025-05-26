# step_03_remove_exact_duplicates.R
# Removes exact duplicate rows across all columns

library(dplyr)
library(here)

# Load cleaned data from step 02
data_step_02 <- readRDS(here("clean_2025", "cleaned_step_02.rds"))
start_rows <- nrow(data_step_02)

# Remove exact duplicate rows
cleaned_data_no_exact_dups <- data_step_02 %>%
  distinct()

end_rows <- nrow(cleaned_data_no_exact_dups)
affected_rows <- start_rows - end_rows

# Create step_03_report
step_03_report <- data.frame(
  Cleaning_Step = "step_03_remove_exact_duplicates",
  Start_No_Rows = start_rows,
  End_No_Rows = end_rows,
  Affected_Rows = affected_rows,
  Deleted = ifelse(affected_rows > 0, "Y", "N")
)

# Save report and cleaned data
write.csv(step_03_report, here("clean_2025", "step_03_report.csv"), row.names = FALSE)
saveRDS(cleaned_data_no_exact_dups, here("clean_2025", "cleaned_step_03.rds"))

cat("Step 03 complete: Removed", affected_rows, "exact duplicate rows.\n")
