library(ggplot2)
install.packages("dplyr")
install.packages("ggridges")
library("ggridges")
library("ggplot2")

#Devrait donner point reliee entre eux pour chaque sps
donnees<-read.csv(file="site_100_92_R01_2021-10-01.csv")
as.data.frame(donnees)

#Avec profondeur riviere
plot1<-ggplot(data= donnees,
              mapping = aes(x = profondeur_riviere, y= abondance, color=nom_sci)
              )+
  geom_point()+
  geom_smooth(method="lm")


#Avec largeur riviere
plot2<-ggplot(data= donnees,
              mapping = aes(x = largeur_riviere, y= abondance, color=nom_sci)
)+
  geom_point()+
  geom_smooth(method="lm")

plot2
#Avec transparence
plot3<-ggplot(data= donnees,
              mapping = aes(x = transparence_eau, y= abondance, color=nom_sci)
)+
  geom_point()+
  geom_smooth(method="lm")

plot3

#Avec vitesse courant

plot4<-ggplot(data= donnees,
              mapping = aes(x = vitesse_courant, y= abondance, color=nom_sci)
)+
  geom_point()+
  geom_smooth(method="lm")

#Avec temperature eau

plot5<-ggplot(data= donnees,
              mapping = aes(x = temperature_eau_c, y= abondance, color=nom_sci)
)+
  geom_point()+
  geom_smooth(method="lm")
plot5
#Avec site

plot6<- ggplot(data= donnees,
               mapping = aes(x = site, y= abondance, color=nom_sci)
)+
  geom_point()+
  geom_smooth(method="lm")
plot6


#A faire
#Essayer de comprendre comment ggridge fonctionne (geom_ridgeline()) --> graphique plus smooth. Je crois qu'il faut les donnees de >1 site pour cela.
#Essayer avec le set de donnees nettoye, car ici c'est pour seulement 1 rivière 

