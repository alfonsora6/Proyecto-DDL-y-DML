--PARA ELIMINAR UN USUARIO CON SUS TABLAS - Acedemos con el usuario system/root
DROP USER alfonso CASCADE;

--A partir de este punto podemos copiar todo el script hasta el final y ejecutarlo de una.

--CREACIÓN DE USUARIO Y PRIVILEGIOS - Acedemos con el usuario system/root
CREATE USER alfonso identified by alfonso;
GRANT CONNECT TO alfonso;
GRANT RESOURCE TO alfonso;
GRANT UNLIMITED TABLESPACE TO alfonso;
GRANT CREATE VIEW to alfonso;

disconnect
connect alfonso/alfonso

--CREACIÓN DE TABLAS

CREATE TABLE Equipos
(
    Nombre VARCHAR2(20),
    Estadio VARCHAR2(30),
    Aforo NUMBER(6),
    Fundacion DATE,
    Ciudad VARCHAR2(20) NOT NULL,
    CONSTRAINT ck_estadio UNIQUE(Estadio),
    CONSTRAINT ck_aforo CHECK(Aforo<150000),
    CONSTRAINT pk_equipos PRIMARY KEY(Nombre)
);

CREATE TABLE Partidos
(
    Codigo VARCHAR2(4),
    FechaEncuentro DATE,
    Jornada VARCHAR2(20),
    Clima VARCHAR2(20),
    EquipoLocal VARCHAR2(20),
    EquipoVisitante VARCHAR2(20),
    CONSTRAINT ck_fechaencuentro CHECK(EXTRACT(YEAR FROM FechaEncuentro) BETWEEN 2000 AND 2020),
    CONSTRAINT ck_jornada CHECK(Jornada IN('Jornada 1','Jornada 2')),
    CONSTRAINT ck_clima CHECK(Clima IN('Despejado','Lluvioso','Nublado')),
    CONSTRAINT fk_equipolocal FOREIGN KEY (EquipoLocal) REFERENCES Equipos(Nombre),
    CONSTRAINT fk_equipovisitante FOREIGN KEY (EquipoVisitante) REFERENCES Equipos(Nombre),
    CONSTRAINT pk_partidos PRIMARY KEY(Codigo)
);

CREATE TABLE Jugadores
(
    Codigo NUMBER(3),
    Nombre VARCHAR2(20),
    FechaNac DATE,
    Posicion VARCHAR2(3) NOT NULL,
    Dorsal NUMBER(2),
    NombreEquipo VARCHAR2(20),
    CONSTRAINT ck_iniciales CHECK(INITCAP(Nombre)=Nombre),
    CONSTRAINT ck_edad CHECK((2022 - EXTRACT(YEAR FROM FechaNac)) <= 36), --Al ser una constraint de tipo check, no podemos meter funciones como Sysdate. Para ello debemos de crear un trigger que revise por cada fila que el valor insertado o modificado es menor o igual a 36.
    CONSTRAINT ck_posicion CHECK(Posicion=UPPER(Posicion)),
    CONSTRAINT fk_equipos FOREIGN KEY (NombreEquipo) REFERENCES Equipos(Nombre),
    CONSTRAINT pk_jugadores PRIMARY KEY(Codigo)
);

CREATE TABLE Presidente
(
    DNI VARCHAR2(9),
    Nombre VARCHAR2(20),
    Apellido VARCHAR2(20),
    FechaNac DATE,
    NombreEquipo VARCHAR2(20),
    CONSTRAINT ck_dni CHECK(REGEXP_LIKE(DNI,'^[0-9]{8}[A-Za-z]$')),
    CONSTRAINT ck_inicialesmayus CHECK(INITCAP(Nombre)=Nombre),
    CONSTRAINT fk_equipospresidente FOREIGN KEY (NombreEquipo) REFERENCES Equipos(Nombre),
    CONSTRAINT pk_presidente PRIMARY KEY(DNI)
);

CREATE TABLE Goles
(
    NGol NUMBER(2),
    CodPartido VARCHAR2(4),
    CodJugador NUMBER(3),
    Minuto NUMBER(3),
    Descripcion VARCHAR2(30),
    CONSTRAINT ck_minuto CHECK(Minuto<120),
    CONSTRAINT fk_partidos FOREIGN KEY (CodPartido) REFERENCES Partidos(Codigo),
    CONSTRAINT fk_jugadores FOREIGN KEY (CodJugador) REFERENCES Jugadores(Codigo),
    CONSTRAINT pk_goles PRIMARY KEY(NGol)
);

--UNA VEZ CREADAS LAS TABLAS CONSIDERA LAS SIGUIENTES RESTRICCIONES.-----------------------------------------------------

--1. Modifica la tabla partidos: Clima por defecto "Despejado".

ALTER TABLE Partidos MODIFY Clima VARCHAR2(20) DEFAULT 'Despejado';

--2. Tabla Goles: Añadir columna llamada "Tipo" de tipo VARCHAR(20).

ALTER TABLE Goles ADD Tipo VARCHAR2(20);

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

ALTER TABLE Jugadores DISABLE CONSTRAINT ck_dorsal;

--9. Tabla Jugadores: Activa la restricción del dorsal.

