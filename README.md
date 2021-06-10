# Primera práctica (Programación lógica pura)

## SUMAS DE PARES DE LISTAS Y CUADRADOS

## Enunciado

Nuestro primer objetivo es, dado un naturalNpar, construir dos lis-
tas de longitudN/2, cuyos elementos sumen lo mismo. Para ello, definir los siguientes
predicados:

1. Definir un predicadonums(N,L)tal queNes un número natural yLes la lista de
    números naturales en orden descendente deNa 1.
2. Definir un predicadosumlist(L,S)tal queLes una lista de números naturales
ySes la suma de todos los elementos deL.
3. Definir un predicadochoose_one(E,L,R)tal queLes una lista,Ees un elemento
cualquiera deL, yRes lo que queda de la lista, después de quitarE. Dada una
listaL, una llamada achoose_one/3debe devolver enE, como alternativas al
pedir más soluciones, sucesivamente todos los elementos deE, y enRtodos los
restos.
4. Usando el predicadochoose_one/3, escribir el predicadoperm(L,LP), tal queL
es una lista yLPes una permutación deL(es decir, una lista con los mismos
elementos deL, en distinto orden). Por ejemplo, dada una listaL,perm(L,LP)
debe generar como alternativas enLPtodas las permutaciones deL.
5. Definir un predicadosplit(L,L1,L2)tal queLes una lista de longitudN,Nes
par,L1contiene losN/2elementos en posición impar deLyL2los en posición
par. Es decir:split([a,b,c,d],X,Y)devolveríaX = [a,c], Y = [b,d].
6. Para completar nuestro primer objetivo, escribir, usando los predicados anterio-
res, un predicadosumlists(N,L1,L2,S)tal queNes par,L1yL2son dos listas
de longitudN/2, que contienen entre ellas todos los números de Peano de 1 a
N, yL1yL2suman lo mismo.Sdebe ser el valor de dicha suma.

Como segundo objetivo, dadoN, y los números de Peano consecu-
tivos de 1 aN^2 , colocarlos en un cuadrado de tamañoN×Ntal que todas las filas
sumen lo mismo. Para ello programar (pudiéndose usar algunos predicados del punto
anterior) el siguiente predicado:

```
square_lists(N,SQ,S), tal queNes el número,SQel cuadrado (representado
comoNlistas deNelementos cada una), ySel valor que suman las filas.
Por ejemplo,square_lists(s(s(0)),SQ,S)devolveríaS = s(s(s(s(s(0))))),
SQ = [ [s(s(s(s(0)))), s(0)], [s(s(s(0))), s(s(0))] ].
```

# Segunda práctica (ISO-Prolog)

## COMPRESIÓN DE SECUENCIAS

## Enunciado

Para comprimir secuencias de caracteres se suelen sustituir subsecuencias repeti-
das por el número de sus repeticiones. Así, la secuenciaaaaaaaase comprime ena7.
La secuencia original es de longitud siete, la comprimida tiene solo longitud dos. La
secuenciaababab, de longitud seis, se comprime en(ab)3, de longitud cinco. Nótese
que los paréntesis se cuentan también como caracteres de la secuencia. Solo hacen
falta paréntesis si la subsecuencia que se repite es de más de un carácter.
Para secuencias complejas se procede a dividirla en partes, que se comprimen
por separado (y luego se unen). Así, el proceso completo de compresión se lleva a
cabo bien por repetición o por división. En la compresión por repetición se localiza
una subsecuencia que se repita un cierto número de veces, como ya se ha dicho, y el
resultado es esta subsecuencia (posiblemente también comprimida) con su número
de repeticiones. Por ejemplo, la secuenciaaaaaaaase comprime en la secuenciaa7.
En la compresión por división se divide la secuencia original en dos partes que a
su vez se comprimen por separado y se unen los resultados. Por ejemplo, la secuen-
ciaaaaaaaabbbbbbbse comprime ena7b7(comprimiendo cada parte, a su vez, por
repetición). La secuenciaaaabaaabse comprime por repetición en(a3b)2donde la
subsecuencia aaab se ha comprimido ena3bpor división (y a su vezaaaena3por
repetición).
Los resultados de la compresión (tanto de la secuencia original como de sus sub-
secuencias) han de ser más cortos que las secuencias iniciales. Así, no es admisible
comprimiraaena2, porque tienen la misma longitud, niababen(ab)2, porque esta
última es más larga.
Las secuencias se representaran como listas de caracteres. Por ejemplo,aaaes
[a,a,a]y(ab)3es[’(’,a,b,’)’,3]. En estas listas los números ocupan una única
posición, tengan el numero de dígitos que tengan. Así,a12es la lista[a,12]y tiene
longitud dos (no tres).
Los objetivos de la práctica son los siguientes:

