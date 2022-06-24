/*Crea una vista de la tabla “jugador” de la base de datos “rz” que contenga 
los campos “nombre” y “año”. Correspondiéndose el nombre con el nombre y los
dos apellidos del jugador, y el año con el año de llegada.*/
CREATE OR REPLACE VIEW jugadores AS SELECT 
CONCAT_WS(' ', nombre, apellido_1, apellido_2) AS 'Nombre',
anyo_llegada AS 'Año' 
FROM jugador;

/*Elimina la vista creada en el ejercicio anterior*/
DROP VIEW jugadores;

/*Recupera  con  una  consulta  anidada  a  partir  de  la  vista 
“títulos_view” los  campeonatos  en  los  que  el  campeón  o  
subcampeón  haya  sido  el  Vizcaya  o  el  Athletic Club de Bilbao.*/
SELECT * FROM titulos_view
WHERE
(Campeón IN ('Vizcaya', 'Athletic Club de Bilbao'))
OR (Subcampeón IN ('Vizcaya',
'Athletic Club de Bilbao'));

/*Recupera a partir de la vista “títulos view” la información de las ligas
no ganadas ni por Real Madrid, ni por el Fútbol Club Barcelona.*/
SELECT *
FROM titulos_view
WHERE
(Competición = 'Liga Española')
AND (Campeón NOT IN ('Real Madrid',
'Fútbol Club Barcelona'));

/*Recupera a partir de la vista “títulos view” la información de
las ligas en las que ni Real  Madrid, ni  Fútbol  Club  Barcelona  han  
resultado ser  los  equipos  cam-peones o subcampeones.*/ 
SELECT *
FROM titulos_view
WHERE
(Competición = 'Liga Española')
AND (Campeón NOT IN ('Real Madrid',
'Fútbol Club Barcelona'))
AND (Subcampeón NOT IN ('Real Madrid',
'Fútbol Club Barcelona'));

/*Recupera a partir de la vista “títulos view” la información de las ligas 
en las que el equipo campeón es un equipo que ha ganado más de cinco
campeonatos y no sea ni Real Madrid, ni Fútbol Club Barcelona.*/
SELECT *
FROM titulos_view tit
WHERE
(tit.Competición = 'Liga Española')
AND (tit.Campeón NOT IN ('Real Madrid',
'Fútbol Club Barcelona'))
AND (tit.Campeón IN (
SELECT tit2.Campeón
FROM titulos_view tit2
WHERE (Competición = 'Liga Española')
GROUP BY tit2.Campeón
HAVING COUNT(*)>5
));
