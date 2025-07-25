SELECT * FROM detenidos;
SELECT * FROM Provincias;
SELECT * FROM Cantones;
SELECT * FROM Parroquias;

-- Agregar columna para primary key
ALTER TABLE detenidos
ADD COLUMN id_detenido INT UNSIGNED AUTO_INCREMENT PRIMARY KEY;

-- Creacion de tabla detenidos_copy para manipular los datos
DROP TABLE IF EXISTS detenidos_copy;
CREATE TABLE detenidos_copy AS
    SELECT * FROM detenidos;

-- Agregar primary key
ALTER TABLE detenidos_copy
ADD PRIMARY KEY (id_detenido);

SELECT * FROM detenidos_copy;

-- Agregar un 0 para corregiir datos de id
UPDATE detenidos_copy
SET codigo_provincia = LPAD(codigo_provincia, 2, '0');

-- Crear la tabla provincias_copy para manipular los datos
drop table if exists provincias_copy;
CREATE TABLE provincias_copy AS
SELECT DISTINCT(codigo_provincia), nombre_provincia, Poblacion, `Area-km2`, `Densidad_poblacional-personas_por_km2`
FROM detenidos_copy LEFT JOIN Provincias
ON nombre_provincia = Provincia_de_residencia;

SELECT * FROM provincias_copy;

-- Actualizar el valor de una columna con valor null
UPDATE provincias_copy
SET `Area-km2` = '1,060,053'
WHERE codigo_provincia = '00';

-- Cambiar el tipo de dato de la columna para dar primary key
ALTER TABLE provincias_copy
MODIFY codigo_provincia INT NULL;

-- Agregar primary key a la tabla de provincias
ALTER TABLE provincias_copy
ADD PRIMARY KEY (codigo_provincia);

-- Agregar un 0 para corregiir datos de id
UPDATE detenidos_copy
SET codigo_canton = LPAD(codigo_canton, 4, '0');

SELECT * FROM Cantones;

UPDATE detenidos_copy
SET nombre_canton = 'Francisco de Orellana'
WHERE codigo_canton = '2201';

UPDATE detenidos_copy
SET nombre_canton = 'Rumiñahui'
WHERE codigo_canton = '1705';

UPDATE Cantones
SET Canton = 'LA TRONCAL'
WHERE Canton = 'TRONCAL';

UPDATE detenidos_copy
SET nombre_canton = 'LA TRONCAL'
WHERE codigo_canton = '0304';

UPDATE detenidos_copy
SET nombre_provincia = 'CAÑAR'
WHERE codigo_canton = '0304';

UPDATE Cantones
SET Canton = 'QUITO'
WHERE Canton = 'Distrito Metropolitano De Quito';

UPDATE Cantones
SET Canton = 'La Concordia'
WHERE Canton = 'Concordia';

UPDATE detenidos_copy
SET nombre_provincia = 'SANTO DOMINGO DE LOS TSACHILAS'
WHERE codigo_canton = '0808';

UPDATE detenidos_copy
SET codigo_canton = '2302'
WHERE codigo_canton = '0808';

UPDATE detenidos_copy
SET nombre_canton = 'EL EMPALME'
WHERE codigo_canton = '0908';

UPDATE detenidos_copy
SET nombre_canton = 'CORONEL MARCELINO MARIDUEÑA'
WHERE codigo_canton = '0923';

UPDATE Cantones
SET Canton = 'ALFREDO BAQUERIZO MORENO'
WHERE Canton = 'ALFREDO BAQUERIZO MORENO (Juján)';

UPDATE detenidos_copy
SET nombre_canton = 'GENERAL ANTONIO ELIZALDE'
WHERE codigo_canton = '0927';

UPDATE Cantones
SET Canton = 'GENERAL ANTONIO ELIZALDE'
WHERE Canton = 'GENERAL  ANTONIO ELIZALDE';

UPDATE detenidos_copy
SET nombre_canton = 'LOGROÑO'
WHERE codigo_canton = '1410';

UPDATE detenidos_copy
SET codigo_provincia = '23'
WHERE codigo_canton = '2302';

drop table if exists cantones_copy;
CREATE TABLE cantones_copy AS
SELECT DISTINCT (codigo_canton), codigo_provincia, nombre_canton, Poblacion, `Area-km2`, `Densidad_poblacional-personas_por_km2`
FROM detenidos_copy LEFT JOIN Cantones ON nombre_provincia = Provincia
    AND nombre_canton = Canton;

SELECT * FROM cantones_copy;

UPDATE cantones_copy
SET `Area-km2` = '1,060,053'
WHERE codigo_provincia = '00';

ALTER TABLE cantones_copy
MODIFY codigo_provincia int null,
MODIFY codigo_canton int null;

ALTER TABLE cantones_copy
ADD PRIMARY KEY (codigo_canton);

ALTER TABLE cantones_copy
ADD CONSTRAINT provincia_fk
FOREIGN KEY (codigo_provincia)
REFERENCES provincias_copy(codigo_provincia);

--

UPDATE Parroquias
SET Canton = 'QUITO'
WHERE Canton = 'Distrito Metropolitano De Quito';

UPDATE detenidos_copy
SET codigo_parroquia = LPAD(codigo_parroquia, 6, '0');

UPDATE detenidos_copy
SET nombre_parroquia = REGEXP_REPLACE(nombre_parroquia, '\\s*\\([^)]*\\)', '');

UPDATE detenidos_copy
SET nombre_parroquia = REGEXP_REPLACE(nombre_parroquia, 'gral\\.|gnrl\\.|g\\.?n\\.?r\\.?l\\.?', 'GENERAL');