1. Programar un predicadodivision/2con cabeceradivision(Inicial, Comprimida)
    que se verifica si la secuenciaComprimidaes el resultado de comprimir la se-
    cuenciaInicialmediante división. Nótese que una solución válida paraComprimida
    no tiene que ser necesariamente la mejor en términos de longitud, aunque es-
    te programa debe ser capaz de devolver todas las soluciones, ya sea mediante
    backtracking o mediante el uso de predicados de agregación.
2. Programar un predicadorepeticion/2con cabecerarepeticion(Inicial, Comprimida)
que se verifica si la secuenciaComprimidaes el resultado de comprimir la se-
cuencia inicial mediante repetición. En este caso aplican los mismos comentarios
y recomendaciones que en el predicado anterior.


3. Programar un predicadocomprimir/2con cabeceracomprimir(Inicial, Comprimida)
    que se verifica siComprimidaes el resultado de comprimir la secuencia del pri-
    mer argumento, según lo especificado más arriba. La secuencia original (primer
    argumento) viene dada en la llamada y en ella no aparecen ni paréntesis ni
    números. Para que la compresión sea eficaz, se deben probar una tras otra ite-
    rativamente sucesivas compresiones, hasta dar con la de menor longitud (es
    decir, realizando una búsqueda). Para que el programa sea eficiente es nece-
    sario almacenar compresiones ya obtenidas, utilizando para ello la técnica de
    memorización de lemas.

A continuación os ofrecemos una guía para realizar la práctica de forma gradual.

1. Emperazemos con una versión preliminar del predicadocomprimir/2de cabe-
    ceracomprimir(Inicial,Comprimida):
       comprimir(Inicial,Comprimida):-
          limpia_memo ,
          compresion_recursiva(Inicial,Comprimida).

```
limpia_memo.
```
```
compresion_recursiva(Inicial,Inicial).
```

Esta solución que obviamente no comprime, la tomaremos de base para progre-
sivamente implementar los requisitos de la práctica. El predicadolimpia_memo/
se encargará más adelante de limpiar la base de datos de memorización. El pre-
dicadocompresion_recursiva/2será el predicado de compresión interno que
llamemos de forma recursiva (sin limpiar la base de datos de memorización).

2. Escribir un predicadopartir/3con cabecerapartir(Todo, Parte1, Parte2)
    que se verifica siParte1yParte2son dos subsecuencias _no vacías_ que conca-
    tenadas forman la secuenciaTodo.
3. Escribir un predicadoparentesis/3con cabeceraparentesis(Parte,Num,ParteNum),
    dondeParteNumes una lista de caracteres que es el resultado de componer
    la listaPartecon el número de repeticionesNum, añadiendo paréntesis solo si
    Partetiene 2 elementos o más. Por ejemplo:
       ?- parentesis([a,b,c],3,R).
       R = [’(’,a,b,c,’)’,3]? ;
       no

```
?- parentesis([a,b],2,R).
R = [’(’,a,b,’)’,2]? ;
no
```
```
?- parentesis([a],2,R).
R = [a,2]? ;
```

```
no
```
4. Implementar un predicadose_repite/4con cabecerase_repite(Cs,Parte,Num0,Num),
    que tiene éxito siCsse obtiene por repetirNveces la secuenciaParte. El argu-
    mentoNumincrementaNum0enN. Por ejemplo:
       % [a,b,c] se repite 1 vez en [a,b,c]
          ?- se_repite([a,b,c],[a,b,c],0,R).
          R = 1? ;
          no

