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
caminoSeguro([A]):- perteneceA(A,_).
caminoSeguro([A,B]):- zonasLimitrofes(A,B), perteneceA(A,Region1), perteneceA(B,Region2), regionesLimitrofes(Region1,Region2).
caminoSeguro([A,B,C]):- not(primeras3ZonasMismaRegion([A,B,C])).
caminoSeguro([A,B,C|Cola]):- not(primeras3ZonasMismaRegion([A,B,C])), caminoSeguro([B,C|Cola]).

primeras3ZonasMismaRegion([A,B,C|_]):- zonasLimitrofes(A,B),zonasLimitrofes(B,C),perteneceA(A, MismaRegion),perteneceA(B, MismaRegion),perteneceA(C, MismaRegion).
% ------- TP ENTREGA 2 --------
%% Punto 1
% parte A - 

cantidadDeRegiones(Camino,Cantidad):-
    findall(Region,(member(Zona,Camino), perteneceA(Zona,Region)),ListaRegiones),
    list_to_set(ListaRegiones,Lista),
    length(Lista,Cantidad).

% parte B - 
esVueltero(Camino):- nth1(Pos1,Camino,Zona), nth1(Pos2,Camino,Zona), Pos2\=Pos1.
% parte C - 
todosLosCaminosConducenAMordor(ListaCaminos):- forall(member(Camino,ListaCaminos), caminoConduceAMordor(Camino)).
caminoConduceAMordor(Camino):- last(Camino,Zona), perteneceA(Zona,mordor).
%% Punto 2
% parte A - 
%viajero(Nombre, maiar(Nivel,PoderMagico)).
viajero(gandalf, maiar(25, 260)).
% parte B - 
%viajero(Nombre, guerrera(raza, [(Arma,Nivel)]).
viajero(legolas, guerrera(elfo, [(arco,29),(espada,20)])).
viajero(gimli, guerrera(enano, [(hacha, 26)])).
viajero(aragorn, guerrera(dunedain, [(espada, 30)])).
viajero(boromir, guerrera(hombre, [(espada, 26)])).
viajero(gorbag, guerrera(orco, [(ballesta, 24)])).
viajero(ugluk, guerrera(uruk-hai,[(espada,26),(arco,22)])).
% parte C - 
%viajero(Nombre, pacifista(Raza, Edad)).
viajero(frodo, pacifista(hobbit, 51)).
viajero(sam, pacifista(hobbit, 36)).
viajero(barbol, pacifista(ent, 5300)).
%% Punto 3
% parte A - 
razaViajero(Persona,maiar):- viajero(Persona, maiar(_,_)).
razaViajero(Persona,Raza):- viajero(Persona, guerrera(Raza,[_])).
razaViajero(Persona,Raza):- viajero(Persona, pacifista(Raza,[_])).
% parte B - 
armaViajero(Persona,baston):- viajero(Persona, maiar(_,_)).
armaViajero(Persona,daga):- viajero(Persona, pacifista(hobbit, Edad)), Edad =< 50.
armaViajero(Persona,espadaCorta):- viajero(Persona, pacifista(hobbit, Edad)), Edad > 50.
armaViajero(Persona,fuerza):- viajero(Persona, pacifista(ent, _)).
armaViajero(Persona,Arma):- viajero(Persona, guerrera(_, ListaArmas)), armaGuerrera(Arma,ListaArmas).
armaGuerrera(Arma,ListaArmas):- member((Arma,_),ListaArmas).
% parte C - 
nivelViajero(Persona, Nivel):- viajero(Persona, maiar(Nivel, _)).
nivelViajero(Persona, Nivel):- viajero(Persona, guerrera(_,_,Nivel)), 
    findall(Level, viajero(Persona, guerrera(_, _, Level)),ListaLevel), 
    max_member(Nivel,ListaLevel).
nivelViajero(Persona, Nivel):- viajero(Persona, pacifista(hobbit, Edad)), Nivel is Edad / 4.
nivelViajero(Persona, Nivel):- viajero(Persona, pacifista(ent, Edad)), Nivel is Edad / 100.
%% Punto 4
% parte A - 
grupo([Integrante1,Integrante2]):- viajero(Integrante1,_), viajero(Integrante2,_), Integrante1 \= Integrante2.
grupo(Grupo):- forall(member(Integrante,Grupo), viajero(Integrante,_)).
% parte B - 
zonaRequerimiento(minasTirith, integrante(maiar, 25)).
zonaRequerimiento(moria, elemento(armaduraMithril, 1)).
zonaRequerimiento(isengard, integrante(maiar, 27)).
zonaRequerimiento(isengard, magia(280)).
zonaRequerimiento(abismoDeHelm, integrante(elfo, 28)).
zonaRequerimiento(abismoDeHelm, integrante(enano, 20)).
zonaRequerimiento(abismoDeHelm, integrante(maiar, 25)).
zonaRequerimiento(abismoDeHelm, magia(200)).
zonaRequerimiento(sagrario, elemento(anduril, 1)).
zonaRequerimiento(minasMorgul, elemento(lembas, 2)).
zonaRequerimiento(minasMorgul, elemento(luzEärendil, 1)).

tiene(sam, lembas).
tiene(sam, lembas).
tiene(sam, lembas).
tiene(gandalf, sombraGris).
tiene(frodo, armaduraMithril).
tiene(frodo, luzEärendil).
tiene(frodo, lembas).
tiene(frodo, capaElfica).
tiene(sam, capaElfica).
tiene(legolas, capaElfica).
tiene(aragorn, capaElfica).
tiene(aragorn, anduril).

cumpleRequerimiento(RequerimientoZona, Grupo):- grupo(Grupo), zonaRequerimiento(_, RequerimientoZona), integranteCumple(RequerimientoZona, Grupo).
integranteCumple(integrante(Raza, NivelMinimo), Grupo):-
    member(Miembro, Grupo), razaViajero(Miembro, Raza), nivelViajero(Miembro, Nivel), Nivel >= NivelMinimo.
integranteCumple(elemento(Elemento, CantidadMinima), Grupo):-
    findall(Elemento, (member(Miembro, Grupo), tiene(Miembro, Elemento)), ListaElemento), length(ListaElemento, Cant), Cant >= CantidadMinima.
integranteCumple(magia(PoderTotalMinimo), Grupo):-
    member(Miembro, Grupo), viajero(Miembro, maiar(_, PoderMagico)), PoderMagico >= PoderTotalMinimo.
%% Punto 5
% parte A - 

zona(Zona):-perteneceA(Zona,_).
puedeAtravesar(Zona,Grupo):-zona(Zona), grupo(Grupo), forall(zonaRequerimiento(Zona,Requerimiento), cumpleRequerimiento(Requerimiento,Grupo)).

% parte B - 
seSientenComoEnCasa(Grupo, Region):- forall(perteneceA(Zona,Region), puedeAtravesar(Zona,Grupo)).