-- Xom Data · Showtime count and average ticket price per film
-- Problem: https://xomdata.com/practice/medium-join-076
-- Solved: 2026-09-29

with top_rank as(
select 
    m.movie_name,
    m.genres,
    count(s.id) as showtime_count,
    round(avg(s.ticket_price),0) as avg_ticket_price,
    dense_rank()over(
        partition by m.genres
        order by avg(s.ticket_price) desc
    ) as rank_in_genre
from movies m
left join showtimes s on m.id = s.movie_id
group by 1
) 
select 
    movie_name,
    genres,
    showtime_count,
    avg_ticket_price,
    rank_in_genre,
    first_value(movie_name) over (
    partition by genres
    order by avg_ticket_price desc
) as top_movie_in_genre
from top_rank 
order by genres asc, rank_in_genre asc, movie_name asc
