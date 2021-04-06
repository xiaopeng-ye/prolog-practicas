:- module(_,_,[assertions,regtypes]).
alumno_prode('Ye','','Xiao Peng','A180321').

:- doc(title,"Sumas de pares de listas y cuadrados").
:- doc(author, "Xiao Peng Ye, A180321").
:- doc(usage, "use_module('codigo.pl')").

% predicados auxiliares

:- prop nat/1
   #"N@'{u}mero natural. @includedef{nat/1}".

nat(0).
nat(s(X)):-nat(X).

:- pred sum(A,B,C)
   #"@var{C} es el resultado de aplicar la suma de los valores @var{A} y @var{B} en formato Peano. @includedef{sum/3}".

sum(0,X,X):-nat(X).
sum(s(X),Y,s(Z)):-sum(X,Y,Z).

:- test sum(A,B,C) : (A = 0, B = s(0)) => (C = s(0)) + not_fails #"Caso base".
:- test sum(A,B,C) : (A = s(0), B = s(s(0))) => (C = s(s(s(0)))) + not_fails.

:- pred mul(X,Y,Z)
   #"@var{Z} es el resultado de multiplicar los n@'{u}meros Peano @var{X} y @var{Y}. @includedef{mul/3}".

mul(0,X,0):-nat(X).
mul(s(X),Y,Z1):-mul(X,Y,Z),sum(Y,Z,Z1).

:- test mul(X,Y,Z) : (X = 0, Y = s(s(s(0)))) => (Z = 0) + not_fails.
:- test mul(X,Y,Z) : (X = s(s(0)), Y = s(s(s(0)))) => (Z = s(s(s(s(s(s(0))))))) + not_fails.

:- pred append(L1,L2,L3)
   #"@var{L3} es la lista resultado de concatenar las listas @var{L1} y @var{L2}. @includedef{append/3}".

append([],L,L).
append([X|L1],L2,[X|L3]):-append(L1,L2,L3).

:- test append(L1,L2,L3) : (L1 = [b,c], L2 = [a] ) => (L3 = [b,c,a]) + not_fails.
:- test append(L1,L2,L3) : (L1 = [[a,b]], L2 = [[c],[d]]) => (L3 = [[a,b],[c],[d]]) + not_fails.

:- pred length(L,N)
   #"@var{N} es la logitud de la lista @var{L}. @includedef{length/2}".

length([],0).
length([_|L],s(N)):-
    length(L,N).

:- test length(L,N) : (L = [a,b,c,d]) => (N = s(s(s(s(0))))) + not_fails.

:- pred split_lists(N,L,M)
   #"@var{M} es la matriz resultante de dividir la lista @var{L} en sublistas de @var{N} elementos. @includedef{split_lists/3}".

split_lists(_,[],[]).
split_lists(N,L,[X|M]):-
    length(X,N),
    append(X,L1,L),
    split_lists(N,L1,M).

:- test split_lists(N,L,M) : (L = [a,b,c,d], N = s(s(0))) => (M = [[a,b],[c,d]]) + not_fails.

sumlist_matrix([X],S):-sumlist(X,S).
sumlist_matrix([L1|SQ],S):-
    sumlist_matrix(SQ,S),
    sumlist(L1,S).

:- pred less(X,Y)
   #"@var{X} y @var{Y} son n@'{u}meros peanos tal que @var{X} es menor o igual uqe @var{Y}. @includedef{less/2}".

less(0,X):-nat(X).
less(s(X),s(Y)):-less(X,Y).

:- test less(X,Y) : (X = s(s(0)), Y = 0) + fails.
:- test less(X,Y) : (X = s(0), Y = s(s(s(0)))) + not_fails.

% predicados del ejercicio

:- pred nums(N,L)
   #"@var{L} es la lista de n@'{u}meros naturales en orden descendente de @var{N} a 1). @includedef{nums/2}".

nums(0,[]).
nums(s(N),[s(N)|L]):-nums(N,L).

:- test nums(N,L) : (L = [0,s(0)]) + fails.
:- test nums(N,L) : (N = s(s(s(0)))) => (L = [s(s(s(0))),s(s(0)), s(0)]) + not_fails.                                     

