-- Write a query to display for each store its store ID, city, and country.

SELECT S.STORE_ID, C.CITY, CC.COUNTRY
FROM SAKILA.STORE S
LEFT JOIN SAKILA.ADDRESS A
ON S.ADDRESS_ID = A.ADDRESS_ID
LEFT JOIN SAKILA.CITY C
ON A.CITY_ID = C.CITY_ID
LEFT JOIN SAKILA.COUNTRY CC
ON C.COUNTRY_ID = CC.COUNTRY_ID;

-- Write a query to display how much business, in dollars, each store brought in.
SELECT S.STORE_ID, SUM(P.AMOUNT) AS TOTAL_DOLLAR
FROM SAKILA.STORE S
LEFT JOIN SAKILA.STAFF ST
ON S.STORE_ID = ST.STORE_ID
LEFT JOIN SAKILA.PAYMENT P
ON ST.STAFF_ID = P.STAFF_ID
GROUP BY 1
ORDER BY 2;

-- What is the average running time of films by category?
SELECT FC.CATEGORY_ID, CA.NAME, AVG(F.LENGTH) AS AVG_TIME_PER_CAT
FROM SAKILA.FILM F 
LEFT JOIN SAKILA.FILM_CATEGORY FC
ON F.FILM_ID = FC.FILM_ID
LEFT JOIN SAKILA.CATEGORY CA
ON FC.CATEGORY_ID = CA.CATEGORY_ID
GROUP BY 1, 2
ORDER BY 3 DESC;


-- Which film categories are longest?
SELECT FC.CATEGORY_ID, CA.NAME, SUM(F.LENGTH) AS LONGEST_CATEGORY
FROM SAKILA.FILM F 
LEFT JOIN SAKILA.FILM_CATEGORY FC
ON F.FILM_ID = FC.FILM_ID
LEFT JOIN SAKILA.CATEGORY CA
ON FC.CATEGORY_ID = CA.CATEGORY_ID 
GROUP BY 1, 2
ORDER BY 3 DESC;

-- Display the most frequently rented movies in descending order.
SELECT FILM_ID, TITLE, SUM(RENTAL_DURATION) AS MOST_RENTED
FROM SAKILA.FILM 
GROUP BY 1,2
ORDER BY 3 DESC;  

-- List the top five genres in gross revenue in descending order.
SELECT CA.NAME, FC.CATEGORY_ID, SUM(P.AMOUNT) AS GENRES_GROSS_REVENUE
FROM SAKILA.CATEGORY CA
LEFT JOIN SAKILA.FILM_CATEGORY FC
ON CA.CATEGORY_ID = FC.CATEGORY_ID  
LEFT JOIN SAKILA.FILM F
ON FC.FILM_ID = F.FILM_ID
LEFT JOIN SAKILA.INVENTORY I
ON F.FILM_ID = I.FILM_ID
LEFT JOIN SAKILA.RENTAL R
ON I.INVENTORY_ID = R.INVENTORY_ID
LEFT JOIN SAKILA.PAYMENT P
ON R.RENTAL_ID = P.RENTAL_ID
GROUP BY 1,2
ORDER BY 3 DESC LIMIT 5; 

-- Is "Academy Dinosaur" available for rent from Store 1?
SELECT F.TITLE, I.STORE_ID, R.RETURN_DATE AS AVAILABLE
FROM SAKILA.FILM F 
LEFT JOIN SAKILA.INVENTORY I 
ON F.FILM_ID = I.FILM_ID
LEFT JOIN SAKILA.RENTAL R 
ON I.INVENTORY_ID = R.INVENTORY_ID AND R.RETURN_DATE IS NULL
WHERE F.TITLE = 'Academy Dinosaur' AND I.STORE_ID = 1; 