#Code aussi intégré dans la fonction de nettoyage des données
#Donc plus besoin?






#Code pour retirer les colonnes qui contiennent seulement des NA

supprimer_col_na <- function(data){
# Vérifier si une colonne contient uniquement des NA
na_columns <- sapply(final_data, function(col) all(is.na(col)))

# Afficher les noms des colonnes qui contiennent uniquement des NA
columns_with_na_only <- names(na_columns[na_columns == TRUE])
print(columns_with_na_only)

# Supprimer les colonnes contenant uniquement des NA
data_clean <- final_data %>%
  select(-which(na_columns))  # Retirer les colonnes où na_columns est TRUE
return(data_clean)

}

# Vérification du résultat
print(head(final_data_clean))
