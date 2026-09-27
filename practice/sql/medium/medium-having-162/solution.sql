-- Xom Data · Suppliers that deliver late frequently
-- Problem: https://xomdata.com/practice/medium-having-162
-- Solved: 2026-09-27

select
    s.supplier_name,
    s.material_type,
    count(p.id) as purchase_count,
    sum(p.total_value) as total_purchase_value,
    round(avg(julianday(p.actual_receipt) - julianday(p.expected_receipt)),2) as avg_late_days ,
    round(100.00*sum(case when julianday(p.actual_receipt) <= julianday(p.expected_receipt) then 1 else 0 end)/ count(p.id),2) as on_time_rate,
    rank()over(
        order by round(avg(julianday(p.actual_receipt) - julianday(p.expected_receipt)),2) desc
    ) as late_rank,
    ntile(4) over(
        order by round(avg(julianday(p.actual_receipt) - julianday(p.expected_receipt)),2) desc
    ) as risk_tier
from suppliers s
left join purchase_orders p on s.id = p.supplier_id
group by 1,2
having  count(p.id) >= 3 and round(avg(julianday(p.actual_receipt) - julianday(p.expected_receipt)),2) > 0
order by late_rank asc, supplier_name asc
