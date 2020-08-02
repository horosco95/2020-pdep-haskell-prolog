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

puedeSeguirCon(Camino,Zona):-last(Camino,Ultimo), zonasLimitrofes(Zona,Ultimo).
    
% parte B -

sonConsecutivos(Camino1,[Zona|_]):- puedeSeguirCon(Camino1,Zona).


%% Punto 6
% parte A - 
caminoLogico([_]).
caminoLogico([A,B]):- zonasLimitrofes(A,B).
caminoLogico([Zona1,Zona2|Cola]):- zonasLimitrofes(Zona1,Zona2), caminoLogico([Zona2|Cola]).

% parte B -

caminoSeguro([A,B,C]):- not(primeras3ZonasMismaRegion([A,B,C])).
caminoSeguro([A,B,C|Cola]):- not(primeras3ZonasMismaRegion([A,B,C])), caminoSeguro([B,C|Cola]).

primeras3ZonasMismaRegion([A,B,C|_]):- zonasLimitrofes(A,B),zonasLimitrofes(B,C),perteneceA(Misma,A),perteneceA(Misma,B),perteneceA(Misma,C).

% ------- TP ENTREGA 2 --------
%% Punto 1
% parte A - 

% parte B - 

% parte C - 
/*
[minasTirith,minasMorgul]
[minasTirith,minasMorgul,monteDelDestino]
[monteDelDestino,minasMorgul,minasTirith,minasMorgul]

[minasTirith,minasMorgul]
[minasTirith,minasMorgul,monteDelDestino]
[monteDelDestino,minasMorgul,minasTirith]
 */
todosLosCaminosConducenAMordor([Camino]):- caminoConduceAMordor(Camino).
todosLosCaminosConducenAMordor([UnCamino|Caminos]):- caminoConduceAMordor(UnCamino), todosLosCaminosConducenAMordor(Caminos). 
caminoConduceAMordor(Camino):- last(Camino,Zona), perteneceA(Zona,mordor).
%% Punto 2
% parte A - 
%viajero(Nombre, maiar(Nivel,PoderMagico)).
viajero(gandalf, maiar(25, 260)).
% parte B - 
%viajero(Nombre, guerrera(raza, Arma, NivelArma)).
viajero(legolas, guerrera(elfo, arco, 29)).
viajero(legolas, guerrera(elfo, espada, 20)).
viajero(gimli, guerrera(enano, hacha, 26)).
viajero(aragorn, guerrera(dunedain, espada, 30)).
viajero(boromir, guerrera(hombre, espada, 26)).
viajero(gorbag, guerrera(orco, ballesta, 24)).
viajero(ugluk, guerrera(uruk-hai, espada, 26)).
viajero(ugluk, guerrera(uruk-hai, arco, 22)).
% parte C - 
%viajero(Nombre, pacifista(Raza, Edad)).
viajero(frodo, pacifista(hobbit, 51)).
viajero(sam, pacifista(hobbit, 36)).
viajero(barbol, pacifista(ent, 5300)).
%% Punto 3
% parte A - 

% parte B - 

% parte C - 

%% Punto 4
% parte A - 

% parte B - 

%% Punto 5
% parte A - 

% parte B - 