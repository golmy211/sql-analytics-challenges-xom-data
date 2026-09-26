-- Xom Data · Delivery performance by size class
-- Problem: https://xomdata.com/practice/medium-case-160
-- Solved: 2026-09-26

with test as (
    select 
        t.vehicle_type,
        t.capacity_tons,
        count(d.id) as shipment_count,
        sum(case 
                when d.results = 'success' then 1 else 0 end) as delivered,
        case 
            when  t.capacity_tons >= 10 then 'Large Truck'
            when  t.capacity_tons between 5 and 10 then 'Medium Truck'
            else 'Small Truck'
            end as size_class,
        round(sum(case 
                when d.results = 'success' then 1 else 0 end) * 100.0/ count(d.id),2) as delivery_rate
    from trucks t  
    left join shipments s on t.id = s.truck_id
    left join deliveries d on s.id = d.shipment_id 
    group by 1,2
) 
select 
    vehicle_type,
    capacity_tons,
    shipment_count,
    size_class,
    delivered,
    delivery_rate,
    rank()over(
        partition by size_class order by delivery_rate desc
    ) as rank_in_size
from test
order by size_class asc, rank_in_size asc, vehicle_type asc
