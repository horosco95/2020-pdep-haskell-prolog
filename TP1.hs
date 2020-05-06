type Desgaste = Number
type Patente = String
type Fecha = (Number, Number, Number)

-- Definiciones base
anio :: Fecha -> Number
anio (_, _, year) = year

data Auto = Auto {
  patente :: Patente,
  desgasteLlantas :: [Desgaste],
  rpm :: Number,
  temperaturaAgua :: Number,
  ultimoArreglo :: Fecha
} deriving Show

--Punto 1



--Punto 2
--parte 1 - (Integrante A)



--parte 2 - (Integrante B)



--Punto 3
--parte 1 - (Integrante A)



--parte 2 - (Integrante B)
