# step_02_trim_whitespace.R
# Trims whitespace from all character columns

library(dplyr)
library(stringr)
library(here)

# Load cleaned data from Step 01
data_step_01 <- readRDS(here("clean_2025", "cleaned_step_01.rds"))
start_rows <- nrow(data_step_01)

# Trim whitespace on all character columns
trimmed_data <- data_step_01 %>%
  mutate(across(where(is.character), str_trim))

# Count rows that changed due to trimming
affected_rows <- sum(!apply(data_step_01 == trimmed_data, 1, all))
end_rows <- nrow(trimmed_data)

# Create step_02_report
step_02_report <- data.frame(
  Cleaning_Step = "step_02_trim_whitespace",
  Start_No_Rows = start_rows,
  End_No_Rows = end_rows,
  Affected_Rows = affected_rows,
  Deleted = "N"
)

# Save step report and cleaned data
write.csv(step_02_report, here("clean_2025", "step_02_report.csv"), row.names = FALSE)
saveRDS(trimmed_data, here("clean_2025", "cleaned_step_02.rds"))

cat("Step 02 complete: Trimmed whitespace in", affected_rows, "rows.\n")
