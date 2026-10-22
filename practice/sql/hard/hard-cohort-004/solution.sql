-- Xom Data · Customer cohorts viewed by acquisition channel
-- Problem: https://xomdata.com/practice/hard-cohort-004
-- Solved: 2026-10-22

with cohort as (
    -- Bước 1: Tìm tháng mua hàng đầu tiên (thế hệ) và kênh của từng khách
    select 
        o.customer_id,
        c.channel,
        min(o.order_date)::date as first_order_date
    from orders o
    join customers c on o.customer_id = c.customer_id
    group by 1, 2
)

-- Bước 2: Join lại với bảng orders để tính toán retention
select 
    c.channel,
    to_char(c.first_order_date, 'YYYY-MM') as cohort_month,
    count(distinct c.customer_id) as cohort_size,
    count(distinct case 
            -- So sánh tháng mua hàng với (tháng đơn đầu + 1 tháng)
            when to_char(o.order_date::date, 'YYYY-MM') = to_char(c.first_order_date + INTERVAL '1 month', 'YYYY-MM') 
            then o.customer_id 
          end) as retained_m1
from cohort c
join orders o on c.customer_id = o.customer_id
group by 1, 2
order by c.channel asc, cohort_month asc;
