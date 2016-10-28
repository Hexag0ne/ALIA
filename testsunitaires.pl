% Fichier contenant les tests unitaires fait sur nos différents morceaux de codes

:- use_module(puissance4).

%Lance touts les tests.
%Si le test passe, affiche OK ; KO dans le cas contraire.
tests :- write('joueurSuivant : '),(testJoueurSuivant -> write('OK') ; write('KO')).

%Test des règles joueurSuivant
testJoueurSuivant :-
	joueurSuivant('x','o'),
	joueurSuivant('o','x'),
	not(joueurSuivant('x','x')),
	not(joueurSuivant('o','o')).

%Test de gameOver
%TODO