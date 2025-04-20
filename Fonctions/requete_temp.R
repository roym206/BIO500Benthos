
#Installer les packages
library(RSQLite)
library(DBI)
source("Fonctions/creer_tables.R")

### Étape 1: Se connecter à la base de données ###
#con <-dbConnect(SQLite(), dbname="db_name") #chatGPT m'a dit de l'enlever

### Étape 2: Faire les requête ###

#Requête richesse spécifique par site en fonction de la température
fonction_requete_temp <- function(db_path= "reseau.db") {
  con <-dbConnect(SQLite(), dbname=db_path)
Requete_temperature <- "
  SELECT 
      COUNT(DISTINCT b.nom_sci) AS richesse_specifique,
      e.temperature_eau_c
  FROM benthos b
  LEFT JOIN emplacement e
    ON b.site = e.site AND b.date_obs = e.date_obs
  GROUP BY e.temperature_eau_c;
"


Requete_temperature <- dbGetQuery(con, Requete_temperature)
dbDisconnect(con)
return(Requete_temperature)

}

#Requête richesse spécifique en fonction du courant
fonction_requete_cou <- function(db_path = "reseau.db") {
  con <-dbConnect(SQLite(), dbname=db_path)
Requete_courant<- "
  SELECT 
      COUNT(DISTINCT b.nom_sci) AS richesse_specifique,
      e.vitesse_courant
  FROM benthos b
  LEFT JOIN emplacement e
    ON b.site = e.site AND b.date_obs = e.date_obs
  GROUP BY e.vitesse_courant;
;
"
Requete_courant <- dbGetQuery(con, Requete_courant)
dbDisconnect(con)
return(Requete_courant)

}

#Requête richesse spécifique en fonction de la profondeur
fonction_requete_pro <- function(db_path = "reseau.db") {
  con <-dbConnect(SQLite(), dbname=db_path)
Requete_profondeur<- "
  SELECT 
      COUNT(DISTINCT b.nom_sci) AS richesse_specifique,
      e.profondeur_riviere
  FROM benthos b
  LEFT JOIN emplacement e
    ON b.site = e.site AND b.date_obs = e.date_obs
  GROUP BY e.profondeur_riviere;
;
"
Requete_profondeur <- dbGetQuery(con, Requete_profondeur)

dbDisconnect(con)
return(Requete_profondeur)



}