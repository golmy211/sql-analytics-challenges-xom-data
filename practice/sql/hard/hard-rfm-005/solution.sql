-- Xom Data · Scoring fairly when multiple customers are tied
-- Problem: https://xomdata.com/practice/hard-rfm-005
-- Solved: 2026-11-07

with s as (
    select 
        customer_id,
        sum(amount) as total_spent,
        RANK()over(
            order by sum(amount) desc
        ) as rank 
    from orders
    group by 1 
),
f as (
    select
        customer_id,
        total_spent,
        COALESCE((rank::numeric - 1)/nullif((count(customer_id)over() - 1),0),0) as r  
    from s 
)
select 
    customer_id,
    total_spent,
    case when r < 0.2 then 5
        when r >= 0.2 and r < 0.4 then 4 
        when r >= 0.4  and r < 0.6 then 3
        when r >= 0.6 and r < 0.8 then 2 
        else 1 
        end as m_score
 from f
