
library(readr)
library(dplyr)
library(lubridate)
library(janitor)
library(stringr)

directory_path <-"DATA"
csv_files <- list.files(path = directory_path,pattern = "\\.csv$", full.names = TRUE)
print(csv_files)





donnees <- list()


#combinaison des dataframes en un seul dataframes
for (file in csv_files) {
  # conn <- dbConnect(SQLite(), dbname = file, synchronous = NULL)
  data <- read.csv(file)
  donnees <- append(donnees, list(data))
  # dbDisconnect(conn)
  
}

final_data <- bind_rows(donnees)
print(head(final_data))

# Vérifier si une colonne contient uniquement des NA
na_columns <- sapply(final_data, function(col) all(is.na(col)))

# Afficher les noms des colonnes qui contiennent uniquement des NA
columns_with_na_only <- names(na_columns[na_columns == TRUE])


# Supprimer les colonnes contenant uniquement des NA
final_data_clean <- final_data %>%
  select(-which(na_columns))  # Retirer les colonnes où na_columns est TRUE

# Vérification du résultat
print(head(final_data_clean))

str(final_data_clean)


# uniformiser le nom des variables
final_data_clean$transparence_eau<- toupper(final_data_clean$transparence_eau)
final_data_clean$ETIQSTATION<- toupper(final_data_clean$ETIQSTATION)
final_data_clean$nom_sci<- toupper(final_data_clean$nom_sci)

# Vérifier si chaque valeur de la colonne 'transparence_eau' est un chiffre
# Afficher les valeurs qui ne sont pas des chiffres

is_numeric <- grepl("^[-+]?[0-9]*\\.?[0-9]+$", final_data_clean$temperature_eau_c)
non_numeric_values <- final_data_clean[!is_numeric, ]

# les valeurs non-conformes sont des NA donc pas de correction nécessaire





# Vérifier si chaque valeur de la colonne 'vitesse_courant' est un chiffre
# Afficher les valeurs qui ne sont pas des chiffres

is_numeric <- grepl("^[-+]?[0-9]*\\.?[0-9]+$", final_data_clean$vitesse_courant)
non_numeric_values <- final_data_clean[!is_numeric, ]

# les valeurs non-conformes sont des NA donc pas de correction nécessaire


# Vérifier si chaque valeur de la colonne 'profondeur_riviere' est un chiffre
# Afficher les valeurs qui ne sont pas des chiffres

is_numeric <- grepl("^[-+]?[0-9]*\\.?[0-9]+$", final_data_clean$profondeur_riviere)
non_numeric_values <- final_data_clean[!is_numeric, ]

# les valeurs non-conformes sont des NA donc pas de correction nécessaire


# Vérifier si chaque valeur de la colonne 'abondance' est un chiffre
# Afficher les valeurs qui ne sont pas des chiffres

is_numeric <- grepl("^[-+]?[0-9]*\\.?[0-9]+$", final_data_clean$abondance)
non_numeric_values <- final_data_clean[!is_numeric, ]


# Vérifier si chaque valeur de la colonne 'largeur_riviere' est un chiffre
# Afficher les valeurs qui ne sont pas des chiffres

is_numeric <- grepl("^[-+]?[0-9]*\\.?[0-9]+$", final_data_clean$largeur_riviere)
non_numeric_values <- final_data_clean[!is_numeric, ]


# les valeurs non-conformes sont des NA donc pas de correction nécessaire



# Vérifier si chaque valeur de la colonne 'fraction' est un chiffre
# Afficher les valeurs qui ne sont pas des chiffres

is_numeric <- grepl("^[-+]?[0-9]*\\.?[0-9]+$", final_data_clean$fraction)
non_numeric_values <- final_data_clean[!is_numeric, ]



# Convertir la colonne en facteur pour pouvoir vérifier le nombre de niveau
final_data$transparence_eau <- factor(final_data$transparence_eau)
# Vérifier les niveaux dans la colonne 'transparence_eau'
levels_transparence <- levels(final_data$transparence_eau)
# Compter combien de niveaux
num_levels <- length(levels_transparence)
# Afficher le nombre de niveaux
cat("Il y a", num_levels, "niveaux dans la colonne 'transparence_eau'.\n")

#uniformiser le nom dans la colonne transparence eau
# Remplacer "élevée" par "elevee" dans la colonne 'transparence_eau' pour éviter les problèmes d'affichage
final_data_clean$transparence_eau <- gsub("ÉLEVÉE", "ELEVEE", final_data_clean$transparence_eau)



#Mettre la colonne 'date' sous le bon format
final_data_clean$date <- as.Date(final_data_clean$date, format = "%Y-%m-%d")

#Vérifier si les données dans la colonne date sont conforme au format yyy-mm-jj

is_date <- !is.na(ymd(final_data_clean$date, quiet = TRUE))
table(is_date)

# Afficher les lignes avec des dates non conformes
final_data_clean$date[!is_date]

#Les dates non-conformes sont des NA donc pas de correction nécessaire


#Mettre la colonne 'date_obs' sous le bon format
final_data_clean$date <- as.Date(final_data_clean$date_obs, format = "%Y-%m-%d")

#Vérifier si les données dans la colonne date sont conforme au format yyy-mm-jj
is_date <- !is.na(ymd(final_data_clean$date_obs, quiet = TRUE))
table(is_date)

# Afficher les lignes avec des dates non conformes
final_data_clean$date_obs[!is_date]

#Les dates non-conformes sont des NA donc pas de correction nécessaire

#uniformiser la colonne 'heure_obs'
final_data_clean$heure_obs <- gsub("h", ":", final_data_clean$heure_obs)

# 2ième étape du projet

library(RSQLite)
con <-dbConnect(SQLite(), dbname="reseau.db")


#ajouter une colonne ID
final_data_clean$ID <- 1:nrow(final_data_clean)

#créer un data_frame selon le même ordre que la clé primaire pour benthos
data_benthos<-subset(final_data_clean, select = c(ID,nom_sci,site,date_obs,fraction,abondance,heure_obs,ETIQSTATION))


#créer un data_frame selon le même ordre que la clé primaire pour site
data_site <- subset(final_data_clean, select = c(date,site,largeur_riviere,profondeur_riviere,vitesse_courant,transparence_eau,temperature_eau_c))

#Créer la table Benthos
tbl_benthos<- "
CREATE TABLE benthos (
ID        INTEGER PRIMARY KEY,
nom_sci   CHARACTER(50),
site      VARCHAR(20),
date_obs  CHARACTER(20),
fraction  NUMERIC,
abondance INTEGER,
heure_obs CHARACTER(20),
ETIQSTATION CHARACTER(20),
FOREIGN KEY (SITE)
);"

dbSendQuery(con, tbl_benthos)


#Créer la table site
tbl_site <-"
CREATE TABLE site (
date                DATE,
site                VARCHAR(20),
largeur_riviere     REAL,
profondeur_riviere  REAL,
vitesse_courant     REAL,
transparence_eau    VARCHAR(20),
temperature_eau_c   REAL
);"
dbSendQuery(con, tbl_site)


#Injection des donnees
dbWriteTable(con, append = TRUE, name ="site", value=data_site)
dbWriteTable(con, append = TRUE, name ="benthos", value=data_benthos)





dbDisconnect(con)













