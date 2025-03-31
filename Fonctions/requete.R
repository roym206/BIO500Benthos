#requête
#install.packages("RSQLite")
library(RSQLite)
library(DBI)
source("Fonctions/creer_tables.R")
con <-dbConnect(SQLite(), dbname="db_name")

abondance_esp_transp_e <- "

SELECT nom_sci, abondance
FROM benthos
JOIN site
WHERE transparence_eau like 'ELEVEE'
;"

Requete_transparence_e<- dbGetQuery(con, abondance_esp_transp_e)
head(Requete_transparence_e)


abondance_esp_transp_m <- "

SELECT nom_sci, abondance
FROM benthos
JOIN site
WHERE transparence_eau like 'MOYENNE'
;"

Requete_transparence_m<- dbGetQuery(con, abondance_esp_transp_m)
head(Requete_transparence_m)

abondance_esp_transp_f <- "

SELECT nom_sci, abondance
FROM benthos
JOIN site
WHERE transparence_eau like 'FAIBLE'
;"

Requete_transparence_f<- dbGetQuery(con, abondance_esp_transp_f)
head(Requete_transparence_f)

dbDisconnect(con)
