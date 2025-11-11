/* Evaluación Final Módulo 2: SQL | Claudia Cervantes Lecours 
(la PRIMERA respuesta es la RESPUESTA FINAL - justo debajo del ejercicio | pruebas, queries, notas suelen estar mas abajo)*/

USE sakila;

/* 1. Selecciona todos los nombres de las películas sin que aparezcan duplicados. */
SELECT DISTINCT title
	FROM film;

/* 2. Muestra los nombres de todas las películas que tengan una clasificación de "PG-13" */
SELECT title
	FROM film
    WHERE rating = 'PG-13';

/* 3. Encuentra el título y la descripción de todas las películas que contengan 
la palabra "amazing" en su descripción. */
SELECT title, description  						-- descripcion - aunque este en negrita azul, no es una palabra reservada en MySQL es un identificador (no hacian falta backticks)
	FROM film
    WHERE description LIKE '%amazing%';			-- LIKE no importan mayuscula/minuscula

/* 4. Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos. */
SELECT title, length
	FROM film
    WHERE length > 120;
    
SELECT *
	FROM film;

/* 5. Recupera los nombres de todos los actores. */
SELECT first_name, last_name
	FROM actor;

/* 6. Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido. */
SELECT first_name, last_name
	FROM actor
    WHERE last_name LIKE '%Gibson%'; 			-- con % por si acaso es un apellido compuesto

/* 7. Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20. */
SELECT first_name, last_name
	FROM actor
    WHERE actor_id BETWEEN 10 AND 20;
    
SELECT first_name, last_name
	FROM actor
    WHERE actor_id >= 10 AND actor_id <= 20;	-- mejor con BETWEEN

SELECT *
	FROM actor;

/* 8. Encuentra el título de las películas en la tabla film que no sean 
ni "R" ni "PG-13" en cuanto a su clasificación. */
SELECT title
	FROM film
    WHERE rating NOT IN ('R', 'PG-13');

SELECT title, rating
	FROM film
    WHERE rating IN ('R', 'PG-13');  -- comprobando lo contrario - que el entre el IN y NOT IN suman al total (1000) ;)
    
SELECT *
	FROM film;
    
/* 9. Encuentra la cantidad total de películas en cada clasificación de la tabla film y muestra la
clasificación junto con el recuento. */
SELECT rating, COUNT(rating) AS total_films_in_rating
	FROM film
    GROUP BY rating;

SELECT *
	FROM category;  				-- clasificacion es rating, no category name

SELECT *
	FROM film;

/* 10. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su
nombre y apellido junto con la cantidad de películas alquiladas. */
SELECT c.customer_id AS id, c.first_name, c.last_name, COUNT(r.rental_id) AS total_rentals
	FROM customer AS c
	LEFT JOIN rental AS r ON c.customer_id = r.customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name;

SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) AS total_rentals
	FROM customer AS c
	LEFT JOIN rental AS r ON c.customer_id = r.customer_id
	GROUP BY c.customer_id, c.first_name, c.last_name
    HAVING COUNT(r.rental_id) = 0;   	-- LEFT JOIN incluye 0s en COUNT (interpreto que sea deseado incluyendo clientes sin alquilar) | por curiosidad queria ver cuantos 0 (no habian)
    
SELECT COUNT(customer_id)
	FROM customer;						-- confirmando numero de customer ids (599 - cuadra)

/* 11. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría
junto con el recuento de alquileres. */
SELECT DISTINCT c.name AS category_name, COUNT(r.rental_id) AS total_rentals_by_category
	FROM category AS c
    INNER JOIN film_category AS fc ON c.category_id = fc.category_id
    INNER JOIN film AS f ON fc.film_id = f.film_id
    INNER JOIN inventory AS i ON f.film_id = i.film_id
    INNER JOIN rental AS r ON i.inventory_id = r.inventory_id
    GROUP BY c.name;				

SELECT DISTINCT c.name AS category_name, COUNT(r.rental_id) AS total_rentals_by_category
	FROM category AS c
    LEFT JOIN film_category AS fc ON c.category_id = fc.category_id
    LEFT JOIN film AS f ON fc.film_id = f.film_id
    LEFT JOIN inventory AS i ON f.film_id = i.film_id
    LEFT JOIN rental AS r ON i.inventory_id = r.inventory_id
    GROUP BY c.name;						-- LEFT JOIN o INNER JOIN (igual que el anterior) pero decidi desviar a INNER JOIN
    
SELECT DISTINCT c.name, COUNT(fc.film_id) AS total_films_in_category 
	FROM category AS c 
    LEFT JOIN film_category AS fc ON c.category_id = fc.category_id 
    GROUP BY c.name;						
											-- films por categoria luego desarrollar hasta el rental con JOIN (COUNT de pk en rental, DISTINCT por defecto)
SELECT *
	FROM category;
    
SELECT *
	FROM film_category;

/* 12. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y
muestra la clasificación junto con el promedio de duración. */
SELECT rating, ROUND(AVG(length)) AS average_duration
	FROM film
    GROUP BY rating;
											-- ROUND() para quitar los 4 digitos despues del . (no es una carrera de Hussein Bolt)
