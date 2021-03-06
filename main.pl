%%%%% fichier main.pl
% Ce fichier contient l'algorithme principal du jeu qui consiste à faire jouer successivement les différents joueurs jusqu'à ce qu'un gagnant émerge.

%%%% Imports des autres modules
:-use_module('play.pl').
:-use_module('puissance4.pl').
:-use_module('util.pl').

%%%Modélisation du plateau de jeu :.
% La grille du jeu est modélisée par une liste de neuf listes, de 7 éléments chacune.
% La surface "jouable" de la grille étant les 6 derniers élements des 7 listes du milieu, 
% 	le reste des élements a été rajoutée pour des soucis de modélisation.
%	Note: 'x' -> Joueur1, 'o' -> Joueur2, 'f' -> Case fictive
% L'indice de la première liste correspond à la n-ième colonne en partant de la gauche.
% L'indice des listes des colonnes correspond à la n-ième case en partant du bas.

% Le jeu est 'global' et peut être modifié par assert et retract (ajoute une affirmation / vérité / prédicat ou supprime une affirmation / vérité / prédicat) de la base de connaissance de l'état du jeu.
:- dynamic jeu/1.

%%%%% tourSuivant est une fonction récursive qui fait jouer alternativement les deux joueurs aux Puisance 4 jusqu'à ce que le jeu se termine.
% Cette première règle est déclenchée si GameOver renvoie vrai et interrompt l'autre règle récursive qui fait dérouler le jeu ( clause !).
tourSuivant(Joueur,Colonne) :-
	joueurSuivant(Winner,Joueur),
	jeu(Grille),
	Colonne > 0, 
	gameOver(Grille,Colonne,Winner),!,
	afficherGrille(Grille),
	write('Game over ! Le gagnant est: ' ),
	writeln(Winner), nl,
	retract(jeu(Grille)).

% Règle générale récursive qui fait jouer les joueurs chacun leur tour
tourSuivant(Joueur,_) :-
	jeu(Grille), %% grille = getGrille()
	afficherGrille(Grille), %puissance4.pl
	write('Nouveau tour pour: '), writeln(Joueur),
	joue(Joueur, Grille, ColonneJoue), %play.pl
	jouerCoup(Grille,ColonneJoue, Joueur, NouvGrille),
	sauverCoup(Grille,NouvGrille),
	joueurSuivant(Joueur, NextJoueur), %puissance4.pl
	tourSuivant(NextJoueur,ColonneJoue).

%%% init permet de lancer le jeu. Cette règle permet d'initialiser le plateau de jeu et les joueurs. 
init :- assert(jeu([[],[],[],[],[],[],[]])), tourSuivant('x',0).

ia :- assert(jeu([[],[],[],[],[],[],[]])), tourSuivant('a',0).

alea :- assert(jeu([[],[],[],[],[],[],[]])), tourSuivant('R',0).

vsiaa :- assert(jeu([[],[],[],[],[],[],[]])), tourSuivant('P',0).
vsiar :- assert(jeu([[],[],[],[],[],[],[]])), tourSuivant('K',0).

%%% SauverCoup(Grille, NouvGrille)
% Met à jour la grille de jeu dans la base de faits
sauverCoup(Grille, NouvGrille):-
	retract(jeu(Grille)), assert(jeu(NouvGrille)), !.

