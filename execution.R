# exécuter le projet
library(targets)
tar_make()
tar_visnetwork()
tar_read(final_data_clean)
tar_read(chemin)
 