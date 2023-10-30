--Display the customer names that share the same address (e.g husband and wife)
select c.first_name, c.last_name, count (a.address) address
from customer as c
join address as a
on c.address_id = a.address_id
group by 1,2
having count (a.address) >1;

--What is the name of the customer who made the highest total payments
select c.first_name, c.last_name, sum (p.amount) as total_payment
from customer as c
join payment as p
on c.customer_id = p.customer_id
group by 1,2
order by 3 desc
limit 1;

--What is the movie(s) that was rented the most
select f.title, count(r.rental_id) as number_of_rent
from film as f
join inventory as i 
on i.film_id = f.film_id
join rental as r
on r.inventory_id = i.inventory_id
group by 1
order by 2 desc
limit 1;

--Which movies has been rented so far
select distinct f.title
from film as f
join inventory as i 
on i.film_id = f.film_id
join rental as r
on r.inventory_id = i.inventory_id;

--which movies have not been rented so far
select distinct f.title
from film as f
where f.title not in
(select distinct f.title
from film as f
join inventory as i 
on i.film_id = f.film_id
join rental as r
on r.inventory_id = i.inventory_id);

--which customers have not rented any movies so far
select c.first_name, c.last_name
from customer as c
where c.customer_id
not in 
(select r.customer_id from rental as r);

--Display each movie and the number of times it got rented
select f.title, count(r.rental_id) as number_of_rent
from film as f
join inventory as i 
on i.film_id = f.film_id
join rental as r
on r.inventory_id = i.inventory_id
group by 1;

--show the first name and the last name and the number of times
--the actor acted in each movie
select t1.first_name,t1.last_name,
count(t1.film_id) count_of_movie_features
from 
(select a.first_name,a.last_name, fa.film_id
from actor as a
join film_actor as fa 
on fa.actor_id = a.actor_id) as t1 
group by 1,2
order by 3 desc;

--display the name of actors that acted in more than 20 movies
select t1.first_name,t1.last_name,
count(t1.film_id) count_of_movie_features
from 
(select a.first_name,a.last_name, fa.film_id
from actor as a
join film_actor as fa 
on fa.actor_id = a.actor_id) as t1 
group by 1,2
having count(t1.film_id) > 20
order by 3;


--For all the movies rate "PG" show me the movie 
--and the number of times it got rented

select f.rating, f.title, count(r.rental_id) as count_of_rental
from film as f
join inventory as i 
on i.film_id = f.film_id
join rental as r
on r.inventory_id = i.inventory_ID
WHERE f.rating = 'PG'
group by 1,2
ORDER BY 3 DESC;


--Display the movies offered for rent in store_id 1 and not offered in store_id 2
select t1.title
from 
(select distinct f.title, i.store_id
from film as f
join inventory as i
on f.film_id = i.film_id
where i.store_id = 1) t1
where t1.title not in
(select f.title
from film as f
join inventory as i
on f.film_id = i.film_id
where i.store_id = 2)
order by t1.title asc

--Dispay the movies offered for rent in any of the two stores 1 and 2
Select distinct f.title, i.store_id
from film as f
join inventory as i
on f.film_id = i.film_id
order by f.title;

--Display the movies titles offered in both stores at the same time
select t1.title
from 
(select distinct f.title, i.store_id
from film as f
join inventory as i
on f.film_id = i.film_id
where i.store_id = 1) t1
where t1.title in
(select f.title
from film as f
join inventory as i
on f.film_id = i.film_id
where i.store_id = 2)
order by t1.title asc

--Display the movie title for the most rented movie in the store with store_id 1
SELECT f.title, i.store_id, count (r.rental_id) as count_of_rental
from film as f
join inventory as i 
on f.film_id = i.film_id
join rental as r
on r.inventory_id = i.inventory_id
group by 1,2
having i.store_id = 1
order by 3 desc
limit 1;

--How many movies are not offered for rent in the stores yet. 
--There are two stores only 1 and 2
select count (*)
from 
(select f.title
 from film as f) t1
 where t1.title not in
(select f.title
from film as f
join inventory as i
on f.film_id = i.film_id)

--Show the number of rented movies under each rating
select f.rating, count (r.rental_id) count_of_rentals
from film as f
join inventory as i
on i.film_id = f.film_id
join rental as r
on r.inventory_id = i.inventory_id
group by 1
order by 2 desc;

--Show the profit of each of the stores 1 and 2
select i.store_id, sum (p.amount) profit
from inventory as i
join rental as r
on r.inventory_id = i.inventory_id
join payment as p
on p.rental_id = r.rental_id
group by 1;

