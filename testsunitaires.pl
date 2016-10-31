% Fichier contenant les tests unitaires fait sur nos différents morceaux de codes

:- use_module(puissance4).
:- use_module(util).

%Lance touts les tests.
%Si le test passe, affiche OK ; KO dans le cas contraire.
tests :-
	write('joueurSuivant:'),(testJoueurSuivant -> write('OK') ; write('KO')),nl,
	write('ajouterCase  :'),(testAjouterCase -> write('OK') ; write('KO')),nl,
	write('valeurGrille :'),(testValeurGrille -> write('OK') ; write('KO')),nl,
	write('gameOver     :'),(testGameOver -> write('OK') ; write('KO')),nl.
				
%%%% Tests du module Util
%Test de ajouterCase/3
testAjouterCase :-
	ajouterCase('x',[],['x']),
	not(ajouterCase('o',[],['x'])),
	ajouterCase('x',['o','x'],['o','x','x']).

%Test de valeurGrille/4
testValeurGrille :-
	valeurGrille([['x'],[],[],[],[],[],[]],1,1,'x'),
	not(valeurGrille([['x'],[],[],[],[],[],[]],5,1,'x')).

%%%% Tests du module puissance4
%Test de joueurSuivant/2
testJoueurSuivant :-
	joueurSuivant('x','o'),
	joueurSuivant('o','x'),
	not(joueurSuivant('x','x')),
	not(joueurSuivant('o','o')).

%Test de gameOver
testGameOver :-
	gameOver([[_,_,_,_,_,_,_,_],[_,_,_,_,_,_,_,_],[_,_,_,_,_,_,_,_],[_,_,_,_,_,_,_,_],[_,_,_,_,_,_,_,_],[_,_,_,_,_,_,_,_],[_,_,_,_,_,_,_,_],[_,_,_,_,_,_,_,_]],1,'Égalité'), % Cas d'égalité
	gameOver([['x','x','x','x'],[],[],[],[],[],[]],1,'x'), %Victoire verticale
	gameOver([[_,_,_,'x'],[_,_,'x'],[_,'x'],['x'],[],[],[]],1,'x'),	%Victoire diagonale vers le bas à droite
	gameOver([[_,_,_,'x'],[_,_,'x'],[_,'x'],['x'],[],[],[]],2,'x'),	%Victoire diagonale vers le bas à droite 2
	gameOver([[_,_,_,'x'],[_,_,'x'],[_,'x'],['x'],[],[],[]],3,'x'),	%Victoire diagonale vers le haut à gauche 3
	gameOver([[_,_,_,'x'],[_,_,'x'],[_,'x'],['x'],[],[],[]],4,'x'),	%Victoire diagonale vers le haut à gauche 4
	gameOver([['x'],['x'],['x'],['x'],[],[],[]],1,'x'), %Victoire horizontale
	gameOver([['x'],['x'],['x'],['x'],[],[],[]],2,'x'), %Victoire horizontale
	gameOver([['x'],['x'],['x'],['x'],[],[],[]],3,'x'), %Victoire horizontale
	gameOver([['x'],['x'],['x'],['x'],[],[],[]],4,'x'), %Victoire horizontale
	gameOver([['x'],[_,'x'],[_,_,'x'],[_,_,_,'x'],[],[],[]],1,'x'), %Victoire deuxième diagonale
	gameOver([['x'],[_,'x'],[_,_,'x'],[_,_,_,'x'],[],[],[]],2,'x'), %Victoire deuxième diagonale
	gameOver([['x'],[_,'x'],[_,_,'x'],[_,_,_,'x'],[],[],[]],3,'x'), %Victoire deuxième diagonale
	gameOver([['x'],[_,'x'],[_,_,'x'],[_,_,_,'x'],[],[],[]],4,'x'), %Victoire deuxième diagonale
	not(gameOver([['x','x','x','x'],[],[],[],[],[],[]],1,'o')),%Pas de victoire pour 'o' !
	not(gameOver([[],['x'],[],[],[],[],[]],2,'x')). %Pas de victoire, il n'y a qu'un seul pion

