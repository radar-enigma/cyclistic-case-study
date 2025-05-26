# step_04_standardize_columns.R
# Standardizes column names and key categorical fields

library(dplyr)
library(stringr)
library(here)

# Load cleaned data from step 03
data_step_03 <- readRDS(here("clean_2025", "cleaned_step_03.rds"))
start_rows <- nrow(data_step_03)

# Standardize column names
colnames(data_step_03) <- tolower(colnames(data_step_03))
colnames(data_step_03) <- str_replace_all(colnames(data_step_03), "\\.", "_")

# Copy for comparison before standardization
original_data <- data_step_03

# Standardize categorical columns
standardized_data <- data_step_03 %>%
  mutate(
    member_casual = tolower(member_casual),
    rideable_type = tolower(rideable_type)
  )

# Count affected rows
affected_rows <- sum(
  standardized_data$member_casual != original_data$member_casual |
    standardized_data$rideable_type != original_data$rideable_type
)

end_rows <- nrow(standardized_data)

# Create step_04_report
step_04_report <- data.frame(
  Cleaning_Step = "step_04_standardize_columns",
  Start_No_Rows = start_rows,
  End_No_Rows = end_rows,
  Affected_Rows = affected_rows,
  Deleted = "N"
)

# Save report and cleaned data
write.csv(step_04_report, here("clean_2025", "step_04_report.csv"), row.names = FALSE)
saveRDS(standardized_data, here("clean_2025", "cleaned_step_04.rds"))

cat("Step 04 complete: Standardized columns and values. Affected", affected_rows, "rows.\n")
