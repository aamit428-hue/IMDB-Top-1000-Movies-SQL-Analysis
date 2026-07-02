-- ============================================================
--        IMDB Top 1000 Movies — SQL Analysis
--        Tool    : PostgreSQL 18
--        Dataset : IMDB Top 1000 (Kaggle)
--        Level   : Beginner — First SQL Project
-- ============================================================


-- ============================================================
-- STEP 1 : CREATE TABLE
-- ============================================================

DROP TABLE IF EXISTS MOVIES_RATINGS;

CREATE TABLE IF NOT EXISTS MOVIES_RATINGS
(
Poster_Link  VARCHAR(300),
Series_Title VARCHAR(100),
Released_Year	VARCHAR(10),
Certificate	VARCHAR(10),
Runtime	VARCHAR(10),
Genre	VARCHAR(50),
IMDB_Rating	DECIMAL,
Overview	VARCHAR(500),
Meta_score	INT,
Director VARCHAR(100),	
Star1	VARCHAR(100),
Star2	VARCHAR(100),
Star3	VARCHAR(100),
Star4	VARCHAR(100),
No_of_Votes	int,
Gross money

);

-- ============================================================
-- STEP 2 : VIEW ALL DATA
-- ============================================================

select * from movies_ratings


-- ============================================================
-- STEP 3 : MOVIES SORTED BY IMDB RATING (HIGHEST FIRST)
-- ============================================================

SELECT Series_Title , IMDB_Rating	
FROM movies_ratings
ORDER BY IMDB_Rating DESC;


-- ============================================================
-- STEP 4 : COUNT TOTAL MOVIES PER GENRE
-- ============================================================

SELECT Genre, COUNT(*) AS total_movies
FROM movies_ratings
GROUP BY Genre
ORDER BY total_movies DESC;


-- ============================================================
-- STEP 5 : AVERAGE RATING PER DIRECTOR (MIN 3 MOVIES)
-- ============================================================

SELECT Director,round (AVG(IMDB_Rating),2) AS avg_rating
FROM movies_ratings
GROUP BY Director
HAVING COUNT(*) >= 3
ORDER BY avg_rating DESC;


-- ============================================================
-- STEP 6 : TOTAL MOVIES PER YEAR AND TITLE
-- ============================================================

SELECT series_title, released_year, COUNT(*) AS total_movies
FROM movies_ratings
GROUP BY released_year,series_title
ORDER BY released_year;


-- ============================================================
-- STEP 7 : ALL MOVIES WITH THEIR IMDB RATING
-- ============================================================

SELECT series_title,IMDB_Rating
FROM movies_ratings;


-- ============================================================
-- STEP 8 : MOVIES RELEASED AFTER 2010
-- ============================================================

SELECT series_title, released_year
FROM movies_ratings
WHERE released_year > '2010'
ORDER BY released_year DESC;


-- ============================================================
-- STEP 9 : MOVIES WITH IMDB RATING ABOVE 8.5
-- ============================================================

SELECT  series_title,IMDB_Rating
FROM  movies_ratings
WHERE IMDB_Rating > '8.5'
ORDER BY IMDB_Rating DESC;


-- ============================================================
-- STEP 10 : TOP 10 DIRECTORS BY MOVIE COUNT
-- ============================================================

SELECT Director, COUNT(*) AS movie_count
FROM movies_ratings
GROUP BY Director
ORDER BY movie_count DESC
LIMIT 10;


-- ============================================================
-- STEP 11 : TOP 10 MOVIES BY NUMBER OF VOTES
-- ============================================================

SELECT Series_Title, No_of_Votes
FROM movies_ratings
ORDER BY  No_of_Votes DESC
LIMIT 10;


-- ============================================================
-- STEP 12 : MOVIES WITH GROSS REVENUE ABOVE $100 MILLION
-- ============================================================

SELECT Series_Title , Gross
FROM movies_ratings
WHERE Gross > '100000000'
ORDER BY Gross DESC;


-- ============================================================
-- STEP 13 : AVERAGE RUNTIME PER MOVIE AND GENRE
-- ============================================================

SELECT Series_Title,Genre,
round(AVG(CAST(REPLACE(Runtime, ' min', '') AS INT)),2) AS avg_runtime
FROM movies_ratings
GROUP BY Series_Title, Genre
ORDER BY avg_runtime DESC;


-- ============================================================
-- STEP 14 : TOP 5 HIGHEST GROSSING MOVIES
-- ============================================================

SELECT Series_Title , Gross
FROM movies_ratings
where gross is not null
ORDER BY Gross DESC
LIMIT 5;


-- ============================================================
-- STEP 15 : ALL MOVIES DIRECTED BY STEVEN SPIELBERG
-- ============================================================

SELECT Series_Title, Director
FROM movies_ratings
WHERE Director = 'Steven Spielberg';


-- ============================================================
-- STEP 16 : MOVIES WITH NO GROSS REVENUE DATA (NULL CHECK)
-- ============================================================

SELECT series_title, Gross
FROM movies_ratings
WHERE Gross IS NULL;


