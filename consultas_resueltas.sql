-- =========================================================
-- 1. Crea el esquema de la BBDD.
-- =========================================================

-- Código anterior:
 CREATE SCHEMA IF NOT EXISTS dvd_rental;

-- Cambio realizado:
-- Antes se propuso crear un esquema llamado dvd_rental, pero en el
-- fichero SQL proporcionado la base ya está definida sobre el esquema
-- public. Por eso, para ajustarlo al archivo real del proyecto, se
-- sustituye por public.

CREATE SCHEMA IF NOT EXISTS public;

-- Si además quieres eliminarlo si existe y crearlo de nuevo, puedes
-- usar DROP SCHEMA ... CASCADE seguido de CREATE SCHEMA.
-- Esto borra todas las tablas, vistas, funciones y demás objetos
-- que existan dentro del esquema.

DROP SCHEMA IF EXISTS public CASCADE;
CREATE SCHEMA public;


-- =========================================================
-- 2. Muestra los nombres de todas las películas con una
--    clasificación por edades de 'R'.
-- =========================================================


 SELECT
    title
 FROM film
 WHERE rating = 'R';
 
 
 -- =========================================================
-- 3. Encuentra los nombres de los actores que tengan un
--    actor_id entre 30 y 40.
-- =========================================================

SELECT
    first_name,
    last_name
FROM actor
WHERE actor_id BETWEEN 30 AND 40;


-- =========================================================
-- 4. Obtén las películas cuyo idioma coincide con el
--    idioma original.
-- =========================================================

-- Código anterior:
 SELECT
    title
 FROM film
 WHERE language_id = original_language_id;

-- Cambio realizado:
-- Se añade la condición original_language_id IS NOT NULL para
-- evitar comparar contra valores nulos. Así la consulta solo
-- devuelve películas en las que el idioma original está
-- informado y además coincide con el idioma actual.

SELECT
    title
FROM film
WHERE original_language_id IS NOT NULL
  AND language_id = original_language_id;


-- =========================================================
-- 5. Ordena las películas por duración de forma ascendente.
-- =========================================================

-- Código anterior:
 SELECT
     title,
     length
 FROM film
 ORDER BY
     length ASC;

-- Cambio realizado:
-- Se añade title ASC como segundo criterio de ordenación para
-- que, si varias películas tienen la misma duración, el orden
-- sea estable y más limpio al revisar los resultados.

SELECT
    title,
    length
FROM film
ORDER BY
    length ASC,
    title ASC;


-- =========================================================
-- 6. Encuentra el nombre y apellido de los actores que
--    tengan 'Allen' en su apellido.
-- =========================================================

-- Código anterior:
 SELECT
     first_name,
     last_name
 FROM actor
 WHERE last_name LIKE '%Allen%';
--
-- Cambio realizado:
-- Se sustituye LIKE por ILIKE para que la búsqueda no dependa
-- de mayúsculas o minúsculas. Así la consulta encuentra
-- 'Allen', 'ALLEN' o cualquier otra combinación.

SELECT
    first_name,
    last_name
FROM actor
WHERE last_name ILIKE '%Allen%';


-- =========================================================
-- 7. Encuentra la cantidad total de películas en cada
--    clasificación de la tabla film y muestra la
--    clasificación junto con el recuento.
-- =========================================================

SELECT
    rating,
    COUNT(*) AS total_peliculas
FROM film
GROUP BY
    rating
ORDER BY
    total_peliculas DESC,
    rating ASC;

-- =========================================================
-- 8. Encuentra el título de todas las películas que son
--    'PG-13' o tienen una duración mayor a 3 horas.
-- =========================================================

SELECT
    title
FROM film
WHERE rating = 'PG-13'
   OR length > 180
ORDER BY
    title ASC;


-- =========================================================
-- 9. Encuentra la variabilidad de lo que costaría
--    reemplazar las películas.
-- =========================================================

