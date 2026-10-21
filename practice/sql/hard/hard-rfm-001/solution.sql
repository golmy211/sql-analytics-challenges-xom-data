-- Xom Data · Scoring customers across three measures
-- Problem: https://xomdata.com/practice/hard-rfm-001
-- Solved: 2026-10-21

with s as(
select 
    customer_id,
    max(order_date) as recency,
    count(*) as frequency,
    sum(amount) as monetary 
from orders
where order_date <= '2024-06-30' 
group by 1 
),

rfm as (
    
    select 
        customer_id,
        6- ntile(5)over(
            order by recency desc, customer_id asc
        ) as r_score,
        6- ntile(5)over(
            order by frequency desc, customer_id asc
        ) as f_score,
        6- ntile(5)over(
            order by monetary desc, customer_id asc
        ) as m_score
    from s 
)
select 
    customer_id,
    r_score,
    f_score,
    m_score,
    r_score + f_score + m_score as rfm_total
from rfm
