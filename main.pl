%%%%% fichier main.pl
% Ce fichier contient l'algorithme principal du jeu qui consiste à faire jouer successivement les différents joueurs jusqu'à ce qu'un gagnant émerge.

%%%% Imports des autres modules
:-use_module('play.pl').
:-use_module('puissance4.pl').
:-use_module('util.pl').

%%%Modélisation du plateau de jeu :
% Nous utilisons une liste de sept listes. Ces sept listes représentent une colonne de la grille et contient 7 éléments.
% L'indice de la première liste correspond à la n-ième colonne en partant de la gauche.
% L'indice des listes des colonnes correspond à la n-ième case en partant du bas.

% Le jeu est 'global' et peut être modifié par assert et retract (ajoute une affirmation / vérité / prédicat ou supprime une affirmation / vérité / prédicat) de la base de connaissance de l'état du jeu.
:- dynamic jeu/1.

%%%%% play est une fonction récursive qui fait jouer alternativement les deux joueurs aux Puisance 4 jusqu'à ce que le jeu se termine.
% Cette première règle est déclenchée si GameOver renvoie vrai et interrompt l'autre règle récursive qui fait dérouler le jeu ( clause !).
%play(_) :- gameOver(Grille, Colonne, Winner), !, write('Game over ! Winner is: ' ), writeln(Winner), nl, displayBoard(Grille).
%play(_) :- displayBoard(Grille).

% Règle générale récursive
tourSuivant(Player) :-
	write('New turn for: '), writeln(Player),
	writeln('##jeu(Grille)##'), jeu(Grille),
	writeln('##displayBoard(Grille)##'), afficherGrille(Grille),
	writeln('##joue##'), joue(Player, Grille, ColonneJoue),
	writeln('##jouerCoup##'), jouerCoup(Grille, ColonneJoue, Player, NouvGrille), %On récupère le nouvel état de la grille.
	writeln('##sauverCoup##'), sauverCoup(Grille, NouvGrille), %Remplace la grille du jeu dans la base de fait 'jeu'
	writeln('##joueurSuivant(Player, NextPlayer)##'), joueurSuivant(Player, NextPlayer),
	writeln('##tourSuivnat(NextPlayer)##'), tourSuivant(NextPlayer).
			
%%% init permet de lancer le jeu. Cette règle permet d'initialiser le plateau de jeu et les joueurs. 
init :- length(Grille,9), assert(jeu(Grille)), play('x').

%%% puissance4.AfficherGrille

%%% play.Joue

%%% JouerCoup(Grille, ColonneJoue, Player, NouvGrille)
% Permet de placer le pion du joueur courant dans la grille actuelle et renvoie la nouvelle grille ainsi formée.
% C'est cette fonction qui détermine quel caractère utiliser en fonction du joueur qui est passé en paramètre (humain X, machine O) !
jouerCoup(Grille, ColonneJoue, Player, NouvGrille) :-
	majGrille(Grille, ColonneJoue, Player, NouvGrille).

nthElem(N, L, []):- longueur(L, N1), N1 < N.
nthElem(N, L, X):- nth1(N, L, X).

majGrille(Grille, ColonneJoue, Player, NouvGrille) :-
    nthElem(ColonneJoue, Grille, OldColonne),
    ajouterCase(Player, OldColonne, NouvColonne),
    IndiceCol is ColonneJoue-1,
    majColonne(Grille, IndiceCol, NewColonne, NouvGrille).

%%% ajouterCase
%TODO

%%% majColonne
%TODO

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% SauverCoup(Grille, NouvGrille)
% Met à jour la grille de jeu dans la base de faits
sauverCoup(Grille, NouvGrille):-
	retract(jeu(Grille)), assert(jeu(NouvGrille)).

%%% puissance4.joueurSuivant

%%% tourSuivant (Indice: C'est une boucle !)