SELECT
    VAR_SAMP(replacement_cost) AS varianza_reemplazo,
    STDDEV_SAMP(replacement_cost) AS desviacion_estandar_reemplazo
FROM film;


-- =========================================================
-- 10. Encuentra la mayor y menor duración de una película
--     de nuestra BBDD.
-- =========================================================

SELECT
    MAX(length) AS duracion_maxima,
    MIN(length) AS duracion_minima
FROM film;


-- =========================================================
-- 11. Encuentra lo que costó el antepenúltimo alquiler
--     ordenado por día.
-- =========================================================

SELECT
    r.rental_id,
    r.rental_date,
    p.amount AS coste_alquiler
FROM rental r
JOIN payment p
    ON p.rental_id = r.rental_id
ORDER BY
    r.rental_date DESC,
    r.rental_id DESC
OFFSET 2
LIMIT 1;



-- =========================================================
-- 12. Encuentra el título de las películas en la tabla
--     film que no sean ni 'NC-17' ni 'G'.
-- =========================================================

SELECT
    title
FROM film
WHERE rating NOT IN ('NC-17', 'G')
ORDER BY
    title ASC;



-- =========================================================
-- 13. Encuentra el promedio de duración de las películas
--     para cada clasificación de la tabla film y muestra
--     la clasificación junto con el promedio de duración.
-- =========================================================

SELECT
    rating,
    ROUND(AVG(length), 2) AS promedio_duracion
FROM film
GROUP BY
    rating
ORDER BY
    rating ASC;


-- =========================================================
-- 14. Encuentra el título de todas las películas que
--     tengan una duración mayor a 180 minutos.
-- =========================================================

SELECT
    title
FROM film
WHERE length > 180
ORDER BY
    title ASC;

-- =========================================================
-- 15. ¿Cuánto dinero ha generado en total la empresa?
-- =========================================================

SELECT
    SUM(amount) AS dinero_total_generado
FROM payment;

-- =========================================================
-- 16. Muestra los 10 clientes con mayor valor de id.
-- =========================================================

SELECT
    customer_id,
    first_name,
    last_name
FROM customer
ORDER BY
    customer_id DESC
LIMIT 10;


-- =========================================================
-- 17. Encuentra el nombre y apellido de los actores que
--     aparecen en la película con título 'Egg Igby'.
-- =========================================================

-- Código anterior:
 SELECT
     a.first_name,
     a.last_name
 FROM actor a
 JOIN film_actor fa
     ON a.actor_id = fa.actor_id
 JOIN film f
     ON fa.film_id = f.film_id
 WHERE f.title = 'EGG IGBY'
 ORDER BY
     a.last_name ASC,
     a.first_name ASC;
--
-- Cambio realizado:
-- Se sustituye la comparación exacta por ILIKE para que la
-- consulta no dependa de cómo venga escrito el título en
-- mayúsculas o minúsculas.
-- En este caso no varía el resultado pero en otras BBDD
-- podría afectar.
-- La estructura de tablas y relaciones sí es correcta:
-- actor se relaciona con film a través de film_actor.

SELECT
    a.first_name,
    a.last_name
FROM actor a
JOIN film_actor fa
    ON a.actor_id = fa.actor_id
JOIN film f
    ON fa.film_id = f.film_id
WHERE f.title ILIKE 'Egg Igby'
ORDER BY
    a.last_name ASC,
    a.first_name ASC;


-- =========================================================
-- 18. Selecciona todos los nombres de las películas únicos.
-- =========================================================

SELECT DISTINCT
    title
FROM film
ORDER BY
    title ASC;


-- =========================================================
-- 19. Encuentra el título de las películas que son
--     comedias y tienen una duración mayor a 180 minutos.
-- =========================================================

SELECT
    f.title
FROM film f
JOIN film_category fc
    ON f.film_id = fc.film_id
JOIN category c
    ON fc.category_id = c.category_id
WHERE c.name = 'Comedy'
  AND f.length > 180
ORDER BY
    f.title ASC;


