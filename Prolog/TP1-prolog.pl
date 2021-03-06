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
regionesLejanas(Region1,Region2):- region(Region1),region(Region2), Region1\=Region2,sonLejanas(Region1,Region2).

sonLejanas(Region1,Region2):- not(regionesLimitrofes(Region1,Region2)),
    not(terceraRegionLimitrofeConAmbas(Region1,Region2)),Region1\=Region2.

terceraRegionLimitrofeConAmbas(UnaRegion,OtraRegion):- regionesLimitrofes(UnaRegion,OtraEnComun),regionesLimitrofes(OtraEnComun,OtraRegion),UnaRegion\=OtraRegion.
%%Generador de Regiones:
region(Region):- perteneceA(_,Region).

%% Punto 5
% parte A - 

puedeSeguirCon(Camino,Zona):-last(Camino,Ultimo), zonasLimitrofes(Zona,Ultimo).
    
% parte B -
sonConsecutivos(Camino1,[Zona|_]):- puedeSeguirCon(Camino1,Zona).

%% Punto 6
% parte A - 
caminoLogico([_]).
caminoLogico([Zona1,Zona2|Cola]):- zonasLimitrofes(Zona1,Zona2), caminoLogico([Zona2|Cola]).

% parte B -
caminoSeguro([_]).
caminoSeguro([_,_]).
caminoSeguro([Zona1,Zona2,Zona3|Cola]):-tramoSeguro(Zona1,Zona2,Zona3), caminoSeguro([Zona2,Zona3|Cola]).

tramoSeguro(Zona1,Zona2,Zona3):- not((perteneceA(Zona1,Region),perteneceA(Zona2,Region),perteneceA(Zona3,Region))).

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
razaViajero(Persona,Raza):- viajero(Persona, guerrera(Raza,_)).
razaViajero(Persona,Raza):- viajero(Persona, pacifista(Raza,_)).
% parte B - 
armaViajero(Persona,baston):- viajero(Persona, maiar(_,_)).
armaViajero(Persona,daga):- viajero(Persona, pacifista(hobbit, Edad)), Edad =< 50.
armaViajero(Persona,espadaCorta):- viajero(Persona, pacifista(hobbit, Edad)), Edad > 50.
armaViajero(Persona,fuerza):- viajero(Persona, pacifista(ent, _)).
armaViajero(Persona,ListaArmas):- viajero(Persona, guerrera(_, ListaArmasNivel)), findall(Arma, armaGuerrera(Arma,ListaArmasNivel), ListaArmas).
armaGuerrera(Arma,ListaArmas):- member((Arma,_),ListaArmas).
% parte C - 
nivelViajero(Persona, Nivel):- viajero(Persona, maiar(Nivel, _)).
nivelViajero(Persona, Nivel):- viajero(Persona, guerrera(_, ListaArmasNivel)),
    nivelGuerrera(Nivel,ListaArmasNivel),
    forall(nivelGuerrera(Otros,ListaArmasNivel), Otros=<Nivel).
nivelGuerrera(Nivel,ListaArmasNivel):- member((_,Nivel),ListaArmasNivel).	
nivelViajero(Persona, Nivel):- viajero(Persona, pacifista(hobbit, Edad)), Nivel is Edad / 4.
nivelViajero(Persona, Nivel):- viajero(Persona, pacifista(ent, Edad)), Nivel is Edad / 100.
%% Punto 4
% parte A - 
grupo(Integrantes):- permutation(Integrantes,Miembros), findall(Integrante, viajero(Integrante,_),Viajeros),
    gruposPosibles(Viajeros,Miembros), length(Miembros, Cant), Cant >= 1.

gruposPosibles([], []).
gruposPosibles([Posible|Resto], [Posible|Integrantes]):- viajero(Posible,_), gruposPosibles(Resto, Integrantes).
gruposPosibles([_|Resto],Integrantes):- gruposPosibles(Resto,Integrantes).
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
zonaRequerimiento(minasMorgul, elemento(luzE??rendil, 1)).

tiene(sam, lembas).
tiene(sam, lembas).
tiene(sam, lembas).
tiene(gandalf, sombraGris).
tiene(frodo, armaduraMithril).
tiene(frodo, luzE??rendil).
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
    poderMagicoGrupo(Grupo, Cantidad), Cantidad > PoderTotalMinimo.

poderMagicoGrupo(Grupo, PoderMagicoTotal):-
   	findall(PoderMagico, (member(Miembro, Grupo),magia(Miembro, PoderMagico)), ListaPoderMagico), sumlist(ListaPoderMagico,PoderMagicoTotal).
magia(Integrante, PoderMagico):- razaViajero(Integrante,elfo), nivelViajero(Integrante, Nivel), PoderMagico is Nivel * 2.
magia(Integrante, PoderMagico):- razaViajero(Integrante,Raza), member(Raza,[dunedain,enano]), nivelViajero(Integrante, PoderMagico).
magia(Integrante, PoderMagico):- razaViajero(Integrante,maiar), viajero(Integrante, maiar(_,PoderMagico)).
magia(Integrante, 0):- razaViajero(Integrante,Raza), not(member(Raza,[elfo,dunedain,enano,maiar])).
%% Punto 5
% parte A - 

zona(Zona):-perteneceA(Zona,_).
puedeAtravesar(Zona,Grupo):-zona(Zona), grupo(Grupo), forall(zonaRequerimiento(Zona,Requerimiento), cumpleRequerimiento(Requerimiento,Grupo)).

% parte B - 
seSientenComoEnCasa(Grupo, Region):- perteneceA(_,Region), grupo(Grupo),
    forall(perteneceA(Zona,Region), puedeAtravesar(Zona,Grupo)).