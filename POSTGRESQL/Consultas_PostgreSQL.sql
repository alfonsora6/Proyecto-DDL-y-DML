--1- Consultas sencillas.

-- Mostrar el nombre de los futbolistas que son delantero centro.
SELECT Nombre FROM Jugadores WHERE Posicion='DC';

-- Mostrar los equipos de la ciudad de Sevilla.
SELECT Nombre FROM Equipos WHERE Ciudad='Sevilla';


--2- Vistas.

-- Crea una vista que muestre el nombre y la posición de los jugadores que nunca han metido un gol.

CREATE VIEW Jugadores_sin_goles
AS
SELECT Nombre,Posicion 
FROM Jugadores 
WHERE Codigo NOT IN (SELECT CodJugador from Goles);

SELECT * FROM Jugadores_sin_goles;


--3- Subconsultas.

-- Muestra el nombre y apellido de los presidentes de los equipos de Madrid.
SELECT CONCAT(Nombre,' ',Apellido) as "Nombre y apellido" 
FROM Presidente 
WHERE NombreEquipo IN (SELECT Nombre 
                       FROM Equipos 
                       WHERE Ciudad='Madrid');

-- Muestra el nombre de los jugadores que han metido mas de un gol.
SELECT Nombre 
FROM Jugadores 
WHERE Codigo IN (SELECT CodJugador 
                 FROM Goles 
                 GROUP BY CodJugador 
                 HAVING COUNT(codjugador)>1);

--Muestra el Nombre, apellido y DNI (En mayúsculas) del presidente del equipo que cuente con un menor aforo.
SELECT UPPER(CONCAT(Nombre,' ',Apellido)) AS "Nombre y apellido",DNI 
FROM Presidente 
WHERE NombreEquipo=(SELECT Nombre 
                    FROM Equipos 
                    WHERE aforo=(SELECT min(Aforo) FROM Equipos));