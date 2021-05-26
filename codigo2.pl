:- module(_, _, [classic, assertions, regtypes]).
alumno_prode('Ye', '', 'Xiao Peng', 'A180321').

:- doc(title, "Compresi@'{o}n de secuencias").
:- doc(author, "Xiao Peng Ye, A180321").
:- doc(usage, "use_module('codigo.pl')").

:- pred comprimir(Inicial, Comprimida)
# "@var{Comprimida} es el resultado de comprimir @var{Inicial}, una lista de caracteres, utilizado la t@'{e}cnica de memoria din@'{a}mica. @includedef{comprimir/2}".

comprimir(Inicial, Comprimida) :-
    limpia_memo,
    compresion_recursiva(Inicial, Comprimida).

:- test comprimir(Inicial, Comprimida) : (Inicial = [a, a, a, a, a, b, b, b, b], Comprimida= [a, 5, b, 4]) + not_fails.
:- test comprimir(Inicial, Comprimida) : (Inicial = [a, b, a, b, a, b], Comprimida= ['(', a, b, ')', 3]) + not_fails.
:- test comprimir(Inicial, Comprimida) : (Inicial = "abcabc", Comprimida= "abcabc") + not_fails.

%memoria utilizada para guardar las sentencias ya comprimidas
:- dynamic memo/2.

:- pred compresion_recursiva(Inicial, Comprimida)
# "Predicado auxiliar de compresion. @includedef{compresion_recursiva/2}".

compresion_recursiva(Inicial, Comprimida) :-
    mejor_compresion_memo(Inicial, Comprimida), !.

compresion_recursiva(Inicial, Inicial).

:- pred limpia_memo
# "Borrar todos los predicados de memo de la memoria din@'{a}mica. @includedef{limpia_memo/0}".

limpia_memo :-
    retractall(memo(_, _)).

:- pred minimo_lista(Lista, Minimo)
# "@var{Minimo} es la lista con menor longitud de la lista de listas @var{Lista}. @includedef{minimo_lista/2}".

minimo_lista(Lista, Minimo) :-
    member(Minimo, Lista),
    length(Minimo, N),
    \+ (member(X, Lista), length(X, M), N > M), !.

:- test minimo_lista(Lista, Minimo) : (Lista= ["1", "22", "333", "4444"]) => (Minimo= "1") + not_fails.
:- test minimo_lista(Lista, Minimo) : (Lista= ["22", "22", "333", "4444", "4444"]) => (Minimo= "22") + not_fails.

:- pred mejor_compresion(Inicial, Comprimida)
# "Versi@'{o}n mejorado del predicado compresi@'{o}n utilizando findall para obtener la lista de todos las posibles sentencias comprimidas quedando solo con la de longitud menor. @includedef{mejor_compresion/2}".

mejor_compresion(Inicial, Comprimida) :-
    findall(X, (compresion(Inicial, X)), L),
    minimo_lista(L, Comprimida).

:- test mejor_compresion(Inicial, Comprimida) : (Inicial=[a, a, a, a, b, b, b, c, c, c, c, a, a, a, a, b, b, b, c, c, c, c], Comprimida= ['(', a, 4, b, 3, c, 4, ')', 2]) + not_fails.

:- pred mejor_compresion_memo(Inicial, Comprimida)
# "Predicado auxiliar para salvar las sentencias comprimidas ya conocidas en la memoria din@'{a}mica, evitando as@'{i} duplicar el trabajo. @includedef{mejor_compresion_memo/2}".

mejor_compresion_memo(Inicial, Comprimida) :- memo(Inicial, Comprimida), !.
mejor_compresion_memo(Inicial, Comprimida) :-
    mejor_compresion(Inicial, Comprimida),
    assert(memo(Inicial, Comprimida)).

:- pred partir(Todo, Parte1, Parte2)
# "@var{Todo} es la lista formado al concatenar las listas no vacias @var{Parte1} y @var{Parte2}. @includedef{partir/3}".

partir(Todo, Parte1, Parte2) :-
    append(Parte1, Parte2, Todo),
    Parte1 \= [],
    Parte2 \= [].

:-test partir(Todo, Parte1, Parte2) : (Todo=[a, b, c], Parte1=[], Parte2=[a, b, c]) + fails.
:-test partir(Todo, Parte1, Parte2) : (Todo=[a, b, c, d, e], Parte1=[a, b]) => (Parte2=[c, d, e]) + not_fails.
:-test partir(Todo, Parte1, Parte2) : (Parte1= "hola", Parte2= " mundo") => (Todo= "hola mundo") + not_fails.

