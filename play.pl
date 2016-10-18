%%%%% Fichier play.pl
% Ce fichier contient les règles d'intelligence artificielle permettant à la fois à la machine et au joueur 'humain' de décider de leurs coups.
:-module('play', [joue/3]).

%Demande au joueur de choisir une colonne où placer son pion. Joue a deux règles, une quand joueur est l'humain (player vaut 'H'), une quand joueur est machine (player vaut (M))
joue('H', _ , ColonneJoue):- get(ColonneJoue).

joue('M', Grille, ColonneJoue):- get(ColonneJoue). %TODO à modifier plus tard évidemment !