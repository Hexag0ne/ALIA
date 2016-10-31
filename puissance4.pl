%%%%% fichier puissance4.pl
% Ce fichier contient les mécanismes d'affichage du tableau de jeu, passage au tour suivant, et fin de jeu.

%%% Export du module puissance4 et de ses prédicats
:-module( puissance4, [joueurSuivant/2, afficherGrille/1, gameOver/3]).

:-use_module('util.pl').

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
afficherCol(_,_,0).
afficherCol(Grille,X,Y) :-
	afficherLigne(Grille,X,Y),
	nl,
	Ya is Y - 1 ,
	afficherCol(Grille,X,Ya), !.

%%% AfficherGrille
% Fonction qui permet l'affichage du plateau de jeu
afficherGrille(Grille) :- X is 1, Y is 6, afficherCol(Grille,X,Y).


%%% GameOver(Grille, Colonne, Winner)
% Cette règle doit être vraie si un joueur gagne ou si le jeu se termine en égalité.
% La règle est appelée entre deux play successifs par le main ou par l'IA qui veut prévoir ses coups.
% La grille est la grille de jeu (sept listes de sept éléments)
% La colonne est la colonne dans laquelle le dernier pion a été placé
% Winner prends la valeur du joueur qui gagne la partie ou 'draw' s'il y a égalité.

%Cas Diagonale droite montante 1ère position
gameOver(Grille,ColonneJouee,Winner):-
    nth1(ColonneJouee, Grille,Colonne),
	proper_length(Colonne, Y), A is ColonneJouee+1, B is ColonneJouee+2, C is ColonneJouee+3, D is Y+1, E is Y+2, F is Y+3,
	valeurGrille(Grille,ColonneJouee,Y,Winner),
	valeurGrille(Grille,A,D,Winner),
	valeurGrille(Grille,B,E,Winner),
	valeurGrille(Grille,C,F,Winner),!.
%Cas Diagonale droite montante 2ème position
gameOver(Grille,ColonneJouee,Winner):-
	nth1(ColonneJouee, Grille,Colonne),
	proper_length(Colonne, Y), A is ColonneJouee-1, B is ColonneJouee+1, C is ColonneJouee+2, D is Y-1, E is Y+1, F is Y+2,
	valeurGrille(Grille,A,D,Winner),
	valeurGrille(Grille,B,E,Winner),
	valeurGrille(Grille,C,F,Winner),!.
%Cas Diagonale droite montante 3ème position
gameOver(Grille,ColonneJouee,Winner):-
	nth1(ColonneJouee, Grille,Colonne),
	proper_length(Colonne, Y), A is ColonneJouee-1, B is ColonneJouee-2, C is ColonneJouee+1, D is Y-1, E is Y-2, F is Y+1,
	valeurGrille(Grille,A,D,Winner),
	valeurGrille(Grille,B,E,Winner),
	valeurGrille(Grille,C,F,Winner),!.
%Cas diagonale droite montante 4ème position
gameOver(Grille,ColonneJouee,Winner):-
	nth1(ColonneJouee, Grille,Colonne),
	proper_length(Colonne, Y), A is ColonneJouee-1, B is ColonneJouee-2, C is ColonneJouee-3, D is Y-1, E is Y-2, F is Y-3,
	valeurGrille(Grille,A,D,Winner),
	valeurGrille(Grille,B,E,Winner),
	valeurGrille(Grille,C,F,Winner),!.

%Cas diagonale gauche montante 1ère position
gameOver(Grille,ColonneJouee,Winner):-
	nth1(ColonneJouee, Grille,Colonne),
	proper_length(Colonne, Y), A is ColonneJouee-1, B is ColonneJouee-2, C is ColonneJouee-3, D is Y+1, E is Y+2, F is Y+3,
	valeurGrille(Grille,A,D,Winner),
	valeurGrille(Grille,B,E,Winner),
	valeurGrille(Grille,C,F,Winner),!.
%Cas diagonale gauche montante 2ème position
gameOver(Grille,ColonneJouee,Winner):-
	nth1(ColonneJouee, Grille,Colonne),
	proper_length(Colonne, Y), A is ColonneJouee-1, B is ColonneJouee-2, C is ColonneJouee+1, D is Y+1, E is Y+2, F is Y-1,
	valeurGrille(Grille,A,D,Winner),
	valeurGrille(Grille,B,E,Winner),
	valeurGrille(Grille,C,F,Winner),!.
