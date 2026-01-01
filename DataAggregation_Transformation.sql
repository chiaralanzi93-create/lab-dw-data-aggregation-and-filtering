DESCRIBE sakila.film;
SHOW COLUMNS FROM sakila.film;
-- Challenge 1
select title, max(length) as max_length,min(length) as min_length
from sakila.film
group by title;

select 
min(length) as min_length,
max(length) as max_length
from sakila.film;
 
-- subgroup - cte 
with mix_max_duration as (
select 
min(length) as min_length,
max(length) as max_length
from sakila.film)

select title, length
from sakila.film
where length = (select min_length from mix_max_duration) or length = (select max_length from mix_max_duration);

select floor(avg(length)/60) as avg_hour,
mod(round(avg(length)),60) as avg_min
from sakila.film;

-- 2
select datediff(
(select max(rental_date) from sakila.rental),
(select min(rental_date) from sakila.rental)) as n_of_working_days;

select rental_date, month (rental_date), weekday(rental_date)
from sakila.rental
limit 20;

select rental_date,
 case 
   when weekday(rental_date) in (6,7) then 'weekend'
   else 'workday'
 end as day_type -- add new colmn
from sakila.rental;

-- 3
select title, ifnull(rental_duration, 'Not Available') as rental_duration
from sakila.film
order by title asc;

-- bonus
select concat(first_name ,' ',  last_name), substr(email, 1, 3)
from sakila.customer
order by last_name asc;


-- Challenge 2
select count(film_id)
from sakila.film;

select  rating, count(film_id)
from sakila.film
group by rating;

select  rating, count(film_id)
from sakila.film
group by rating
order by count(film_id) desc;

select  rating, round(avg(length),2) as avg_duration
from sakila.film
group by rating
order by avg_duration desc;

select  rating, round(avg(length),2) as avg_duration
from sakila.film
group by rating
having avg_duration > 120
order by avg_duration desc;

-- bonus
select last_name
from sakila.actor
group by last_name
having COUNT(last_name) = 1;