SELECT *
	FROM film
    LIMIT 15;

/* 13. Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love". */
SELECT a.first_name, a.last_name
	FROM actor AS a
    INNER JOIN film_actor as fa ON a.actor_id = fa.actor_id
    INNER JOIN film as f ON fa.film_id = f.film_id
    WHERE f.title LIKE 'Indian Love';
	
SELECT *
	FROM film
    WHERE title LIKE 'Indian Love';
    
SELECT COUNT(DISTINCT actor_id)
	FROM film_actor
    WHERE film_id = 458;          				-- comprobando cantidad de actores con output de query final (10 = 10)

/* 14. Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción. */
    
SELECT title, description
	FROM film
    WHERE description LIKE '%dog%' OR description LIKE '%cat%';  
												-- LIKE requiere todo repetido (no se puede con lista ni simple OR)

/* 15. Hay algún actor o actriz que no aparezca en ninguna película en la tabla film_actor. */
SELECT a.actor_id, a.first_name, a.last_name
	FROM actor AS a
    LEFT JOIN film_actor AS fa ON a.actor_id = fa.actor_id
    WHERE fa.actor_id IS NULL;					-- Repuesta: NO | LEFT JOIN asegurando que se incluyeran los que no estaban


SELECT a.actor_id, a.first_name, a.last_name
FROM actor AS a
WHERE NOT EXISTS (
    SELECT 1
    FROM film_actor AS fa
    WHERE fa.actor_id = a.actor_id
);												-- intente la opcion con WHERE NOT EXITS no me salia - esto es con ayuda de IA

SELECT COUNT(*) 
	FROM actor;

SELECT COUNT(DISTINCT actor_id) 
	FROM film_actor;   							-- comprobando los resultados (actors = film_actors)

/* 16. Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010. */
SELECT title
	FROM film
    WHERE release_year BETWEEN 2005 AND 2010;	

SELECT title, release_year
	FROM film
    WHERE release_year LIKE 2006;	-- comprobando anos, solo salen de 2006 

/* 17. Encuentra el título de todas las películas que son de la misma categoría que "Family". */
SELECT f.title
	FROM film AS f
    INNER JOIN film_category AS fc ON f.film_id = fc.film_id
    INNER JOIN category AS c ON fc.category_id = c.category_id
    WHERE c.name = 'Family';
    
SELECT f.title, c.name
	FROM film AS f
    INNER JOIN film_category AS fc ON f.film_id = fc.film_id
    INNER JOIN category AS c ON fc.category_id = c.category_id
    WHERE c.name = 'Family';		-- comprobacion de category
									-- notas random: tablas --> category - film category - film (luego en orden inner to outer)

/* 18. Muestra el nombre y apellido de los actores que aparecen en más de 10 películas. */
SELECT a.first_name, a.last_name, COUNT(DISTINCT fa.film_id) AS total_films
	FROM actor AS a
    INNER JOIN film_actor AS fa ON a.actor_id = fa.actor_id
    GROUP BY a.actor_id, a.first_name, a.last_name
    HAVING COUNT(DISTINCT fa.film_id) > 10;
    
									-- notas random: film actor, actor, film_id
                                    
/* 19. Encuentra el título de todas las películas que son "R" y tienen 
una duración mayor a 2 horas en la tabla film. */
SELECT title
	FROM film
    WHERE rating = 'R' AND length > 120;

SELECT title, rating, length
	FROM film
    WHERE rating = 'R' AND length > 120;  -- comprobacion
    
/* 20. Encuentra las categorías de películas que tienen un promedio de duración superior a 120 minutos y
muestra el nombre de la categoría junto con el promedio de duración. */
SELECT c.name AS category_name, ROUND(AVG(f.length)) AS average_duration
	FROM category AS c
    INNER JOIN film_category AS fc ON c.category_id = fc.category_id
    INNER JOIN film AS f ON fc.film_id = f.film_id
    GROUP BY c.name
    HAVING AVG(length) > 120;				-- ROUND() para dejarlo mas limpio (sin los 4 digitos despues del .)
											-- notas random: categories - average over 120mins length - 

SELECT c.name AS category_name, ROUND(AVG(f.length))
	FROM category AS c
    INNER JOIN film_category AS fc ON c.category_id = fc.category_id
    INNER JOIN film AS f ON fc.film_id = f.film_id
    GROUP BY c.name
    ORDER BY ROUND(AVG(f.length)) ASC;		-- comprobando (con y sin ROUND en SELECT y ORDER BY)

/* 21. Encuentra los actores que han actuado en al menos 5 películas y muestra el nombre del actor junto
con la cantidad de películas en las que han actuado. */
SELECT a.first_name, a.last_name, COUNT(DISTINCT fa.film_id) AS total_films
	FROM actor AS a
    INNER JOIN film_actor AS fa ON a.actor_id = fa.actor_id
    GROUP BY a.actor_id, a.first_name, a.last_name
    HAVING COUNT(DISTINCT fa.film_id) >= 5;

