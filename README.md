# Proyecto-DDL-y-DML

### Tabla Equipos

|  			**EQUIPOS** 		 |                                   |                     |
|---------------|-----------------------------------|---------------------|
|  			**Nombre** 		  |  			Cadena 			de Carácteres, tamaño 20 		 |  			   			 		               |
|  			Estadio 		     |  			Cadena 			de Carácteres, tamaño 20 		 |  			Único 		             |
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
|  			***NombreEquipoLocal*** 		     |  			Cadena 			de Carácteres, tamaño 20 		 |  			   			 		                                    |
|  			***NombreEquipoVisitante*** 		 |  			Cadena 			de Carácteres, tamaño 20 		 |  			   			 		                                    |

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

1. Modifica la tabla partidos: Clima por defecto **"Despejado"**.

2. Tabla Goles: Añadir columna llamada **"Tipo"** de tipo **VARCHAR(20)**

3. Elimina la columna **FechaNac** de la tabla Presidente.

4. Eliminar la restricción de Clima obligatorio **('Despejado','Lluvioso','Nublado')**.

5. Tabla Goles: La columna **"Tipo"** solo podrá ser **"Remate, Penalti, Falta o Autogol"**.

6. Tabla Partidos: Actualizar la restricción de **FechaEncuentro**, el año deberá estar entre 2010 y 2000.

7. Tabla Jugadores: El **dorsal** solo podrá ser del 1 al 50.

8. Tabla Jugadores: Desactiva temporalmente la restricción del dorsal.

9. Tabla Jugadores: Activa la restricción del dorsal.

10. La **fundación** de los equipos debe de ser desde 1890.

11. Tabla Equipos: La **ciudad** debe empezar por mayúsculas.

12. La **posición** de los jugadores debe tener mas de 1 carácter.