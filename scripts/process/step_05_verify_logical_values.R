# step_05_logical_values_check.R
# Checks datetime logic and flags records with non-positive ride durations

library(dplyr)
library(lubridate)
library(here)

# Load cleaned data from step 04
data_step_04 <- readRDS(here("clean_2025", "cleaned_step_04.rds"))
start_rows <- nrow(data_step_04)

# Parse datetime columns and compute ride_length
data_step_04 <- data_step_04 %>%
  mutate(
    started_at = ymd_hms(started_at, quiet = TRUE),
    ended_at = ymd_hms(ended_at, quiet = TRUE),
    ride_length = as.numeric(difftime(ended_at, started_at, units = "secs"))
  )

# Identify logical issues
issues <- data_step_04 %>%
  filter(is.na(started_at) | is.na(ended_at) | ride_length <= 0)

affected_rows <- nrow(issues)
end_rows <- start_rows  # No deletion

# Save logical issues
write.csv(issues, here("clean_2025", "step_05_issue.csv"), row.names = FALSE)

# Create step_05_report
step_05_report <- data.frame(
  Cleaning_Step = "step_05_logical_values_check",
  Start_No_Rows = start_rows,
  End_No_Rows = end_rows,
  Affected_Rows = affected_rows,
  Deleted = "N"
)

# Save report and pass-through data
write.csv(step_05_report, here("clean_2025", "step_05_report.csv"), row.names = FALSE)
saveRDS(data_step_04, here("clean_2025", "cleaned_step_05.rds"))

cat("Step 05 complete: Found", affected_rows, "rows with logical time issues. Saved to step_05_issue.csv\n")
