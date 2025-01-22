library(stringr)

# Path to your project
#project_path <- "path/to/project"

# List all .qmd files
qmd_files <- list.files(pattern = "\\.qmd$", full.names = TRUE)

# Function to check for improper fenced divs
check_fenced_divs <- function(file) {
  content <- readLines(file, warn = FALSE)
  # Check for empty `:::`
  if (any(str_detect(content, "^:::\\s*$"))) {
    return(file)
  }
  return(NULL)
}

# Apply check to all files
problem_files <- lapply(qmd_files, check_fenced_divs)
problem_files <- unlist(problem_files)  # Flatten the list

# Print problematic files
if (length(problem_files) > 0) {
  cat("Problematic files with empty `:::` blocks:\n", paste(problem_files, collapse = "\n"))
} else {
  cat("No issues found!")
}
