%%%%% fichier main.pl
% Ce fichier contient l'algorithme principal du jeu qui consiste à faire jouer successivement les différents joueurs jusqu'à ce qu'un gagnant émerge.



%%%% Imports des autres modules
:-use_module('play.pl').
:-use_module('puissance4.pl').

%%%Modélisation du plateau de jeu :
% Nous utilisons une liste de sept listes. Ces sept listes représentent une colonne de la grille et contient 7 éléments.
% L'indice de la première liste correspond à la n-ième colonne en partant de la gauche.
% L'indice des listes des colonnes correspond à la n-ième case en partant du bas.

% Le jeu est 'global' et peut être modifié par assert et retract (ajoute une affirmation / vérité / prédicat ou supprime une affirmation / vérité / prédicat) de la base de connaissance de l'état du jeu.
:- dynamic jeu/1.



%%%%% play est une fonction récursive qui fait jouer alternativement les deux joueurs aux Puisance 4 jusqu'à ce que le jeu se termine.
% Cette première règle est déclenchée si GameOver renvoie vrai et  interrompt l'autre règle récursive qui fait dérouler le jeu ( clause !).
play(_):-gameOver(Grille, Colonne,Winner), !, writeln('Game over ! Winner is :' ), writeln(Winner), displayBoard(Grille).

% Règle générale récursive
play(Player):- write('New turn for: '), writeln(Player),
			jeu(Grille),
			displayBoard(Grille),
			joue(Player, Grille, ColonneJoue), 
			playMove(Grille, ColonneJoue, Player, NouvelleGrille), %On récupère le nouvel état de la grille.
			applyIt(Grille, NouvelleGrille), %Remplace la grille du jeu dans la base de fait 'jeu'
			nextPLayer(Player, NextPlayer),
			play(NextPlayer).
			
%%%%% init permet de lancer le jeu. Cette règle permet d'initialiser le plateau de jeu et les joueurs. 
init :- length(Board,9), assert(board(Board)), play('x').

%%% PlayMove(Grille, ColonneJoue, Player, NouvelleGrille)
% Permet de placer le pion du joueur courant dans la grille actuelle et renvoie la nouvelle grille ainsi formée.
% C'est cette fonction qui détermine quel caractère utiliser en fonction du joueur qui est passé en paramètre (humain X, machine O) !
playMove(Grille, ColonneJoue, Player, NouvelleGrille) :- NouvelleGrille = Grille.

%%% applyIt(Grille, NouvelleGrille)
% Met à jour la grille de jeu dans la base de faits
applyIt(Grille, NouvelleGrille):-retract(jeu(Grille)),assert(jeu(NouvelleGrille)).