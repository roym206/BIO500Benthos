#Charger les packages

library(RSQLite)
library(DBI)
library(dplyr)

### Étape 1: Préparer les données à l'injection ###

 ## Étape 1.1: Préparer la table benthos
creerBD <- function(final_data_clean, db_name = "reseau.db"){
  
# Ajouter une colonne ID aux données nettoyées
# final_data_clean$ID <- 1:nrow(final_data_clean)

# créer un data_frame selon le même ordre que la clé primaire pour la table benthos
data_benthos<-subset(final_data_clean, select = c(nom_sci,site,date_obs,fraction,abondance,heure_obs,ETIQSTATION))

# Ajouter une colonne ID à la table benthos
data_benthos$ID_sp <- 1:nrow(data_benthos)

## Étape 1.2: Préparer la table emplacement

# Créer un data_frame selon le même ordre que la clé primaire pour site et enlever les lignes qui se répètent pour la table emplacement
data_emplacement <- final_data_clean %>%
  select(date_obs, site, largeur_riviere, profondeur_riviere, vitesse_courant, transparence_eau, temperature_eau_c) %>%
  distinct()

# Ajouter une colonne ID à la table emplacement
data_emplacement$ID_place <- 1:nrow(data_emplacement)

### Étape 2: créer les tables SQL ###

## Étape 2.1: créer la connexion 

  
  con <-dbConnect(SQLite(), dbname = db_name)

## Étape 2.2: Créer la table Benthos
tbl_benthos<- "
CREATE TABLE benthos (
ID_sp     INTEGER PRIMARY KEY AUTOINCREMENT,
nom_sci   CHARACTER(50),
site      VARCHAR(20),
date_obs  CHARACTER(20),
fraction  NUMERIC,
abondance INTEGER,
heure_obs CHARACTER(20),
ETIQSTATION CHARACTER(20),
FOREIGN KEY (site, date_obs) REFERENCES emplacement(site, date_obs)
);"

dbSendQuery(con, tbl_benthos)

## Étape 2.3: Créer la table emplacement
tbl_emplacement <-"
CREATE TABLE emplacement (
ID_place           INTEGER PRIMARY KEY AUTOINCREMENT,
site                VARCHAR(20),
date_obs            CHARACTER(20),
largeur_riviere     REAL,
profondeur_riviere  REAL,
vitesse_courant     REAL,
transparence_eau    VARCHAR(20),
temperature_eau_c   REAL
);"
dbSendQuery(con, tbl_emplacement)


### Étape 3: Injecter les données dans les tables ###
dbWriteTable(con, append = TRUE, name ="emplacement", value = data_emplacement)
dbWriteTable(con, append = TRUE, name ="benthos", value = data_benthos)



# Déconnexion de la BD
dbDisconnect(con)

}




