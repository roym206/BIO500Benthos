#requête

sql_requete_test <- "

SELECT nom_sci, abondance
FROM benthos

;"

Test_de_requete<- dbGetQuery(con, sql_requete_test)
head(Test_de_requete)