--1- Consultas sencillas.

-- Mostrar el nombre de los futbolistas que son delantero centro.
SELECT Nombre FROM Jugadores WHERE Posicion='DC';

-- Mostrar los equipos de la ciudad de Sevilla.
SELECT Nombre FROM Equipos WHERE Ciudad='Sevilla';

--2- Vistas.

-- Crea una vista que muestre el nombre y la posición de los jugadores que nunca han metido un gol.
CREATE VIEW Jugadores_sin_goles
AS
(SELECT Nombre,Posicion 
 FROM Jugadores 
 WHERE Codigo NOT IN (SELECT CodJugador from Goles));

SELECT * FROM Jugadores_sin_goles;

--3- Subconsultas.

-- Muestra el nombre y apellido de los presidentes de los equipos de Madrid.
SELECT Nombre||' '||Apellido as "Nombre y apellido" FROM Presidente WHERE NombreEquipo IN (SELECT Nombre FROM Equipos WHERE Ciudad='Madrid');

-- Muestra el nombre de los jugadores que han metido mas de un gol.
SELECT Nombre 
FROM Jugadores 
WHERE Codigo IN (SELECT CodJugador 
                 FROM Goles 
                 GROUP BY CodJugador 
                 HAVING COUNT(codjugador)>1);

--4- Combinaciones de tablas.

-- Mostrar el nombre y apellido de cada presidente junto al nombre del equipo al que pertenece.
SELECT p.Nombre||' '||p.Apellido AS "Nombre y apellido", e.Nombre 
FROM Presidente p,Equipos e 
WHERE p.NombreEquipo=e.Nombre;

--5- Inserción de registros. Consultas de datos anexados.

-- Inserta un nuevo jugador con código 123, con nombre 'David Alaba', su fecha de nacimiento es el 24 de junio de 1992, juega como defensa central, tiene el dorsal con el número 4, y que juega en el mismo equipo que 'Vinicius Junior'.
INSERT INTO Jugadores
SELECT 123,'David Alaba',TO_DATE('24/06/1992','DD/MM/YYYY'),'DFC',4,Nombre 
FROM equipos 
WHERE nombre=(SELECT NombreEquipo 
              FROM jugadores 
              WHERE nombre='Vinicius Junior');

--6- Modificación de registros. Consultas de actualización.

-- Actualiza el listado de goles, de forma que todos los goles anotados por Karim Benzema sean de remate.
UPDATE Goles SET Tipo = 'Remate'
WHERE CodJugador=(SELECT Codigo 
                  FROM Jugadores 
                  WHERE Nombre='Karim Benzema');

--7- Borrado de registros. Consultas de eliminación.

-- Elimina todos los goles marcados en partidos lluviosos a partir del minuto 60.
DELETE FROM Goles 
       WHERE CodPartido IN (SELECT Codigo 
                            FROM Partidos 
                            WHERE Clima='Lluvioso') AND Minuto>60;

--8- Group by y having.

--Muestra el nombre y el año de nacimiento de los jugadores que hayan metido más de un gol de remate.
SELECT j.nombre,EXTRACT(YEAR FROM j.fechanac) as "Año de nacimiento",count(g.ngol) as Goles 
FROM jugadores j, goles g 
WHERE j.codigo=g.codjugador AND g.tipo='Remate' 
GROUP BY j.nombre,j.fechanac 
HAVING COUNT(g.ngol)>1;


--Muestra todas las ciudades que tienen más de un equipo.

SELECT ciudad from equipos group by ciudad having count(nombre)>1;




----------------------------------------------------------------------------------
9- Outer joins. Combinaciones externas.

Muestra los equipos fundados a partir del año 1900 junto al número de jugadores registrados en la base de datos por cada uno de los equipos.

----------------------------------------------------------------------------------
10- Consultas con operadores de conjuntos.

Comprueba mediante una consulta si hay algún estado climatico en los partidos de la jornada 1 que hayan sido distintos a todos estados climáticos de los partidos de la jornada 2.

SQL> Select clima from partidos where jornada='Jornada 1'
  2  MINUS
  3  Select clima from partidos where jornada='Jornada 2';

CLIMA
---------
Lluvioso


Muestra el nombre de todos los jugadores y presidentes que empiecen por 'J'. 

select nombre from jugadores where REGEXP_LIKE(nombre,'^J')
UNION
select nombre from presidente where REGEXP_LIKE(nombre,'^J');

----------------------------------------------------------------------------------

11- Subconsultas correlacionadas.



12- Consulta que incluya varios tipos de los indicados anteriormente.