%Cas diagonale gauche montante 3ème position
gameOver(Grille,ColonneJouee,Winner):-
	nth1(ColonneJouee, Grille,Colonne),
	proper_length(Colonne, Y), A is ColonneJouee-1, B is ColonneJouee+1, C is ColonneJouee+2, D is Y+1, E is Y-1, F is Y-2,
	valeurGrille(Grille,A,D,Winner),
	valeurGrille(Grille,B,E,Winner),
	valeurGrille(Grille,C,F,Winner),!.
%Cas diagonale gauche montante 4ème position
gameOver(Grille,ColonneJouee,Winner):-
	nth1(ColonneJouee, Grille,Colonne),
	proper_length(Colonne, Y), A is ColonneJouee-1, B is ColonneJouee-2, C is ColonneJouee-3, D is Y+1, E is Y+2, F is Y+3,
	valeurGrille(Grille,A,D,Winner),
	valeurGrille(Grille,B,E,Winner),
	valeurGrille(Grille,C,F,Winner),!.

%Cas horizontal 3 à gauche
gameOver(Grille,ColonneJouee,Winner):-
	nth1(ColonneJouee, Grille,Colonne),
	proper_length(Colonne, Y), A is ColonneJouee-1, B is ColonneJouee-2, C is ColonneJouee-3, D is Y, E is Y, F is Y,
	valeurGrille(Grille,A,D,Winner),
	valeurGrille(Grille,B,E,Winner),
	valeurGrille(Grille,C,F,Winner),!.
%Cas horizontal 2 à gauche
gameOver(Grille,ColonneJouee,Winner):-
	nth1(ColonneJouee, Grille,Colonne),
	proper_length(Colonne, Y), A is ColonneJouee+1, B is ColonneJouee-1, C is ColonneJouee-2, D is Y, E is Y, F is Y,
	valeurGrille(Grille,A,D,Winner),
	valeurGrille(Grille,B,E,Winner),
	valeurGrille(Grille,C,F,Winner),!.
%Cas horizontal 2 à droite
gameOver(Grille,ColonneJouee,Winner):-
	nth1(ColonneJouee, Grille,Colonne),
	proper_length(Colonne, Y), A is ColonneJouee-1, B is ColonneJouee+1, C is ColonneJouee+2, D is Y, E is Y, F is Y,
	valeurGrille(Grille,A,D,Winner),
	valeurGrille(Grille,B,E,Winner),
	valeurGrille(Grille,C,F,Winner),!.
%Cas horizontal 3 à droite
gameOver(Grille,ColonneJouee,Winner):-
	nth1(ColonneJouee, Grille,Colonne),
	proper_length(Colonne, Y), A is ColonneJouee+1, B is ColonneJouee+2, C is ColonneJouee+3, D is Y, E is Y, F is Y,
	valeurGrille(Grille,A,D,Winner),
	valeurGrille(Grille,B,E,Winner),
	valeurGrille(Grille,C,F,Winner),!.
%Cas vertical
gameOver(Grille,ColonneJouee,Winner):-
	nth1(ColonneJouee,Grille,Colonne),
	proper_length(Colonne, Y), A is ColonneJouee, B is ColonneJouee, C is ColonneJouee, D is Y-1, E is Y-2, F is Y-3,
	valeurGrille(Grille,A,D,Winner),
	valeurGrille(Grille,B,E,Winner),
	valeurGrille(Grille,C,F,Winner),!.
%Cas d'égalité quand la grille est remplie
gameOver(Grille,_,'Égalité'):-grilleRemplie(Grille).
%%%% fin GameOver %%%%

%%%% grilleRemplie
% Cette règle devient vraie si la grille est entièrement remplie et qu'aucun coup supplémentaire ne peut y être joué.
grilleRemplie(Grille):-
	nth0(1,Grille,Col1),colonneRemplie(Col1),
	nth0(2,Grille,Col2),colonneRemplie(Col2),
	nth0(3,Grille,Col3),colonneRemplie(Col3),
	nth0(4,Grille,Col4),colonneRemplie(Col4),
	nth0(5,Grille,Col5),colonneRemplie(Col5),
	nth0(6,Grille,Col6),colonneRemplie(Col6),
	nth0(7,Grille,Col7),colonneRemplie(Col7).
