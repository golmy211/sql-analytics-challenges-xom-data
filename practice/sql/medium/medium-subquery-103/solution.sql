-- Xom Data · Products more expensive than the category average
-- Problem: https://xomdata.com/practice/medium-subquery-103
-- Solved: 2026-09-22

with product_avg as (
    select
        product_name,
        category,
        price,
        avg(price) over (partition by category) as avg_price
    from products
)
select 
    product_name,
    category,
    price,
    round((price - avg_price),0) as diff_from_avg,
    round((price - avg_price)/avg_price * 100.00,2) as pct_above 
from product_avg
where price > avg_price 
order by pct_above desc, product_name asc
