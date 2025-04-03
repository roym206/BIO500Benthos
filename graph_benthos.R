library(ggplot2)
install.packages("dplyr")
install.packages("ggridges")
library("ggridges")
library("ggplot2")

#Devrait donner point reliee entre eux pour chaque sps
donnees<-read.csv(file="site_100_92_R01_2021-10-01.csv")
as.data.frame(donnees)
plot1<-ggplot(data= donnees,
              mapping = aes(x = profondeur_riviere, y= abondance, color=nom_sci)
              )+
  geom_point()+
  geom_smooth(method="lm")

#A faire
#Essayer de comprendre comment ggridge fonctionne --> graphique plus smooth
#Essayer avec le set de donnees nettoye, car ici c'est pour seulement 1 rivière 
