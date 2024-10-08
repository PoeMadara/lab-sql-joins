-- Exercise 1: List the number of films per category
SELECT 
    c.name AS category_name, 
    COUNT(f.film_id) AS film_count  -- Number of films in each category
FROM 
    film AS f
JOIN 
    film_category AS fc ON f.film_id = fc.film_id
JOIN 
    category AS c ON fc.category_id = c.category_id
GROUP BY 
    c.name;

-- Exercise 2: Retrieve the store ID, city, and country for each store
SELECT 
    s.store_id, 
    ci.city, 
    co.country  -- Store ID, City, and Country
FROM 
    store AS s
JOIN 
    address AS a ON s.address_id = a.address_id
JOIN 
    city AS ci ON a.city_id = ci.city_id
JOIN 
    country AS co ON ci.country_id = co.country_id;

-- Exercise 3: Calculate the total revenue generated by each store in dollars
SELECT 
    i.store_id, 
    SUM(p.amount) AS total_revenue  -- Total revenue per store
FROM 
    payment AS p
JOIN 
    rental AS r ON p.rental_id = r.rental_id  -- Join with rental table to access inventory
JOIN 
    inventory AS i ON r.inventory_id = i.inventory_id  -- Join with inventory to access store_id
GROUP BY 
    i.store_id;

-- Exercise 4: Determine the average running time of films for each category
SELECT 
    c.name AS category_name, 
    ROUND(AVG(f.length), 2) AS avg_running_time  -- Average running time of films in each category
FROM 
    film AS f
JOIN 
    film_category AS fc ON f.film_id = fc.film_id
JOIN 
    category AS c ON fc.category_id = c.category_id
GROUP BY 
    c.name;

-- Bonus 1: Identify the film categories with the longest average running time
SELECT 
    c.name AS category_name, 
    ROUND(AVG(f.length), 2) AS avg_running_time  -- Average running time, sorted by longest first
FROM 
    film AS f
JOIN 
    film_category AS fc ON f.film_id = fc.film_id
JOIN 
    category AS c ON fc.category_id = c.category_id
GROUP BY 
    c.name
ORDER BY 
    avg_running_time DESC  -- Sort by average running time in descending order
LIMIT 1;  -- Top category with the longest running time

-- Bonus 2: Display the top 10 most frequently rented movies in descending order
SELECT 
    f.title, 
    COUNT(r.rental_id) AS rental_count  -- Number of rentals per film
FROM 
    rental AS r
JOIN 
    inventory AS i ON r.inventory_id = i.inventory_id
JOIN 
    film AS f ON i.film_id = f.film_id
GROUP BY 
    f.title
ORDER BY 
    rental_count DESC  -- Sort by rental count in descending order
LIMIT 10;  -- Top 10 most rented movies

-- Bonus 3: Determine if "Academy Dinosaur" can be rented from Store 1
SELECT 
    f.title, 
    i.store_id, 
    CASE 
        WHEN COUNT(i.inventory_id) > 0 THEN 'Available'  -- Check if the movie is available in store 1
        ELSE 'Not Available'
    END AS availability
FROM 
    film AS f
JOIN 
    inventory AS i ON f.film_id = i.film_id
WHERE 
    f.title = 'Academy Dinosaur' 
    AND i.store_id = 1;

-- Bonus 4: Provide a list of all distinct film titles, along with their availability status
SELECT 
    f.title, 
    CASE 
        WHEN COUNT(i.inventory_id) > 0 THEN 'Available'  -- Check if the film is available
        ELSE 'NOT Available'
    END AS availability
FROM 
    film AS f
LEFT JOIN 
    inventory AS i ON f.film_id = i.film_id
GROUP BY 
    f.title;
