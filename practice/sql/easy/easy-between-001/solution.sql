-- Xom Data · Products in a price range
-- Problem: https://xomdata.com/practice/easy-between-001
-- Solved: 2026-09-21

-- Write your SQL here
select 
    product_name,
    price
from products 
where price between 200 and 500