ALTER TABLE Jugadores ENABLE CONSTRAINT ck_dorsal;

--10. La fundación de los equipos debe de ser desde 1890.

ALTER TABLE Equipos ADD CONSTRAINT ck_fundacion CHECK(EXTRACT(YEAR FROM Fundacion) >= 1890);

--11. Tabla Equipos: La ciudad debe empezar por mayúsculas.

ALTER TABLE Equipos ADD CONSTRAINT ck_ciudad CHECK(INITCAP(Ciudad)=Ciudad);

--12. La posición de los jugadores debe tener mas de 1 carácter.

ALTER TABLE Jugadores ADD CONSTRAINT ck_longitudposicion CHECK(LENGTH(Posicion) > 1);


--INSERCCIONES-----------------------------------------------------------------------------------------------------------

--Tabla Equipos

INSERT INTO Equipos VALUES('Real Madrid','Santiago Bernabéu',81044,TO_DATE('08/03/1931','DD/MM/YYYY'),'Madrid');
INSERT INTO Equipos VALUES('Sevilla','Ramón Sánchez Pizjuán',43883,TO_DATE('25/01/1890','DD/MM/YYYY'),'Sevilla');
INSERT INTO Equipos VALUES('Barcelona','Camp Nou',99354,TO_DATE('29/11/1899','DD/MM/YYYY'),'Barcelona');
INSERT INTO Equipos VALUES('Atlético Madrid','Wanda Metropolitano',68456,TO_DATE('26/04/1903','DD/MM/YYYY'),'Madrid');
INSERT INTO Equipos VALUES('Betis','Benito Villamarín',60721,TO_DATE('12/09/1907','DD/MM/YYYY'),'Sevilla');
INSERT INTO Equipos VALUES('Real Sociedad','Reale Arena',39500,TO_DATE('07/09/1909','DD/MM/YYYY'),'San Sebastian');


--Tabla Partidos

INSERT INTO Partidos VALUES('AAA1',TO_DATE('19/09/20','DD/MM/YY'),'Jornada 1','Despejado','Real Madrid','Real Sociedad');
INSERT INTO Partidos VALUES('AAA2',TO_DATE('23/06/20','DD/MM/YY'),'Jornada 1','Despejado','Sevilla','Atlético Madrid');
INSERT INTO Partidos VALUES('BBB1',TO_DATE('13/08/20','DD/MM/YY'),'Jornada 2','Despejado','Betis','Barcelona');
INSERT INTO Partidos VALUES('AAA3',TO_DATE('24/12/19','DD/MM/YY'),'Jornada 1','Lluvioso','Atlético Madrid','Betis');
INSERT INTO Partidos VALUES('BBB2',TO_DATE('17/05/20','DD/MM/YY'),'Jornada 2','Despejado','Real Sociedad','Sevilla');
INSERT INTO Partidos VALUES('BBB3',TO_DATE('16/09/20','DD/MM/YY'),'Jornada 2','Nublado','Barcelona','Atlético Madrid');


--Tabla Jugadores

INSERT INTO Jugadores VALUES(111, 'Ivan Rakitic', TO_DATE('10/03/1988','DD/MM/YYYY'),'MC',10,'Sevilla');
INSERT INTO Jugadores VALUES(112, 'Jules Koundé', TO_DATE('12/11/1998','DD/MM/YYYY'),'DFC',25,'Sevilla');
INSERT INTO Jugadores VALUES(113, 'Karim Benzema', TO_DATE('19/12/1987','DD/MM/YYYY'),'DC',9,'Real Madrid');
INSERT INTO Jugadores VALUES(114, 'Vinicius Junior', TO_DATE('12/07/2000','DD/MM/YYYY'),'EI',20,'Real Madrid');
INSERT INTO Jugadores VALUES(115, 'Gavi', TO_DATE('05/08/2004','DD/MM/YYYY'),'MC',30,'Barcelona');
INSERT INTO Jugadores VALUES(116, 'Ousmane Dembele', TO_DATE('15/05/1997','DD/MM/YYYY'),'ED',7,'Barcelona');
INSERT INTO Jugadores VALUES(117, 'Nabil Fekir', TO_DATE('18/07/1993','DD/MM/YYYY'),'MCO',8,'Betis');
INSERT INTO Jugadores VALUES(118, 'Sergio Canales', TO_DATE('16/02/1991','DD/MM/YYYY'),'MC',10,'Betis');
INSERT INTO Jugadores VALUES(119, 'Antoine Griezmann', TO_DATE('21/03/1991','DD/MM/YYYY'),'DC',8,'Atlético Madrid');
INSERT INTO Jugadores VALUES(120, 'Jan Oblak', TO_DATE('07/01/1993','DD/MM/YYYY'),'POR',13,'Atlético Madrid');
INSERT INTO Jugadores VALUES(121, 'Mathew Ryan', TO_DATE('08/04/1992','DD/MM/YYYY'),'POR',13,'Real Sociedad');
INSERT INTO Jugadores VALUES(122, 'Mikel Oyarzabal', TO_DATE('21/04/1997','DD/MM/YYYY'),'EI',10,'Real Sociedad');


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