-- =========================================================
-- 20. Encuentra las categorías de películas que tienen un
--     promedio de duración superior a 110 minutos y
--     muestra el nombre de la categoría junto con el
--     promedio de duración.
-- =========================================================

SELECT
    c.name AS categoria,
    ROUND(AVG(f.length), 2) AS promedio_duracion
FROM category c
JOIN film_category fc
    ON c.category_id = fc.category_id
JOIN film f
    ON fc.film_id = f.film_id
GROUP BY
    c.name
HAVING AVG(f.length) > 110
ORDER BY
    promedio_duracion DESC,
    c.name ASC;


-- =========================================================
-- 21. ¿Cuál es la media de duración del alquiler de las
--     películas?
-- =========================================================

-- Código anterior:
 SELECT
     ROUND(
         AVG(EXTRACT(EPOCH FROM (return_date - rental_date)) / 86400.0),
         2
     ) AS media_dias_alquiler
 FROM rental
 WHERE return_date IS NOT NULL;

-- Cambio realizado:
-- Se sustituye el cálculo en segundos convertido a días por
-- AVG(return_date - rental_date), ya que return_date y
-- rental_date son columnas timestamp de la tabla rental.
-- Nos daría dias - horas en ves de solo dias con decimales.

SELECT
    AVG(return_date - rental_date) AS media_duracion_alquiler
FROM rental
WHERE return_date IS NOT NULL;


-- =========================================================
-- 22. Crea una columna con el nombre y apellidos de todos
--     los actores y actrices.
-- =========================================================

SELECT
    actor_id,
    first_name || ' ' || last_name AS nombre_completo
FROM actor
ORDER BY
    actor_id ASC;

-- Cambio realizado:
-- Se puede realizar con la funcion CONCAT.
-- El resultado es el mismo.

SELECT
    actor_id,
    CONCAT(first_name, ' ', last_name) AS nombre_completo
FROM actor
ORDER BY
    actor_id ASC;


-- =========================================================
-- 23. Números de alquiler por día, ordenados por cantidad
--     de alquiler de forma descendente.
-- =========================================================

SELECT
    DATE(rental_date) AS dia,
    COUNT(*) AS numero_alquileres
FROM rental
GROUP BY
    DATE(rental_date)
ORDER BY
    numero_alquileres DESC,
    dia DESC;



-- =========================================================
-- 24. Encuentra las películas con una duración superior al
--     promedio.
-- =========================================================

SELECT
    title,
    length
FROM film
WHERE length > (
    SELECT
        AVG(length)
    FROM film
)
ORDER BY
    length DESC,
    title ASC;



-- =========================================================
-- 25. Averigua el número de alquileres registrados por mes.
-- =========================================================

SELECT
    DATE_TRUNC('month', rental_date)::date AS mes,
    COUNT(*) AS numero_alquileres
FROM rental
GROUP BY
    DATE_TRUNC('month', rental_date)
ORDER BY
    mes ASC;


-- =========================================================
-- 26. Encuentra el promedio, la desviación estándar y
--     varianza del total pagado.
-- =========================================================

SELECT
    ROUND(AVG(amount), 2) AS promedio_pagado,
    ROUND(STDDEV_SAMP(amount), 2) AS desviacion_estandar_pagado,
    ROUND(VAR_SAMP(amount), 2) AS varianza_pagado
FROM payment;


-- =========================================================
-- 27. ¿Qué películas se alquilan por encima del precio
--     medio?
-- =========================================================

SELECT DISTINCT
    f.title,
    f.rental_rate
FROM film f
JOIN inventory i
    ON f.film_id = i.film_id
JOIN rental r
    ON i.inventory_id = r.inventory_id
WHERE f.rental_rate > (
    SELECT
        AVG(rental_rate)
    FROM film
)
ORDER BY
    f.rental_rate DESC,
    f.title ASC;



-- =========================================================
-- 28. Muestra el id de los actores que hayan participado en
--     más de 40 películas.
-- =========================================================

