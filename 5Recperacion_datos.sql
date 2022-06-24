-- 1 Recupera el listado de todas las competiciones registradas en la base de datos.
-- SELECCIONA nombre_competicion COMO 'Nombre de la competicion' DESDE competicion;
SELECT nombre_competicion AS 'Nombre de la competición'FROM competicion;

-- 2 Recupera los países registrados en la base de datos, y sus correspondientes códigos de país.
SELECT id_pais AS 'Código', nombre_pais AS 'País' FROM pais;

-- 3 Recupera el listado de equipos cuyo nombre contiene la palabra “real”.
-- SELECCIONA nombre_equipo COMO 'Equipo' DESDE equipo DONDE nombre_equipo COMO(CONTENGA) 'real';
SELECT nombre_equipo AS 'Equipo' FROM equipo WHERE nombre_equipo LIKE '%real%';

-- 4 Recupera el listado de todos los equipos italianos.
SELECT id_pais AS 'País', nombre_equipo AS 'Equipo' FROM equipo WHERE id_pais = 'ITA';

-- 5 Recupera el listado de los equipos portugueses y franceses.
SELECT p.nombre_pais AS 'País', e.nombre_equipo AS 'Equipo' 
FROM equipo e INNER JOIN pais p ON (e.id_pais = p.id_pais) 
WHERE (p.nombre_pais = 'Portugal') OR (p.nombre_pais = 'Francia');

-- 6 Recupera  el  listado  de  los  equipos  portugueses  y  
-- franceses  ordenados  por  nombre de equipo y por país.
SELECT p.nombre_pais AS 'País', e.nombre_equipo AS 'Equipo'
FROM equipo e INNER JOIN pais p ON (e.id_pais = p.id_pais)
WHERE (p.nombre_pais = 'Portugal') OR (p.nombre_pais = 'Francia')
ORDER BY e.nombre_equipo ASC, p.nombre_pais ASC;

-- 7 Muestra el listado de temporadas de los años treinta de forma ordenada y 
-- con el formato “año de inicio-año de fin”
SELECT CONCAT(CAST(anyo_inicio AS CHAR(4)), ' - ', CAST(anyo_fin AS CHAR(4))) AS 'Temporada' 
FROM temporada 
WHERE anyo_inicio BETWEEN 1930 AND 1939 ORDER BY anyo_inicio ASC;

-- 8 Contabiliza el número de temporadas durante los años treinta.
SELECT COUNT(*) FROM temporada WHERE anyo_inicio BETWEEN 1930 AND 1939;

-- 9 Contabiliza el número de ligas españolas disputadas durante los años treinta.
SELECT COUNT(*) 
FROM campeonato camp 
    INNER JOIN temporada t ON (camp.id_temporada = t.id_temporada)
    INNER JOIN competicion c ON (camp.id_competicion = c.id_competicion)
WHERE (t.anyo_inicio BETWEEN 1930 AND 1939)
    AND (c.nombre_competicion = 'Liga española');

-- 10 Contabiliza  el  número  de  competiciones  de  copa  disputadas  durante  los  
-- años  treinta,independientemente del régimen político y del jefe de estado.
SELECT COUNT(*) FROM campeonato camp
    INNER JOIN temporada t ON (camp.id_temporada = t.id_temporada)
    INNER JOIN competicion c ON (camp.id_competicion = c.id_competicion)
    WHERE
    (t.anyo_inicio BETWEEN 1930 AND 1939)
    AND ((c.nombre_competicion = 'Copa de S. M. el Rey')
    OR (c.nombre_competicion = 'Copa del Presidente de la República')
    OR (c.nombre_competicion = 'Copa de S. E. El Generalísimo'));

-- 11 Recupera  el  nombre  de  las  competiciones  disputadas  durante  los  años  treinta,
-- así como el número total de títulos disputados de cada una.
SELECT c.nombre_competicion AS 'Competición',
COUNT(*) AS 'Títulos'
FROM campeonato camp
    INNER JOIN temporada t
        ON (camp.id_temporada = t.id_temporada)
    INNER JOIN competicion c
        ON (camp.id_competicion = c.id_competicion)
WHERE (t.anyo_inicio BETWEEN 1930 AND 1939)
GROUP BY c.nombre_competicion
ORDER BY c.nombre_competicion ASC;

    -- 12 Recupera el número de títulos por competición obtenidos por el Real Madrid 
    -- en la década de los años treinta.
SELECT c.nombre_competicion AS 'Competicion', COUNT(*) AS 'Títulos'
FROM campeonato camp
        INNER JOIN temporada t
            ON (camp.id_temporada = t.id_temporada)
        INNER JOIN competicion c
            ON (camp.id_competicion = c.id_competicion)
        INNER JOIN equipo e
            ON (camp.campeon = e.id_equipo)
WHERE (t.anyo_inicio BETWEEN 1930 AND 1939)AND (e.nombre_equipo = 'Real Madrid')
GROUP BY c.nombre_competicion
ORDER BY c.nombre_competicion ASC;

-- 13 Recupera el número de títulos por competición obtenidos 
-- por el Real Zaragoza a lo largo de su historia.
SELECT c.nombre_competicion AS 'Competicion', COUNT(*) AS 'Títulos'
FROM campeonato camp
        INNER JOIN temporada t
            ON (camp.id_temporada = t.id_temporada)
        INNER JOIN competicion c
            ON (camp.id_competicion = c.id_competicion)
        INNER JOIN equipo e
            ON (camp.campeon = e.id_equipo)
WHERE (e.nombre_equipo = 'Real Zaragoza')
GROUP BY c.nombre_competicion
ORDER BY c.nombre_competicion ASC;

-- 14 Recupera la información del número de títulos obtenidos a lo largo de la historia por cada equipo.
-- Teniendo en cuenta solamente los equipos que hayan obtenido más de dos títulos a lo largo de su historia.
--  Muestra primero los equipos que mayor número de títulos hayan obtenido a lo largo de su historia.
SELECT e.nombre_equipo AS 'Equipo',
COUNT(*) AS 'Títulos'
FROM campeonato camp
    INNER JOIN competicion c
        ON (camp.id_competicion = c.id_competicion)
    INNER JOIN equipo e
        ON (camp.campeon = e.id_equipo)
    GROUP BY e.nombre_equipo
HAVING (count(*)) > 2
ORDER BY Títulos DESC;

-- 15 Recupera  los  equipos  que  han  sido  capaces  de  ganar  títulos  en  más  de  dos  competiciones  distintas.
-- Ordénalos  de  mayor  a  menor  por  el  número  de  competiciones.

SELECT e.nombre_equipo AS 'Equipo',
COUNT(*) AS 'Títulos'
FROM campeonato camp
    INNER JOIN competicion c
        ON (camp.id_competicion = c.id_competicion)
    INNER JOIN equipo e
        ON (camp.campeon = e.id_equipo)
    GROUP BY e.nombre_equipo
HAVING (count(*)) > 2
ORDER BY Títulos DESC;
WHERE c.nombre_competicion