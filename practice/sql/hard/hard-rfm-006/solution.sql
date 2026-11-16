-- Xom Data · The eight-segment customer map
-- Problem: https://xomdata.com/practice/hard-rfm-006
-- Solved: 2026-11-16

with s as (
    SELECT 
            distinct customer_id,
            case 
                when cast('2024-06-30' as date) - cast(max(order_date) as date) <= 30 then 4
                when cast('2024-06-30' as date) - cast(max(order_date) as date) between 31 and 60 then 3
                when cast('2024-06-30' as date) - cast(max(order_date) as date) between 61 and 120 then 2 
                when cast('2024-06-30' as date) - cast(max(order_date) as date) > 120 then 1 
                end as r_score,
            case
                when count(order_id) >= 10 then 4 
                when count(order_id) between 5 and 9 then 3 
                when count(order_id) between 2 and 4 then 2 
                else 1 
                end as f_score

    from orders 
    where order_date <= '2024-06-30'
    GROUP BY 1
)
select * ,
        case 
            when r_score >=3 and f_score >= 3 then 'Champions'
            when r_score >=3 and f_score = 2 then 'Potential Loyalist'
            when r_score >=3 and f_score = 1 then 'New Customers'  
            when r_score =2 and f_score >= 3 then 'At Risk'
            when r_score =2 and f_score <= 2 then 'About To Sleep'
            when r_score = 1 and f_score >= 3 then 'Cannot Lose Them'
            when r_score = 1 and f_score = 2 then 'Hibernating'
            when r_score = 1 and f_score = 1 then 'Lost'
            end as segment
from s
