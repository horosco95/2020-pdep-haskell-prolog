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
                     | (("DJ"<=).take 2) (patente auto) && (("NB">=).take 2) (patente auto) = calculoPatental (patente auto)
                     | otherwise = 15000

calculoPatental::Patente->Int
calculoPatental patenteAuto | (('4'==).last) patenteAuto = ((3000*).length) patenteAuto
                            | otherwise = 20000

--Punto 2
--parte 1 - (Gonzalo)

esAutoPeligroso::Auto -> Bool
esAutoPeligroso = (>0.5).head.desgasteLlantas

--parte 2 - (Hermes)
necesitaRevision :: Auto -> Bool
necesitaRevision = (<=2015).anio.ultimoArreglo


--Punto 3
data Empleado = Empleado {
 nombre :: String,
 edad :: Int,
 funciones::(Auto->Auto)
} deriving Show

operaciones::Empleado->Auto->Auto
operaciones mecanico auto= (funciones mecanico) auto

--parte 1 - (Gonzalo)

alfa :: Empleado
alfa = Empleado {nombre="Alfa", edad=28, funciones = regularVueltas}

bravo :: Empleado
bravo = Empleado {nombre="Bravo", edad=30, funciones = cambioLlantas}

charly :: Empleado
charly = Empleado {nombre="Charly", edad=35, funciones = ((funciones alfa).(funciones bravo))}

regularVueltas :: Auto -> Auto
regularVueltas auto | (>2000) (rpm auto) = auto {rpm = 2000}
                    | otherwise = auto

cambioLlantas :: Auto -> Auto
cambioLlantas auto = auto {desgasteLlantas = (\[_,_,_,_]->[0,0,0,0]) (desgasteLlantas auto)}


--parte 2 - (Hermes)

tango :: Empleado
tango = Empleado {nombre="Tango", edad=31, funciones = nada}

zulu :: Empleado
zulu = Empleado {nombre="Zulu", edad=40, funciones = (funciones lima).aguaA90Grados}

lima :: Empleado
lima = Empleado {nombre="Lima", edad=28, funciones = cambio2Llantas}



nada :: Auto -> Auto
nada vehiculo= vehiculo
aguaA90Grados :: Auto -> Auto
aguaA90Grados vehiculo = vehiculo {temperaturaAgua = 90}
cambio2Llantas :: Auto -> Auto
cambio2Llantas vehiculo = vehiculo {desgasteLlantas = (\[_,_,c,d]->[0,0,c,d]) (desgasteLlantas vehiculo)}