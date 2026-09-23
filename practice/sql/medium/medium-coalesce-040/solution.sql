-- Xom Data · Book count and average price by genre
-- Problem: https://xomdata.com/practice/medium-coalesce-040
-- Solved: 2026-09-23

select 
    g.genre_name,
    count(b.id) as book_count,
    coalesce(round(avg(b.price),0),0) as avg_price,
    coalesce(min(b.price),0) as min_price,
    coalesce(max(b.price),0) as max_price,
    coalesce(max(b.price) -min(b.price),0) as price_range,
    rank()over(
        order by count(b.id) desc
    ) as coverage_rank,
    ntile(3)over(
        order by count(b.id) desc, g.genre_name asc
    ) as library_focus
from genres g
left join books b on g.id = b.genre_id 
group by 1
order by coverage_rank asc, g.genre_name asc
