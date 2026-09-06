-- Xom Data · High-priced products
-- Problem: https://xomdata.com/practice/easy-where-002
-- Solved: 2026-09-06

select name, price 
from products 
where price > 500000
order by price desc
