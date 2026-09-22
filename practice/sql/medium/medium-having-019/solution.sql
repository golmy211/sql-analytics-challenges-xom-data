-- Xom Data · High-rated sellers with many orders
-- Problem: https://xomdata.com/practice/medium-having-019
-- Solved: 2026-09-22

select 
    s.store_name,
    s.reputation_score,
    count(s.id) as order_count,
    dense_rank () over(
        order by count(s.id) desc
    ) as rank_by_orders,
    sum(count(s.id))over(
        order by count(s.id) desc,s.store_name asc
        rows between unbounded preceding and current row
    ) as cumulative_orders
from sellers s
join orders o on s.id = o.seller_id 
where s.reputation_score >= 4.5 
group by 1,2
having count(s.id) >= 3
order by rank_by_orders asc , s.store_name asc
