-- Xom Data · Stock-in history by supplier
-- Problem: https://xomdata.com/practice/medium-join-014
-- Solved: 2026-09-30

with rank as(
select 
    w.warehouse_name,
    count(s.id) as import_count,
    count(distinct s.product_id) as distinct_product_count,
    count(distinct s.suppliers) as distinct_supplier_count,
    max(import_date) as last_import_date,
    rank()over(
        order by count(s.id) desc
    ) as activity_rank
from warehouses w 
left join stock_imports s on w.id = s.warehouse_id
left join products p on s.product_id = p.id
group by 1
) 
select 
    warehouse_name,
    import_count,
    distinct_product_count,
    distinct_supplier_count,
    last_import_date,
    activity_rank,
    lag(warehouse_name)over(
        order by activity_rank
    ) as prev_warehouse
from rank
order by activity_rank asc, warehouse_name asc
