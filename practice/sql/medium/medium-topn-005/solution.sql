-- Xom Data · Top two films per genre, rank included
-- Problem: https://xomdata.com/practice/medium-topn-005
-- Solved: 2026-10-02

-- Write your SQL here
with top_2 as (
    select 
        title,
        genre,
        revenue,
        row_number()over(
            partition by genre
            order by revenue desc , title asc
        ) as rank_in_genre
    from box_office
)
select 
    genre,
    rank_in_genre,
    title,
    revenue
from top_2 
where rank_in_genre <= 2 
order by genre asc, rank_in_genre asc
