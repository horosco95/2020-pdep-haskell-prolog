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

--Punto 1
costoReparacion :: Auto -> Int
costoReparacion auto | esPatenteNueva.patente $ auto = 12500
                     | estaEntre "DJ" "NB" . patente $ auto = calculoPatental.patente $ auto
                     | otherwise = 15000

estaEntre :: Patente -> Patente -> Patente -> Bool
estaEntre cotaInf cotaSup unaPatente = ((cotaInf<=).dosPrimerosPatente) unaPatente && ((cotaSup>=).dosPrimerosPatente) unaPatente

esPatenteNueva :: Patente -> Bool
esPatenteNueva  = (==7).length

dosPrimerosPatente :: Patente -> String
dosPrimerosPatente patente = take 2 patente

calculoPatental :: Patente->Int
calculoPatental patenteAuto | terminaEn '4' patenteAuto = ((3000*).length) patenteAuto
                            | otherwise = 20000
terminaEn ::  Char -> Patente -> Bool
terminaEn caracter = (caracter==).last

--Punto 2
--parte 1 - (Gonzalo)

esAutoPeligroso::Auto -> Bool
esAutoPeligroso = (>0.5).head.desgasteLlantas

--parte 2 - (Hermes)
necesitaRevision :: Auto -> Bool
necesitaRevision = (<=2015).anio.ultimoArreglo


--Punto 3

type Mecanico = Auto -> Auto


--parte 1 - (Gonzalo)
alfa :: Mecanico
alfa = regularVueltas

bravo :: Mecanico
bravo = cambioLlantas

charly :: Mecanico
charly = alfa.bravo

regularVueltas :: Auto -> Auto
regularVueltas auto = auto {rpm = min 2000 (rpm auto)}                      

cambioLlantas :: Auto -> Auto
cambioLlantas auto = auto {desgasteLlantas = (\[_,_,_,_]-> replicate 4 0) (desgasteLlantas auto)}


--parte 2 - (Hermes)
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