-- ============================================================
-- STEP 17 : MOVIES RATED ABOVE AVERAGE (SUBQUERY)
-- ============================================================

SELECT Series_Title, IMDB_Rating
FROM movies_ratings
WHERE IMDB_Rating > (
    SELECT AVG(IMDB_Rating)
    FROM movies_ratings)
ORDER BY IMDB_Rating DESC;


-- ============================================================
-- STEP 18 : TOP 10 MOST APPEARING LEAD ACTORS
-- ============================================================

SELECT Star1 AS actor_name, COUNT(*) AS appearance_count
FROM  movies_ratings
GROUP BY Star1
ORDER BY appearance_count DESC
LIMIT 10;


-- ============================================================
-- STEP 19 : RANK MOVIES BY RATING WITHIN EACH YEAR (WINDOW FUNCTION)
-- ============================================================

SELECT Series_Title,Released_Year,IMDB_Rating,
RANK() OVER (PARTITION BY Released_Year ORDER BY IMDB_Rating DESC) AS year_rank
FROM movies_ratings;




-- ============================================================
-- STEP 20 : VIEW ALL DATA
-- ============================================================

SELECT * FROM MOVIES_RATINGS;


-- ============================================================
-- STEP 21 : MOVIES WITH TITLE, YEAR AND DIRECTOR
-- ============================================================

SELECT SERIES_TITLE, RELEASED_YEAR, DIRECTOR FROM MOVIES_RATINGS;


-- ============================================================
-- STEP 22 : MOVIES WITH TITLE, YEAR AND IMDB RATING
-- ============================================================

SELECT SERIES_TITLE, RELEASED_YEAR, IMDB_RATING FROM MOVIES_RATINGS;


-- ============================================================
-- STEP 23 : MOVIES FILTERED BY CERTIFICATE (UA AND A)
-- ============================================================

SELECT SERIES_TITLE, RELEASED_YEAR, IMDB_RATING , CERTIFICATE
FROM MOVIES_RATINGS
WHERE CERTIFICATE IN ('UA','A');


-- ============================================================
-- STEP 24 : CERTIFICATE + HIGH RATING + DRAMA GENRE FILTER
-- ============================================================

SELECT SERIES_TITLE, RELEASED_YEAR, IMDB_RATING , CERTIFICATE , 
GENRE FROM MOVIES_RATINGS
WHERE CERTIFICATE IN ('UA','A') AND IMDB_RATING>8.3 AND GENRE ILIKE '%DRAMA%';  


-- ============================================================
-- STEP 25: DRAMA MOVIES WITH SPECIFIC ACTOR BETWEEN 2000-2020
-- ============================================================

SELECT DISTINCT *
FROM MOVIES_RATINGS
WHERE CERTIFICATE IN('UA','A') AND GENRE ILIKE '%DRAMA%' 
AND IMDB_RATING>7.0 
AND 'MADHAVAN' IN 
( UPPER (STAR1), UPPER(STAR2), UPPER(STAR3) ,UPPER(STAR4)) 
AND RELEASED_YEAR BETWEEN '2000'  AND '2020'
ORDER BY RELEASED_YEAR;


-- ============================================================
-- STEP 26 : COUNT MOVIES BY CERTIFICATE
-- ============================================================

SELECT CERTIFICATE , COUNT(*) AS TOTAL_MOVIES
FROM MOVIES_RATINGS
GROUP BY CERTIFICATE;


-- ============================================================
-- STEP 27 : AVERAGE RATING PER GENRE
-- ============================================================

SELECT GENRE, AVG(IMDB_RATING)::NUMERIC(05,2) AS AVG_RATING
FROM MOVIES_RATINGS
GROUP BY GENRE
ORDER BY AVG_RATING DESC  ;


-- ============================================================
-- STEP 28 : MOVIES RELEASED BETWEEN 1920 AND 2010
-- ============================================================

SELECT DISTINCT SERIES_TITLE, RELEASED_YEAR 
FROM MOVIES_RATINGS
WHERE RELEASED_YEAR BETWEEN '1920 'AND '2010'
ORDER BY RELEASED_YEAR;


-- ============================================================
-- STEP 29 : FIND ALL MOVIES OF A SPECIFIC ACTOR (MADHAVAN)
-- ============================================================

SELECT DISTINCT  SERIES_TITLE
FROM MOVIES_RATINGS
WHERE 'MADHAVAN' IN (UPPER (STAR1),UPPER (STAR2),
UPPER (STAR3),UPPER (STAR4));


-- ============================================================
-- STEP 30 : TOP 5 LONGEST MOVIES BY RUNTIME
-- ============================================================

SELECT DISTINCT SERIES_TITLE, RUNTIME FROM MOVIES_RATINGS
ORDER BY RUNTIME DESC
LIMIT 5;


-- ============================================================
-- STEP 31 : COUNT TOTAL MOVIES PER YEAR
-- ============================================================

SELECT  DISTINCT RELEASED_YEAR, COUNT(*) AS TOTAL
FROM MOVIES_RATINGS
GROUP BY RELEASED_YEAR
ORDER BY RELEASED_YEAR;


