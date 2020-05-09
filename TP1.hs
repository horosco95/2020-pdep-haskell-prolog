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
costoReparacion auto | (('7'==).length) patente auto = 12500
                     | "DJ"<= patente auto && patente auto <="NB" = calculoPatental (patente auto)
                     | otherwise = 15000

calculoPatental::Patente->Int
calculoPatental patenteAuto | (('4'==).last) patenteAuto = ((3000*).length) patenteAuto
                            | otherwise = 20000

--Punto 2
--parte 1 - (Integrante A)



--parte 2 - (Integrante B)


--Punto 3
--parte 1 - (Integrante A)



--parte 2 - (Integrante B)
