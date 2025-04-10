
#install.packages("RSQLite")
library(RSQLite)
library(DBI)
source("Fonctions/creer_tables.R")
con <-dbConnect(SQLite(), dbname="db_name")

#Requete pour la température pour avoir la richesse spécifique par site
#Requete_temperature <- "
#SELECT nom_sci, date_obs, site
#FROM benthos
#LEFT JOIN emplacement ON benthos.site = emplacement.site AND benthos.date_obs = emplacement.date_obs

#UNION

#SELECT temperature_eau_c
#FROM emplacement
#RIGHT JOIN emplacement ON benthos.site = emplacement.site AND benthos.date_obs = emplacement.date_obs
#;"


Requete_temperature <- "
SELECT b.nom_sci, b.date_obs, b.site, e.temperature_eau_c
FROM benthos b
LEFT JOIN emplacement e
ON b.site = e.site AND b.date_obs = e.date_obs;
"
Requete_temperature <- dbGetQuery(con, Requete_temperature)
head(Requete_temperature)


Requete_richesse <- "
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
Requete_richesse <- dbGetQuery(con, Requete_richesse)
head(Requete_richesse)
