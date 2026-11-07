-- Xom Data · Scoring when the money is still sitting in the cart
-- Problem: https://xomdata.com/practice/hard-rfm-011
-- Solved: 2026-11-07

with s as(
    select 
        o.customer_id,    
        count(DISTINCT o.order_id) as order_count,
        COALESCE(sum(oi.quantity * oi.unit_price),0) as total_spent
    from orders o
    LEFT JOIN order_items oi on o.order_id = oi.order_id
    where o.order_date <= '2024-06-30'
    GROUP BY 1
)
select 
    customer_id,
    order_count,
    total_spent,
    6 - ntile(5)over(order by total_spent desc,customer_id) as m_score

from s
