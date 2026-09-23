-- Xom Data · Categories full enough for the homepage
-- Problem: https://xomdata.com/practice/easy-having-001
-- Solved: 2026-09-23

-- Write your SQL here
select 
    category,
    count(id) as num_products
from products
group by 1
having count(id) >= 3 
order by 1 asc
