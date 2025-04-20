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

1



targets::tar_errored()
