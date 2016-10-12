

%%%Modélisation du plateau de jeu :
% Nous utilisons une liste de sept listes. Ces sept listes représentent une colonne de la grille et contient 7 éléments.
% L'indice de la première liste correspond à la n-ième colonne en partant de la gauche.
% L'indice des listes des colonnes correspond à la n-ième case en partant du bas.
% Le jeu est 'global' et peut être modifié par assert et retract (ajoute une affirmation / vérité / prédicat ou supprime une affirmation / vérité / prédicat) de la base de connaissance de l'état du jeu.
:- dynamic jeu/1.


%%% DisplayBoard
% Fonction permettant d'afficher la grille de jeu contenue dans
displayBoard:-writeln('-------').


%%% GameOver(Winner)
% Cette règle doit être vraie si un joueur gagne ou si le jeu se termine en égalité.
% La règle est appelée entre deux play

%%% Play(player)
% Cette règle récursive permet de demander alternativement à chaque joueur de formuler un coup

% Cette première règle est déclenchée si GameOver renvoie vrai et  interrompt l'autre règle récursive qui fait dérouler le jeu ( clause !).
play(_):-GameOver(Winner), !, writeln('Game over ! Winner is :' ), writeln(Winner), displayBoard.

play(Player):- write('New turn for: '), writeln(Player),
			jeu(Grille),
			displayBoard,
			joue(Player, Grille, ColonneJoue), %Demande au joueur de choisir une colonne où placer son pion. Joue aura deux règles, une quand joueur est l'humain (player vaut 'H'), une quand joueur est machine (player vaut (M))
			playMove(Grille, ColonneJoue, Player, NouvelleGrille), %On récupère le nouvel état de la grille.
			applyIt(Grille, NouvelleGrille), %Remplace la grille du jeu dans la base de fait 'jeu'
			nextPLayer(Player, NextPlayer),
			play(NextPlayer).


%%% Joue(Player, Grille, ColonneJoue)
% Cette règle permet pour un joueur et une Grille de jeu donnée de renvoyer une colonne où placer le pion du joueur
% Player doit être humain ('H') ou machine ('M').
% Il existe deux règles, une pour l'humain qui demande une entrée clavier et une pour la machine qui réfléchit très fort au problème (aléatoirement dans une V1).
Joue('H', _ , ColonneJoue):- //TODO

Joue('M', Grille, ColonneJoue):- //TODO

%%% PlayMove(Grille, ColonneJoue, Player, NouvelleGrille)
% Permet de placer le pion du joueur courant dans la grille actuelle et renvoie la nouvelle grille ainsi formée.
% C'est cette fonction qui détermine quel caractère utiliser en fonction du joueur qui est passé en paramètre (humain X, machine O) !

%%% applyIt(Grille, NouvelleGrille)
% Met à jour la grille de jeu dans la base de faits
applyIt(Grille, NouvelleGrille):-retract(jeu(Grille)),assert(jeu(NouvelleGrille)).


%%%nextPlayer(Player, Nextplayer)
%Si le joueur courant est l'humain, le suivant est la machine et inversement !
nextPlayer('H', 'M').
nextPlayer('M','H').
