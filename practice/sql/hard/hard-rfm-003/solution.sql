-- Xom Data · Freshness score plus diligence points
-- Problem: https://xomdata.com/practice/hard-rfm-003
-- Solved: 2026-11-15

with s as(
    select 
        customer_id,
        count(*) as order_count,
        max(order_date) as order_date
    from orders
    where order_date <= '2024-06-30'
    group by 1 
),
f as (
    select 
        distinct customer_id,
        6 - ntile(5)over(order by order_date desc,customer_id) as r_score,
        case when order_count >= 8 then 3 
            when order_count between 4 and 7 then 2
            else 1 
            end as f_score
    from s 
)
select 
    *,
    r_score + f_score as total_score,
    case when  r_score + f_score  >= 7 then 'Gold'
        when r_score + f_score between 5 and 6 then 'Silver'
        else 'Bronze'
        end as label
from f
