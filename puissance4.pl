:-module( puissance4, [nextPlayer/2, displayBoard/1, gameOver/3]).

%Predicat qui permet de dessiner un élément
displayElem(H) :- H = a, write('o'),  write(' | ').
displayElem(H) :- H = b, write('x'),  write(' | ').
displayElem(H) :- H \= a, H \= b, write(' '),  write(' | ').

%Predicat qui permet de dessiner une ligne
displayLine(_,8,_).
displayLine(Grille,X,Y) :-  nth1(X,Grille,Column), nth1(Y,Column,Elem), displayElem(Elem), Xa is X+1, displayLine(Grille,Xa,Y), !. 
displayLine(Grille,X,Y) :-  displayElem(c) , Xa is X+1, displayLine(Grille,Xa,Y), !. 

%Predicat qui permet de dessiner toutes les colonnes. Il dessine les lignes une par une et redessine par recursion
displayCol(_,_,0).
displayCol(Grille,X,Y) :- displayLine(Grille,X,Y), nl, Ya is Y - 1 , displayCol(Grille,X,Ya), !.

%%% DisplayBoard
% Fonction permettant d'afficher la grille de jeu
displayBoard(Grille) :- X is 1, Y is 6, displayCol(Grille,X,Y).

%%% GameOver(Grille, Colonne, Winner)
% Cette règle doit être vraie si un joueur gagne ou si le jeu se termine en égalité.
% La règle est appelée entre deux play successifs par le main ou par l'IA qui veut prévoir ses coups.
% La grille est la grille de jeu (sept listes de sept éléments)
% La colonne est la colonne dans laquelle le dernier pion a été placé
% Winner prends la valeur du joueur qui gagne la partie ou 'draw' s'il y a égalité.
gameOver(_, X, Winner):- Winner = 'Caramba', !.

%%%nextPlayer(Player, Nextplayer)
%Si le joueur courant est l'humain, le suivant est la machine et inversement !
nextPlayer('x', 'o').
nextPlayer('o', 'x').
