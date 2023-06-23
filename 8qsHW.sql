--1. List all customers who live in Texas(use JOINs)
SELECT first_name, last_name, district
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
WHERE address.district = 'Texas';


--2. Get all payments above 6.99$ w/ customer's full name
SELECT first_name, last_name, amount
FROM payment
INNER JOIN customer
ON payment.customer_id = customer.customer_id
WHERE amount > 6.99
GROUP BY first_name, last_name, amount;


--3. Show all customers names who have made payments over 175$
-- use subqueries
SELECT first_name, last_name, SUM(amount)
FROM payment
WHERE customer_id IN (
	SELECT customer_id
	FROM customer
	GROUP BY customer_id
	HAVING SUM(amount) > 175.00
	ORDER BY SUM(amount) DESC
)
GROUP BY first_name, last_name, SUM(amount);


--4. List all customers that live in Nepal
SELECT first_name, last_name, country
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
INNER JOIN city
ON address.city_id = city.city_id
INNER JOIN country
ON city.country_id = country.country_id
WHERE country = 'Nepal';


--5. Which staff member had the most transactions?
SELECT staff_id, first_name, last_name
FROM staff
WHERE staff_id IN (
	SELECT staff_id
	FROM payment
	GROUP BY staff_id
	ORDER BY COUNT(staff_id) DESC
	LIMIT 1
)
GROUP BY first_name, last_name, staff_id;



--6. How many movies of each rating are there?
SELECT rating, COUNT(rating)
FROM film
GROUP BY rating
ORDER BY COUNT(rating);

--7. Show all customers who have made a single payment above 6.99
--use subqueries

SELECT customer_id, amount
FROM payment
WHERE customer_id IN (
	SELECT customer_id
	FROM customer
	GROUP BY customer_id
	HAVING amount = 6.99
)
GROUP BY customer_id, amount;


--8. How many free rentals did our stores give away?
SELECT *
FROM inventory;
