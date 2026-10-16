-- Xom Data · Spending hierarchy within each channel
-- Problem: https://xomdata.com/practice/medium-classify-002
-- Solved: 2026-10-16

select 
    c.channel,
    o.customer_id,
    sum(o.amount) as total_spent,
    dense_rank()over(
        partition by c.channel
        order by sum(o.amount) desc
    ) as rank_in_channel
from customers c
join orders o on c.customer_id = o.customer_id
group by 1,2 
order by channel asc, rank_in_channel, customer_id
