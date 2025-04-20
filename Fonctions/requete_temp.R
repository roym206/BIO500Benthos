
#Installer les packages
library(RSQLite)
library(DBI)
source("Fonctions/creer_tables.R")

### Étape 1: Se connecter à la base de données ###
con <-dbConnect(SQLite(), dbname="db_name")

### Étape 2: Faire les requête ###

#Requête richesse spécifique par site en fonction de la température
fonction_requete_temp <- function(con) {
Requete_temperature <- "
SELECT 
    b.site,
    b.date_obs,
    COUNT(DISTINCT b.nom_sci) AS richesse_specifique,
    e.temperature_eau_c
FROM benthos b
LEFT JOIN emplacement e
ON b.site = e.site AND b.date_obs = e.date_obs
GROUP BY b.site, b.date_obs, e.temperature_eau_c;
"
Requete_temperature <- dbGetQuery(con, Requete_temperature)
return(Requete_temperature)
}

#Requête richesse spécifique en fonction du courant
fonction_requete_cou <- function(con) {
Requete_courant<- "
SELECT 
    b.site,
    b.date_obs,
    COUNT(DISTINCT b.nom_sci) AS richesse_specifique,
    e.vitesse_courant
FROM benthos b
LEFT JOIN emplacement e
ON b.site = e.site AND b.date_obs = e.date_obs
GROUP BY b.site, b.date_obs, e.vitesse_courant;
"
Requete_courant <- dbGetQuery(con, Requete_courant)
return(Requete_courant)
}

#Requête richesse spécifique en fonction de la profondeur
fonction_requete_pro <- function(con) {
Requete_profondeur<- "
SELECT 
    b.site,
    b.date_obs,
    COUNT(DISTINCT b.nom_sci) AS richesse_specifique,
    e.profondeur_riviere
FROM benthos b
LEFT JOIN emplacement e
ON b.site = e.site AND b.date_obs = e.date_obs
GROUP BY b.site, b.date_obs, profondeur_riviere;
"
Requete_profondeur <- dbGetQuery(con, Requete_profondeur)
return(Requete_profondeur)
}







