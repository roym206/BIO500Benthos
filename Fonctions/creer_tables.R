# Charger les packages

library(RSQLite)
library(DBI)
library(dplyr)

### Étape 1: Préparer les données à l'injection ###

# Fonction principale pour créer la base de données
creerBD <- function(final_data_clean, db_path = "reseau.db") {
  
  ## Étape 1.1: Préparer les tables
  #Ajout ID à Benthos
  data_benthos <- subset(final_data_clean, select = c(nom_sci, site, date_obs, fraction, abondance, heure_obs, ETIQSTATION))
  data_benthos$ID_sp <- 1:nrow(data_benthos)
  
  #Ajout ID à emplacement
  data_emplacement <- final_data_clean %>%
    select(date_obs, site, largeur_riviere, profondeur_riviere, vitesse_courant, transparence_eau, temperature_eau_c) %>%
    distinct()
  data_emplacement$ID_place <- 1:nrow(data_emplacement)
  
### Étape 2: Créer les tables SQL ###  
  
  # créer connexion SQLite
  con <- dbConnect(SQLite(), dbname = db_path)
  
  # Créer table benthos
  dbSendQuery(con, "
    CREATE TABLE IF NOT EXISTS benthos (
      ID_sp     INTEGER PRIMARY KEY AUTOINCREMENT,
      nom_sci   CHARACTER(50),
      site      VARCHAR(20),
      date_obs  CHARACTER(20),
      fraction  NUMERIC,
      abondance INTEGER,
      heure_obs CHARACTER(20),
      ETIQSTATION CHARACTER(20)
    );
  ")
  
  # Créer table emplacement
  dbSendQuery(con, "
    CREATE TABLE IF NOT EXISTS emplacement (
      ID_place           INTEGER PRIMARY KEY AUTOINCREMENT,
      site               VARCHAR(20),
      date_obs           CHARACTER(20),
      largeur_riviere    REAL,
      profondeur_riviere REAL,
      vitesse_courant    REAL,
      transparence_eau   VARCHAR(20),
      temperature_eau_c  REAL
    );
  ")
  
### Étape 3: Injection des données ###
  dbWriteTable(con, append = TRUE, name = "emplacement", value = data_emplacement)
  dbWriteTable(con, append = TRUE, name = "benthos", value = data_benthos)
  
  dbDisconnect(con)
  
  # Retourner le chemin du fichier pour que targets le suive
  return(db_path)
}
