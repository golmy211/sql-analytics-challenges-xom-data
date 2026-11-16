-- Xom Data · Frequently co-purchased product pairs
-- Problem: https://xomdata.com/practice/sql-nightmare-004
-- Solved: 2026-11-16

with s as(
    select 
        o.user_id,
        o.product_id as product_a,
        o2.product_id as product_b
    from orders o 
    join orders o2 
    on o.user_id = o2.user_id and o2.product_id > o.product_id
)
select 
    product_a,
    product_b,
    count(distinct user_id) as co_buyers
from s 
GROUP BY 1,2
order by co_buyers desc,product_a,product_b
