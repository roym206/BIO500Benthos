#requête

sql_requete_test <- "

SELECT nom_sci, abondance
FROM benthos
JOIN 
WHERE transparence_eau 
;"

Test_de_requete<- dbGetQuery(con, sql_requete_test)
head(Test_de_requete)

#créer un data_frame selon le même ordre que la clé primaire pour site
data_site <- subset(final_data_clean, select = c(ID,date,site,largeur_riviere,profondeur_riviere,vitesse_courant,transparence_eau,temperature_eau_c))


#Créer la table Benthos
tbl_benthos<- "
CREATE TABLE benthos (
ID        INTEGER PRIMARY KEY,
nom_sci   CHARACTER(50),
site      VARCHAR(20),
date_obs  CHARACTER(20),
fraction  NUMERIC,
abondance INTEGER,
heure_obs CHARACTER(20),
ETIQSTATION CHARACTER(20)
);"

dbSendQuery(con, tbl_benthos)


#Créer la table site
tbl_site <-"
CREATE TABLE site (
ID        INTEGER PRIMARY KEY,
date                DATE,
site                VARCHAR(20),
largeur_riviere     REAL,
profondeur_riviere  REAL,
vitesse_courant     REAL,
transparence_eau    VARCHAR(20),
temperature_eau_c   REAL,
PRIMARY KEY ()


);"

dbSendQuery(con, tbl_site)