SELECT
    actor_id
FROM film_actor
GROUP BY
    actor_id
HAVING COUNT(*) > 40
ORDER BY
    actor_id ASC;


-- =========================================================
-- 29. Obtener todas las películas y, si están disponibles
--     en el inventario, mostrar la cantidad disponible.
-- =========================================================

SELECT
    f.film_id,
    f.title,
    COUNT(i.inventory_id) FILTER (
        WHERE inventory_in_stock(i.inventory_id)
    ) AS cantidad_disponible
FROM film f
LEFT JOIN inventory i
    ON f.film_id = i.film_id
GROUP BY
    f.film_id,
    f.title
ORDER BY
    f.title ASC;



-- =========================================================
-- 30. Obtener los actores y el número de películas en las
--     que ha actuado.
-- =========================================================

SELECT
    a.actor_id,
    a.first_name,
    a.last_name,
    COUNT(fa.film_id) AS numero_peliculas
FROM actor a
LEFT JOIN film_actor fa
    ON a.actor_id = fa.actor_id
GROUP BY
    a.actor_id,
    a.first_name,
    a.last_name
ORDER BY
    numero_peliculas DESC,
    a.last_name ASC,
    a.first_name ASC;




-- =========================================================
-- 31. Obtener todas las películas y mostrar los actores que
--     han actuado en ellas, incluso si algunas películas no
--     tienen actores asociados.
-- =========================================================

SELECT
    f.film_id,
    f.title,
    STRING_AGG(
        CONCAT(a.first_name, ' ', a.last_name),
        ', '
        ORDER BY a.last_name, a.first_name
    ) AS actores
FROM film f
LEFT JOIN film_actor fa
    ON f.film_id = fa.film_id
LEFT JOIN actor a
    ON fa.actor_id = a.actor_id
GROUP BY
    f.film_id,
    f.title
ORDER BY
    f.title ASC;



-- =========================================================
-- 32. Obtener todos los actores y mostrar las películas en
--     las que han actuado, incluso si algunos actores no
--     han actuado en ninguna película.
-- =========================================================

SELECT
    a.actor_id,
    a.first_name,
    a.last_name,
    STRING_AGG(
        f.title,
        ', '
        ORDER BY f.title
    ) AS peliculas
FROM actor a
LEFT JOIN film_actor fa
    ON a.actor_id = fa.actor_id
LEFT JOIN film f
    ON fa.film_id = f.film_id
GROUP BY
    a.actor_id,
    a.first_name,
    a.last_name
ORDER BY
    a.last_name ASC,
    a.first_name ASC;


-- =========================================================
-- 33. Obtener todas las películas que tenemos y todos los
--     registros de alquiler.
-- =========================================================

SELECT
    f.title,
    i.inventory_id,
    r.rental_id,
    r.rental_date,
    r.return_date
FROM film f
LEFT JOIN inventory i
    ON f.film_id = i.film_id
LEFT JOIN rental r
    ON i.inventory_id = r.inventory_id
ORDER BY
    f.title ASC,
    r.rental_date ASC;



-- =========================================================
-- 34. Encuentra los 5 clientes que más dinero se hayan
--     gastado con nosotros.
-- =========================================================

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    SUM(p.amount) AS total_gastado
FROM customer c
JOIN payment p
    ON c.customer_id = p.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
ORDER BY
    total_gastado DESC,
    c.customer_id ASC
LIMIT 5;



-- =========================================================
-- 35. Selecciona todos los actores cuyo primer nombre es
--     'Johnny'.
-- =========================================================


SELECT
    *
FROM actor
WHERE first_name ILIKE 'Johnny';


-- =========================================================
-- 36. Renombra la columna “first_name” como Nombre y
--     “last_name” como Apellido.
-- =========================================================


-- Si solo quieres cambiarlas en la consulta
SELECT
    first_name AS "Nombre",
    last_name AS "Apellido"
FROM actor;


