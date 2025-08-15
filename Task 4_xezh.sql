create database MovieRental;
use MovieRental;
create table rental_data(MOVIE_ID INT,CUSTOMER_ID INT,GENRE VARCHAR(50),RENTAL_DATE DATE,RETURN_DATE DATE,RENTAL_FEE DECIMAL(10,2));
insert into rental_data(MOVIE_ID, CUSTOMER_ID, GENRE, RENTAL_DATE, RETURN_DATE, RENTAL_FEE)VALUES(1, 101, 'Action', '2025-05-01', '2025-05-05', 50.00),(2, 102, 'Drama', '2025-05-03', '2025-05-06', 40.00),(3, 103, 'Comedy', '2025-05-10', '2025-05-12', 30.00),(4, 101, 'Action', '2025-06-01', '2025-06-04', 55.00),(5, 104, 'Action', '2025-06-03', '2025-06-07', 60.00),(6, 102, 'Drama', '2025-06-10', '2025-06-15', 45.00),(7, 105, 'Comedy', '2025-06-15', '2025-06-17', 35.00),(8, 106, 'Action', '2025-07-01', '2025-07-05', 70.00),(9, 103, 'Drama', '2025-07-05', '2025-07-09', 42.00),(10, 107, 'Comedy', '2025-07-10', '2025-07-12', 33.00),(11, 104, 'Action', '2025-07-15', '2025-07-19', 65.00),(12, 108, 'Drama', '2025-07-18', '2025-07-22', 48.00),(13, 109, 'Comedy', '2025-07-20', '2025-07-22', 38.00),(14, 101, 'Action', '2025-08-01', '2025-08-05', 80.00),(15, 110, 'Drama', '2025-08-02', '2025-08-06', 50.00);
select * from rental_data;
#OLAP Operation
#a) Drill Down: Analyze rentals from genre to individual movies level.
select GENRE,MOVIE_ID,count(*) as rental_count,sum(RENTAL_FEE) as total_fee
from rental_data
group by GENRE,MOVIE_ID
order by GENRE,MOVIE_ID;
#b) Rollup:Summarize total rental fees by genre and then overall.
select GENRE,sum(RENTAL_FEE) as total_fee
from rental_data
group by GENRE with rollup;
#c) Cube: Analyze total rental fees across combinations of genre,rental date and customer.
SELECT GENRE,RENTAL_DATE,CUSTOMER_ID,SUM(RENTAL_FEE) AS total_rental_fee
FROM rental_data
GROUP BY GENRE, RENTAL_DATE, CUSTOMER_ID WITH ROLLUP
UNION ALL
SELECT GENRE,NULL AS RENTAL_DATE,CUSTOMER_ID,SUM(RENTAL_FEE)
FROM rental_data
GROUP BY GENRE, CUSTOMER_ID
UNION ALL
SELECT NULL AS GENRE,RENTAL_DATE,CUSTOMER_ID,SUM(RENTAL_FEE)
FROM rental_data
GROUP BY RENTAL_DATE, CUSTOMER_ID;
#d) Slice: Extract rentals only from the "Action" genre.
select *
from rental_data
where GENRE="Action";
#e) Dice: Extract rentals where GENRE="Action" or "Drama" and ENTAL_DATE is in the last 3 months.
select*
from rental_data
where GENRE IN ("Action","Drama")
and RENTAL_DATE>=date_sub(curdate(),interval 3 month);