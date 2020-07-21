%% Punto 1
perteneceA(eriador,comarca).
perteneceA(eriador,rivendel).
perteneceA(montaniasNubladas,moria).
perteneceA(montaniasNubladas,lothlorien).
perteneceA(rohan,edoras).
perteneceA(rohan,isengard).
perteneceA(rohan,abismoDeHelm).
perteneceA(gondor,minasTirith).
perteneceA(mordor,minasMorgul).
perteneceA(mordor,monteDelDestino).

%% Punto 2
camino([comarca,rivendel,moria,lothlorien,edoras,minasTirith,minasMorgul,monteDelDestino]).

%% Punto 3
zonasLimitrofes(rivendel,moria).
zonasLimitrofes(moria,rivendel).
zonasLimitrofes(moria,isengard).
zonasLimitrofes(isengard,moria).
zonasLimitrofes(lothlorien,edoras).
zonasLimitrofes(edoras,lothlorien).
zonasLimitrofes(edoras,minasTirith).
zonasLimitrofes(minasTirith,edoras).
zonasLimitrofes(minasTirith,minasMorgul).
zonasLimitrofes(minasMorgul,minasTirith).
zonasLimitrofes(UnaZona,OtraZona):- perteneceA(Region,UnaZona),perteneceA(Region,OtraZona),UnaZona\=OtraZona.

%% Punto 4
% parte A - 

regionesLimitrofes(UnaRegion,OtraRegion):- perteneceA(UnaRegion,UnaZona), perteneceA(OtraRegion,OtraZona), zonasLimitrofes(UnaZona,OtraZona), UnaRegion\=OtraRegion.

% parte B - 
region(Region):-perteneceA(Region,_).
regionesLejanas(UnaRegion,OtraRegion):- region(UnaRegion), not(regionesLimitrofes(UnaRegion,OtraRegion)),
    not((regionesLimitrofes(UnaRegion,OtraEnComun),regionesLimitrofes(OtraEnComun,OtraRegion))),UnaRegion \= OtraRegion.


%% Punto 5
% parte A - 

ultimoElemento([Elem],Elem).
ultimoElemento([_|Cola],Ultimo):- ultimoElemento(Cola,Ultimo).
puedeSeguirCon(Camino,Zona):-ultimoElemento(Camino,Ultimo), zonasLimitrofes(Zona,Ultimo).
    
% parte B -

sonConsecutivos(Camino1,[Cabeza2|_]):- puedeSeguirCon(Camino1,Cabeza2).


%% Punto 6
% parte A - 

caminoLogico([A,B]):- zonasLimitrofes(A,B).
caminoLogico([Zona1,Zona2|Cola]):- zonasLimitrofes(Zona1,Zona2), caminoLogico([Zona2|Cola]).

% parte B -

caminoSeguro([A,B,C]):- not(primeras3ZonasMismaRegion([A,B,C])).
caminoSeguro([A,B,C|Cola]):- not(primeras3ZonasMismaRegion([A,B,C])), caminoSeguro([B,C|Cola]).

primeras3ZonasMismaRegion([A,B,C|_]):- zonasLimitrofes(A,B),zonasLimitrofes(B,C),perteneceA(Misma,A),perteneceA(Misma,B),perteneceA(Misma,C).