-- ============================================================
-- STEP 32 : CHECK FOR DUPLICATE MOVIE TITLES
-- ============================================================

SELECT SERIES_TITLE, COUNT(*) 
FROM MOVIES_RATINGS
GROUP BY SERIES_TITLE
HAVING COUNT(*)> 1;


-- ============================================================
-- STEP 33 : HIGHEST RATED MOVIE PER YEAR
-- ===========================================================

SELECT  RELEASED_YEAR, MAX(IMDB_RATING) AS MAX_RATING
FROM MOVIES_RATINGS
GROUP BY RELEASED_YEAR;


-- ============================================================
-- STEP 34 : DRAMA MOVIES WITH RATING ABOVE 7
-- ============================================================

SELECT SERIES_TITLE, IMDB_RATING, GENRE, RELEASED_YEAR
 FROM MOVIES_RATINGS
 WHERE GENRE ILIKE '%DRAM%'
  AND IMDB_RATING>7 ;


-- ============================================================
-- STEP 36 : TOTAL COUNT OF EACH CERTIFICATE (NON NULL)
-- ============================================================

SELECT COUNT(CERTIFICATE),CERTIFICATE
FROM MOVIES_RATINGS
WHERE CERTIFICATE IS NOT NULL
GROUP BY CERTIFICATE;


-- ============================================================
-- STEP 37 : CERTIFICATE COUNT WHERE TOTAL IS MORE THAN 5
-- ============================================================

SELECT COUNT(CERTIFICATE),CERTIFICATE AS CERTIFICATE_RATINGS
FROM MOVIES_RATINGS
GROUP BY CERTIFICATE
HAVING COUNT (CERTIFICATE) >5
ORDER BY  CERTIFICATE_RATINGS DESC;


-- ============================================================
-- STEP 38 : TOTAL VOTES GROUPED BY CERTIFICATE
-- ============================================================

SELECT COUNT(NO_OF_VOTES) AS TOTAL_VOTES,CERTIFICATE 
FROM MOVIES_RATINGS
GROUP BY CERTIFICATE
ORDER BY CERTIFICATE ;


-- ============================================================
-- STEP 39 : FIND MAXIMUM IMDB RATING
-- ============================================================

SELECT MAX(IMDB_RATING)
FROM MOVIES_RATINGS;


-- ============================================================
-- STEP 40 : FIND MINIMUM IMDB RATING
-- ============================================================

SELECT MIN(IMDB_RATING)
FROM MOVIES_RATINGS;


-- ============================================================
-- STEP 41 : SHOW MIN AND MAX RATING IN ONE ROW
-- ============================================================

SELECT MIN(IMDB_RATING) AS MINIMUM_VALUES, MAX (IMDB_RATING) AS MAX_VALE
FROM MOVIES_RATINGS;


-- ============================================================
-- STEP 42 : FIND MOVIE WITH EXACT RATING OF 9.3
-- ============================================================

SELECT SERIES_TITLE , IMDB_RATING
FROM MOVIES_RATINGS
WHERE (IMDB_RATING) =9.3;


-- ============================================================
-- STEP 43 : SHOW MIN AND MAX RATING IN TWO SEPARATE ROWS (UNION)
-- ============================================================

SELECT MIN(IMDB_RATING) AS MIN_MAX
FROM MOVIES_RATINGS
UNION
SELECT MAX (IMDB_RATING)
FROM MOVIES_RATINGS;


-- ============================================================
-- STEP 44 : MIN AND MAX RATING WITH LABELS USING UNION
-- ============================================================

SELECT MIN(IMDB_RATING) AS RATINGS, 'MIN_VALUE' AS VALUES
FROM MOVIES_RATINGS
UNION
SELECT MAX (IMDB_RATING) AS MIN_MAX, 'MAX_VALUE' AS MAXVALUE
FROM MOVIES_RATINGS;


-- ============================================================
-- STEP 45 : BASIC FILTER — MOVIES WITH RATING 9.0 AND ABOVE
-- ============================================================

SELECT Series_Title, IMDB_Rating, Released_Year 
FROM MOVIES_RATINGS
WHERE IMDB_Rating >= 9.0 
ORDER BY IMDB_Rating DESC;


-- ============================================================
-- STEP 46 : MULTIPLE CONDITIONS — DRAMA AFTER 2010 WITH HIGH RATING
-- ============================================================

SELECT Series_Title, Genre, Director 
FROM MOVIES_RATINGS
WHERE Genre LIKE '%Drama%' 
  AND Released_Year >= '2010'
  AND IMDB_Rating > 8.5
ORDER BY No_of_Votes DESC
LIMIT 10;


-- ============================================================
-- STEP 47 : STRING FUNCTIONS — OVERVIEW LENGTH AND SHORT PREVIEW
-- ============================================================

SELECT 
    Series_Title,
    LENGTH(Overview) as overview_length,
    SUBSTR(Overview, 1, 100) || '...' as short_overview
FROM MOVIES_RATINGS
WHERE Overview LIKE '%redemption%' OR Overview LIKE '%love%';


-- ============================================================
-- END OF FILE
-- ============================================================
