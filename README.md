# Proyecto-DDL-y-DML

### Tabla Equipos

|  			**EQUIPOS** 		   |                                   |                     |
|-------------|-----------------------------------|---------------------|
|  			**Nombre** 		    |  			Cadena 			de Carácteres, tamaño 20 		 |  			   			 		               |
|  			Estadio 		   |  			Cadena 			de Carácteres, tamaño 20 		 |  			Único 		             |
|  			Aforo 		     |  			Numérico 			hasta 999.999 		          |  			Menor 			que 150.000 		 |
|  			Fundación 		 |  			Fecha 		                           |  			   			 		               |
|  			Ciudad 		    |  			Cadena 			de Carácteres, tamaño 20 		 |  			   			 		               |

### Tabla Partidos

|  			**PARTIDOS** 		   |                                   |                                           |
|------------------|-----------------------------------|-------------------------------------------|
|  			**Código** 		     |  			Cadena 			de Carácteres, tamaño 4 		  |  			   			 		                                     |
|  			FechaEncuentro 		 |  			Fecha 		                           |  			El 			año debe de estar entre 2000 y 2020. 		 |
|  			Jornada 		        |  			Cadena 			de Caracteres, tamaño 20 		 |  			‘Jornada 1’ o ‘Jornada 			2’ 		               |
|  			GolesLocal 		     |  			Numérico, 			tamaño 2 		              |  			Por 			defecto 0 		                           |
|  			GolesVisitante 		 |  			Numérico, 			tamaño 2 		              |  			Por 			defecto 0 		                           |

### Tabla Jugadores

|  			**JUGADORES** 		 |                                   |                           |
|-----------------|-----------------------------------|---------------------------|
|  			**Codigo** 		    |  			Numérico 			hasta 999 		              |  			   			 		                     |
|  			Nombre 		        |  			Cadena 			de Carácteres, tamaño 20 		 |  			Iniciales 			en mayúsculas 		 |
|  			FechaNac 		      |  			Fecha 		                           |  			   			 		                     |
|  			Posición 		      |  			Cadena 			de Carácteres, tamaño 3 		  |  			En 			mayúsculas 		           |
|  			Dorsal 		        |  			Numérico 			hasta 99 		               |  			No 			nulo 		                 |

### Tabla Presidente

|  			**PRESIDENTE** 		 |                                   |                                    |
|------------------|-----------------------------------|------------------------------------|
|  			**DNI** 		        |  			Cadena 			de Caracteres, tamaño 9 		  |  			El 			DNI debe acabar con una letra 		 |
|  			Nombre 		         |  			Cadena 			de Caracteres, tamaño 20 		 |  			Iniciales 			en mayúsculas 		          |
|  			Apellido 		       |  			Cadena 			de Caracteres, tamaño 20 		 |  			   			 		                              |
|  			FechaNac 		       |  			Fecha 		                           |  			   			 		                              |
|  			***Equipo*** 		   |  			Cadena 			de Carácteres, tamaño 20 		 |  			   			 		                              |
|  			AñoFundación 		   |  			Numérico, 			tamaño 4 		              |  			El 			año debe de ser menor de 2010 		 |

### Tabla Goles

|  			**GOLES** 		        |                                   |                                   |
|--------------------|-----------------------------------|-----------------------------------|
|  			**NGol** 		         |  			Numérico 			hasta 99 		               |  			   			 		                             |
|  			***CodPartido*** 		 |  			Cadena 			de Carácteres, tamaño 4 		  |  			   			 		                             |
|  			***Equipo*** 		     |  			Cadena 			de Carácteres, tamaño 20 		 |  			   			 		                             |
|  			***CodJugador*** 		 |  			Numérico 			hasta 999 		              |  			   			 		                             |
|  			Minuto 		           |  			Numérico, 			tamaño 3 		              |  			El 			minuto debe ser menor de 120 		 |
|  			Descripción 		      |  			Cadena 			de Caracteres, tamaño 30 		 |  			   			 		                             |
