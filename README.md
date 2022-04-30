# Proyecto-DDL-y-DML

### Tabla Equipos

|  			**EQUIPOS** 		 |                                   |                     |
|---------------|-----------------------------------|---------------------|
|  			**Nombre** 		  |  			Cadena 			de Carácteres, tamaño 20 		 |  			   			 		               |
|  			Estadio 		     |  			Cadena 			de Carácteres, tamaño 30 		 |  			Único 		             |
|  			Aforo 		       |  			Numérico 			hasta 999.999 		          |  			Menor 			que 150.000 		 |
|  			Fundación 		   |  			Fecha 		                           |  			   			 		               |
|  			Ciudad 		      |  			Cadena 			de Carácteres, tamaño 20 		 |  			No 			nulo 		           |

### Tabla Partidos

|  			**PARTIDOS** 		                |                                   |                                          |
|-------------------------------|-----------------------------------|------------------------------------------|
|  			**Código** 		                  |  			Cadena 			de Carácteres, tamaño 4 		  |  			   			 		                                    |
|  			FechaEncuentro 		              |  			Fecha 		                           |  			El 			año debe de estar entre 2000 y 2020 		 |
|  			Jornada 		                     |  			Cadena 			de Caracteres, tamaño 20 		 |  			‘Jornada 1’ o ‘Jornada 			2’ 		              |
|  			Clima 		                       |  			Cadena 			de Caracteres, tamaño 20 		 |  			‘Despejado’ 			o ‘Lluvioso’ o ‘Nublado’ 		   |
|  			***EquipoLocal*** 		     |  			Cadena 			de Carácteres, tamaño 20 		 |  			   			 		                                    |
|  			***EquipoVisitante*** 		 |  			Cadena 			de Carácteres, tamaño 20 		 |  			   			 		                                    |

### Tabla Jugadores

|  			**JUGADORES** 		      |                                   |                                              |
|----------------------|-----------------------------------|----------------------------------------------|
|  			**Codigo** 		         |  			Numérico 			hasta 999 		              |  			   			 		                                        |
|  			Nombre 		             |  			Cadena 			de Carácteres, tamaño 20 		 |  			Iniciales 			en mayúsculas 		                    |
|  			FechaNac 		           |  			Fecha 		                           |  			El 			jugador podrá tener como máximo 36 años 		 |
|  			Posición 		           |  			Cadena 			de Carácteres, tamaño 3 		  |  			En 			mayúsculas 		                              |
|  			Dorsal 		             |  			Numérico 			hasta 99 		               |  			No 			nulo 		                                    |
|  			***NombreEquipo*** 		 |  			Cadena 			de Carácteres, tamaño 20 		 |  			   			 		                                        |

### Tabla Presidente

|  			**PRESIDENTE** 		     |                                   |                                                             |
|----------------------|-----------------------------------|-------------------------------------------------------------|
|  			**DNI** 		            |  			Cadena 			de Caracteres, tamaño 9 		  |  			El 			DNI debe acabar con una letra y contener 9 caracteres. 		 |
|  			Nombre 		             |  			Cadena 			de Caracteres, tamaño 20 		 |  			Iniciales 			en mayúsculas. 		                                  |
|  			Apellido 		           |  			Cadena 			de Caracteres, tamaño 20 		 |  			   			 		                                                       |
|  			FechaNac 		           |  			Fecha 		                           |  			   			 		                                                       |
|  			***NombreEquipo*** 		 |  			Cadena 			de Carácteres, tamaño 20 		 |  			   			 		                                                       |

### Tabla Goles

|  			**GOLES** 		        |                                   |                                   |
|--------------------|-----------------------------------|-----------------------------------|
|  			**NGol** 		         |  			Numérico 			hasta 99 		               |  			   			 		                             |
|  			***CodPartido*** 		 |  			Cadena 			de Carácteres, tamaño 4 		  |  			   			 		                             |
|  			***CodJugador*** 		 |  			Numérico 			hasta 999 		              |  			   			 		                             |
|  			Minuto 		           |  			Numérico, 			tamaño 3 		              |  			El 			minuto debe ser menor de 120 		 |
|  			Descripción 		      |  			Cadena 			de Caracteres, tamaño 30 		 |  			   			 		                             |


### UNA VEZ CREADAS LAS TABLAS CONSIDERA LAS SIGUIENTES RESTRICCIONES:

- Modifica la tabla partidos: Clima por defecto **"Despejado"**.

- Tabla Goles: Añadir columna llamada **"Tipo"** de tipo **VARCHAR2** con tamaño 20.

- Elimina la columna **FechaNac** de la tabla Presidente.

- Eliminar la restricción de Clima obligatorio **('Despejado','Lluvioso','Nublado')**.

- Tabla Goles: La columna **"Tipo"** solo podrá ser **"Remate, Penalti, Falta o Autogol"**.

- Tabla Partidos: Actualizar la restricción de **FechaEncuentro**, el año deberá estar entre 2010 y 2000.

- Tabla Jugadores: El **dorsal** solo podrá ser del 1 al 50.

- Tabla Jugadores: Desactiva temporalmente la restricción del dorsal.

- Tabla Jugadores: Activa la restricción del dorsal.

- La **fundación** de los equipos debe de ser desde 1890.

- Tabla Equipos: La **ciudad** debe empezar por mayúsculas.

- La **posición** de los jugadores debe tener mas de 1 carácter.


## CONSULTAS

- Consulta sencilla
    - Mostrar el nombre de los futbolistas que son delantero centro.
    - Mostrar los equipos de la ciudad de Sevilla.

- Vistas.
    - Crea una vista que muestre el nombre y la posición de los jugadores que nunca han metido un gol.

- Subconsultas.
    - Muestra el nombre de los presidentes de los equipos de Madrid.
    - Muestra el nombre de los jugadores que han metido mas de un gol.

- Combinaciones de tablas.
    - Mostrar el nombre y apellido de cada presidente junto al nombre del equipo al que pertenece.

- Inserción de registros. Consultas de datos anexados.
    - Inserta un nuevo jugador con código 123, con nombre 'David Alaba', su fecha de nacimiento es el 24 de junio de 1992, juega como defensa central, tiene el dorsal con el número 4, y que juega en el mismo equipo que 'Vinicius Junior'.

- Modificación de registros. Consultas de actualización.
    - Actualiza el listado de goles, de forma que todos los goles anotados por Karim Benzema sean de remate.

- Borrado de registros. Consultas de eliminación.
    - Elimina todos los goles marcados en partidos lluviosos a partir del minuto 60.

- Group by y having.
    - Muestra el nombre y el año de nacimiento de los jugadores que hayan metido más de un gol de remate.
    - Muestra todas las ciudades que tienen más de un equipo.    

- Outer joins. Combinaciones externas.
    - Muestra los equipos fundados a partir del año 1900 junto al número de jugadores registrados en la base de datos para cada uno de los equipos.

- Consultas con operadores de conjuntos.
    - Comprueba mediante una consulta si hay algún estado climatico en los partidos de la jornada 1 que hayan sido distintos a todos estados climáticos de los partidos de la jornada 2.
    - Muestra el nombre de todos los jugadores y presidentes que empiecen por J. 

- Subconsultas correlaccionadas.
- Consulta que incluya varios tipos de los indicados anteriormente.