--Query for classification of family movies by duration of rental to quarters and calculation of number

-- Use CTE to create a temporary dataset that uses the main part of the query
WITH rental_info
AS
(SELECT
    f.title AS film_title
   ,c.name AS category_name
   ,f.rental_duration AS rental_days
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
  category_name
 ,rental_quartile
 ,COUNT(film_title) AS film_count -- Calculation of the total number of films in each category
FROM rental_info
GROUP BY category_name
        ,rental_quartile -- Grouping results by category and rental quartile
ORDER BY category_name, rental_quartile; --Ordering by the category name and rental quartile in ascending order