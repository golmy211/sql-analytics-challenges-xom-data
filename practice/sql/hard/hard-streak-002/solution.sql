-- Xom Data · Who is still on an active streak today
-- Problem: https://xomdata.com/practice/hard-streak-002
-- Solved: 2026-11-02

with s as (
    select 
        customer_id,
        order_date,
        TO_CHAR(cast(order_date as date),'YYYY-MM') as month 
    from orders 
),
f as (
    select 
        customer_id,
        CAST(TO_CHAR(cast('2024-06-01' as date),'YYYY') AS INTEGER) *12 + CAST(TO_CHAR(cast('2024-06-01' as date),'MM') AS INTEGER) as cidx,
        CAST(TO_CHAR(cast(order_date as date),'YYYY') AS INTEGER) *12 + CAST(TO_CHAR(cast(order_date as date),'MM') AS INTEGER) as fidx
    from s 
),
b as (
    select 
        customer_id,
        (cidx - fidx) as diff,
        -- Dùng DENSE_RANK trừ đi 1 để rank bắt đầu từ 0 (khớp với diff = 0 của tháng 5)
        DENSE_RANK() OVER (PARTITION BY customer_id ORDER BY fidx DESC) - 1 as lien_tiep
    from f
)
select 
    customer_id,
    COUNT(DISTINCT diff) as current_streak
from b
-- Ý tưởng của bạn: khoảng cách tháng phải bằng đúng thứ tự liên tiếp
where diff = lien_tiep 
group by customer_id
-- Điều kiện bắt buộc: khách phải có giao dịch ở tháng hiện tại (2024-05, tức là diff = 0)
having MIN(diff) = 0 
order by current_streak desc, customer_id asc;
