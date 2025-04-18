
#install.packages("RSQLite")
library(RSQLite)
library(DBI)
source("Fonctions/creer_tables.R")
con <-dbConnect(SQLite(), dbname="db_name")

#Requete pour la température pour avoir la richesse spécifique par site

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
head(Requete_temperature)
}

#Requête richesse en fonction de la température
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
head(Requete_courant)
}


#Requête richesse en fonction profondeur
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
head(Requete_profondeur)
}







