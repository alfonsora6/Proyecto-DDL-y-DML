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