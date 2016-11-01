%%%%% fichier play.pl
% Ce fichier contient les règles d'intelligence artificielle permettant à la fois à la machine et au joueur 'humain' de décider de leurs coups.

%%% Export du module play et de ses prédicats
:-module('play', [joue/3,coupGagnant/3,coupPerdant/3]).

:-use_module('puissance4.pl').
:-use_module('util.pl').

%Demande au joueur de choisir une colonne où placer son pion. Joue a deux règles, une quand joueur est l'humain ('x'), une quand joueur est machine ('o')
joue('x', _, ColonneJoue):-
    write('Choisissez une colonne [1-7]: '), read(ColonneJoue), integer(ColonneJoue), ColonneJoue < 8, ColonneJoue > 0.

joue('o', _, ColonneJoue):-
    write('Choisissez une colonne [1-7]: '), read(ColonneJoue), integer(ColonneJoue), ColonneJoue < 8, ColonneJoue > 0.

				%Coups de l'IA 'opportuniste'
% Première règle : si l'IA peut gagner alors elle joue dans cette colonne
joue('a',Grille,ColonneJoue):-
	coupGagnant(Grille,ColonneJoue,'a'),!.
% Deuxième règle : si l'IA ne peut pas gagner alors elle choisie de jouer dans la colonne la plus au centre
joue('a',Grille,ColonneJoue):-
	not(colonneRemplie(Grille,4)),
	ColonneJoue is 4.
joue('a',Grille,ColonneJoue):-
	not(colonneRemplie(Grille,5)),
	ColonneJoue is 5.
joue('a',Grille,ColonneJoue):-
	not(colonneRemplie(Grille,3)),
	ColonneJoue is 3.
joue('a',Grille,ColonneJoue):-
	not(colonneRemplie(Grille,6)),
	ColonneJoue is 6.
joue('a',Grille,ColonneJoue):-
	not(colonneRemplie(Grille,2)),
	ColonneJoue is 2.
joue('a',Grille,ColonneJoue):-
	not(colonneRemplie(Grille,7)),
	ColonneJoue is 7.
joue('a',Grille,ColonneJoue):-
	not(colonneRemplie(Grille,1)),
	ColonneJoue is 1.

joue('O',_,ColonneJoue) :- joue('x',_,ColonneJoue).

%Renvoie vrai dans le cas où si le joueur place son pion dans la colonne ColonneJoue alors celui-ci remporte immédiatement la partie
coupGagnant(Grille,ColonneJoue,Joueur) :-
	jouerCoup(Grille,ColonneJoue,Joueur,Z),
	gameOver(Z,ColonneJoue,Joueur).

coupGagnant(Grille,Joueur):- coupGagnant(Grille,1,Joueur).
coupGagnant(Grille,Joueur):- coupGagnant(Grille,2,Joueur).
coupGagnant(Grille,Joueur):- coupGagnant(Grille,3,Joueur).
coupGagnant(Grille,Joueur):- coupGagnant(Grille,4,Joueur).
coupGagnant(Grille,Joueur):- coupGagnant(Grille,5,Joueur).
coupGagnant(Grille,Joueur):- coupGagnant(Grille,6,Joueur).
coupGagnant(Grille,Joueur):- coupGagnant(Grille,7,Joueur).


coupPerdant(Grille,ColonneJoue,Joueur) :-
	jouerCoup(Grille,ColonneJoue,Joueur,Z),
	joueurSuivant(Joueur,Suivant),
	coupGagnant(Z,Suivant).
