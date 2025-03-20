#Importer SQL et connecter à R pour pouvoir combiner les BD

#install.packages('RSQLite')
#library(RSQLite)
#install.packages('DBI')
#library(DBI)

setwd("~/UdeS/Hiver 2025/BIO500/Projet de session - données-20250211/benthos/benthos")


chemin_dossier <- "~/UdeS/Hiver 2025/BIO500/Projet de session - données-20250211/benthos/benthos" 

fonc_combine <- function(chemin_dossier) {
  
#importer les libraries nécessaires
library(readr)
library(dplyr)
  
#Créer un chemin vers nos fichiers CSV

fichier_csv<-list.files(chemin_dossier, pattern = "\\.csv$", full.names = TRUE)

# Lire et combiner les fichiers CSV 
donnees <- fichier_csv%>%
  lapply(read.csv) %>%
  bind_rows()
#donnees <- list()

#Boucle pour importer les fichiers
#for (file in fichier_csv) {
# data <- read.csv(file)
 # donnees <- append(donnees, list(data))
  

return(donnees) #Retourner la liste de dataframe
}
#fusion des tables en une seule
final_data <- bind_rows(donnees)
print(head(final_data))
#}




#Site internet, fonctionnait pas
#conn <- dbConnect(sqlite, "[db file from DBeaver]")