-- Si en su lugar quieres modificar la tabla 

ALTER TABLE actor
RENAME COLUMN first_name TO nombre;

ALTER TABLE actor
RENAME COLUMN last_name TO apellido;


-- =========================================================
-- 37. Encuentra el ID del actor más bajo y más alto en la
--     tabla actor.
-- =========================================================

SELECT
    MIN(actor_id) AS actor_id_minimo,
    MAX(actor_id) AS actor_id_maximo
FROM actor;


-- =========================================================
-- 38. Cuenta cuántos actores hay en la tabla “actor”.
-- =========================================================

SELECT
    COUNT(*) AS total_actores
FROM actor;


-- =========================================================
-- 39. Selecciona todos los actores y ordénalos por apellido
--     en orden ascendente.
-- =========================================================

SELECT
    *
FROM actor
ORDER BY
    last_name ASC,
    first_name ASC;


-- =========================================================
-- 40. Selecciona las primeras 5 películas de la tabla
--     “film”.
-- =========================================================

SELECT
    *
FROM film
ORDER BY
    film_id ASC
LIMIT 5;


-- =========================================================
-- 41. Agrupa los actores por su nombre y cuenta cuántos
--     actores tienen el mismo nombre. ¿Cuál es el nombre
--     más repetido?
-- =========================================================

SELECT
    first_name,
    COUNT(*) AS total_actores
FROM actor
GROUP BY
    first_name
ORDER BY
    total_actores DESC,
    first_name ASC;



-- =========================================================
-- 42. Encuentra todos los alquileres y los nombres de los
--     clientes que los realizaron.
-- =========================================================

SELECT
    r.rental_id,
    r.rental_date,
    r.return_date,
    c.customer_id,
    c.first_name,
    c.last_name
FROM rental r
JOIN customer c
    ON r.customer_id = c.customer_id
ORDER BY
    r.rental_date ASC,
    r.rental_id ASC;



-- =========================================================
-- 43. Muestra todos los clientes y sus alquileres si
--     existen, incluyendo aquellos que no tienen alquileres.
-- =========================================================

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    r.rental_id,
    r.rental_date,
    r.return_date
FROM customer c
LEFT JOIN rental r
    ON c.customer_id = r.customer_id
ORDER BY
    c.customer_id ASC,
    r.rental_date ASC;


-- Comprobacion de que existen clientes sin alquileres, ya que al revisar
-- No veía registros con los campos de alquiler en [NULL]

SELECT
    c.customer_id,
    c.first_name,
    c.last_name
FROM customer c
LEFT JOIN rental r
    ON c.customer_id = r.customer_id
WHERE r.rental_id IS NULL;



-- =========================================================
-- 44. Realiza un CROSS JOIN entre las tablas film y
--     category. ¿Aporta valor esta consulta? ¿Por qué?
-- =========================================================

SELECT
    f.title,
    c.name AS categoria
FROM film f
CROSS JOIN category c
ORDER BY
    f.title ASC,
    c.name ASC;

-- Respuesta:
-- Esta consulta no suele aportar mucho valor
-- salvo que quieras tener todas las combinaciones posibles 




-- =========================================================
-- 45. Encuentra los actores que han participado en películas
--     de la categoría 'Action'.
-- =========================================================

SELECT DISTINCT
    a.actor_id,
    a.first_name,
    a.last_name
FROM actor a
JOIN film_actor fa
    ON a.actor_id = fa.actor_id
JOIN film_category fc
    ON fa.film_id = fc.film_id
JOIN category c
    ON fc.category_id = c.category_id
WHERE c.name = 'Action'
ORDER BY
    a.last_name ASC,
    a.first_name ASC;



-- =========================================================
-- 46. Encuentra todos los actores que no han participado en
--     películas.
-- =========================================================

SELECT
    a.actor_id,
    a.first_name,
    a.last_name
FROM actor a
LEFT JOIN film_actor fa
    ON a.actor_id = fa.actor_id
