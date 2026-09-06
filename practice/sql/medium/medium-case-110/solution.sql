-- Xom Data · Classify products by sales velocity
-- Problem: https://xomdata.com/practice/medium-case-110
-- Solved: 2026-09-06

select
        p.name,
        p.categories,
        coalesce(sum(t.quantity),0) as total_sold,
        case
            when coalesce(sum(t.quantity),0) >= 100 then 'Best Seller'
            when coalesce(sum(t.quantity),0) between 50 and 100 then 'Average'
            else 'Slow Mover'
            end as classification,
        dense_rank()over(
            partition by p.categories
            order by coalesce(sum(t.quantity),0) desc
        ) as rank_in_cat,
        round(
        coalesce(sum(t.quantity), 0) / sum(coalesce(sum(t.quantity), 0)) over (partition by p.categories) * 100.0,
        2
    ) as pct_of_cat_total
from products p 
left join transactions t on p.id = t.product_id 
group by p.name, p.categories
order by p.categories, rank_in_cat, p.name
