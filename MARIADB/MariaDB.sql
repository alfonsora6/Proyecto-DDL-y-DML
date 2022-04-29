
--CREACIÓN DE USUARIO Y PRIVILEGIOS - Acedemos con 'mysql -u root -p'

CREATE USER alfonso@localhost IDENTIFIED BY 'alfonso';
GRANT ALL PRIVILEGES ON *.* TO 'alfonso'@'localhost' IDENTIFIED BY 'alfonso' WITH GRANT OPTION;

exit
mysql -u alfonso -p

--A partir de este punto podemos copiar todo el script hasta el final y ejecutarlo de una.

--CREACIÓN DE LA BASE DE DATOS Y PRIVILEGIOS AL USUARIO

CREATE DATABASE LIGA;
GRANT ALL PRIVILEGES ON LIGA .* TO alfonso@localhost;

USE LIGA;

--CREACIÓN DE TABLAS

CREATE TABLE Equipos
(
    Nombre VARCHAR(20),
    Estadio VARCHAR(30),
    Aforo INT(6),
    Fundacion DATE,
    Ciudad VARCHAR(20) NOT NULL,
    CONSTRAINT ck_estadio UNIQUE(Estadio),
    CONSTRAINT ck_aforo CHECK(Aforo<150000),
    CONSTRAINT pk_equipos PRIMARY KEY(Nombre)
);

CREATE TABLE Partidos
(
    Codigo VARCHAR(4),
    FechaEncuentro DATE,
    Jornada VARCHAR(20),
    Clima VARCHAR(20),
    EquipoLocal VARCHAR(20),
    EquipoVisitante VARCHAR(20),
    CONSTRAINT ck_fechaencuentro CHECK(YEAR(FechaEncuentro) BETWEEN 2000 AND 2020),
    CONSTRAINT ck_jornada CHECK(Jornada IN('Jornada 1','Jornada 2')),
    CONSTRAINT ck_clima CHECK(Clima IN('Despejado','Lluvioso','Nublado')),
    CONSTRAINT fk_equipolocal FOREIGN KEY (EquipoLocal) REFERENCES Equipos(Nombre),
    CONSTRAINT fk_equipovisitante FOREIGN KEY (EquipoVisitante) REFERENCES Equipos(Nombre),
    CONSTRAINT pk_partidos PRIMARY KEY(Codigo)
);

CREATE TABLE Jugadores
(
    Codigo INT(3),
    Nombre VARCHAR(20),
    FechaNac DATE,
    Posicion VARCHAR(3) NOT NULL,
    Dorsal INT(2),
    NombreEquipo VARCHAR(20),
    CONSTRAINT ck_iniciales CHECK(Nombre REGEXP ('^[A-Z]')),
    CONSTRAINT ck_edad CHECK((2022 - YEAR(FechaNac)) <= 36),
    CONSTRAINT ck_posicion CHECK(Posicion=UPPER(Posicion)),
    CONSTRAINT fk_equipos FOREIGN KEY (NombreEquipo) REFERENCES Equipos(Nombre),
    CONSTRAINT pk_jugadores PRIMARY KEY(Codigo)
);

CREATE TABLE Presidente
(
    DNI VARCHAR(9),
    Nombre VARCHAR(20),
    Apellido VARCHAR(20),
    FechaNac DATE,
    NombreEquipo VARCHAR(20),
    CONSTRAINT ck_dni CHECK(DNI REGEXP '^[0-9]{8}[A-Za-z]$'),
    CONSTRAINT ck_inicialesmayus CHECK(Nombre REGEXP ('^[A-Z]')),
    CONSTRAINT fk_equipospresidente FOREIGN KEY (NombreEquipo) REFERENCES Equipos(Nombre),
    CONSTRAINT pk_presidente PRIMARY KEY(DNI)
);

CREATE TABLE Goles
(
    NGol INT(2),
    CodPartido VARCHAR(4),
    CodJugador INT(3),
    Minuto INT(3),
    Descripcion VARCHAR(30),
    CONSTRAINT ck_minuto CHECK(Minuto<120),
    CONSTRAINT fk_partidos FOREIGN KEY (CodPartido) REFERENCES Partidos(Codigo),
    CONSTRAINT fk_jugadores FOREIGN KEY (CodJugador) REFERENCES Jugadores(Codigo),
    CONSTRAINT pk_goles PRIMARY KEY(NGol)
);

--UNA VEZ CREADAS LAS TABLAS CONSIDERA LAS SIGUIENTES RESTRICCIONES.-----------------------------------------------------

