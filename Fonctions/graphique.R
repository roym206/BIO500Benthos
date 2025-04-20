# 
# library(ggplot2)
# # graphique de la richesse spécifique en fonction de la température
# plot(Requete_temperature$temperature_eau_c, Requete_temperature$richesse_specifique,
#      xlab = "Température de l'eau (°C)",
#      ylab = "Richesse spécifique",
#      main = "Richesse spécifique en fonction de la température")
# abline(lm(richesse_specifique ~ temperature_eau_c, data = Requete_temperature), col = "red")


# Fonction pour créer un graphique de la richesse spécifique en fonction de la température
graphique_richesse_temperature <- function() {
  library(ggplot2)
  
  # graphique de la richesse spécifique en fonction de la température
  plot(Requete_temperature$temperature_eau_c, Requete_temperature$richesse_specifique,
       xlab = "Température de l'eau (°C)",
       ylab = "Richesse spécifique",
       main = "Richesse spécifique en fonction de la température")
  
  abline(lm(richesse_specifique ~ temperature_eau_c, data = Requete_temperature), col = "red")
}




# 
# # graphique de la richesses spécifique en fonction de la profondeur
# library(ggplot2)
# library(dplyr)
# # Créer des intervalles de profondeur
# Requete_profondeur$intervalle_profondeur<- cut(
#   Requete_profondeur$profondeur_riviere,
#   breaks = seq(0, 0.8, by = 0.2),
#   include.lowest = TRUE,
#   right = TRUE
# )
# 
# # Enlever les lignes avec NA dans l'intervalle
# Requete_profondeur <- Requete_profondeur %>%
#   filter(!is.na(intervalle_profondeur))
# 
# #Calculer la richesse moyenne par intervalle de profondeur
# richesse_moyenne_selon_profondeur <- Requete_profondeur %>%
#   group_by(intervalle_profondeur) %>%
#   summarise(richesse_moyenne = mean(richesse_specifique, na.rm = TRUE))
# # Créer un histogramme
# ggplot(richesse_moyenne_selon_profondeur, aes(x = intervalle_profondeur, y = richesse_moyenne)) +
#   geom_col(fill = "darkblue", width = 0.5) +
#   labs(
#     x = "Intervalle de profondeur (m)",
#     y = "Richesse spécifique moyenne",
#     title = "Richesse spécifique moyenne selon la profondeur"
#   ) +
#   theme_minimal()



# Fonction pour créer un graphique de la richesse spécifique en fonction de la profondeur
graphique_richesse_profondeur <- function() {
  library(ggplot2)
  library(dplyr)
  
  # Créer des intervalles de profondeur
  Requete_profondeur$intervalle_profondeur <- cut(
    Requete_profondeur$profondeur_riviere,
    breaks = seq(0, 0.8, by = 0.2),
    include.lowest = TRUE,
    right = TRUE
  )
  
  # Enlever les lignes avec NA dans l'intervalle
  Requete_profondeur <- Requete_profondeur %>%
    filter(!is.na(intervalle_profondeur))
  
  # Calculer la richesse moyenne par intervalle de profondeur
  richesse_moyenne_selon_profondeur <- Requete_profondeur %>%
    group_by(intervalle_profondeur) %>%
    summarise(richesse_moyenne = mean(richesse_specifique, na.rm = TRUE))
  
  # Créer un histogramme
  ggplot(richesse_moyenne_selon_profondeur, aes(x = intervalle_profondeur, y = richesse_moyenne)) +
    geom_col(fill = "darkblue", width = 0.5) +
    labs(
      x = "Intervalle de profondeur (m)",
      y = "Richesse spécifique moyenne",
      title = "Richesse spécifique moyenne selon la profondeur"
    ) +
    theme_minimal()
}





# 
# 
# # graphique de la richesses spécifique en fonction de la vitesse du courant
# 
# # Créer les classes de courant
# Requete_courant$classe_courant <- cut(
#   Requete_courant$vitesse_courant,
#   breaks = c(0, 0.2, 0.4, 0.6, 1.0),
#   include.lowest = TRUE,
#   right = FALSE
# )
# 
# # Supprimer les NA s’il y en a
# Requete_courant_clean <- Requete_courant %>%
#   filter(!is.na(classe_courant), !is.na(richesse_specifique))
# 
# # Diagramme de densité
# ggplot(Requete_courant_clean, aes(x = richesse_specifique, fill = classe_courant)) +
#   geom_density(alpha = 0.9) +
#   labs(
#     title = "Distribution de la richesse spécifique selon la vitesse du courant",
#     x = "Richesse spécifique",
#     y = "Densité",
#     fill = "Classe de courant (m/s)"
#   ) +
#   theme_minimal()
# 
# #La densité en Y indique la probabilité relative de trouver une valeur de richesse spécifique dans un intervalle donné.



# Fonction pour créer un graphique de la richesse spécifique en fonction de la vitesse du courant
graphique_richesse_courant <- function() {
  library(ggplot2)
  library(dplyr)
  
  # Créer les classes de courant
  Requete_courant$classe_courant <- cut(
    Requete_courant$vitesse_courant,
    breaks = c(0, 0.2, 0.4, 0.6, 1.0),
    include.lowest = TRUE,
    right = FALSE
  )
  
  # Supprimer les NA s’il y en a
  Requete_courant_clean <- Requete_courant %>%
    filter(!is.na(classe_courant), !is.na(richesse_specifique))
  
  # Diagramme de densité
  ggplot(Requete_courant_clean, aes(x = richesse_specifique, fill = classe_courant)) +
    geom_density(alpha = 0.9) +
    labs(
      title = "Distribution de la richesse spécifique selon la vitesse du courant",
      x = "Richesse spécifique",
      y = "Densité",
      fill = "Classe de courant (m/s)"
    ) +
    theme_minimal()
}