:- pred parentesis(Parte, Num, ParteNumm)
# "@var{ParteNum} es la lista de caracteres que es el resultado de componer la lista @var{Parte} con el n@'{u}mero de repeticiones @var{Num}, anadiendo par@'{e}ntesis solo si @var{Parte} tiene 2 elementos o m@'{a}s. @includedef{parentesis/3}".

parentesis([X], Num, [X, Num]) :- number(Num).
parentesis(Parte, Num, ParteNum) :-
    number(Num),
    append(['('|Parte], [')', Num], ParteNum),
    length(Parte, N),
    N > 1.

:- test parentesis(Parte, Num, ParteNum) : (Parte= [a], Num=3) => (ParteNum= [a, 3]) + not_fails.
:- test parentesis(Parte, Num, ParteNum) : (Parte= [a, b, c], Num=9) => (ParteNum= ['(', a, b, c, ')', 9]) + not_fails.
:- test parentesis(Parte, Num, ParteNum) : (Num=4, ParteNum= ['(', t, e, s, t, ')', 4]) => (Parte= [t, e, s, t]) + not_fails.

:- pred se_repite(Cs, Parte, Num0, Num)
# "La lista @var{Cs} es el resultado de repetir @var{Num} - @var{Num0} veces la lista @var{Parte}. @includedef{se_repite/4}".

se_repite([], _, Num0, Num) :- Num is Num0.
se_repite(Cs1, Parte, Num0, Num1) :-
    append(Parte, Cs, Cs1),
    se_repite(Cs, Parte, Num0, Num),
    Num1 is Num + 1.

:- test se_repite(Cs, Parte, Num0, Num) : (Cs= "abcabcabcabc", Parte= "abc", Num0=0) => (Num=4) + not_fails.
:- test se_repite(Cs, Parte, Num0, Num) : (Cs= "abcacabc", Parte= "abc", Num0=0) + fails.
:- test se_repite(Cs, Parte, Num0, Num) : (Cs=[], Parte= "vacio", Num0=0) => (Num=0) + not_fails.

:- pred repeticion(Inicial, Comprimida)
# "La sentencia @var{Comprimida} es el resultado de comprimir la sentencia @var{Inicial} por la repetici@'{o}n de su subsecuencia. @includedef{repeticion/2}".

repeticion(Inicial, Comprimida) :-
    partir(Inicial, Parte, _),
    se_repite(Inicial, Parte, 0, Num),
    compresion_recursiva(Parte, ParteComprimida),
    parentesis(ParteComprimida, Num, Comprimida).

:- test repeticion(Inicial, Comprimida) : (Inicial= [a, a, a, a, a, a, a, a, a, a], Comprimida=[a, 10]) + not_fails.
:- test repeticion(Inicial, Comprimida) : (Inicial= [a, b, a, b, a, b, a, b, a, b], Comprimida= ['(', a, b, ')', 5]) + not_fails.
:- test repeticion(Inicial, Comprimida) : (Inicial= "safjfjerw") + fails.

:- pred division(Incial, Comprimida)
# "La sentencia @var{Comprimida} es el resultado de comprimir la sentencia @var{Inicial} por divisi@'{o}n. @includedef{division/2}".

division(Inicial, Comprimida) :-
    partir(Inicial, Parte1, Parte2),
    compresion_recursiva(Parte1, Comprimida1),
    compresion_recursiva(Parte2, Comprimida2),
    append(Comprimida1, Comprimida2, Comprimida).

:-test division(Inicial, Comprimida) : (Inicial= [a, a, a, a, b, b, b, b, b], Comprimida= [a, 4, b, 5]) + not_fails.
:-test division(Inicial, Comprimida) : (Inicial= [a, a, a, b], Comprimida= [a, 3, b]) + not_fails.

:- pred compresion(Inicial, Comprimida)
# "Devuelve todos las posibles sentencias comprimidas del @var{Inicial} tanto por repeticion como divisi@'{o}n. @includedef{compresion/2}".

compresion(Inicial, Comprimida) :- repeticion(Inicial, Comprimida).
compresion(Inicial, Comprimida) :- division(Inicial, Comprimida).
