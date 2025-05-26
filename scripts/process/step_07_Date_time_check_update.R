library(dplyr)
library(lubridate)

# Load cleaned data from step 06
data_step_06 <- read.csv("d:/capstone_project/cyclistic_v3/clean_2025/cleaned_step_06.csv", stringsAsFactors = FALSE)

start_rows <- nrow(data_step_06)

# Check if started_at and ended_at parse correctly
parse_failed <- function(dt) {
  is.na(ymd_hms(dt, quiet = TRUE))
}

issues <- data_step_06 %>%
  filter(parse_failed(started_at) | parse_failed(ended_at) | ymd_hms(started_at) > ymd_hms(ended_at))

affected_rows <- nrow(issues)
end_rows <- start_rows

# Save affected records CSV
write.csv(issues, "d:/capstone_project/cyclistic_v3/clean_2025/step_07_issue.csv", row.names = FALSE)

# Create report for step 07
step_07_report <- data.frame(
  Cleaning_Step = "step_07_date_time_check",
  Start_No_Rows = start_rows,
  End_No_Rows = end_rows,
  Affected_Rows = affected_rows,
  Deleted = "N"
)

# parsing date time column into proper formats
data_step_06 <- data_step_06 %>%
  mutate(
    started_at = as.POSIXct(started_at, format = "%Y-%m-%dT%H:%M:%SZ", tz = "UTC"),
    ended_at = as.POSIXct(ended_at, format = "%Y-%m-%dT%H:%M:%SZ", tz = "UTC")
  )

# Save step report CSV
write.csv(step_07_report, "d:/capstone_project/cyclistic_v3/clean_2025/step_07_report.csv", row.names = FALSE)

# Append to final_report
final_report <- bind_rows(final_report, step_07_report)

# Save cleaned data unchanged
write.csv(data_step_06, "d:/capstone_project/cyclistic_v3/clean_2025/cleaned_step_07.csv", row.names = FALSE)

cat("Step 07 complete: Found", affected_rows, "rows with date-time issues; saved to step_07_issue.csv\n")
