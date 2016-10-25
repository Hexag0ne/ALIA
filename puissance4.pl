%%%%% fichier puissance4.pl
% Ce fichier contient les mécanismes d'affichage du tableau de jeu, passage au tour suivant, et fin de jeu.

%%% Export du module puissance4 et de ses prédicats
:-module( puissance4, [joueurSuivant/2, afficherGrille/1, gameOver/3]).

%%% JoueurSuivant(joueur, joueurSuivant)
%Si le joueur courant est l'humain, le suivant est la machine et inversement !
joueurSuivant('x','o').
joueurSuivant('o','x').

%%% AfficherElem
%Predicat qui permet de dessiner un élément
afficherElem(H) :- H = 'o', write('o'),  write(' | ').
afficherElem(H) :- H = 'x', write('x'),  write(' | ').
afficherElem(H) :- H \= 'x', H \= 'o', write(' '),  write(' | ').

%%% AfficherLigne
%Predicat qui permet le dessin d'une ligne
afficherLigne(_,8,_).
afficherLigne(Grille,X,Y) :-
	nth1(X,Grille,Column),
	nth1(Y,Column,Elem),
	afficherElem(Elem),
	Xa is X+1,
	afficherLigne(Grille,Xa,Y), !. 
afficherLigne(Grille,X,Y) :-
	afficherElem('f'),
	Xa is X+1,
	afficherLigne(Grille,Xa,Y), !. 

%%% AfficherCol
%Predicat qui permet le dessin des colonnes
afficherCol(_,_,1).
afficherCol(Grille,X,Y) :-
	afficherLigne(Grille,X,Y),
	nl,
	Ya is Y - 1 ,
	afficherCol(Grille,X,Ya), !.

%%% AfficherGrille
% Fonction qui permet l'affichage du plateau de jeu
afficherGrille(Grille) :- X is 1, Y is 7, afficherCol(Grille,X,Y). 


%%% GameOver(Grille, Colonne, Winner)
% Cette règle doit être vraie si un joueur gagne ou si le jeu se termine en égalité.
% La règle est appelée entre deux play successifs par le main ou par l'IA qui veut prévoir ses coups.
% La grille est la grille de jeu (sept listes de sept éléments)
% La colonne est la colonne dans laquelle le dernier pion a été placé
% Winner prends la valeur du joueur qui gagne la partie ou 'draw' s'il y a égalité.

%Cas Diagonale droite montante 1ère position 
gameOver(Grille,ColonneJouee, Winner):- proper_length(ColonneJouee, Y),
	valeurGrille(Grille,ColonneJouee,Y,Winner),
	valeurGrille(Grille,ColonneJouee+1,Y+1,Winner),
	valeurGrille(Grille,ColonneJouee+2,Y+2,Winner),
	valeurGrille(Grille,ColonneJouee+3,Y+3,Winner),!.
%Cas Diagonale droite montante 2ème position 
gameOver(Grille,ColonneJouee, Winner):-
	proper_length(ColonneJouee, Y),
	valeurGrille(Grille,ColonneJouee,Y,Winner),
	valeurGrille(Grille,ColonneJouee-1,Y-1,Winner),
	valeurGrille(Grille,ColonneJouee+1,Y+1,Winner),
	valeurGrille(Grille,ColonneJouee+2,Y+2,Winner),!.
%Cas Diagonale droite montante 3ème position
gameOver(Grille,ColonneJouee, Winner):-
	valeurGrille(Grille,ColonneJouee,Y,Winner),
	valeurGrille(Grille,ColonneJouee-1,Y-1,Winner),
	valeurGrille(Grille,ColonneJouee-2,Y-2,Winner),
	valeurGrille(Grille,ColonneJouee+1,Y+1,Winner),!.
%Cas diagonale droite montante 4ème position
gameOver(Grille,ColonneJouee, Winner):-
	valeurGrille(Grille,ColonneJouee,Y,Winner),
	valeurGrille(Grille,ColonneJouee-1,Y-1,Winner),
	valeurGrille(Grille,ColonneJouee-2,Y-2,Winner),
	valeurGrille(Grille,ColonneJouee-3,Y-3,Winner),!.

