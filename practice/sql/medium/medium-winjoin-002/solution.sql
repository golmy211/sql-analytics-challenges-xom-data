-- Xom Data · The customer's total next to every order
-- Problem: https://xomdata.com/practice/medium-winjoin-002
-- Solved: 2026-10-03

with total_amount as (
select 
    c.id,
    c.customer_name,
    sum(o.amount) as total_customer
from customers c 
right join orders o on c.id = o.customer_id 
group by 1,2
)
select 
    t.customer_name,
    o.order_date,
    o.amount,
    t.total_customer as customer_total 
from total_amount t 
join orders o on t.id = o.customer_id
order by customer_name asc, order_date asc