WHERE fa.film_id IS NULL
ORDER BY
    a.last_name ASC,
    a.first_name ASC;


-- =========================================================
-- 47. Selecciona el nombre de los actores y la cantidad de
--     películas en las que han participado.
-- =========================================================

SELECT
    a.first_name,
    a.last_name,
    COUNT(fa.film_id) AS cantidad_peliculas
FROM actor a
LEFT JOIN film_actor fa
    ON a.actor_id = fa.actor_id
GROUP BY
    a.actor_id,
    a.first_name,
    a.last_name
ORDER BY
    cantidad_peliculas DESC,
    a.last_name ASC,
    a.first_name ASC;


-- =========================================================
-- 48. Crea una vista llamada “actor_num_peliculas” que
--     muestre los nombres de los actores y el número de
--     películas en las que han participado.
-- =========================================================

CREATE OR REPLACE VIEW actor_num_peliculas AS
SELECT
    a.actor_id,
    a.first_name,
    a.last_name,
    COUNT(fa.film_id) AS numero_peliculas
FROM actor a
LEFT JOIN film_actor fa
    ON a.actor_id = fa.actor_id
GROUP BY
    a.actor_id,
    a.first_name,
    a.last_name;



-- =========================================================
-- 49. Calcula el número total de alquileres realizados por
--     cada cliente.
-- =========================================================

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(r.rental_id) AS total_alquileres
FROM customer c
LEFT JOIN rental r
    ON c.customer_id = r.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
ORDER BY
    total_alquileres DESC,
    c.customer_id ASC;



-- =========================================================
-- 50. Calcula la duración total de las películas en la
--     categoría 'Action'.
-- =========================================================

SELECT
    c.name AS categoria,
    SUM(f.length) AS duracion_total
FROM category c
JOIN film_category fc
    ON c.category_id = fc.category_id
JOIN film f
    ON fc.film_id = f.film_id
WHERE c.name = 'Action'
GROUP BY
    c.name;



-- =========================================================
-- 51. Crea una tabla temporal llamada “cliente_rentas_temporal”
--     para almacenar el total de alquileres por cliente.
-- =========================================================


-- En caso de que se necesite actualizar
DROP TABLE IF EXISTS cliente_rentas_temporal;

CREATE TEMP TABLE cliente_rentas_temporal AS
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(r.rental_id) AS total_alquileres
FROM customer c
LEFT JOIN rental r
    ON c.customer_id = r.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name;

-- Comprobacion rapida de la tabla temporal
select * from cliente_rentas_temporal;


-- =========================================================
-- 52. Crea una tabla temporal llamada “peliculas_alquiladas”
--     que almacene las películas que han sido alquiladas al
--     menos 10 veces.
-- =========================================================

DROP TABLE IF EXISTS peliculas_alquiladas;

CREATE TEMP TABLE peliculas_alquiladas AS
SELECT
    f.film_id,
    f.title,
    COUNT(r.rental_id) AS total_alquileres
FROM film f
JOIN inventory i
    ON f.film_id = i.film_id
JOIN rental r
    ON i.inventory_id = r.inventory_id
GROUP BY
    f.film_id,
    f.title
HAVING COUNT(r.rental_id) >= 10;

-- Comprobacion rapida de la tabla temporal
select * from peliculas_alquiladas;




-- =========================================================
-- 53. Encuentra el título de las películas que han sido
--     alquiladas por el cliente con el nombre
--     ‘Tammy Sanders’ y que aún no se han devuelto.
--     Ordena los resultados alfabéticamente por título.
-- =========================================================

-- Código anterior:
 SELECT DISTINCT
     f.title
 FROM customer c
 JOIN rental r
     ON c.customer_id = r.customer_id
 JOIN inventory i
     ON r.inventory_id = i.inventory_id
 JOIN film f
     ON i.film_id = f.film_id
 WHERE c.first_name ILIKE 'Tammy'
   AND c.last_name ILIKE 'Sanders'
   AND r.return_date IS NULL
 ORDER BY
     f.title ASC;


