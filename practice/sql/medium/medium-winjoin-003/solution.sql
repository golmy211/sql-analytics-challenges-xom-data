-- Xom Data · Each aisle's best seller
-- Problem: https://xomdata.com/practice/medium-winjoin-003
-- Solved: 2026-10-02

-- Write your SQL here
with top_cat as (
    select 
        c.category_name,
        p.product_name,
        sum(p.units_sold) as units_sold,
        row_number()over(
            partition by c.category_name
            order by sum(p.units_sold) desc, p.product_name asc  
        ) as rn 
    from categories c 
    join products p on c.id = p.category_id
    group by 1,2
)
select 
    category_name,
    product_name,
    coalesce(units_sold,0) as units_sold
from top_cat
where rn = 1 
order by category_name asc