%Cas diagonale gauche montante 1ère position
gameOver(Grille,ColonneJouee, Winner):-
	valeurGrille(Grille,ColonneJouee,Y,Winner),
	valeurGrille(Grille,ColonneJouee-1,Y+1,Winner),
	valeurGrille(Grille,ColonneJouee-2,Y+2,Winner),
	valeurGrille(Grille,ColonneJouee-3,Y+3,Winner),!.
%Cas diagonale gauche montante 2ème position
gameOver(Grille,ColonneJouee, Winner):-
	valeurGrille(Grille,ColonneJouee,Y,Winner),
	valeurGrille(Grille,ColonneJouee-1,Y+1,Winner),
	valeurGrille(Grille,ColonneJouee-2,Y+2,Winner),
	valeurGrille(Grille,ColonneJouee+1,Y-1,Winner),!.
%Cas diagonale gauche montante 3ème position
gameOver(Grille,ColonneJouee, Winner):-
	valeurGrille(Grille,ColonneJouee,Y,Winner),
	valeurGrille(Grille,ColonneJouee-1,Y+1,Winner),
	valeurGrille(Grille,ColonneJouee+1,Y-1,Winner),
	valeurGrille(Grille,ColonneJouee+2,Y-2,Winner),!.
%Cas diagonale gauche montante 4ème position
gameOver(Grille,ColonneJouee, Winner):-
	valeurGrille(Grille,ColonneJouee,Y,Winner),
	valeurGrille(Grille,ColonneJouee-1,Y+1,Winner),
	valeurGrille(Grille,ColonneJouee-2,Y+2,Winner),
	valeurGrille(Grille,ColonneJouee-3,Y+3,Winner),!.

%Cas horizontal 3 à gauche
gameOver(Grille,ColonneJouee, Winner):-
	valeurGrille(Grille,ColonneJouee,Y,Winner),
	valeurGrille(Grille,ColonneJouee-1,Y,Winner),
	valeurGrille(Grille,ColonneJouee-2,Y,Winner),
	valuerGrille(Grille,ColonneJouee-3,Y,Winner),!.
%Cas horizontal 2 à gauche
gameOver(Grille,ColonneJouee, Winner):-
	valeurGrille(Grille,ColonneJouee,Y,Winner),
	valeurGrille(Grille,ColonneJouee+1,Y,Winner),
	valeurGrille(Grille,ColonneJouee-1,Y,Winner),
	valeurGrille(Grille,ColonneJouee-2,Y,Winner),!.
%Cas horizontal 2 à droite
gameOver(Grille,ColonneJouee, Winner):-
	valeurGrille(Grille,ColonneJouee,Y,Winner),
	valeurGrille(Grille,ColonneJouee-1,Y,Winner),
	valeurGrille(Grille,ColonneJouee+1,Y,Winner),
	valeurGrille(Grille,ColonneJouee+2,Y,Winner),!.
%Cas horizontal 3 à droite
gameOver(Grille,ColonneJouee, Winner):-
	valeurGrille(Grille,ColonneJouee,Y,Winner),
	valeurGrille(Grille,ColonneJouee+1,Y,Winner),
	valeurGrille(Grille,ColonneJouee+2,Y,Winner),
	valuerGrille(Grille,ColonneJouee+3,Y,Winner),!.
%Cas vertical
gameOver(Grille,ColonneJouee, Winner):-
	valeurGrille(Grille,ColonneJouee,Y,Winner),
	valeurGrille(Grille,ColonneJouee,Y-1,Winner),
	valeurGrille(Grille,ColonneJouee,Y-2,Winner),
	valeurGrille(Grille,ColonneJouee,Y-3,Winner),!.
%Cas d'égalité
%TODO décommenter l'égalité quand la détection de la grille remplie sera faite.
%gameOver(Grille, _, 'Draw'):- grilleEstRemplie(Grille).
%%%% fin GameOver %%%%

%%%% grilleEstRemplie
% Cette règle devient vraie si la grille est entièrement remplie et qu'aucun coup supplémentaire ne peut y être joué.
%grilleEstRemplie([H|T]|):- nth0(6,H,Y),nonvar(Y),isfull(T).
%TODO