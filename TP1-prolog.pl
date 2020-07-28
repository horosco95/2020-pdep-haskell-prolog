% ------- TP ENTREGA 1 --------
%% Punto 1
perteneceA(comarca,eriador).
perteneceA(rivendel,eriador).
perteneceA(moria,montaniasNubladas).
perteneceA(lothlorien,montaniasNubladas).
perteneceA(edoras,rohan).
perteneceA(isengard,rohan).
perteneceA(abismoDeHelm,rohan).
perteneceA(minasTirith,gondor).
perteneceA(minasMorgul,mordor).
perteneceA(monteDelDestino,mordor).

%% Punto 2
camino([comarca,rivendel,moria,lothlorien,edoras,minasTirith,minasMorgul,monteDelDestino]).

%% Punto 3
limitrofes(rivendel,moria).
limitrofes(moria,isengard).
limitrofes(lothlorien,edoras).
limitrofes(edoras,minasTirith).
limitrofes(minasTirith,minasMorgul).
zonasLimitrofes(UnaZona,OtraZona):-limitrofes(UnaZona,OtraZona).
zonasLimitrofes(UnaZona,OtraZona):-limitrofes(OtraZona,UnaZona).
zonasLimitrofes(UnaZona,OtraZona):- perteneceA(UnaZona,Region),perteneceA(OtraZona,Region),UnaZona\=OtraZona.

%% Punto 4
% parte A - 

regionesLimitrofes(UnaRegion,OtraRegion):- perteneceA(UnaZona,UnaRegion), perteneceA(OtraZona,OtraRegion), zonasLimitrofes(UnaZona,OtraZona), UnaRegion\=OtraRegion.

% parte B - 
%region(Region):-perteneceA(Region,_).
regionesLejanas(UnaRegion,OtraRegion):- perteneceA(_,UnaRegion),not(regionesLimitrofes(UnaRegion,OtraRegion)),
    not(terceraRegionLimitrofeConAmbas(UnaRegion,OtraRegion)),UnaRegion\=OtraRegion.
terceraRegionLimitrofeConAmbas(UnaRegion,OtraRegion):- regionesLimitrofes(UnaRegion,OtraEnComun),regionesLimitrofes(OtraEnComun,OtraRegion),UnaRegion\=OtraRegion.

%% Punto 5
% parte A - 

ultimoElemento([Elem],Elem).
ultimoElemento([_|Cola],Ultimo):- ultimoElemento(Cola,Ultimo).
puedeSeguirCon(Camino,Zona):-ultimoElemento(Camino,Ultimo), zonasLimitrofes(Zona,Ultimo).
    
% parte B -

sonConsecutivos(Camino1,[Zona|_]):- puedeSeguirCon(Camino1,Zona).


%% Punto 6
% parte A - 

caminoLogico([A,B]):- zonasLimitrofes(A,B).
caminoLogico([Zona1,Zona2|Cola]):- zonasLimitrofes(Zona1,Zona2), caminoLogico([Zona2|Cola]).

% parte B -

caminoSeguro([A,B,C]):- not(primeras3ZonasMismaRegion([A,B,C])).
caminoSeguro([A,B,C|Cola]):- not(primeras3ZonasMismaRegion([A,B,C])), caminoSeguro([B,C|Cola]).

primeras3ZonasMismaRegion([A,B,C|_]):- zonasLimitrofes(A,B),zonasLimitrofes(B,C),perteneceA(Misma,A),perteneceA(Misma,B),perteneceA(Misma,C).

% ------- TP ENTREGA 2 --------
