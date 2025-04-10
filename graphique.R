
# graphique de la richesse spécifique en fonction de la température
plot(Requete_richesse$temperature_eau_c, Requete_richesse$richesse_specifique,
     xlab = "Température de l'eau (°C)",
     ylab = "Richesse spécifique",
     main = "Richesse spécifique en fonction de la température")
abline(lm(richesse_specifique ~ temperature_eau_c, data = Requete_richesse), col = "red")





# graphique de la richesses spécifique en fonction de la profondeur

# Tracer le nuage de points avec des limites spécifiques sur l'axe X
plot(Requete_profondeur_clean$profondeur_riviere, Requete_profondeur_clean$richesse_specifique,
     xlab = "Profondeur (m)",
     ylab = "Richesse spécifique",
     main = "Richesse spécifique en fonction de la profondeur",
     xlim = c(0, 30))  # Définir les limites de l'axe X de 0 à 1

# Ajouter la droite de régression
abline(lm(richesse_specifique ~ profondeur_riviere, data = Requete_profondeur_clean), col = "red")



# graphique de la richesses spécifique en fonction de la vitesse du courant

# Tracer le nuage de points pour richesse spécifique vs vitesse du courant
plot(Requete_courant$vitesse_courant, Requete_courant$richesse_specifique,
     xlab = "Vitesse du courant (m/s)", 
     ylab = "Richesse spécifique", 
     main = "Relation entre richesse spécifique et vitesse du courant",
     xlim = c(0, 30))  # Définir les limites de l'axe X de 0 à 1

# Ajouter une droite de régression linéaire
abline(lm(richesse_specifique ~ vitesse_courant, data = Requete_courant), col = "red")

