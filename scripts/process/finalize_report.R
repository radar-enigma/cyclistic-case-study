library(dplyr)
library(readr)
library(knitr)
library(kableExtra)

# Define the directory where reports are stored
report_dir <- "d:/capstone_project/cyclistic_v3/clean_2025"

# List all step report files
report_files <- list.files(path = report_dir, pattern = "step_\\d{2}_report\\.csv$", full.names = TRUE)

# Read and combine all step reports
final_report <- report_files %>%
  lapply(read_csv, show_col_types = FALSE) %>%
  bind_rows()

# Output clean HTML table
kable(final_report, format = "html", align = "c", caption = "Summary of Cleaning Steps") %>%
  kable_styling(
    full_width = FALSE,
    position = "center",
    bootstrap_options = c("striped", "hover", "condensed", "responsive")
  ) %>%
  row_spec(0, bold = TRUE)
