:-module(util,[getValeurGrille/4]).

%%%% valeurGrille(Grille,Colonne,Ligne,Valeur)
%Permet de récupérer la valeur contenue dans le tableau de jeu situé dans la colonne et la ligne spécifié. 
%Attention la grille est supposée avoir une ligne vide en-dessous inutilisée et deux colonnes intilisés sur les côtés gauche et droit.
%Les indices valables pour la ligne : [1,6]
%Les indices valvables pour la colonne : [1,7]
valeurGrille(Grille,numCol,numLigne,Valeur):-nth0(Colonne,Grille,colonne),nth0(numLigne,colonne,Valeur).
