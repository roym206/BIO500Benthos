#Créer les bases de données et injecter les données dans les tables

creerBD <- function(final_data_clean, db_name = "reseau.db"){

library(RSQLite)
library(DBI)
library(dplyr)
  
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
nom_sci   CHARACTER(50),
site      VARCHAR(20),
date      DATE,
fraction  NUMERIC,
abondance INTEGER,
heure_obs CHARACTER(20),
ETIQSTATION CHARACTER(20),
FOREIGN KEY (site, date) REFERENCES emplacement(site, date)
);"

dbSendQuery(con, tbl_benthos)

#Créer la table site
tbl_emplacement <-"
CREATE TABLE emplacement (
ID.place           INTEGER PRIMARY KEY AUTOINCREMENT,
site                VARCHAR(20),
date                DATE,
largeur_riviere     REAL,
profondeur_riviere  REAL,
vitesse_courant     REAL,
transparence_eau    VARCHAR(20),
temperature_eau_c   REAL,
);"
dbSendQuery(con, tbl_emplacement)


#Injection des donnees
dbWriteTable(con, append = TRUE, name ="emplacement", value=data_emplacement)
dbWriteTable(con, append = TRUE, name ="benthos", value=data_benthos)




dbDisconnect(con)

}




