import Text.Show.Functions
type Desgaste = Float
type Patente = String
type Fecha = (Int, Int, Int)

-- Definiciones base
anio :: Fecha -> Int
anio (_, _, year) = year

data Auto = Auto {
  patente :: Patente,
  desgasteLlantas :: [Desgaste],
  rpm :: Int,
  temperaturaAgua :: Int,
  ultimoArreglo :: Fecha
} deriving Show

costoReparacion :: Auto -> Int
costoReparacion auto | esPatenteNueva.patente $ auto = 12500
                     | estaEntre "DJ" "NB" . patente $ auto = calculoPatental.patente $ auto
                     | otherwise = 15000

estaEntre :: Patente -> Patente -> Patente -> Bool
estaEntre cotaInf cotaSup unaPatente = ((cotaInf<=).take 2) unaPatente && ((cotaSup>=).take 2) unaPatente

esPatenteNueva :: Patente -> Bool
esPatenteNueva  = (==7).length

calculoPatental :: Patente->Int
calculoPatental patenteAuto | terminaEn '4' patenteAuto = ((3000*).length) patenteAuto
                            | otherwise = 20000
terminaEn ::  Char -> Patente -> Bool
terminaEn caracter = (caracter==).last

esAutoPeligroso::Auto -> Bool
esAutoPeligroso = (>0.5).head.desgasteLlantas

necesitaRevision :: Auto -> Bool
necesitaRevision = (<=2015).anio.ultimoArreglo

type Mecanico = Auto -> Auto
alfa :: Mecanico
alfa = regularVueltas

bravo :: Mecanico
bravo = cambioLlantas

charly :: Mecanico
charly = alfa.bravo

regularVueltas :: Auto -> Auto
regularVueltas auto | (>2000) (rpm auto) = auto {rpm = 2000}
                    | otherwise = auto
cambioLlantas :: Auto -> Auto
cambioLlantas auto = auto {desgasteLlantas = (\[_,_,_,_]->[0,0,0,0]) (desgasteLlantas auto)}

tango :: Mecanico
tango vehiculo = vehiculo

zulu :: Mecanico
zulu  = lima.aguaA90Grados

lima :: Mecanico
lima  = cambio2Llantas

aguaA90Grados :: Auto -> Auto
aguaA90Grados vehiculo = vehiculo {temperaturaAgua = 90}
cambio2Llantas :: Auto -> Auto
cambio2Llantas vehiculo = vehiculo {desgasteLlantas = (\[_,_,c,d]->[0,0,c,d]) (desgasteLlantas vehiculo)}

--Punto 4
estanOrdenadosPorDesgaste :: [Auto] -> Bool
estanOrdenadosPorDesgaste  autos = all ordenadosDesgasteParOImpar . ordenarAutosSegunPosicion $ autos

ordenarAutosSegunPosicion :: [Auto] -> [(Int, Auto)]
ordenarAutosSegunPosicion autos = zip [1..] autos

ordenadosDesgasteParOImpar :: (Int, Auto) -> Bool
ordenadosDesgasteParOImpar (pos,auto) | estaEnPosicionPar (pos,auto) = (tieneDesgaste even) . desgasteLlantas $ auto
                                      | otherwise = (tieneDesgaste odd) . desgasteLlantas $ auto

estaEnPosicionPar :: (Int, Auto) -> Bool
estaEnPosicionPar (pos,_)= even pos

tieneDesgaste :: (Int -> Bool) -> [Desgaste] -> Bool
tieneDesgaste condicion desgasteAuto = condicion.calcularDesgaste $ desgasteAuto

calcularDesgaste :: [Desgaste] -> Int
calcularDesgaste = round.(10*).sum

--Punto 5

aplicarOrdenReparacion :: OrdenReparacion -> Auto -> Auto
aplicarOrdenReparacion unaOrden auto = actualizarFecha (fecha unaOrden) . reparaciones (tecnicos unaOrden) $ auto

data OrdenReparacion = UnaOrdenReparacion {
  fecha :: Fecha,
  tecnicos :: [Mecanico]
} deriving Show
prepararOrdenReparacion :: Fecha -> [Mecanico] -> OrdenReparacion
prepararOrdenReparacion unaFecha listaTecnicos = UnaOrdenReparacion {fecha=unaFecha,tecnicos=listaTecnicos}

reparaciones :: [Mecanico] -> Auto -> Auto
reparaciones tecnicos auto = foldl (flip ($)) auto tecnicos

actualizarFecha :: Fecha -> Auto -> Auto
actualizarFecha unaFecha unAuto= unAuto {ultimoArreglo = unaFecha} 

--Punto 6
--parte 1 - Gonzalo

mecanicosQueDejanAutoEnCondiciones :: Auto -> [Mecanico] -> [Mecanico]
mecanicosQueDejanAutoEnCondiciones coche  listaMecanicos =  (filtrarMecanicos coche) $ listaMecanicos

filtrarMecanicos :: Auto -> [Mecanico] -> [Mecanico]
filtrarMecanicos coche listaMecanicos = filter (\unElem -> not.esAutoPeligroso.unElem $ coche) listaMecanicos

--parte 2 - Hermes

costoReparacionAutosConRevision :: [Auto] -> Int
costoReparacionAutosConRevision listaAutos = sumarCostoReparacionPorAuto.filtrarAutosNecesitenRevision $ listaAutos

sumarCostoReparacionPorAuto :: [Auto] -> Int
sumarCostoReparacionPorAuto = sum.map costoReparacion

filtrarAutosNecesitenRevision :: [Auto] -> [Auto]
filtrarAutosNecesitenRevision = filter (necesitaRevision)

--Punto 7
tecnicosInfinitos :: [Mecanico]
tecnicosInfinitos = zulu:tecnicosInfinitos

autosInfinitos :: [Auto]
autosInfinitos = autosInfinitos' 0

autosInfinitos' :: Float -> [Auto]
autosInfinitos' n = Auto {
 patente = "AAA000",
 desgasteLlantas = [n, 0, 0, 0.3],
 rpm = 1500 + round n,
 temperaturaAgua = 90,
 ultimoArreglo = (20, 1, 2013)
} : autosInfinitos' (n + 1)
--parte 1 - Gonzalo

mecanicosQueDejanAutoEnCondicionesPrimero coche listaMecanicos = head.(filtrarMecanicos coche) $ listaMecanicos

--parte 2 - Hermes

costoReparacionAutosConRevisionPrimeros3 :: [Auto] -> Int
costoReparacionAutosConRevisionPrimeros3 listaAutos = sumarCostoReparacionPorAuto.take 3.filtrarAutosNecesitenRevision $ listaAutos