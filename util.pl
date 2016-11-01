%%%%% fichier main.pl
% Ce fichier contient des méthodes utiles pour les autres modules du jeu.

%%% Export du module util et de ses prédicats
:-module(util, [valeurGrille/4, ajouterCase/3, majColonne/4, colonneRemplie/2, jouerCoup/4]).

%%%% valeurGrille(Grille,Colonne,Ligne,Valeur)
%Permet de récupérer la valeur contenue dans le tableau de jeu situé dans la colonne et la ligne spécifié. 
%Attention la grille est supposée avoir une ligne vide en-dessous inutilisée et deux colonnes inutilisés sur les côtés gauche et droit.
%Les indices valables pour la ligne : [1,6]
%Les indices valvables pour la colonne : [1,7]
valeurGrille(G,C,L,V):-
	nth1(C,G,Cl),
	nth1(L,Cl,V).
	
%%% AjouterCase
%Ajoute une valeur à la fin d'une liste passée en paramètre
%Pseudo-code: NouvColonne = OldColonne.append(Player)
ajouterCase(X,[],[X]).
ajouterCase(X,[Y|L1],[Y|L2]):- ajouterCase(X,L1,L2), length([Y|L1],N), N<6 .

%%% MajColonne
%Remplace l'élement d'une liste par un autre, passé en paramètre
%Pseudo-code: NouvGrille = Grille, NouvGrille[IndiceCol] = NouvColonne
majColonne([_|T], 0, X, [X|T]).
majColonne([H|T], I, X, [H|R]):- I > -1, NI is I-1, majColonne(T, NI, X, R), !.
majColonne(L, _, _, L).

%%% JouerCoup(Grille, ColonneJoue, Joueur, NouvGrille)
% Permet de placer le pion du joueur courant dans la grille actuelle et renvoie la nouvelle grille ainsi formée.
jouerCoup(Grille,ColonneJoue, Joueur, NouvGrille) :-
	nth1(ColonneJoue, Grille, OldColonne), %% OldColonne = Grille[ColonneJoue]
	ajouterCase(Joueur, OldColonne, NouvColonne),
	IndiceCol is ColonneJoue-1,
	majColonne(Grille, IndiceCol, NouvColonne, NouvGrille). %%utils.pl

% Détermine si une colonne est bien remplie.
% Dans notre situation, cela signifie que la colonne contient 8 termes
colonneRemplie(Colonne):-
	proper_length(Colonne,6).

colonneRemplie(Grille,Colonne) :-
	nth1(Colonne,Grille,NCol),
	colonneRemplie(NCol).