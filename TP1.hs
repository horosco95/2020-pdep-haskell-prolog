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
costoReparacion:: Auto -> Int
costoReparacion auto | ((7==).length) (patente auto) = 12500
                     | "DJ"<= (patente auto) && (patente auto) <="NB" = calculoPatental (patente auto)
                     | otherwise = 15000

calculoPatental::Patente->Int
calculoPatental patenteAuto | (('4'==).last) patenteAuto = ((3000*).length) patenteAuto
                            | otherwise = 20000

--Punto 2
--parte 1 - (Integrante A)

esAutoPeligroso::Auto -> Bool
esAutoPeligroso = (>0.5).head.desgasteLlantas

--parte 2 - (Integrante B)
necesitaRevision :: Auto -> Bool
necesitaRevision = (<=2015).anio.ultimoArreglo
--Punto 3
--parte 1 - (Integrante A)



--parte 2 - (Integrante B)
data Empleado = Empleado {
 nombre :: String,
 edad :: Int,
 funciones::(Auto->Auto)
} deriving Show

tango :: Empleado
tango = Empleado {nombre="Tango", edad=31, funciones = nada}

zulu :: Empleado
zulu = Empleado {nombre="Zulu", edad=40, funciones = (funciones lima).aguaA90Grados}

lima :: Empleado
lima = Empleado {nombre="Lima", edad=28, funciones = cambio2Llantas}

operaciones::Empleado->Auto->Auto
operaciones mecanico auto= (funciones mecanico) auto

nada :: Auto -> Auto
nada vehiculo= vehiculo
aguaA90Grados :: Auto -> Auto
aguaA90Grados vehiculo = vehiculo {temperaturaAgua = 90}
cambio2Llantas :: Auto -> Auto
cambio2Llantas vehiculo = vehiculo {desgasteLlantas = (\[_,_,c,d]->[0,0,c,d]) (desgasteLlantas vehiculo)}