--1. Modifica la tabla partidos: Clima por defecto "Despejado".

ALTER TABLE Partidos MODIFY Clima VARCHAR(20) DEFAULT 'Despejado';

--2. Tabla Goles: Añadir columna llamada "Tipo" de tipo VARCHAR(20).

ALTER TABLE Goles ADD Tipo VARCHAR(20);

--3. Elimina la columna FechaNac de la tabla Presidente.

ALTER TABLE Presidente DROP COLUMN FechaNac;

--4. Eliminar la restricción de Clima obligatorio ('Despejado','Lluvioso','Nublado').

ALTER TABLE Partidos DROP CONSTRAINT ck_clima;

--5. Tabla Goles: La columna "Tipo" solo podrá ser "Remate, Penalti, Falta o Autogol".

ALTER TABLE Goles ADD CONSTRAINT ck_tipo CHECK(Tipo IN('Remate','Penalti','Falta','Autogol'));

--6. Tabla Partidos: Actualizar la restricción de FechaEncuentro, el año deberá estar entre 2010 y 2000.

ALTER TABLE Partidos DROP CONSTRAINT ck_fechaencuentro;

ALTER TABLE Partidos ADD CONSTRAINT ck_fechaencuentro CHECK(EXTRACT(YEAR FROM FechaEncuentro) BETWEEN 2010 AND 2020);

--7. Tabla Jugadores: El dorsal solo podrá ser del 1 al 50.

ALTER TABLE Jugadores ADD CONSTRAINT ck_dorsal CHECK(Dorsal>=1 and Dorsal<=50);

--8. Tabla Jugadores: Desactiva temporalmente la restricción del dorsal.
--La restricción NOCHECK no funciona.

ALTER TABLE Jugadores DISABLE KEYS;

--9. Tabla Jugadores: Activa la restricción del dorsal.

ALTER TABLE Jugadores ENABLE KEYS;

--10. La fundación de los equipos debe de ser desde 1890.

ALTER TABLE Equipos ADD CONSTRAINT ck_fundacion CHECK(EXTRACT(YEAR FROM Fundacion) >= 1890);

--11. Tabla Equipos: La ciudad debe empezar por mayúsculas.

ALTER TABLE Equipos ADD CONSTRAINT ck_ciudad CHECK(Ciudad REGEXP ('^[A-Z]'));

--12. La posición de los jugadores debe tener mas de 1 carácter.

ALTER TABLE Jugadores ADD CONSTRAINT ck_longitudposicion CHECK(LENGTH(Posicion) > 1);


--INSERCCIONES-----------------------------------------------------------------------------------------------------------

--Tabla Equipos

INSERT INTO Equipos VALUES('Real Madrid','Santiago Bernabéu',81044,STR_TO_DATE('08/03/1931','%d/%m/%Y'),'Madrid');
INSERT INTO Equipos VALUES('Sevilla','Ramón Sánchez Pizjuán',43883,STR_TO_DATE('25/01/1890','%d/%m/%Y'),'Sevilla');
INSERT INTO Equipos VALUES('Barcelona','Camp Nou',99354,STR_TO_DATE('29/11/1899','%d/%m/%Y'),'Barcelona');
INSERT INTO Equipos VALUES('Atlético Madrid','Wanda Metropolitano',68456,STR_TO_DATE('26/04/1903','%d/%m/%Y'),'Madrid');
INSERT INTO Equipos VALUES('Betis','Benito Villamarín',60721,STR_TO_DATE('12/09/1907','%d/%m/%Y'),'Sevilla');
INSERT INTO Equipos VALUES('Real Sociedad','Reale Arena',39500,STR_TO_DATE('07/09/1909','%d/%m/%Y'),'San Sebastian');


--Tabla Partidos

INSERT INTO Partidos VALUES('AAA1',STR_TO_DATE('19/09/20','%d/%m/%y'),'Jornada 1','Despejado','Real Madrid','Real Sociedad');
INSERT INTO Partidos VALUES('AAA2',STR_TO_DATE('23/06/20','%d/%m/%y'),'Jornada 1','Despejado','Sevilla','Atlético Madrid');
INSERT INTO Partidos VALUES('BBB1',STR_TO_DATE('13/08/20','%d/%m/%y'),'Jornada 2','Despejado','Betis','Barcelona');
INSERT INTO Partidos VALUES('AAA3',STR_TO_DATE('24/12/19','%d/%m/%y'),'Jornada 1','Lluvioso','Atlético Madrid','Betis');
INSERT INTO Partidos VALUES('BBB2',STR_TO_DATE('17/05/20','%d/%m/%y'),'Jornada 2','Despejado','Real Sociedad','Sevilla');
INSERT INTO Partidos VALUES('BBB3',STR_TO_DATE('16/09/20','%d/%m/%y'),'Jornada 2','Nublado','Barcelona','Atlético Madrid');