/* 22. Encuentra el título de todas las películas que fueron alquiladas por más de 5 días. Utiliza una
subconsulta para encontrar los rental_ids con una duración superior a 5 días y luego selecciona las
películas correspondientes. */
SELECT DISTINCT f.title
	FROM film AS f
    INNER JOIN inventory AS i ON f.film_id = i.film_id
    WHERE i.inventory_id IN (
		SELECT r.inventory_id
			FROM rental AS r
            WHERE DATEDIFF(return_date, rental_date) > 5  		-- DATEDIFF(fecha reciente, fecha anterior) viene de ChatGPT buscando el operador (= dias enteros)
);			

SELECT f.title
	FROM film AS f
    INNER JOIN inventory AS i ON f.film_id = i.film_id
    WHERE i.inventory_id IN (
			SELECT r.inventory_id
			FROM rental AS r
            WHERE DATEDIFF(return_date, rental_date) > 5)		-- comprobaciones sin DISTINCT 3904
;

SELECT DISTINCT rental_id, DATEDIFF(return_date, rental_date) AS rental_days
	FROM rental
	WHERE DATEDIFF(return_date, rental_date) > 5; -- total 7161
    
SELECT COUNT(*) FROM rental
	WHERE DATEDIFF(return_date, rental_date) > 5; -- total 7161

SELECT DISTINCT inventory_id, DATEDIFF(return_date, rental_date) AS rental_days
	FROM rental
	WHERE DATEDIFF(return_date, rental_date) > 5; -- total 6120

SELECT COUNT(DISTINCT inventory_id) FROM rental
	WHERE DATEDIFF(return_date, rental_date) > 5;  -- total 3904

SELECT DISTINCT f.title
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
WHERE DATEDIFF(r.return_date, r.rental_date) > 5;  -- total 955

SELECT *
	FROM inventory;
    
SELECT *
	FROM rental;

-- notas random: rental - inventory - film | peliculas correspondientes | rental ids | rentals - 5+ days SUBCONSULTAAA

/* 23. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría
"Horror". Utiliza una subconsulta para encontrar los actores que han actuado en películas de la
categoría "Horror" y luego exclúyelos de la lista de actores. */

SELECT a.first_name, a.last_name
	FROM actor as a
    WHERE a.actor_id NOT IN (
			SELECT fa.actor_id
            FROM film_actor AS fa
			INNER JOIN film AS f ON fa.film_id = f.film_id
			INNER JOIN film_category AS fc ON f.film_id = fc.film_id
			INNER JOIN category AS c ON fc.category_id = c.category_id
			WHERE c.name = 'Horror'); 

-- INTENTO a Subconsulta correlacional -- fracaso con aprendizaje ;)
SELECT a.actor_id, a.first_name, a.last_name	
	FROM actor AS a
    WHERE NOT EXISTS (							-- no hacia falta nombre de columna despues de WHERE, solo NOT EXISTS
			SELECT 1
				FROM film_actor AS fa			-- tabla actor se tenia que mantener fuera | aqui antes tenia de INNER JOIN al FROM +/-
                INNER JOIN film AS f ON fa.film_id = f.film_id
                INNER JOIN film_category AS fc ON f.film_id = fc.film_id
                INNER JOIN category AS c ON fc.category_id = c.category_id
                WHERE fa.actor_id = a.actor_id AND c.name = 'Horror');  -- la linea correlacional con AND :(
	
-- SUBCONSULTA - actors en peliculas de 'Horror' con joins, joins, joins
SELECT a.actor_id, a.first_name, a.last_name, c.name
	FROM actor as a
	INNER JOIN film_actor AS fa ON a.actor_id = fa.actor_id
	INNER JOIN film AS f ON fa.film_id = f.film_id
	INNER JOIN film_category AS fc ON f.film_id = fc.film_id
	INNER JOIN category AS c ON fc.category_id = c.category_id
	WHERE name = 'Horror'; 
					
SELECT *
	FROM category
    WHERE name = 'Horror';

SELECT *
	FROM actor;

-- notas random: film actor - film - film category - category then exclude from actors list


/* 24. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en
la tabla film. */
SELECT f.title
	FROM film AS f
    INNER JOIN film_category AS fc ON f.film_id = fc.film_id
    INNER JOIN category AS c ON fc.category_id = c.category_id
    WHERE c.name = 'Comedy' AND f.length > 180;

SELECT f.title, c.name, f.length
	FROM film AS f
    INNER JOIN film_category AS fc ON f.film_id = fc.film_id
    INNER JOIN category AS c ON fc.category_id = c.category_id
    WHERE c.name = 'Comedy' AND f.length > 180;				-- comprobando para luego quitar en SELECT

SELECT f.title, c.name, f.length
	FROM film AS f
    INNER JOIN film_category AS fc ON f.film_id = fc.film_id
    INNER JOIN category AS c ON fc.category_id = c.category_id
    WHERE c.name = 'Comedy'; 								-- comprobando comedy solo y length total (sin condicion)

SELECT *
	FROM film
    WHERE length > 180; 									-- 39 de ese length sin llegar a category comedy

															-- notas random: titulo (film) - (film category) - category name (category)
