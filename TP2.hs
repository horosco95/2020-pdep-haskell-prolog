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

estaEnOrden :: [Auto] -> Bool

estaEnOrden [] = True
estaEnOrden [x] = sumaImpar x
estaEnOrden (x:y:xs) = (sumaImpar.desgasteLlantas $ x)  && (sumaPar.desgasteLlantas $ y) && (estaEnOrden xs)  

sumaPar :: Integer -> Bool
sumarPar = even sumaDesgaste

sumaImpar :: Integer -> Bool
sumaImpar = odd sumaDesgaste

sumaDesgaste :: [Float] -> Integer
sumaDesgaste = (10*.sum) desgasteLlantas


--Punto 5



--Punto 6
--parte 1 - Integrante a



--parte 2 - Integrante b


--Punto 7
--parte 1 - Integrante a


--parte 2 - Integrante b