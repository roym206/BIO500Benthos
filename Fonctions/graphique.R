

# Fonction pour créer un graphique de la richesse spécifique en fonction de la température
graphique_richesse_temperature <- function(Requete_temperature) {
  
  
  # graphique de la richesse spécifique en fonction de la température
  graphique_rt <- ggplot(Requete_temperature, aes(x= temperature_eau_c, y= richesse_specifique)) +
    geom_point() + 
    geom_smooth(method = "lm", se = FALSE, color = "red")+
    labs(   
       x = "Température de l'eau (°C)",
       y = "Richesse spécifique",
       title = "Richesse spécifique en fonction de la température"
    ) +
      theme_minimal()+
    theme(
      plot.title = element_text(size = 8)  
    )
  
  return(graphique_rt)
}





# Fonction pour créer un graphique de la richesse spécifique en fonction de la profondeur
graphique_richesse_profondeur <- function(Requete_profondeur) {
 
  
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
 histo_rp <-  ggplot(richesse_moyenne_selon_profondeur, aes(x = intervalle_profondeur, y = richesse_moyenne)) +
    geom_col(fill = "darkblue", width = 0.5) +
    labs(
      x = "Intervalle de profondeur (m)",
      y = "Richesse spécifique moyenne",
      title = "Richesse spécifique moyenne selon la profondeur"
    ) +
    theme_minimal()+
 theme(
   plot.title = element_text(size = 8) 
  )
   return(histo_rp)
 
}




# Fonction pour créer un graphique de la richesse spécifique en fonction de la vitesse du courant
graphique_richesse_courant <- function(Requete_courant) {
 
  
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
 dia_rc <- ggplot(Requete_courant_clean, aes(x = richesse_specifique, fill = classe_courant)) +
    geom_density(alpha = 0.9) +
    labs(
      title = "Distribution de la richesse spécifique selon la vitesse du courant",
      x = "Richesse spécifique",
      y = "Densité",
      fill = "Classe de courant (m/s)"
    ) +
    theme_minimal()+
 theme(
   plot.title = element_text(size = 8), 
   legend.text = element_text(size = 5),
   legend.title = element_text(size = 5)
 )
  return(dia_rc)
}








