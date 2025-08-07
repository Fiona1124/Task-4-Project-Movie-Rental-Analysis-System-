Project: Movie Rental Analysis System (using Redshift or PostgreSQL)
Objective:
Perform advanced analysis on movie rental data using OLAP operations.
The project will include the following tasks:
Database Creation:
Create a database named MovieRental.
Create table rental_data with columns:
MOVIE_ID (integer),
CUSTOMER_ID (integer),
GENRE (varchar),
RENTAL_DATE (date),
RETURN_DATE (date),
RENTAL_FEE (numeric).
Data Creation:
Insert 10–15 sample rental records.
OLAP Operations:
a) Drill Down: Analyze rentals from genre to individual movie level.
b) Rollup: Summarize total rental fees by genre and then overall.
c) Cube: Analyze total rental fees across combinations of genre, rental date, and 
customer.
d) Slice: Extract rentals only from the ‘Action’ genre.
e) Dice: Extract rentals where GENRE = 'Action' or 'Drama' and RENTAL_DATE is in 
the last 3 months.