```
% [a,b,c,a,b,c,a,b,c] se obtiene repitiendo [a,b,c] 3 veces
?- se_repite([a,b,c,a,b,c,a,b,c],[a,b,c],0,R).
R = 3? ;
no
```
```
% [a,b,c,a,c,a,b,c] no se puede obtener mediante repeticiones
% de [a,b,c].
?- se_repite([a,b,c,a,c,a,b,c],[a,b,c],0,R).
no
```
```
% [] se obtiene repitiendo cero veces [a,b,c]
?- se_repite([],[a,b,c],0,R).
R = 0? ;
no
```

Esta será la primera versión de la compresión recursiva, usando únicamente la
repetición. Esta versión nos dará mediante backtracking distintas soluciones, puesto
que todavía no vamos a buscar la más óptima.

1. Cambiaremos el predicadocompresion_recursiva/2a la siguiente versión (re-
    emplazando la anterior):
       compresion_recursiva(Inicial,Comprimida) :-
          repeticion(Inicial,Comprimida).
% No compresion posible:
       compresion_recursiva(Inicial,Inicial).
2. Debeis **implementar** el predicadorepeticion/2, basándoos en los predicados
partir/3yse_repite/4para identificar un prefijo (una parte) que nos de por
repetición la secuencia inicial. Antes de seguir, esta parte debéis comprimirla de
forma recursiva mediante una llamada acompresion_recursiva/2. Finalmente
debe componer la parte (comprimida recursivamente) con el número de repeti-
ciones usando el predicadoparentesis/3. Por ejemplo’:
?- repeticion([a,a,a,a,a,a,a],R).
R = [a,7]? ;
no


```
?- repeticion([a,b,a,b,a,b],R).
R = [’(’,a,b,’)’,3]? ;
no
?- repeticion([a,b,a,b,a],R).
no
```

En esta fase vamos a extender la solución anterior para comprimir repitiendo o
dividiendo. El código ahora sí será capaz de obtener todas las posibles compresiones
por backtracking, tanto óptimas como no óptimas.

1. Para ello cambiaremos el predicadocompresion_recursiva/2a la siguiente ver-
    sión (reemplazando la anterior):
       compresion_recursiva(Inicial,Comprimida) :-
          compresion(Inicial,Comprimida).
% No compresion posible:
       compresion_recursiva(Inicial,Inicial).
2. El **nuevo predicado** compresion/2tendrá dos alternativas: o llamar al predicado
repeticion/2ya implementado o a un **nuevo predicado** division/2, con cabe-
ceradivision(Inicial, Comprimida). El predicadodivision/2debe partir la
lista inicial en dos partes y llamar acompresion_recursiva/2de forma recursiva
en cada una de ellas para finalmente concatenar los resultados.
Es decir, además de considerar las repeticiones, podremos dividir la lista inicial
en dos partes y aplicar el algoritmo a cada una de ellas por separado (dando
más posibilidades a encontrar repeticiones).

En esta penúltima fase vamos a encargarnos de obtener solamente las compresio-
nes óptimas.

1. Para ellocompresion_recursiva/2lo cambiaremos de la siguiente forma:
    compresion_recursiva(Inicial,Comprimida) :-
       mejor_compresion(Inicial,Comprimida).
2. Ahora compresion_recursiva/2 llamará en su lugar al un **nuevo predicado**
mejor_compresion/2, que intentará encontrar compresiones que reduzcan el ta-
maño. Fijaos que ahora tomamos la lista inicial como caso base para minimizar
enmejor_compresion/2, por ese motivo no incluimos una segunda cláusula en
compresion_recursiva/2para el caso en el que no haya compresión posible.
El predicado mejor_compresion/2se puede implementar con predicados de
agregación (findall/3, obteniendo todas las soluciones y quedándonos con la
más corta) o llamando de forma reiterada con un parámetro a minimizar.


Finalmente vamos a implementar la versión que realiza memorización de lemas.
Esta será una solución óptima y además eficiente:

1. Ahora declaramosmemo/2para asertar los lemas, implementamoslimpia_memo/
    para limpiarlos y cambiamoscompresion_recursiva/2.
       :- dynamic memo/2.

```
compresion_recursiva(Inicial,Comprimida) :-
mejor_compresion_memo(Inicial,Comprimida).
```
```
limpia_memo :-
retractall(memo(_,_)).
```
2. Debéis implementar un **nuevo predicado** mejor_compresion_memo/2, que utili-
    zando el predicadomejor_compresion/2, implemente un esquema de memori-
    zación (e.g., igual que el visto en clase para Fibonacci).
