-- Xom Data · Which sales channel leads in orders
-- Problem: https://xomdata.com/practice/easy-groupby-004
-- Solved: 2026-09-23

-- Write your SQL here
select  
    channel, 
    count(order_code) as num_orders 
from orders
group by 1
order by num_orders desc , channel asc
