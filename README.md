# Proyecto SQL - DVD Rental / Shakila

## Descripción del proyecto

Este proyecto consiste en la resolución de una serie de consultas SQL sobre una base de datos relacional en PostgreSQL, utilizando DBeaver como herramienta principal de trabajo.

La base de datos empleada corresponde al modelo de alquiler de películas tipo DVD Rental / Shakila, e incluye información sobre películas, actores, categorías, clientes, alquileres, pagos, inventario, empleados y tiendas.

El objetivo principal del proyecto ha sido poner en práctica la lógica de consultas SQL sobre un entorno relacional realista, trabajando con consultas simples, relaciones entre tablas, subconsultas, vistas y estructuras temporales.

---

## Herramientas utilizadas

- PostgreSQL
- DBeaver

---

## Estructura del repositorio

```text
.
├── README.md
├── esquema_bbdd.sql
└── consultas_resueltas.sql

```
### Contenido de los archivos

- **README.md**: descripción del proyecto, metodología seguida y conclusiones.
- **esquema_bbdd.sql**: archivo con el esquema de la base de datos proporcionada.
- **consultas_resueltas.sql**: archivo con todas las consultas resueltas, numeradas y documentadas.

---

## Base de datos utilizada

La base de datos utilizada está orientada a la gestión de un videoclub o sistema de alquiler de películas. A nivel estructural, se trabaja con entidades relacionadas entre sí como:

- películas
- actores
- categorías
- clientes
- inventario
- alquileres
- pagos
- empleados
- tiendas

Gracias a esta estructura, el proyecto permite practicar desde consultas básicas sobre una sola tabla hasta consultas más complejas con varias relaciones, filtros, agrupaciones y subconsultas.

---

## Objetivos del proyecto

Con este proyecto se pretende demostrar:

- manejo de la herramienta DBeaver
- comprensión del esquema de una base de datos relacional
- resolución de consultas sobre una sola tabla
- manejo correcto de relaciones entre tablas
- uso de subconsultas
- creación de vistas
- uso de tablas temporales
- aplicación de buenas prácticas en SQL
- interpretación correcta de los resultados obtenidos
- entrega ordenada del trabajo en GitHub

## Metodología de trabajo

Antes de empezar a resolver las consultas, se realizó una revisión del esquema de la base de datos para entender las tablas principales, las claves primarias y las relaciones entre ellas.

Una vez comprendida la estructura general, se trabajó de forma progresiva:

1. Carga del esquema en PostgreSQL desde DBeaver.
2. Revisión de tablas principales y relaciones.
3. Resolución de consultas simples sobre una sola tabla.
4. Resolución de consultas con varias tablas y joins.
5. Uso de subconsultas en aquellos ejercicios que lo requerían.
6. Creación de una vista.
7. Creación de tablas temporales.
8. Revisión final del formato, legibilidad y coherencia de resultados.

Durante todo el proceso no solo se buscó que las consultas funcionaran, sino también que el resultado obtenido tuviera sentido con respecto al modelo de datos.

---

## Contenido trabajado

A lo largo del proyecto se han resuelto consultas relacionadas con:

- filtros con `WHERE`
- ordenaciones con `ORDER BY`
- agregaciones con `COUNT`, `SUM`, `AVG`, `MIN` y `MAX`
- agrupaciones con `GROUP BY`
- filtros sobre agrupaciones con `HAVING`
- relaciones entre tablas con `JOIN` y `LEFT JOIN`
- subconsultas
- búsquedas con `EXISTS` y `NOT EXISTS`
- creación de vistas
- creación de tablas temporales
- análisis sobre alquileres, clientes, actores, películas y categorías

---

## Buenas prácticas aplicadas

Para la resolución del proyecto se siguieron varias buenas prácticas:

- consultas indentadas y legibles
- numeración de cada ejercicio
- enunciado incluido como comentario antes de cada consulta
- elección del tipo de join según la lógica del enunciado
- revisión de resultados para comprobar que tenían sentido
- adaptación de algunas consultas para hacerlas más robustas, por ejemplo usando `ILIKE` en búsquedas de texto cuando era conveniente

## Ejemplos de conceptos trabajados

### Consultas sobre una sola tabla

Se realizaron ejercicios sencillos sobre tablas como `actor`, `film` o `payment`, trabajando con filtros, ordenaciones y funciones de agregación.

### Relaciones entre tablas

Se enlazaron tablas como:

- `actor` con `film` a través de `film_actor`
- `film` con `category` a través de `film_category`
- `customer` con `rental`
- `rental` con `inventory`
- `payment` con `customer` y `rental`

### Subconsultas

Se utilizaron subconsultas para comparar valores con medias, buscar referencias concretas y resolver condiciones más complejas.

---

## Vistas

Se creó una vista para mostrar actores junto con el número de películas en las que han participado.

---

## Tablas temporales

Se generaron tablas temporales para almacenar resultados intermedios, como el total de alquileres por cliente o las películas alquiladas un número mínimo de veces.

## Resultado del proyecto

El archivo `consultas_resueltas.sql` contiene la resolución completa de los ejercicios planteados. Cada consulta ha sido documentada y revisada para que el archivo final sea claro, ordenado y fácil de ejecutar desde DBeaver.

Este proyecto ha permitido practicar SQL en un entorno relacional real, reforzando tanto la sintaxis como la lógica de análisis sobre una base de datos estructurada.

---

## Conclusión

Este trabajo no se ha centrado únicamente en escribir consultas SQL, sino también en entender la estructura de la base de datos, aplicar correctamente las relaciones entre tablas y analizar los resultados obtenidos.

Gracias a ello, el proyecto ha servido para consolidar conceptos fundamentales de SQL y para trabajar de forma más sólida sobre un modelo relacional completo.
