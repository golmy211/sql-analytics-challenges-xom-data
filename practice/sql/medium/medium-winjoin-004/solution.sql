-- Xom Data · The same customer's previous order
-- Problem: https://xomdata.com/practice/medium-winjoin-004
-- Solved: 2026-10-02

-- Write your SQL here
select 
    m.member_name,
    p.purchase_date,
    p.amount,
    lag(p.amount)over(
        partition by m.member_name
        order by p.purchase_date asc 
    ) as prev_amount

from members m 
join purchases p on m.id = p.member_id
order by member_name asc, purchase_date asc
