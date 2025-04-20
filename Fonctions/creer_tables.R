#Charger les packages

library(RSQLite)
library(DBI)
library(dplyr)
<<<<<<< HEAD
  
con <-dbConnect(SQLite(), dbname= db_name)

#ajouter une colonne ID
#final_data_clean$ID <- 1:nrow(final_data_clean)

#créer un data_frame selon le même ordre que la clé primaire pour benthos
data_benthos<-subset(final_data_clean, select = c(ID, nom_sci,site,date,fraction,abondance,heure_obs,ETIQSTATION))

#ajouter une colonne ID
data_benthos$ID.sp <- 1:nrow(data_benthos)

#S'assurer que les colonnes de date sont au bon format
data_benthos$date <- as.Date(data_benthos$date , format = "%Y-%m-%d")

#créer un data_frame selon le même ordre que la clé primaire pour emplacement
#data_emplacement <- subset(final_data_clean, select = c(site, date,largeur_riviere,profondeur_riviere,vitesse_courant,transparence_eau,temperature_eau_c))

# Créer un data_frame selon le même ordre que la clé primaire pour site et enlever les lignes qui se répètent
data_emplacement <- final_data_clean %>%
  select(date, site, largeur_riviere, profondeur_riviere, vitesse_courant, transparence_eau, temperature_eau_c) %>%
  distinct()
#ajouter une colonne ID.place
data_emplacement$ID.place <- 1:nrow(data_emplacement)

#S'assurer que les colonnes de date sont au bon format
data_emplacement$date <- as.Date(data_emplacement$date , format = "%Y-%m-%d")

#Créer la table Benthos
tbl_benthos<- "
CREATE TABLE benthos (
ID.sp     INTEGER PRIMARY KEY AUTOINCREMENT,
=======

### Étape 1: Préparer les données à l'injection ###

 ## Étape 1.1: Préparer la table benthos
creerBD <- function(final_data_clean, db_name = "reseau.db"){
  

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
>>>>>>> 1519290a43106d06de67d29ca5a9297a65b6afc1
nom_sci   CHARACTER(50),
site      VARCHAR(20),
date      DATE,
fraction  NUMERIC,
abondance INTEGER,
heure_obs CHARACTER(20),
ETIQSTATION CHARACTER(20),
<<<<<<< HEAD
FOREIGN KEY (site, date) REFERENCES emplacement(site, date)
=======
FOREIGN KEY (site, date_obs) REFERENCES emplacement(site, date_obs)
>>>>>>> 1519290a43106d06de67d29ca5a9297a65b6afc1
);"

dbSendQuery(con, tbl_benthos)

<<<<<<< HEAD
#Créer la table site
tbl_emplacement <-"
CREATE TABLE emplacement (
ID.place           INTEGER PRIMARY KEY AUTOINCREMENT,
site                VARCHAR(20),
date                DATE,
=======
## Étape 2.3: Créer la table emplacement
tbl_emplacement <-"
CREATE TABLE emplacement (
ID_place           INTEGER PRIMARY KEY AUTOINCREMENT,
site                VARCHAR(20),
date_obs            CHARACTER(20),
>>>>>>> 1519290a43106d06de67d29ca5a9297a65b6afc1
largeur_riviere     REAL,
profondeur_riviere  REAL,
vitesse_courant     REAL,
transparence_eau    VARCHAR(20),
<<<<<<< HEAD
temperature_eau_c   REAL,
=======
temperature_eau_c   REAL
>>>>>>> 1519290a43106d06de67d29ca5a9297a65b6afc1
);"
dbSendQuery(con, tbl_emplacement)


<<<<<<< HEAD
#Injection des donnees
dbWriteTable(con, append = TRUE, name ="emplacement", value=data_emplacement)
dbWriteTable(con, append = TRUE, name ="benthos", value=data_benthos)

=======
### Étape 3: Injecter les données dans les tables ###
dbWriteTable(con, append = TRUE, name ="emplacement", value = data_emplacement)
dbWriteTable(con, append = TRUE, name ="benthos", value = data_benthos)
>>>>>>> 1519290a43106d06de67d29ca5a9297a65b6afc1


 # Créer des objets dplyr::tbl pour les tables SQL
 tbl_benthos <- dplyr::tbl(con, "benthos")
 tbl_emplacement <- dplyr::tbl(con, "emplacement")
 
 # Déconnexion de la BD
 dbDisconnect(con)
 
 # Retourner les objets
 return(list(
   tbl_benthos = tbl_benthos,
   tbl_emplacement = tbl_emplacement,
   con = con
 ))
 
}




