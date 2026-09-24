-- Xom Data · Cheapest domestic fare
-- Problem: https://xomdata.com/practice/easy-min-001
-- Solved: 2026-09-24

-- Write your SQL here
select 
    min(price) as lowest_price
from flights
where route_type = 'Domestic'