UPDATE detenidos_copy
SET nombre_parroquia = REGEXP_REPLACE(nombre_parroquia, 'crnel\\.?|cnl\\.?|c\\.?r\\.?n\\.?l\\.?', 'CORONEL');

UPDATE detenidos_copy
SET nombre_parroquia = REGEXP_REPLACE(nombre_parroquia, 'tnte\\.?|tte\\.?|t\\.?n\\.?t\\.?e\\.?', 'TENIENTE');

UPDATE detenidos_copy
set nombre_parroquia = 'San Francisco De Natabuela'
where codigo_parroquia = '100252';

UPDATE Parroquias
SET Parroquia = 'GENERAL LEONIDAS PLAZA GUTIERREZ'
where Parroquia = 'Gral. Leonidas Plaza Gutiérrez';

UPDATE Parroquias
set Parroquia = 'Alfredo Baquerizo Moreno'
where Parroquia = 'Alfredo Baquerizo Moreno (Juján)';

UPDATE Parroquias
set Canton = 'Alfredo Baquerizo Moreno'
where Canton = 'Alfredo Baquerizo Moreno (Juján)';

UPDATE detenidos_copy
SET nombre_parroquia = 'BELLA VISTA'
WHERE codigo_parroquia = '200351';

UPDATE Parroquias
set Parroquia = 'Doctor Miguel Egas Cabezas'
where Parroquia = 'Dr. Miguel Egas Cabezas';

UPDATE detenidos_copy
set nombre_parroquia = 'LA TRONCAL'
WHERE codigo_parroquia = '030450';

UPDATE detenidos_copy
SET nombre_parroquia = 'Picaihua'
where codigo_parroquia = '180160';

update Parroquias
set Canton = 'General Antonio Elizalde'
where Canton = 'General  Antonio Elizalde';

UPDATE Parroquias
set Parroquia = '11 DE NOVIEMBRE'
WHERE Parroquia = 'Once De Noviembre';

update detenidos_copy
set nombre_parroquia = 'Guaytacama'
where codigo_parroquia = '050153';

update Parroquias
set Parroquia = 'Magdalena'
where Parroquia = 'La magdalena';

update Parroquias
set Parroquia = 'Gima'
where Parroquia = 'jima';

update detenidos_copy
set nombre_parroquia = 'Puerto Cayo'
where codigo_parroquia = '130658';

update detenidos_copy
set nombre_parroquia = 'Coronel Lorenzo De Garaycoa'
where codigo_parroquia = '092251';

update detenidos_copy
set nombre_parroquia = 'La Asuncion'
where codigo_parroquia = '010251';

update detenidos_copy
set nombre_parroquia = 'TRIUNFO DORADO'
where codigo_parroquia = '190752';

update detenidos_copy
set nombre_parroquia = 'Alaquez'
where codigo_parroquia = '050151';

update detenidos_copy
set nombre_parroquia = 'Tuutinentsa'
where codigo_parroquia = '140953';

update detenidos_copy
set nombre_parroquia = 'Puerto El Carmen De Putumayo'
where codigo_parroquia = '210350';

update detenidos_copy
set nombre_parroquia = 'San Bartolomé De Pinllo'
where codigo_parroquia = '180163';

update detenidos_copy
set nombre_parroquia = 'San Francisco De Sigsipamba'
where codigo_parroquia = '100553';

update detenidos_copy
set nombre_parroquia = 'San Gerardo'
where codigo_parroquia = '060755';

update detenidos_copy
set nombre_parroquia = 'Baños'
where codigo_parroquia = '180250';

update Parroquias
set Parroquia = '10 de Agosto'
where Parroquia = 'Diez De Agosto';

update Parroquias
set Parroquia = 'Diez De Agosto'
where Parroquia = '10 De Agosto'
AND Canton = 'Pastaza';

update detenidos_copy
set nombre_parroquia = 'El coca'
where codigo_parroquia = '220150';

update Parroquias
set Canton = 'CAMILO PONCE ENRIQUEZ'
where Parroquia = 'EL CARMEN DE PIJILI';

update detenidos_copy
set nombre_parroquia = 'EL CARMEN'
WHERE codigo_parroquia = '130450';

drop table parroquias_copy;

CREATE TABLE parroquias_copy AS
SELECT DISTINCT (codigo_parroquia), codigo_canton, nombre_parroquia, Poblacion, `Area-km2`, `Densidad_poblacional-personas_por_km2`
FROM detenidos_copy LEFT JOIN Parroquias ON nombre_parroquia = Parroquia
    AND nombre_canton = Canton
    AND nombre_provincia = Provincia;

SELECT * FROM
parroquias_copy;

UPDATE parroquias_copy
SET `Area-km2` = '1,060,053'
WHERE codigo_parroquia = 0;

ALTER TABLE parroquias_copy
MODIFY codigo_parroquia int null,
MODIFY codigo_canton int null;

ALTER TABLE parroquias_copy
ADD PRIMARY KEY (codigo_parroquia);

ALTER TABLE parroquias_copy
ADD CONSTRAINT canton_pk
FOREIGN KEY (codigo_canton)
REFERENCES cantones_copy(codigo_canton);

ALTER TABLE detenidos_copy DROP COLUMN nombre_parroquia,
    DROP COLUMN nombre_provincia,
    DROP COLUMN nombre_canton,
    DROP COLUMN codigo_canton,
    DROP COLUMN codigo_provincia;

ALTER TABLE detenidos_copy DROP COLUMN latitud,
    DROP COLUMN longitud;

ALTER TABLE detenidos_copy
MODIFY codigo_parroquia int null;

ALTER TABLE detenidos_copy
ADD CONSTRAINT parroquia_pk
FOREIGN KEY (codigo_parroquia)
REFERENCES parroquias_copy(codigo_parroquia);

SELECT * FROM detenidos_copy;