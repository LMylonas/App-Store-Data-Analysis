CREATE TABLE appleStore_description_combined AS

SELECT * FROM appleStore_description1

UNION All

SELECT * FROM appleStore_description2

UNION All

SELECT * FROM appleStore_description3

UNION All

SELECT * FROM appleStore_description4


**Exploratory Data Analysis**

--Checking unique # of unique apps in both tables to ensure no missing values.
SELECT COUNT(DISTINCT id) as UniqueAppID
FROM AppleStore

SELECT COUNT(DISTINCT id) as UniqueAppID
FROM appleStore_description_combined

--Checking for missing values in key fields.
SELECT COUNT(*) AS MissingValues
FROM AppleStore
WHERE track_name IS NULL OR user_rating IS NULL Or prime_genre IS NULL

SELECT COUNT(*) AS MissingValues
FROM appleStore_description_combined
WHERE app_desc IS NULL

--Find # of apps per genre to determine dominant genres.
SELECT prime_genre, COUNT(*) As NumApps
FROM AppleStore
GROUP BY prime_genre
ORDER BY NumApps DESC

--Find Average App Ratings.
SELECT min(user_rating) AS MinRating, max(user_rating) AS MaxRating, avg(user_rating) AS AvgRating
From AppleStore


*Data Analysis*

--Determine whether paid apps have higher ratings than free apps. 
SELECT CASE
			WHEn price > 0 THEN 'paid'
            ELSE 'free'
       End as App_Type,
       avg(user_rating) AS Avg_Rating
FROM AppleStore
GROUP by App_Type

--Determine the average price of paid apps on the app store. 
SELECT round(avg(price), 2) AS Avg_App_Price
FROM AppleStore
WHERE price > 0

--Checking Genres with low ratings. 
SELECT prime_genre, avg(user_rating) AS Avg_Rating
FROM AppleStore
GROUP BY prime_genre
order by Avg_Rating ASC
LIMIT 10

--Checking if app description length correlates to user ratings. 
SELECT CASE
			WHEN length(b.app_desc) < 500 THEN 'short'
            WHEN length(b.app_desc) BETWEEN 500 AND 1000 THEN 'medium'
            ELSE 'long'
       END AS description_length_bucket,
       avg(a.user_rating) AS avg_rating
FROM AppleStore AS A
JOIN appleStore_description_combined as B 
ON A.id = B.id
GROUP BY description_length_bucket
ORDER BY avg_rating DESC



