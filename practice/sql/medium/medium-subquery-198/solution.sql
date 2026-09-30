-- Xom Data · Top 10 most-borrowed books
-- Problem: https://xomdata.com/practice/medium-subquery-198
-- Solved: 2026-09-30

with engagement as (
select 
    b.title,
    a.full_name as authors,
    p.publisher_name,
    g.genre_name,
    count(distinct bl.id) as borrow_count,
    count(distinct case when r.status = 'ready_pickup' then r.id end) as pending_reservation,
    count(distinct bl.id) + count(distinct case when r.status = 'ready_pickup' then r.id end) as engagement
from books b
left join authors a on b.author_id = a.id
left join publishers p on b.publisher_id = p.id 
left join genres g on b.genre_id = g.id
join book_loans bl on b.id = bl.book_id
left join reservations r on b.id = r.book_id 
group by 1,2,3,4
)
select 
    title, 
    authors,
    publisher_name,
    genre_name,
    borrow_count,
    pending_reservation,
    engagement,
    dense_rank()over(
        order by engagement desc
    ) as overall_rank,
    rank()over(
        partition by genre_name
        order by engagement desc 
    )as rank_in_genre
from engagement
order by overall_rank asc, title asc 
limit 10
