#requête
#install.packages("RSQLite")
library(RSQLite)
library(DBI)
source("Fonctions/creer_tables.R")
con <-dbConnect(SQLite(), dbname="db_name")

abondance_esp_transp_e <- "

SELECT nom_sci, abondance
FROM benthos
LEFT JOIN emplacement ON benthos.site = emplacement.site AND benthos.date = emplacement.date
WHERE transparence_eau LIKE 'ELEVEE'

UNION

SELECT nom_sci, abondance
FROM benthos
RIGHT JOIN emplacement ON benthos.site = emplacement.site AND benthos.date = emplacement.date
WHERE transparence_eau LIKE 'ELEVEE'
;"


Requete_transparence_e <- dbGetQuery(con, abondance_esp_transp_e)
  head(Requete_transparence_e)

