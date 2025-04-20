#Créer un flowchart
#install.packages("DiagrammeR")

#Lui le meilleur jusqu'à maintenant

library(DiagrammeR)

grViz("
digraph {
  # Définir un alignement vertical global pour le graphique
  graph [rankdir = TB] # TB = Top to Bottom

  # Ajouter un nœud pour le titre principal
  title [label = \"Facteurs impactant la richesse spécifique du benthos\", shape = plaintext, fontsize = 20, fontcolor = black]

  # Nœud fictif pour séparer le titre de la légende et du graphique principal
  invisible_anchor [label = \"\", shape = plaintext, width = 0, height = 0, style = invis]

  # Légende en haut, centrée
  subgraph cluster_legend {
    label = \"Légende\";
    fontsize = 10;
    fontcolor = \"black\";
    style = dashed;

    # Carrés colorés et textes associés
    color_key3 [label = \"\", shape = rectangle, style = filled, fillcolor = \"blue\", width = 0.2, height = 0.2]
    label_key3 [label = \"Relation neutre\", shape = plaintext]
    
    color_key2 [label = \"\", shape = rectangle, style = filled, fillcolor = \"red\", width = 0.2, height = 0.2]
    label_key2 [label = \"Relation négative\", shape = plaintext]
    
    color_key1 [label = \"\", shape = rectangle, style = filled, fillcolor = \"green\", width = 0.2, height = 0.2]
    label_key1 [label = \"Relation positive\", shape = plaintext]
    
    # Aligner les éléments côte à côte dans chaque rangée
    { rank = same; color_key3 -> label_key3 [style = invis] }
    { rank = same; color_key2 -> label_key2 [style = invis] }
    { rank = same; color_key1 -> label_key1 [style = invis] }
    
    # Aligner les rangées verticalement les unes sous les autres
    color_key3 -> color_key2 [style = invis]
    label_key3 -> label_key2 [style = invis]
    color_key2 -> color_key1 [style = invis]
    label_key2 -> label_key1 [style = invis]
  }

  # Relier le titre à un nœud fictif invisible pour centrer
  title -> invisible_anchor [style = invis]

  # Graphique principal en dessous de la légende
  subgraph cluster_main {
    node [fontname = Helvetica, shape = rectangle]

    A [label = \"température\"]
    B [label = \"solubilité des gazs\"]
    C [label = \"oxygène dissous\"]
    D [label = \"richesse spécifique\"]
    E [label = \"courant fort\"]
    F [label = \"plus de difficulté à rester sur place\"]
    
    # Liens entre les nœuds
    A -> B [color = \"green\"]
    B -> C [color = \"red\"]
    C -> D [color = \"\"]
    E -> F [color = \"red\"]
    F -> D [color = \"red\"]
    
    # Centrer le graphique principal sous le nœud fictif
    invisible_anchor -> A [style = invis]
  }
}
")

