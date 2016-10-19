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




gameOver(_, _, Winner):- Winner = 'Caramba', !.
gameOver(Grille, _, 'Draw'):- isfull(Grille).

isfull([H|T]|) :- nth0(7,H,Y),nonvar(Y), isfull(T).

%%%nextPlayer(Player, Nextplayer)
%Si le joueur courant est l'humain, le suivant est la machine et inversement !
nextPlayer('H', 'M').
nextPlayer('M','H').
