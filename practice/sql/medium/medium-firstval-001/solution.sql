-- Xom Data · The category's flagship next to each item
-- Problem: https://xomdata.com/practice/medium-firstval-001
-- Solved: 2026-10-03

-- Write your SQL here
select 
    category, 
    product_name,
    price,
    first_value(product_name)over(
        partition by category
        order by price desc, product_name asc 
    ) as top_product
from catalog 
order by category asc , price desc, product_name asc
