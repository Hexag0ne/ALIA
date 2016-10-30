% Fichier contenant les tests unitaires fait sur nos différents morceaux de codes

:- use_module(puissance4).
:- use_module(util).

%Lance touts les tests.
%Si le test passe, affiche OK ; KO dans le cas contraire.
tests :-
	write('joueurSuivant:'),(testJoueurSuivant -> write('OK') ; write('KO')),nl,
	write('ajouterCase  :'),(testAjouterCase -> write('OK') ; write('KO')),nl,
	write('valeurGrille :'),(testValeurGrille -> write('OK') ; write('KO')),nl.
				
%%%% Tests du module Util
%Test de ajouterCase/3
testAjouterCase :-
	ajouterCase('x',[],['x']),
	not(ajouterCase('o',[],['x'])),
	ajouterCase('x',['o','x'],['o','x','x']).

%Test de valeurGrille/4
testValeurGrille :-
	valeurGrille([['n'],['n','x'],['n'],['n'],['n'],['n'],['n'],['n'],['n']],1,1,'x'),
	not(valeurGrille([['n'],['n','x'],['n'],['n'],['n'],['n'],['n'],['n'],['n']],5,1,'x')).

%%%% Tests du module puissance4
%Test de joueurSuivant/2
testJoueurSuivant :-
	joueurSuivant('x','o'),
	joueurSuivant('o','x'),
	not(joueurSuivant('x','x')),
	not(joueurSuivant('o','o')).

%Test de gameOver
%TODO