:- pred sumlist(L,S)
   #"@var{S} es la suma de todos los n@'{u}meros de la lista @var{L}. @includedef{sumlist/2}".

sumlist([],0).
sumlist([X|L], Z):-sumlist(L, S),sum(X,S,Z).

:- test sumlist(L, S) : (S = s(s(0)), L = [s(s(0))]) + not_fails.
:- test sumlist(L, S) : (L = [s(0), s(0), s(s(0))]) => (S = s(s(s(s(0))))) + not_fails.                                                       

:- pred choose_one(E,L,R)
   #"Dada una lista @var{L} devuelve un elemento @var{E} siendo @var{R} la lista de los restos de elementos. @includedef{choose_one/3}".

choose_one(E,[E|R],R).
choose_one(E,[X|L],[X|R]):-choose_one(E,L,R).

:- test choose_one(E,L,R) : (L = [a,b], E = a, R = [b]) + not_fails.
:- test choose_one(E,L,R) : (L = [a,b,c,d,e,f,g], E = b, R = [a,c,d,e,f,g]) + not_fails.

:- pred perm(L,LP)
   #"@var{LP} es una permutaci@'{o}n de los elementos de la lista @var{L}. @includedef{perm/2}".

perm([],[]).
perm(L,[E|LP]):-choose_one(E,L,R),perm(R,LP).

:- test perm(L,LP) : (L = [a]) => (LP = [a]) + not_fails.
:- test perm(L,LP) : (L = [a,b,c,d], LP = [b,c,a,d]) + not_fails.

:- pred split(L,L1,L2)
   #"@var{L} es una lista de longitud @var{N}, @var{N} es par, @var{L1} contiene los @var{N}/2 elementos en posición impar de @var{L} y @var{L2} los en posici@'{o}n par. @includedef{split/3}".

split([],[],[]).
split([X|[Y|L]],[X|L1],[Y|L2]):-split(L,L1,L2).

:- test split(L,L1,L2) : (L = [a,b,c,d]) => (L1 = [a,c], L2 = [b,d]) + not_fails.
:- test split(L,L1,L2) : (L1 = [f,g], L2 = [a,i]) => (L = [f,a,g,i]) + not_fails.

:- pred sumlists(N, L1, L2, S)
   #"@var{N} es par, @var{L1} y @var{L2} son dos listas de longitud @var{N}/2, que contienen entre ellas todos los n@'{u}meros de Peano de 1 a @var{N}, y @var{L1} y @var{L2} suman lo mismo. @var{S} debe ser el valor de dicha suma. @includedef{sumlists/4}".

sumlists(0,[],[],0).
sumlists(N,L1,L2,S):-
    nums(N,L),
    perm(L,LP),
    split(LP,L1,L2),
    sumlist(L1,S),
    sumlist(L2,S).

:- test sumlists(N,L1,L2,S) : (N = s(0)) + fails.
:- test sumlists(N,L1,L2,S) : (N = s(s(s(s(0)))), L1 = [s(0), s(s(s(s(0))))], L2 = [s(s(0)),s(s(s(0)))], S = s(s(s(s(s(0)))))) + not_fails.

:- pred square_lists(N,SQ,S)
   #"@var{N} es el n@'{u}mero, @var{SQ} la matriz de @var{N} listas con @var{N} elementos (n@'{u}meros de peanos desde 1 a @var{N} al cuadrado sin repetir) cada una  y @var{S} el valor que suma cada fila de la matriz @var{SQ} y que sean iguales. @includedef{square_lists/3}".

square_lists(N,SQ,S):-
    less(s(0),N),
    mul(N,N,N2),
    nums(N2,L),
    perm(L,LP),
    split_lists(N,LP,SQ),
    sumlist_matrix(SQ,S).

:- test square_lists(N,SQ,S) : (N = 0) + fails #"N no puede ser 0".
:- test square_lists(N,SQ,S) : (N = s(s(0)), S = s(s(s(s(s(0))))), SQ = [[s(s(s(s(0)))),s(0)],[s(s(s(0))), s(s(0))]]) + not_fails.
