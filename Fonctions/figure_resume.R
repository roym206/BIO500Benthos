#Créer un flowchart
install.packages("DiagrammeR")
library(DiagrammeR)
grViz("digraph flowchart {
      # node definitions with substituted label text
      node [fontname = Helvetica, shape = rectangle]        
      tab1 [label = '@@1']
      tab2 [label = '@@2']
      tab3 [label = '@@3']
      tab4 [label = '@@4']
      tab5 [label = '@@5']

      # edge definitions with the node IDs
      tab1 -> tab2 -> tab3 -> tab4 -> tab5;
      }

      [1]: 'Effets de la température de l'eau'
      [2]: 'L'augmentation de la température réduit la solubilité des gazs dans l'eau'
      [3]: 'Moins d'oxygène dissous dans l'eau'
      [4]: 'Réduction de la richesse spécifique et de l'abondance d'organismes benthiques'
      [5]: 'test'
      ")


library(DiagrammeR)

grViz("
digraph flowchart {
  # node definitions with substituted label text
  node [fontname = Helvetica, shape = rectangle]        
  tab1 [label = '@@1']
  tab2 [label = '@@2']
  tab3 [label = '@@3']
  tab4 [label = '@@4']
  tab5 [label = '@@5']

  # edge definitions with the node IDs
  tab1 -> tab2 -> tab3 -> tab4 -> tab5;
}

[1]: \"Effets de la température de l'eau\"
[2]: \"L'augmentation de la température réduit la solubilité des gazs dans l'eau\"
[3]: \"Moins d'oxygène dissous dans l'eau\"
[4]: \"Réduction de la richesse spécifique et de l'abondance d'organismes benthiques\"
[5]: \"test\"
")


library(DiagrammeR)

grViz("
digraph flowchart {
  # node definitions with substituted label text
  node [fontname = Helvetica, shape = rectangle]        
  tab1 [label = \" ↑ température\"]
  tab2 [label = \" ↓ solubilité des gazs \"]
  tab3 [label = \" ↓ oxygène dissous \"]
  tab4 [label = \" ↓ richesse spécifique \"]
  tab5 [label = \"Courant fort\"]
  tab6 [label = \"raison\"]
  tab7 [label = \"plus de richesse spécifique\"]

  # edge definitions with the node IDs
  tab5 -> tab1 -> tab2 -> tab3 -> tab4;
  tab4 -> tab6 -> tab7;
}
")


library(DiagrammeR)

grViz("
digraph {
  A [label = \"Texte personnalisé pour A↓\"]
  A -> B;
  A -> C;
  B -> D;
  C -> D;
  
}
")


library(DiagrammeR)

grViz("
digraph {
  # Définition des nœuds avec des labels personnalisés
  node [fontname = Helvetica, shape = rectangle]
  
  A [label = \"température\"]
  B [label = \"solubilité des gazs\"]
  C [label = \"oxygène dissous\"]
  D [label = \"richesse spécifique\"]
  E [label = \"courant fort\"]
  F [label = \"raison\"]
  
  
  # Définition des liens avec des couleurs
  A -> B [color = \"green\"]
  B -> C [color = \"red\"]
  C -> D [color = \"red\"]
  E -> F [color = \"red\"]
  F -> D [color = \"red\"]
  
  # Ajouter une légende comme un sous-graphe
  subgraph cluster_legend {
    label = \"Légende\";
    fontsize = 12;
    fontcolor = \"black\";
    style = dashed;

   # Rectangles colorés pour la légende
    key1 [label = \" Relation positive \", shape = rectangle, style = filled, fillcolor = \"green\", fontcolor = \"black\"]
    key2 [label = \" Relation négative \", shape = rectangle, style = filled, fillcolor = \"red\", fontcolor = \"black\"]
    key3 [label = \" Relation neutre \", shape = rectangle, style = filled, fillcolor = \"blue\", fontcolor = \"black\"]
    
    
    key1 -> key2 [style = invis]
    key2 -> key3 [style = invis]
  }

}
")
