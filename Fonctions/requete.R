#requête
#install.packages("RSQLite")
library(RSQLite)
library(DBI)
source("Fonctions/creer_tables.R")
con <-dbConnect(SQLite(), dbname="db_name")

abondance_esp_transp_e <- "

SELECT nom_sci, abondance
FROM benthos
LEFT JOIN emplacement ON benthos.site = emplacement.site AND benthos.date_obs = emplacement.date_obs
WHERE transparence_eau LIKE 'ELEVEE'

UNION

SELECT nom_sci, abondance
FROM benthos
RIGHT JOIN emplacement ON benthos.site = emplacement.site AND benthos.date_obs = emplacement.date_obs
WHERE transparence_eau LIKE 'ELEVEE'
;"


Requete_transparence_e <- dbGetQuery(con, abondance_esp_transp_e)
  head(Requete_transparence_e)

  
#requete pour les abondances dMespèces en fonction de la transparence de l'eau moyenne
  abondance_esp_transp_m <- "

SELECT nom_sci, abondance
FROM benthos
LEFT JOIN emplacement ON benthos.site = emplacement.site AND benthos.date_obs = emplacement.date_obs
WHERE transparence_eau LIKE 'MOYENNE'

UNION

SELECT nom_sci, abondance
FROM benthos
RIGHT JOIN emplacement ON benthos.site = emplacement.site AND benthos.date_obs = emplacement.date_obs
WHERE transparence_eau LIKE 'MOYENNE'
;"
  
  
  Requete_transparence_m <- dbGetQuery(con, abondance_esp_transp_m)
  head(Requete_transparence_m)

  #Requete pour les abondances d'espèces en fonction de la transparence de l'eau faible
  abondance_esp_transp_f <- "

SELECT nom_sci, abondance
FROM benthos
LEFT JOIN emplacement ON benthos.site = emplacement.site AND benthos.date_obs = emplacement.date_obs
WHERE transparence_eau LIKE 'FAIBLE'

UNION

SELECT nom_sci, abondance
FROM benthos
RIGHT JOIN emplacement ON benthos.site = emplacement.site AND benthos.date_obs = emplacement.date_obs
WHERE transparence_eau LIKE 'FAIBLE'
;"
  
  
  Requete_transparence_f <- dbGetQuery(con, abondance_esp_transp_f)
  head(Requete_transparence_f)
  
  
  