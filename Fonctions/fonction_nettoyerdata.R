library(readr)
library(dplyr)
library(lubridate)
library(janitor)
library(stringr)

process_data <- function(directory_path) {
  csv_files <- list.files(path = directory_path, pattern = "\\.csv$", full.names = TRUE)
  print(csv_files)
  
  donnees <- list()
  
  # Combine dataframes into one dataframe
  for (file in csv_files) {
    data <- read.csv(file)
    donnees <- append(donnees, list(data))
  }
  
  
  final_data <- bind_rows(donnees)
  print(head(final_data))
  
  # Check if a column contains only NA
  na_columns <- sapply(final_data, function(col) all(is.na(col)))
  
  # Display the names of columns that contain only NA
  columns_with_na_only <- names(na_columns[na_columns == TRUE])
  
  # Remove columns containing only NA
  final_data_clean <- final_data %>%
    select(-which(na_columns))  # Remove columns where na_columns is TRUE
  
  # Check the result
  print(head(final_data_clean))
  str(final_data_clean)
  
  # Standardize the variable names
  final_data_clean$transparence_eau <- toupper(final_data_clean$transparence_eau)
  final_data_clean$ETIQSTATION <- toupper(final_data_clean$ETIQSTATION)
  final_data_clean$nom_sci <- toupper(final_data_clean$nom_sci)
  
  # Check if each value in the column 'transparence_eau' is a number
  # Display the values that are not numbers
  numeric_columns <- c("temperature_eau_c", "vitesse_courant", "profondeur_riviere", "abondance", "largeur_riviere", "fraction")
  for (col in numeric_columns) {
    is_numeric <- grepl("^[-+]?[0-9]*\\.?[0-9]+$", final_data_clean[[col]])
    non_numeric_values <- final_data_clean[!is_numeric, ]
    # Values that are non-conforming are NA so no correction necessary
  }
  
  # Convert the column to factor to check the number of levels
  final_data$transparence_eau <- factor(final_data$transparence_eau)
  # Check the levels in the column 'transparence_eau'
  levels_transparence <- levels(final_data$transparence_eau)
  # Count the number of levels
  num_levels <- length(levels_transparence)
  # Display the number of levels
  cat("Il y a", num_levels, "niveaux dans la colonne 'transparence_eau'.\n")
  
  # Standardize the name in the column 'transparence_eau'
  final_data_clean$transparence_eau <- gsub("ÉLEVÉE", "ELEVEE", final_data_clean$transparence_eau)
  
  # Set the column 'date' to the correct format
  final_data_clean$date <- as.Date(final_data_clean$date, format = "%Y-%m-%d")
  
  # Check if the data in the 'date' column is in the correct format yyy-mm-dd
  is_date <- !is.na(ymd(final_data_clean$date, quiet = TRUE))
  table(is_date)
  
  # Display rows with non-conforming dates
  final_data_clean$date[!is_date]
  
  # Set the column 'date_obs' to the correct format
  final_data_clean$date <- as.Date(final_data_clean$date_obs, format = "%Y-%m-%d")
  
  # Check if the data in the 'date_obs' column is in the correct format yyy-mm-dd
  is_date <- !is.na(ymd(final_data_clean$date_obs, quiet = TRUE))
  table(is_date)
  
  # Display rows with non-conforming dates
  final_data_clean$date_obs[!is_date]
  
  # Standardize the column 'heure_obs'
  final_data_clean$heure_obs <- gsub("h", ":", final_data_clean$heure_obs)
  
 
  return(final_data_clean)
}