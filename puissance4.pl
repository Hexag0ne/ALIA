:-module( puissance4, [joueurSuivant/2, displayBoard/1, gameOver/3]).

%Predicat qui permet de dessiner un élément
displayElem(H) :- H = a, write('o'),  write(' | ').
displayElem(H) :- H = b, write('x'),  write(' | ').
displayElem(H) :- H \= a, H \= b, write(' '),  write(' | ').
-
%Predicat qui permet de dessiner une ligne
displayLine(_,8,_).
displayLine(Grille,X,Y) :-
	nth1(X,Grille,Column),
	nth1(Y,Column,Elem),
	displayElem(Elem),
	Xa is X+1,
	displayLine(Grille,Xa,Y), !. 
displayLine(Grille,X,Y) :-
	displayElem(c) ,
	Xa is X+1,
	displayLine(Grille,Xa,Y), !. 

%Predicat qui permet de dessiner toutes les colonnes.
%Il dessine les lignes une par une et redessine par recursion
displayCol(_,_,0).
displayCol(Grille,X,Y) :-
	displayLine(Grille,X,Y),
	nl,
	Ya is Y - 1 ,
	displayCol(Grille,X,Ya), !.

%%% DisplayBoard
% Fonction permettant d'afficher la grille de jeu
displayBoard(Grille) :- X is 1, Y is 7, displayCol(Grille,X,Y). 


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

%%% JoueurSuivant(joueur, joueurSuivant)
%Si le joueur courant est l'humain, le suivant est la machine et inversement !
joueurSuivant('H','M').
joueurSuivant('M','H').

