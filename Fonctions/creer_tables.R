#Créer les bases de données et injecter les données dans les tables

creerBD <- function(final_data_clean, db_name = "reseau.db"){

library(RSQLite)
  
con <-dbConnect(SQLite(), dbname="db_name")


#ajouter une colonne ID
final_data_clean$ID <- 1:nrow(final_data_clean)

#créer un data_frame selon le même ordre que la clé primaire pour benthos
data_benthos<-subset(final_data_clean, select = c(ID,nom_sci,site,date_obs,fraction,abondance,heure_obs,ETIQSTATION))


#créer un data_frame selon le même ordre que la clé primaire pour site
data_site <- subset(final_data_clean, select = c(date,site,largeur_riviere,profondeur_riviere,vitesse_courant,transparence_eau,temperature_eau_c))



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
ETIQSTATION CHARACTER(20)
);"

dbSendQuery(con, tbl_benthos)

#Injection des donnees
dbWriteTable(con, append = TRUE, name ="site", value=data_site)
dbWriteTable(con, append = TRUE, name ="benthos", value=data_benthos)





dbDisconnect(con)

}




