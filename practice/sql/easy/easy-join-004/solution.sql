-- Xom Data · Today's showtimes in time order
-- Problem: https://xomdata.com/practice/easy-join-004
-- Solved: 2026-09-21

-- Write your SQL here
select
    s.start_time,
    m.title,
    s.screen
from movies m 
join showtimes s on m.id = s.movie_id
order by start_time ASC, title
