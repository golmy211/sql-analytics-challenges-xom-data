-- Xom Data · Score customers by RFM
-- Problem: https://xomdata.com/practice/sql-nightmare-008
-- Solved: 2026-11-09

with s as (
    select 
        customer_id,
        max(txn_date) as r,
        count(*) as frequency,
        round(sum(amount)::NUMERIC,2) as monetary
    from transactions
    GROUP BY 1
),
f as (
    select 
        distinct s.customer_id,
        abs(cast(s.r as date) - cast(max(t.txn_date)over() as date)) + 1 as recency,
        s.frequency,
        s.monetary
    from  transactions t 
    join s on s.customer_id = t.customer_id
    
), 
a as (
select 
    customer_id,
    recency,
    frequency,
    monetary,
    ntile(5)over(order by recency desc,customer_id) as r_score,
    ntile(5)over(order by frequency asc,customer_id) as f_score,
    ntile(5)over(order by monetary asc,customer_id) as m_score
from f
)
select *, 
        round(r_score * 0.4 + f_score * 0.3 + m_score * 0.3,2) as rfm_score 

from a 
order by rfm_score desc, customer_id
