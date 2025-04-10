library(readr)
library(dplyr)
library(lubridate)
library(janitor)
library(stringr)

process_data <- function(directory_path) {
  csv_files <- list.files(path = directory_path, pattern = "\\.csv$", full.names = TRUE)
  print(csv_files)
  
  donnees <- list()
  
### Étape 1: Combiner les données de tous les sites en un dataframe ###
  
  # Combiner les données de tous les sites en un data frame
  for (file in csv_files) {
    data <- read.csv(file)
    donnees <- append(donnees, list(data))
  }
  
  
  final_data <- bind_rows(donnees)
  print(head(final_data))
  
### Étape 2: Conserver uniquement les colonnes contenant des données ###  
  
  # Vérifier si des colonnes contiennent seulement des NA
  na_columns <- sapply(final_data, function(col) all(is.na(col)))
  
  # Regrouper les colonnes qui contiennent seulement des NA
  columns_with_na_only <- names(na_columns[na_columns == TRUE])
  
  # Supprimer les colonnes qui contiennent seulement des NA
  final_data_clean <- final_data %>%
    select(-which(na_columns))  
  
  # Vérifier qu'il ne reste plus de colonnes avec des NA
  print(head(final_data_clean))
  str(final_data_clean)
  
### Étape 3: Standardiser le nom des colonnes ###
  
  # Standardiser le nom des colonnes
  final_data_clean$transparence_eau <- toupper(final_data_clean$transparence_eau)
  final_data_clean$ETIQSTATION <- toupper(final_data_clean$ETIQSTATION)
  final_data_clean$nom_sci <- toupper(final_data_clean$nom_sci)
  
### Étape 4: S'assurer que les colonnes soit du bon type ###
  
 ## Étape 4.1: colonne "transparence_eau"
  
  # Vérifier si les valeurs dans la colonne 'transparence_eau' sont des nombres
  # Et afficher les valeurs qui ne sont pas des nombres
  numeric_columns <- c("temperature_eau_c", "vitesse_courant", "profondeur_riviere", "abondance", "largeur_riviere", "fraction")
  for (col in numeric_columns) {
    is_numeric <- grepl("^[-+]?[0-9]*\\.?[0-9]+$", final_data_clean[[col]])
    non_numeric_values <- final_data_clean[!is_numeric, ]
    # Les données qui ne sont pas des nombres sont des NA donc pas de correction nécessaire
  }
  
  # Convertir la colonne "transparence_eau" en facteur
  final_data$transparence_eau <- factor(final_data$transparence_eau)
  
  # Vérifier combien de valeurs différentes existe dans la colonne "transparence_eau"
  levels_transparence <- levels(final_data$transparence_eau)
  num_levels <- length(levels_transparence)
  
  # Afficher le nombre de valeurs différentes
  cat("Il y a", num_levels, "niveaux dans la colonne 'transparence_eau'.\n")
  # Il y a 3 noms différents, ce qui est normal
  
  # Standardiser le nom des valeurs dans la colonne 'transparence_eau'
  final_data_clean$transparence_eau <- gsub("ÉLEVÉE", "ELEVEE", final_data_clean$transparence_eau)
  
 ## Étape 4.2: colonne "date"
  
  # Mettre la colonne "date" dans le format date
  final_data_clean$date <- as.Date(final_data_clean$date, format = "%Y-%m-%d")
  
  # Vérifier si la colonne "date" est dans le format yyy-mm-dd
  is_date <- !is.na(ymd(final_data_clean$date, quiet = TRUE))
  table(is_date)
  
 ## Étape 4.3: colonne "date_obs"
  
  # Mettre la colonne "date_obs" dans le format date
  final_data_clean$date <- as.Date(final_data_clean$date_obs, format = "%Y-%m-%d")
  
  # Vérifier si la colonne "date_obs" est dans le format yyy-mm-dd
  is_date <- !is.na(ymd(final_data_clean$date_obs, quiet = TRUE))
  table(is_date)
  
 ## Étape 4.4: colonne "heure"
  
  # Standardiser la colonne heure
  final_data_clean$heure_obs <- gsub("h", ":", final_data_clean$heure_obs)
  
 
  return(final_data_clean)
}