-- Cambio realizado:
-- Se unen nombre y apellido en una sola comparación para
-- reducir líneas en el WHERE y dejar la condición más compacta.
-- ILIKE se mantiene para no depender de mayúsculas o minúsculas.

SELECT DISTINCT
    f.title
FROM customer c
JOIN rental r
    ON c.customer_id = r.customer_id
JOIN inventory i
    ON r.inventory_id = i.inventory_id
JOIN film f
    ON i.film_id = f.film_id
WHERE CONCAT(c.first_name, ' ', c.last_name) ILIKE 'Tammy Sanders'
  AND r.return_date IS NULL
ORDER BY
    f.title ASC;




-- =========================================================
-- 54. Encuentra los nombres de los actores que han actuado
--     en al menos una película que pertenece a la categoría
--     ‘Sci-Fi’. Ordena los resultados alfabéticamente por
--     apellido.
-- =========================================================

-- Código anterior:
SELECT DISTINCT
    a.first_name,
    a.last_name
FROM actor a
JOIN film_actor fa
    ON a.actor_id = fa.actor_id
JOIN film_category fc
    ON fa.film_id = fc.film_id
JOIN category c
    ON fc.category_id = c.category_id
WHERE c.name = 'Sci-Fi'
ORDER BY
    a.last_name ASC,
    a.first_name ASC;

-- Cambio realizado:
-- Se sustituye JOIN + DISTINCT por EXISTS porque el enunciado
-- pide actores que hayan participado en al menos una película
-- de la categoría Sci-Fi.


SELECT
    a.first_name,
    a.last_name
FROM actor a
WHERE EXISTS (
    SELECT
        1
    FROM film_actor fa
    JOIN film_category fc
        ON fa.film_id = fc.film_id
    JOIN category c
        ON fc.category_id = c.category_id
    WHERE fa.actor_id = a.actor_id
      AND c.name ILIKE 'Sci-Fi'
)
ORDER BY
    a.last_name ASC,
    a.first_name ASC;




-- =========================================================
-- 55. Encuentra el nombre y apellido de los actores que han
--     actuado en películas que se alquilaron después de que
--     la película ‘Spartacus Cheaper’ se alquilara por
--     primera vez. Ordena los resultados alfabéticamente
--     por apellido.
-- =========================================================

-- Sacamos la primera fecha del titulo 'Spartacus Cheaper'
WITH primera_fecha_spartacus AS (
    SELECT
        MIN(r.rental_date) AS primera_fecha
    FROM film f
    JOIN inventory i
        ON f.film_id = i.film_id
    JOIN rental r
        ON i.inventory_id = r.inventory_id
    WHERE f.title ILIKE 'Spartacus Cheaper'
)

-- Usamos dicha fecha para las uniones de tablas y filtrar directamente.
SELECT DISTINCT
    a.first_name,
    a.last_name
FROM primera_fecha_spartacus p
JOIN rental r
    ON r.rental_date > p.primera_fecha
JOIN inventory i
    ON r.inventory_id = i.inventory_id
JOIN film_actor fa
    ON i.film_id = fa.film_id
JOIN actor a
    ON fa.actor_id = a.actor_id
ORDER BY
    a.last_name ASC,
    a.first_name ASC;


-- =========================================================
-- 56. Encuentra el nombre y apellido de los actores que no
--     han actuado en ninguna película de la categoría
--     ‘Music’.
-- =========================================================


SELECT
    a.first_name,
    a.last_name
FROM actor a
WHERE NOT EXISTS (
    SELECT
        1
    FROM film_actor fa
    JOIN film_category fc
        ON fa.film_id = fc.film_id
    JOIN category c
        ON fc.category_id = c.category_id
    WHERE fa.actor_id = a.actor_id
      AND c.name ILIKE 'Music'
)
ORDER BY
    a.last_name ASC,
    a.first_name ASC;



