library(dplyr)

# Load cleaned data from step 07
data_step_07 <- read.csv("d:/capstone_project/cyclistic_v3/clean_2025/cleaned_step_07.csv", stringsAsFactors = FALSE)

start_rows <- nrow(data_step_07)

issues <- data_step_07 %>%
  filter(
    is.na(start_lat) | is.na(start_lng) |
      start_lat == 0 | start_lng == 0 |
      start_lat < -90 | start_lat > 90 |
      start_lng < -180 | start_lng > 180
  )

affected_rows <- nrow(issues)
end_rows <- start_rows

# Save affected records CSV
write.csv(issues, "d:/capstone_project/cyclistic_v3/clean_2025/step_08_issue.csv", row.names = FALSE)

# Create report for step 08
step_08_report <- data.frame(
  Cleaning_Step = "step_08_lat_long_check",
  Start_No_Rows = start_rows,
  End_No_Rows = end_rows,
  Affected_Rows = affected_rows,
  Deleted = "N"
)

# Save step report CSV
write.csv(step_08_report, "d:/capstone_project/cyclistic_v3/clean_2025/step_08_report.csv", row.names = FALSE)

# Append to final_report
final_report <- bind_rows(final_report, step_08_report)

# Save cleaned data unchanged
write.csv(data_step_07, "d:/capstone_project/cyclistic_v3/clean_2025/cleaned_step_08.csv", row.names = FALSE)

cat("Step 08 complete: Found", affected_rows, "rows with invalid lat/long; saved to step_08_issue.csv\n")
