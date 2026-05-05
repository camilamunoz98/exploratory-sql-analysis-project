-- PLEASE READ THIS BEFORE RUNNING THE EXERCISE

-- ⚠️ IMPORTANT: This SQL file may crash due to two common issues: comments and missing semicolons.

-- ✅ Suggestions:
-- 1) Always end each SQL query with a semicolon `;`
-- 2) Ensure comments are well-formed:
--    - Use `--` for single-line comments only
--    - Avoid inline comments after queries
--    - Do not use `/* */` multi-line comments, as they may break execution

-- -----------------------------------------------
-- queries.sql
-- Complete each mission by writing your SQL query
-- directly below the corresponding instruction
-- -----------------------------------------------


--NIVEL 1– Exploración básica (SELECT, LIMIT, DISTINCT, WHERE)

-- 1. ¿Cuáles son las primeras 10 observaciones registradas?

SELECT *
FROM observations
LIMIT 10;

-- 2.¿Qué identificadores de región (region_id) aparecen en los datos?

SELECT DISTINCT region_id
FROM observations;


--3. ¿Cuántas especies distintas (species_id) se han observado?
--Combina COUNT con DISTINCT para no contar duplicados.

SELECT COUNT(DISTINCT species_id) AS especies_distintas
FROM observations;

-- 4. ¿Cuántas observaciones hay para la región con region_id = 2?

SELECT *
FROM observations
WHERE region_id = 2;

-- 5. ¿Cuántas observaciones se registraron el día 1998-08-08?
--Filtra por fecha exacta usando igualdad.

SELECT *
FROM observations
WHERE observation_date = '1998-08-08';



-- NIVEL 2 – Agregación y ordenamiento (GROUP BY, COUNT, ORDER BY, HAVING sin JOIN)

-- 6.¿Cuál es el region_id con más observaciones?
--Agrupa por región y cuenta cuántas veces aparece cada una.

SELECT region_id, COUNT(*) AS total_observaciones
FROM observations
GROUP BY region_id
ORDER BY total_observaciones DESC;

-- 7. ¿Cuáles son los 5 species_id más frecuentes?
--Agrupa, ordena por cantidad descendente y limita el resultado.

SELECT species_id, COUNT (*) AS especies_frecuentes
FROM observations
GROUP BY species_id
ORDER BY especies_frecuentes DESC
LIMIT 5;

-- 8. ¿Qué especies (species_id) tienen menos de 5 registros?
-- Agrupa por especie y usa HAVING para aplicar una condición.

SELECT species_id, COUNT(*) AS conteo_registros
FROM observations
GROUP BY species_id
HAVING conteo_registros < 5
ORDER BY conteo_registros ASC;


-- 9. ¿Qué observadores (observer) registraron más observaciones?
-- Agrupa por el nombre del observador y cuenta los registros.


SELECT observer, COUNT(*) AS total
FROM observations
GROUP BY observer
ORDER BY total DESC;


-- NIVEL 3 – Relaciones entre tablas (JOIN)

-- 10. Muestra el nombre de la región (regions.name) para cada observación.
-- Relaciona observations con regions usando region_id.

SELECT observations.id, regions.name AS region_name, observations.observation_date
FROM observations
JOIN regions ON  observations.region_id = regions.id;


-- 11. Muestra el nombre científico de cada especie registrada (species.scientific_name).
-- Relaciona observations con species usando species_id.

SELECT observations.id, species.scientific_name
FROM observations
JOIN species ON observations.species_id = species.id;


-- 12. ¿Cuál es la especie más observada por cada región?
-- Agrupa por región y especie, y ordena por cantidad.

SELECT regions.name, species.scientific_name, COUNT(*) AS total
FROM observations
JOIN species ON observations.species_id = species.id
JOIN regions ON observations.region_id = regions.id
GROUP BY regions.name, species.scientific_name
ORDER BY regions.name, total DESC;


-- NIVEL 4 (opcional) – Manipulación de datos

-- 13. Inserta una nueva observación ficticia en la tabla observations.
--Asegúrate de incluir todos los campos requeridos por el esquema.

INSERT INTO observations ( 
    species_id, 
    region_id, 
    observer, 
    observation_date, 
    count
)
VALUES (
    34,
     5,
    'obsr160498',
    '2026-05-05',
     3
);


-- 14. Corrige el nombre científico de una especie con error tipográfico.
-- Busca primero el nombre incorrecto y luego actualízalo.

UPDATE species
SET scientific_name = 'Cacatua galerita'
WHERE scientific_name = 'Cacatua Galerita';


-- 15. Elimina una observación de prueba (usa su id).
-- Asegúrate de no borrar datos importantes.
DELETE FROM observations
WHERE id = 124;
