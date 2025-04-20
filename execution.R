# exécuter le projet
library(RSQLite)
library(targets)
tar_make()
tar_visnetwork()
tar_read(benthos)
tar_read(reseau.db)
 
targets::tar_read(reseau.db) %>% collect()
targets::tar_read(tbl_emplacement) %>% collect()

DBI::dbIsValid(db_objects$con)

dbGetQuery(db_objects$con, "SELECT * FROM emplacement")
dbGetQuery(db_objects$con, "SELECT * FROM benthos")




targets::tar_errored()



tar_meta(Requete_temperature, fields = error)
