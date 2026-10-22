-- Xom Data · Multi-level profit margin analysis
-- Problem: https://xomdata.com/practice/hard-multicte-001
-- Solved: 2026-10-22

with s as (
    
    select 
        p.category,
        p.name as product_name,
        sum(o.quantity * o.price) as revenue,
        sum(o.quantity *p.unit_cost) as cost,
        sum(o.quantity * o.price) - sum(o.quantity *p.unit_cost) as profit
    from products p 
    join orders o on p.id = o.product_id
    group by 1,2 
)
    select 
        category,
        product_name,
        revenue,
        cost,
        profit,
        round(100.00 * (revenue-cost)/revenue,2) as margin_pct,
        dense_rank()over(
            partition by category
            order by profit desc
        ) as rank_in_cat,
        round(profit * 100.00/ nullif(max(profit)over(partition by category),0),2) as pct_of_top_in_cat
    from s 
    order by category, rank_in_cat, product_name
