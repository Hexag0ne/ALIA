%%%%% fichier play.pl
% Ce fichier contient les règles d'intelligence artificielle permettant à la fois à la machine et au joueur 'humain' de décider de leurs coups.

%%% Export du module play et de ses prédicats
:-module('play', [joue/3]).

%Demande au joueur de choisir une colonne où placer son pion. Joue a deux règles, une quand joueur est l'humain ('x'), une quand joueur est machine ('o')
joue('x', _, ColonneJoue):-
    write('Choisissez une colonne [1-7]: '), read(ColonneJoue), integer(ColonneJoue), ColonneJoue < 8, ColonneJoue > 0.

joue('o', _, ColonneJoue):-
    write('Choisissez une colonne [1-7]: '), read(ColonneJoue), integer(ColonneJoue), ColonneJoue < 8, ColonneJoue > 0.