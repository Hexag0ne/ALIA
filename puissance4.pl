:-module( puissance4, [nextPlayer/2, displayBoard/1, gameOver/3]).

%%% DisplayBoard
% Fonction permettant d'afficher la grille de jeu contenue dans
displayBoard(Grille):-writeln('-------').


%%% GameOver(Grille, Colonne, Winner)
% Cette règle doit être vraie si un joueur gagne ou si le jeu se termine en égalité.
% La règle est appelée entre deux play successifs par le main ou par l'IA qui veut prévoir ses coups.
% La grille est la grille de jeu (sept listes de sept éléments)
% La colonne est la colonne dans laquelle le dernier pion a été placé
% Winner prends la valeur du joueur qui gagne la partie ou 'draw' s'il y a égalité.

:-use_module

%Cas Diagonale droite montante 1ère position 
gameOver(Grille,ColonneJouee, Winner):- proper_length(ColonneJouee, Y), valeurGrille(Grile,ColonneJouee,Y,Winner), valeurGrille(Grile,ColonneJouee+1,Y+1,Winner), valeurGrille(Grile,ColonneJouee+2,Y+2,Winner), valeurGrille(Grile,ColonneJouee+3,Y+3,Winner),!.
%Cas Diagonale droite montante 2ème position 
gameOver(Grille,ColonneJouee, Winner):- proper_length(ColonneJouee, Y), valeurGrille(Grile,ColonneJouee,Y,Winner), valeurGrille(Grile,ColonneJouee-1,Y-1,Winner), valeurGrille(Grile,ColonneJouee+1,Y+1,Winner), valeurGrille(Grile,ColonneJouee+2,Y+2,Winner),!.

gameOver(Grille,ColonneJouee, Winner):- combinaison3(Grille,ColonneJouee, Winner).
gameOver(Grille,ColonneJouee, Winner):- combinaison4(Grille,ColonneJouee, Winner).
gameOver(Grille,ColonneJouee, Winner):- combinaison5(Grille,ColonneJouee, Winner).
gameOver(Grille,ColonneJouee, Winner):- combinaison6(Grille,ColonneJouee, Winner).
gameOver(Grille,ColonneJouee, Winner):- combinaison7(Grille,ColonneJouee, Winner).
gameOver(Grille,ColonneJouee, Winner):- combinaison8(Grille,ColonneJouee, Winner).
gameOver(Grille,ColonneJouee, Winner):- combinaison9(Grille,ColonneJouee, Winner).
gameOver(Grille,ColonneJouee, Winner):- combinaison10(Grille,ColonneJouee, Winner).
gameOver(Grille,ColonneJouee, Winner):- combinaison11(Grille,ColonneJouee, Winner).
gameOver(Grille,ColonneJouee, Winner):- combinaison12(Grille,ColonneJouee, Winner).
gameOver(Grille,ColonneJouee, Winner):- combinaison13(Grille,ColonneJouee, Winner).





gameOver(Grille, _, 'Draw'):- isfull(Grille).

isfull([H|T]|) :- nth0(6,H,Y),nonvar(Y), isfull(T).

%%%nextPlayer(Player, Nextplayer)
%Si le joueur courant est l'humain, le suivant est la machine et inversement !
nextPlayer('H', 'M').
nextPlayer('M','H').