--Tabla Jugadores

INSERT INTO Jugadores VALUES(111, 'Ivan Rakitic', STR_TO_DATE('10/03/1988','%d/%m/%Y'),'MC',10,'Sevilla');
INSERT INTO Jugadores VALUES(112, 'Jules Koundé', STR_TO_DATE('12/11/1998','%d/%m/%Y'),'DFC',25,'Sevilla');
INSERT INTO Jugadores VALUES(113, 'Karim Benzema', STR_TO_DATE('19/12/1987','%d/%m/%Y'),'DC',9,'Real Madrid');
INSERT INTO Jugadores VALUES(114, 'Vinicius Junior', STR_TO_DATE('12/07/2000','%d/%m/%Y'),'EI',20,'Real Madrid');
INSERT INTO Jugadores VALUES(115, 'Gavi', STR_TO_DATE('05/08/2004','%d/%m/%Y'),'MC',30,'Barcelona');
INSERT INTO Jugadores VALUES(116, 'Ousmane Dembele', STR_TO_DATE('15/05/1997','%d/%m/%Y'),'ED',7,'Barcelona');
INSERT INTO Jugadores VALUES(117, 'Nabil Fekir', STR_TO_DATE('18/07/1993','%d/%m/%Y'),'MCO',8,'Betis');
INSERT INTO Jugadores VALUES(118, 'Sergio Canales', STR_TO_DATE('16/02/1991','%d/%m/%Y'),'MC',10,'Betis');
INSERT INTO Jugadores VALUES(119, 'Antoine Griezmann', STR_TO_DATE('21/03/1991','%d/%m/%Y'),'DC',8,'Atlético Madrid');
INSERT INTO Jugadores VALUES(120, 'Jan Oblak', STR_TO_DATE('07/01/1993','%d/%m/%Y'),'POR',13,'Atlético Madrid');
INSERT INTO Jugadores VALUES(121, 'Mathew Ryan', STR_TO_DATE('08/04/1992','%d/%m/%Y'),'POR',13,'Real Sociedad');
INSERT INTO Jugadores VALUES(122, 'Mikel Oyarzabal', STR_TO_DATE('21/04/1997','%d/%m/%Y'),'EI',10,'Real Sociedad');


--Tabla Presidente

INSERT INTO Presidente VALUES('34582352H','José','Castro','Sevilla');
INSERT INTO Presidente VALUES('47382932K','Florentino','Perez','Real Madrid');
INSERT INTO Presidente VALUES('37494236G','Angel','Haro','Betis');
INSERT INTO Presidente VALUES('47233432B','Jokin','Aperribay','Real Sociedad');
INSERT INTO Presidente VALUES('88236456D','Joan','Laporta','Barcelona');
INSERT INTO Presidente VALUES('37462937F','Enrique','Cerezo','Atlético Madrid');


--Tabla Goles

INSERT INTO Goles VALUES(1,'AAA1',113,67,'Gol de Benzema','Remate');
INSERT INTO Goles VALUES(2,'AAA1',113,78,'Gol de Benzema','Penalti');
INSERT INTO Goles VALUES(3,'AAA2',111,23,'Gol de Rakitic','Falta');
INSERT INTO Goles VALUES(4,'AAA2',119,44,'Gol de Griezmann','Remate');
INSERT INTO Goles VALUES(5,'AAA3',118,12,'Gol de Canales','Penalti');
INSERT INTO Goles VALUES(6,'AAA3',117,86,'Gol de Fekir','Remate');
INSERT INTO Goles VALUES(7,'BBB1',118,34,'Gol en propia de Canales','Autogol');
INSERT INTO Goles VALUES(8,'BBB1',115,69,'Gol de Gavi','Penalti');
INSERT INTO Goles VALUES(9,'BBB2',111,72,'Gol de Rakitic','Remate');
INSERT INTO Goles VALUES(10,'BBB2',122,38,'Gol de Oyarzabal','Falta');
INSERT INTO Goles VALUES(11,'BBB3',116,81,'Gol de Dembele','Remate');
INSERT INTO Goles VALUES(12,'BBB3',116,17,'Gol de Dembele','Remate');

COMMIT;





