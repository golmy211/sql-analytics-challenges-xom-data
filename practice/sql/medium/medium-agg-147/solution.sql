-- Xom Data · Top 10 highest-profit dishes
-- Problem: https://xomdata.com/practice/medium-agg-147
-- Solved: 2026-09-30

select
    d.dish_name,
    c.category_name,
    sum(oi.quantity) as total_sold,
    sum(oi.quantity * oi.unit_price) as revenue,
    sum(oi.quantity * oi.unit_price) - sum(d.cost_price * oi.quantity) as profit,
    round((sum(oi.quantity * oi.unit_price) - sum(d.cost_price * oi.quantity)) * 100.00/sum(oi.quantity * oi.unit_price),2) as margin_pct,
    rank()over(
        order by sum(oi.quantity * oi.unit_price) - sum(d.cost_price * oi.quantity) desc
    ) as rank_by_profit,
    rank()over(
        order by round((sum(oi.quantity * oi.unit_price) - sum(d.cost_price * oi.quantity)) * 100.00/sum(oi.quantity * oi.unit_price),2) desc
    ) as rank_by_margin
from order_items oi 
right join dishes d on oi.dish_id = d.id
right join categories c on d.category_id = c.id
right join orders o on oi.order_id = o.id 
where o.status = 'Completed'
group by 1,2
order by profit desc, dish_name asc
