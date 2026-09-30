-- Xom Data · Rank hotels by room price within each destination
-- Problem: https://xomdata.com/practice/medium-join-155
-- Solved: 2026-09-30

select 
    h.hotel_name,
    h.star_class,
    d.destination_name,
    count(hr.id) as room_count,
    min(hr.nightly_rate) as min_price,
    max(hr.nightly_rate) as max_price,
    round(avg(hr.nightly_rate),0) as avg_price,
    max(hr.nightly_rate) - min(hr.nightly_rate) as price_spread,
    rank()over(
        partition by destination_name
        order by avg(hr.nightly_rate) desc
    ) as rank_in_destination
from hotels h 
left join destinations d on h.destination_id = d.id
left join hotel_rooms hr on h.id = hr.hotel_id
group by 1,2,3
having count(hr.id) >= 2
order by destination_name asc, rank_in_destination asc, hotel_name asc
