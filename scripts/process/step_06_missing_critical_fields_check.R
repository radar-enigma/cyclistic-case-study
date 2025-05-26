library(dplyr)
library(lubridate)

# Load cleaned data from step 05
data_step_05 <- read.csv("d:/capstone_project/cyclistic_v3/clean_2025/cleaned_step_05.csv", stringsAsFactors = FALSE)

start_rows <- nrow(data_step_05)

# Check for missing or malformed critical fields
issues <- data_step_05 %>%
  filter(
    is.na(ride_id) | ride_id == "" |
      is.na(member_casual) | member_casual == "" |
      is.na(started_at) | started_at == "" |
      is.na(ended_at) | ended_at == ""
  )

affected_rows <- nrow(issues)
end_rows <- start_rows

# Save affected records CSV
write.csv(issues, "d:/capstone_project/cyclistic_v3/clean_2025/step_06_issue.csv", row.names = FALSE)

# Create report for step 06
step_06_report <- data.frame(
  Cleaning_Step = "step_06_missing_critical_fields_check",
  Start_No_Rows = start_rows,
  End_No_Rows = end_rows,
  Affected_Rows = affected_rows,
  Deleted = "N"
)

# Save step report CSV
write.csv(step_06_report, "d:/capstone_project/cyclistic_v3/clean_2025/step_06_report.csv", row.names = FALSE)

# Append to final_report (create if doesn't exist)
if (!exists("final_report")) {
  final_report <- step_06_report
} else {
  final_report <- bind_rows(final_report, step_06_report)
}

# Save cleaned data unchanged
write.csv(data_step_05, "d:/capstone_project/cyclistic_v3/clean_2025/cleaned_step_06.csv", row.names = FALSE)

cat("Step 06 complete: Found", affected_rows, "rows with missing critical fields; saved to step_06_issue.csv\n")
