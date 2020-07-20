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

regionesLimitrofes(UnaRegion,OtraRegion):- perteneceA(UnaRegion,UnaZona), perteneceA(OtraRegion,OtraZona), zonasLimitrofes(UnaZona,OtraZona).

% parte B - 

regionesLejanas(UnaRegion,OtraRegion):- not(regionesLimitrofes(UnaRegion,OtraRegion)),
    not((regionesLimitrofes(UnaRegion,OtraEnComun),regionesLimitrofes(OtraEnComun,OtraRegion))),UnaRegion \= OtraRegion.


%% Punto 5
% parte A - 

puedeSeguirCon([CabezaCamino|ColaCamino], Zona):- zonasLimitrofes(ColaCamino,Zona).

% parte B -

sonConsecutivos(Camino1,[Cabeza2|Cola2]):- puedeSeguirCon(Camino1,Cabeza2).


%% Punto 6
% parte A - 

caminoLogico([UnaZona|OtraZona]):-ZonasLimitrofes(UnaZona,OtraZona).
caminoLogico([_|]UnaZona|OtraZona):-caminoLogico([UnaZona|OtraZona]), caminoLogico([_|UnaZona]).

% parte B -

caminoSeguro([Cabeza,Segundo|Cola]):- zonasLimitrofes(Cabeza,Segundo).
%Pendiente de solucion