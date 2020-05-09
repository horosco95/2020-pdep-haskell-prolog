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



--Punto 2
--parte 1 - (Integrante A)



--parte 2 - (Integrante B)



--Punto 3
--parte 1 - (Integrante A)



--parte 2 - (Integrante B)
