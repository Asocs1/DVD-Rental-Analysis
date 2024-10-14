-- Query that lists each movie, the film category it is classified in, and the number of times it has been rented out.

-- Extract the film title and the name of the category to which the film belongs.
SELECT
  f.title AS film_title
 ,c.name AS category_name
 ,COUNT(r.rental_id) AS rental_count -- Calculate the total number of film rentals.
FROM film AS f
-- Join the tables to extract the required information 
JOIN film_category AS fc
  ON f.film_id = fc.film_id -- To see which categories each table belongs to
JOIN category AS c
  ON fc.category_id = c.category_id -- For category name per table
JOIN inventory AS i
  ON f.film_id = i.film_id -- Film information available for rental
JOIN rental AS r
  ON i.inventory_id = r.inventory_id -- Number of rentals per film
WHERE c.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music') -- Filtering for family categories 
GROUP BY f.title
        ,c.name -- Grouping results by movie title and category
ORDER BY category_name; -- Ordering by the category name in ascending order