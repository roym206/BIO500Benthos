
abondance_esp_transp_m <- "

SELECT nom_sci, abondance
FROM benthos
JOIN emplacement
WHERE transparence_eau like 'MOYENNE'
;"

Requete_transparence_m<- dbGetQuery(con, abondance_esp_transp_m)
head(Requete_transparence_m)

abondance_esp_transp_f <- "

SELECT nom_sci, abondance
FROM benthos
JOIN emplacement
WHERE transparence_eau like 'FAIBLE'
;"

Requete_transparence_f<- dbGetQuery(con, abondance_esp_transp_f)
head(Requete_transparence_f)

dbDisconnect(con)

# Vérifier que final_data_clean contient des données
if (nrow(final_data_clean) == 0) {
  stop("final_data_clean is empty.")
}