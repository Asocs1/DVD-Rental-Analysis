-- The query identifies the top 10 customers in terms of total amounts paid in 2007, and then shows details of monthly payments to each customer

-- Use CTE to create a temporary dataset that uses the main part of the query
--It has top 10 customers in terms of payments in 2007
WITH top_customers AS
(SELECT
  p.customer_id
 ,SUM(p.amount) AS total_amount --Calculation of total payments per customer
FROM payment p
WHERE EXTRACT(YEAR FROM p.payment_date) = 2007 --Filtering of payments data for 2007
GROUP BY p.customer_id
ORDER BY total_amount DESC
LIMIT 10)
---- The main part of the query where the results are extracted from CTE
SELECT
  DATE_TRUNC('month', p.payment_date) AS payment_month --Cut-off date to start of month
 ,CONCAT(c.first_name, ' ', c.last_name) AS customer_name --Consolidate the customer's first and last name
 ,COUNT(p.payment_id) AS payment_count --Calculate the number of client payments he made each month
 ,SUM(p.amount) AS monthly_total --Calculate the total amount paid by the customer in that month
FROM payment p
JOIN customer c
  ON p.customer_id = c.customer_id --JOINING to bring customer data
JOIN top_customers tc
  ON p.customer_id = tc.customer_id --JOINING payments with customers in the CTE
GROUP BY c.customer_id
        ,customer_name
        ,payment_month ---- Grouping results by ID and customer name and payment month
ORDER BY customer_name, payment_month;--Ordering by customer name and payment month in descending order