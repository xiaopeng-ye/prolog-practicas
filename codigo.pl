:- module(_,_,[assertions,regtypes]).
alumno_prode('Ye','','Xiao Peng','A180321').

nat(0).
nat(s(X)):-nat(X).

sum(0,X,X):-nat(X).
sum(s(X),Y,s(Z)):-sum(X,Y,Z).

nums(s(0),[s(0)]).
nums(s(N),[s(N)|L]):-nums(N,L).

sumlist([],0).
sumlist([X|L], Z):-sumlist(L, S),sum(X,S,Z).

choose_one(E,[E|R],R).
choose_one(E,[X|L],[X|R]):-choose_one(E,L,R).

perm([],[]).
perm(L,[E|LP]):-choose_one(E,L,R),perm(R,LP).

split([],[],[]).
split([X|[Y|L]],[X|L1],[Y|L2]):-split(L,L1,L2).

sumlists(N,L1,L2,S):-
    nums(N,L),
    perm(L,LP),
    split(LP,L1,L2),
    sumlist(L1,S),
    sumlist(L2,S).

mul(0,X,0):-nat(X).
mul(s(X),Y,Z1):-sum(Y,Z,Z1),mul(X,Y,Z).

conc([],L,L).
conc([X|L1],L2,[X|L3]):-conc(L1,L2,L3).

split_lists(s(s(0)),L,[L1,L2]):-split(L,L1,L2).
split_lists(s(s(N)),L,M):-
    split(L,L1,L2),
    split_lists(N,L1,M1),
    split_lists(N,L2,M2),
    conc(M1,M2,M).

sumlist_matrix([X],S):-sumlist(X,S).
sumlist_matrix([L1|SQ],S):-
    sumlist(L1,S),
    sumlist_matrix(SQ,S).

square_lists(N,SQ,S):-
    mul(N,N,N2),
    nums(N2,L),
    perm(L,LP),
    split_lists(N,LP,SQ),
    sumlist_matrix(SQ,S).