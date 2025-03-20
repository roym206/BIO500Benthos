#Code pour uniformiser les heures dans la BD

#install.packages("lubridate")
library(lubridate)
library(stringr)

temps_converti <- function(temps) {
     # remplacer les h et . par des :
       temps <- str_replace_all(temps,"[h.,]", ":")
     # parser en tant qu'objet de type hms
       temps_p <- parse_date_time(temps, orders = c("HMS", "HM", "H"))
     # Retourner au format HH : MM : SS
       return(format(temps_p, "%H:%M:%S"))
  
}

 final_data$heure_obs <- sapply(final_data$heure_obs, temps_converti)

 