# Final Evaluation – Module 2 (Data Analytics & AI · Adalab)

## Objective / Objetivo
Development of a series of **SQL queries** using the **Sakila database** to demonstrate mastery of data extraction, filtering, aggregation, and relational operations.  
Desarrollo de una serie de **consultas SQL** utilizando la **base de datos Sakila** para demostrar dominio en extracción, filtrado, agregación y operaciones relacionales.

---

## Database Context / Contexto de la Base de Datos
**Sakila** simulates a movie rental store and includes interconnected tables such as:
- `film` – movie details  
- `actor` – actors and actresses  
- `customer` – clients  
- `rental` – rentals  
- `category` – movie genres  
- `film_actor`, `film_category` – relationship tables  

La base de datos **Sakila** simula una tienda de alquiler de películas con tablas interconectadas como las anteriores.

---

## Exercise Description / Descripción del Ejercicio
The evaluation consists of **24 SQL exercises** covering:
1. Data selection and filtering (`SELECT`, `WHERE`, `BETWEEN`, `LIKE`).
2. Aggregation and grouping (`COUNT`, `AVG`, `GROUP BY`, `HAVING`).
3. Use of `JOIN`, `UNION`, and `UNION ALL`.
4. Use of **subqueries** and **correlated subqueries**.
5. Logical conditions and data comparison.

La evaluación incluye **24 ejercicios SQL** que abarcan selección de datos, agrupaciones, uniones, subconsultas y condiciones lógicas.

---

## Example Query / Ejemplo de Consulta

```sql
-- Find all movies rated "PG-13"
SELECT title
FROM film
WHERE rating = 'PG-13';

-- Encuentra todos los títulos de películas con clasificación "PG-13"
SELECT title
FROM film
WHERE rating = 'PG-13';
```

---

## Learning Goals / Objetivos de Aprendizaje
✅ Understand and apply the structure of SQL statements.  
✅ Practice querying relational databases using MySQL Workbench.  
✅ Combine multiple tables through JOINs and subqueries.  
✅ Perform aggregations and conditional filters.  
✅ Strengthen analytical reasoning for database problem solving.

---

## How to Run / Cómo Ejecutar

1. **Open MySQL Workbench** and connect to your local server.  
   *Abre MySQL Workbench y conéctate a tu servidor local.*

2. **Load the Sakila database**:  
   ```sql
   SOURCE sakila-schema.sql;
   SOURCE sakila-data.sql;
   Provided by ADALAB / Proporcionado por ADALAB.
   ```

3. **Open and execute the script** `evaluacion_final-modulo-2-data-analytics-claudia-cervantes-lecours.sql`.  
   *Abre y ejecuta el archivo `.sql` en el orden indicado.*

4. **Review results and verify outputs** for each query.  
   *Revisa los resultados para comprobar el funcionamiento de cada consulta.*

---

## Testing and Validation / Pruebas y Validación
- Each query was executed and tested directly in **MySQL Workbench**.  
- Verified outputs against expected results from the **Sakila dataset**.  
- All statements were formatted and commented for clarity.  
- Subqueries and joins were validated using sample data and cross-checks.

---

## Evaluation Criteria / Criterios de Evaluación
According to Adalab’s rubric:  
- ✅ Basic SQL operations (`SELECT`, `INSERT`, `UPDATE`, `DELETE`)  
- ✅ Grouping, filtering, and conditions (`WHERE`, `HAVING`, `GROUP BY`)  
- ✅ Use of joins (`JOIN`, `UNION`, `UNION ALL`)  
- ✅ Use of subqueries and correlated subqueries  
- ✅ Clear structure and commented code in GitHub repository  

---

## Author / Autora  
**Claudia Cervantes Lecours**  
Bootcamp Data Analytics & AI – Adalab
