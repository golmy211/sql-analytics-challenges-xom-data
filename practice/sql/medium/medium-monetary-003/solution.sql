-- Xom Data · Q2 Spending Ledger, Including the Silent Ones
-- Problem: https://xomdata.com/practice/medium-monetary-003
-- Solved: 2026-10-06

select 
    c.customer_id,
    c.customer_name,
    coalesce(sum(o.amount),0) as q2_spent
from customers c
left join orders o on c.customer_id = o.customer_id and o.order_date between '2024-04-01' and '2024-06-30'
group by 1,2 
order by q2_spent desc, customer_id asc
