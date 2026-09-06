-- Xom Data · Customer spending per order
-- Problem: https://xomdata.com/practice/medium-join-001
-- Solved: 2026-09-06

select 
        c.full_name,
        count(o.id) as order_count,
        coalesce(sum(o.total_amount),0) as total_spending,
        coalesce(avg(o.total_amount),0) as avg_order_value,
        row_number()over(
            order by coalesce(sum(o.total_amount)) DESC, c.full_name asc
        ) as spending_rank
from customers c 
left join orders o on c.id = o.customer_id
group by 1
order by spending_rank asc
