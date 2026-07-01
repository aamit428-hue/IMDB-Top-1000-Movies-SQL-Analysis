# IMDB-Top-1000-Movies-SQL-Analysis
My first SQL project: exploratory data analysis on the IMDB Top 1000 Movies dataset using PostgreSQL.

About
This project explores a dataset of 1000 top-rated IMDB movies, covering title, year, genre, director, cast, runtime, rating, votes, and gross revenue. The goal was to practice core to intermediate SQL skills on a real, messy dataset.
What's Included

imdb_movies_analysis.sql — table schema + 30+ queries
imdb_top_1000.csv — source dataset

Skills Practiced

Table design and data loading
Filtering and sorting (WHERE, ORDER BY, LIKE/ILIKE)
Aggregations (GROUP BY, HAVING, COUNT, AVG, MAX, MIN)
Window functions (RANK() OVER (PARTITION BY ...))
Subqueries (e.g., movies rated above the dataset average)
Set operations (UNION)
String functions (SUBSTR, LENGTH, REPLACE)
Data cleaning: casting text fields to numeric types (runtime stored as "142 min", gross revenue stored as "28,341,469" with commas) before they could be used in calculations

Example Queries

Top-rated movies overall
Average rating by genre, director, and decade
Highest-grossing movies (after parsing the Gross column)
Top-rated movie per year using RANK()
Movies with above-average ratings via subquery

Tools
PostgreSQL syntax · CSV dataset from Kaggle
Notes
This is a learning project — feedback and suggestions welcome.
