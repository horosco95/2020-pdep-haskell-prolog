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



% parte B - 



%% Punto 5
% parte A - 



% parte B -



%% Punto 6
% parte A - 



% parte B -

