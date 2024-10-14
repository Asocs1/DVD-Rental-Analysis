-- Query about the division of family films into four levels (quarters) depending on the duration of the rental compared to the duration of the rental of all films 

-- Use CTE to create a temporary dataset that uses the main part of the query
WITH rental_duration
AS
(SELECT
    f.title AS film_title
   ,c.name AS category_name
   ,f.rental_duration AS rental_day
   ,NTILE(4) --Breakdown of data into four equal groups based on a given order
    -- The order of films is determined based on the duration of the rental then divide them for four quarters
    OVER (ORDER BY f.rental_duration) AS rental_quartile
  FROM film AS f
  JOIN film_category AS fc
    ON f.film_id = fc.film_id
  JOIN category AS c
    ON fc.category_id = c.category_id
  WHERE c.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music'))
-- The main part of the query where the results are extracted from CTE
SELECT
  film_title
 ,category_name
 ,rental_day
 ,CASE -- A new column classifies each film into four categories based on value rental_quartile
    WHEN rental_quartile = 1 THEN 'first_quarter'
    -- The first quartile
    WHEN rental_quartile = 2 THEN 'second_quarter'
    -- The second quartile
    WHEN rental_quartile = 3 THEN 'third_quarter'
    -- The third quartile 
    ELSE 'fourth_quarter'
  -- The fourth quartile
  END AS rental_category
FROM rental_duration
ORDER BY rental_day; -- Ordering by rental day in ascending order