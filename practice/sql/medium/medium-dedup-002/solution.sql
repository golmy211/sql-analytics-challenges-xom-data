-- Xom Data · The current price of each product
-- Problem: https://xomdata.com/practice/medium-dedup-002
-- Solved: 2026-10-03

-- Write your SQL here
with topp as(
select 
    product_name,
    price,
    effective_date,
    row_number()over(
        partition by product_name
        order by effective_date desc
    ) as rn
from price_history
)
select 
    product_name,
    price,
    effective_date 
from topp
where rn = 1 
order by product_name asc
