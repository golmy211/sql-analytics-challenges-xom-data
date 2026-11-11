-- Xom Data · Three-level sales totals: detail, by region, company-wide
-- Problem: https://xomdata.com/practice/expert-final-mix-009
-- Solved: 2026-11-11

with s as(
    select 
        region,
        room,
        sum(revenue) as total_sales
    from sales 
    group by rollup(region,room)
    order by region,room
)
select * from s
