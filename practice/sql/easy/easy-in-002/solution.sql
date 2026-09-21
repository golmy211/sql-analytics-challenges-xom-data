-- Xom Data · Dishes off this season's menu
-- Problem: https://xomdata.com/practice/easy-in-002
-- Solved: 2026-09-21

-- Write your SQL here
select 
    dish_name,
    category 
from dishes
where category not in ('Grill', 'Hotpot')
