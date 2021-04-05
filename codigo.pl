:- module(_,_,[assertions,regtypes]).
alumno_prode('Ye','','Xiao Peng','A180321').

sum(0,X,X).
sum(s(X),Y,s(Z)):-sum(X,Y,Z).

nums(0,[]).
nums(s(N),[s(N)|L]):-nums(N,L).

sumlist([],0).
sumlist([X|L], Z):-sumlist(L, S),sum(X,S,Z).

choose_one(E,[E|R],R).
choose_one(E,[X|L],[X|R]):-choose_one(E,L,R).

perm([],[]).
perm(L,[E|LP]):-choose_one(E,L,R),perm(R,LP).

split([],[],[]).
split([X|[Y|L]],[X|L1],[Y|L2]):-split(L,L1,L2).

sumlists(0,[],[],0).
sumlists(N,L1,L2,S):-
    nums(N,L),
    perm(L,LP),
    split(LP,L1,L2),
    sumlist(L1,S),
    sumlist(L2,S).

mul(0,X,0).
mul(s(X),Y,Z1):-mul(X,Y,Z),sum(Y,Z,Z1).

append([],L,L).
append([X|L1],L2,[X|L3]):-append(L1,L2,L3).

length([],0).
length([_|L],s(N)):-
    length(L,N).

split_lists(_,[],[]).
split_lists(N,L,[X|M]):-
    length(X,N),
    append(X,L1,L),
    split_lists(N,L1,M).

sumlist_matrix([X],S):-sumlist(X,S).
sumlist_matrix([L1|SQ],S):-
    sumlist_matrix(SQ,S),
    sumlist(L1,S).
   
menor(0,X).
menor(s(X),s(Y)):-menor(X,Y).

square_lists(N,SQ,S):-
    menor(s(0),N),
    mul(N,N,N2),
    nums(N2,L),
    perm(L,LP),
    split_lists(N,LP,SQ),
    sumlist_matrix(SQ,S).