-- =========================================================
-- 57. Encuentra el título de todas las películas que fueron
--     alquiladas por más de 8 días.
-- =========================================================

SELECT DISTINCT
    f.title
FROM film f
JOIN inventory i
    ON f.film_id = i.film_id
JOIN rental r
    ON i.inventory_id = r.inventory_id
WHERE r.return_date IS NOT NULL
  AND (r.return_date - r.rental_date) > INTERVAL '8 days'  -- asi no tenemos que hacer gestiones de tiempo
ORDER BY
    f.title ASC;




-- =========================================================
-- 58. Encuentra el título de todas las películas que son de
--     la misma categoría que ‘Animation’.
-- =========================================================

SELECT DISTINCT
    f.title
FROM film f
JOIN film_category fc
    ON f.film_id = fc.film_id
JOIN category c
    ON fc.category_id = c.category_id
WHERE c.name ILIKE 'Animation'
ORDER BY
    f.title ASC;



-- =========================================================
-- 59. Encuentra los nombres de las películas que tienen la
--     misma duración que la película con el título
--     ‘Dancing Fever’. Ordena los resultados alfabéticamente
--     por título de película.
-- =========================================================

SELECT
    title
FROM film
WHERE length = (
    SELECT
        length
    FROM film
    WHERE title ILIKE 'Dancing Fever'
)
ORDER BY
    title ASC;



-- =========================================================
-- 60. Encuentra los nombres de los clientes que han
--     alquilado al menos 7 películas distintas. Ordena los
--     resultados alfabéticamente por apellido.
-- =========================================================

SELECT
    c.first_name,
    c.last_name
FROM customer c
JOIN rental r
    ON c.customer_id = r.customer_id
JOIN inventory i
    ON r.inventory_id = i.inventory_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
HAVING COUNT(DISTINCT i.film_id) >= 7
ORDER BY
    c.last_name ASC,
    c.first_name ASC;


-- =========================================================
-- 61. Encuentra la cantidad total de películas alquiladas
--     por categoría y muestra el nombre de la categoría
--     junto con el recuento de alquileres.
-- =========================================================

SELECT
    c.name AS categoria,
    COUNT(r.rental_id) AS total_alquileres
FROM category c
JOIN film_category fc
    ON c.category_id = fc.category_id
JOIN film f
    ON fc.film_id = f.film_id
JOIN inventory i
    ON f.film_id = i.film_id
JOIN rental r
    ON i.inventory_id = r.inventory_id
GROUP BY
    c.name
ORDER BY
    total_alquileres DESC,
    c.name ASC;



-- =========================================================
-- 62. Encuentra el número de películas por categoría
--     estrenadas en 2006.
-- =========================================================

SELECT
    c.name AS categoria,
    COUNT(f.film_id) AS numero_peliculas_2006
FROM category c
JOIN film_category fc
    ON c.category_id = fc.category_id
JOIN film f
    ON fc.film_id = f.film_id
WHERE f.release_year = 2006
GROUP BY
    c.name
ORDER BY
    numero_peliculas_2006 DESC,
    c.name ASC;



-- =========================================================
-- 63. Obtén todas las combinaciones posibles de
--     trabajadores con las tiendas que tenemos.
-- =========================================================

SELECT
    s.staff_id,
    s.first_name,
    s.last_name,
    st.store_id
FROM staff s
CROSS JOIN store st
ORDER BY
    s.staff_id ASC,
    st.store_id ASC;



-- =========================================================
-- 64. Encuentra la cantidad total de películas alquiladas
--     por cada cliente y muestra el ID del cliente, su
--     nombre y apellido junto con la cantidad de películas
--     alquiladas.
-- =========================================================

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(r.rental_id) AS cantidad_peliculas_alquiladas
FROM customer c
LEFT JOIN rental r
    ON c.customer_id = r.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
ORDER BY
    cantidad_peliculas_alquiladas DESC,
    c.customer_id ASC;


