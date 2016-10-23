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
%play(_) :- gameOver(Grille, Colonne, Winner), !, write('Game over ! Winner is: ' ), writeln(Winner), nl, displayBoard(Grille).
%play(_) :- displayBoard(Grille).

% Règle générale récursive
play(Player) :-
	write('New turn for: '), writeln(Player),
	writeln('##jeu(Grille)##'), jeu(Grille),
	writeln('##displayBoard(Grille)##'), displayBoard(Grille),
	writeln('##joue##'), joue(Player, Grille, ColonneJoue),
	writeln('##playMove##'), playMove(Grille, ColonneJoue, Player, NewGrille), %On récupère le nouvel état de la grille.
	writeln('##applyIt##'), applyIt(Grille, NewGrille), %Remplace la grille du jeu dans la base de fait 'jeu'
	writeln('##nextPlayer(Player, NextPlayer)##'), joueurSuivant(Player, NextPlayer),
	writeln('##play(NextPlayer)##'), play(NextPlayer).
			
%%%%% init permet de lancer le jeu. Cette règle permet d'initialiser le plateau de jeu et les joueurs. 
init :- length(Grille,9), assert(jeu(Grille)), play('x').

%%% PlayMove(Grille, ColonneJoue, Player, NouvelleGrille)
% Permet de placer le pion du joueur courant dans la grille actuelle et renvoie la nouvelle grille ainsi formée.
% C'est cette fonction qui détermine quel caractère utiliser en fonction du joueur qui est passé en paramètre (humain X, machine O) !
playMove(Grille, ColonneJoue, Player, NewGrille) :-
	majGrille(Player, ColonneJoue, NewGrille).

majGrille(Player, ColonneJoue, NewGrille) :-
	jeu(Grille),
	nth1(ColonneJoue, Grille, OldColonne),
	ajouterCase(Player, OldColonne, NewColonne),
	IndiceCol is ColonneJoue-1,
	majColonne(X, IndiceCol, NewColonne, NewGrille).

%%% ajouterCase
%TODO

%%% majColonne
%TODO

%%% applyIt(Grille, NewGrille)
% Met à jour la grille de jeu dans la base de faits
applyIt(Grille, NewGrille):- retract(jeu(Grille)), assert(jeu(NewGrille)).