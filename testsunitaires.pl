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
testGameOver :-
	not(gameOver([['n'],['n','x'],['n'],['n'],['n'],['n'],['n'],['n'],['n']],1,'x')), %Pas de victoire, il n'y a qu'un seul pion
	gameOver([['n'],['n','x','x','x','x'],['n'],['n'],['n'],['n'],['n'],['n'],['n']],1,'x'), %Cas vertical
	gameOver([['n'],['n','x'],['n','x'],['n','x'],['n','x'],['n'],['n'],['n'],['n']],1,'x'), %Cas horizontal vers la droite
	gameOver([['n'],['n','x'],['n','x'],['n','x'],['n','x'],['n'],['n'],['n'],['n']],2,'x'), %Cas horizontal vers la droite 2
	gameOver([['n'],['n','x'],['n','x'],['n','x'],['n','x'],['n'],['n'],['n'],['n']],4,'x'), %Cas horizontal vers la gauche
	gameOver([['n'],['n','x'],['n','x'],['n','x'],['n','x'],['n'],['n'],['n'],['n']],3,'x'), %Cas horizontal vers la gauche 2
	gameOver([['n'],['n','x'],['n',_,'x'],['n',_,_,'x'],['n',_,_,_,'x'],['n'],['n'],['n'],['n']],1,'x'), %Cas diagonale montante vers la droite
	gameOver([['n'],['n','x'],['n',_,'x'],['n',_,_,'x'],['n',_,_,_,'x'],['n'],['n'],['n'],['n']],2,'x'), %Cas diagonale montante vers la droite 2
	gameOver([['n'],['n','x'],['n',_,'x'],['n',_,_,'x'],['n',_,_,_,'x'],['n'],['n'],['n'],['n']],3,'x'), %Cas diagonale montante vers la droite 3
	gameOver([['n'],['n','x'],['n',_,'x'],['n',_,_,'x'],['n',_,_,_,'x'],['n'],['n'],['n'],['n']],4,'x'), %Cas diagonale montante vers la droite 4
	gameOver([['n'],['n',_,_,_,'x'],['n',_,_,'x'],['n',_,'x'],['n','x'],['n'],['n'],['n'],['n']],1,'x'), %Cas diagonale montante vers la gauche
	gameOver([['n'],['n',_,_,_,'x'],['n',_,_,'x'],['n',_,'x'],['n','x'],['n'],['n'],['n'],['n']],2,'x'), %Cas diagonale montante vers la gauche 2
	gameOver([['n'],['n',_,_,_,'x'],['n',_,_,'x'],['n',_,'x'],['n','x'],['n'],['n'],['n'],['n']],3,'x'), %Cas diagonale montante vers la gauche 3
	gameOver([['n'],['n',_,_,_,'x'],['n',_,_,'x'],['n',_,'x'],['n','x'],['n'],['n'],['n'],['n']],4,'x'). %Cas diagonale montante vers la gauche 4
