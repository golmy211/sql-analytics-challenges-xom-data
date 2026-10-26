-- Xom Data · A single composite number per customer
-- Problem: https://xomdata.com/practice/hard-rfm-008
-- Solved: 2026-10-26

with s as (
    select 
        customer_id,
        max(order_date) as recency,
        count(order_id) as frequency,
        sum(amount) as monetary
    from orders 
    where order_date <= '2024-06-30'
    group by 1
    
),
agg as (
    select
        customer_id,
        6-ntile(5)over(
            order by recency desc, customer_id 
        ) as r_score,
        6-ntile(5)over(
            order by frequency desc, customer_id 
        ) as f_score,
        6-ntile(5)over(
            order by monetary desc, customer_id 
        ) as m_score
    from s 
) 
    select 
        customer_id,
        r_score,
        f_score,
        m_score,
        r_score * 100 + f_score * 10 + m_score as weighted_score

    from agg 
    order by weighted_score desc, customer_id asc
