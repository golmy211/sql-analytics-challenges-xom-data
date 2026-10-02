-- Xom Data · Top three sellers per category
-- Problem: https://xomdata.com/practice/medium-topn-002
-- Solved: 2026-10-02

-- Write your SQL here
with top_three as(
    select 
        product_name,
        category,
        units_sold,
        row_number()over(
            partition by category
            order by units_sold desc, product_name asc 
        ) as rn
    from menu_sales
)
select 
    category,
    product_name,
    units_sold
from top_three
where rn <= 3 
order by category asc
