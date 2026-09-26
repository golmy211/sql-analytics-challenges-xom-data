-- Xom Data · Portfolio profit/loss
-- Problem: https://xomdata.com/practice/medium-casewhen-047
-- Solved: 2026-09-26

with profit as (
select 
    s.stock_code,
    c.stock_quantity,
    c.avg_cost_price,
    s.current_price,
    round((s.current_price - c.avg_cost_price) * c.stock_quantity,2) as profit_loss,
    round((s.current_price - c.avg_cost_price) / c.avg_cost_price * 100, 2) as profit_pct
from categories c
left join stocks s on c.stock_id = s.id 
) 
select 
    stock_code,
    stock_quantity,
    avg_cost_price,
    current_price,
    profit_loss,
    profit_pct,
    case 
        when profit_pct > 10 then 'Strong Gain'
        when profit_pct > 0 and profit_pct <= 10 then 'Mild Gain'
        when profit_pct = 0 then 'Break Even'
        when profit_pct > -10 and profit_pct < 0 then 'Mild Loss'
        else 'Strong Loss'
        end as status,
    rank()over(
        order by profit_pct desc
    ) as rank_by_pct,
    sum(avg_cost_price * stock_quantity) over(
        order by profit_pct desc, stock_code asc
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) as cumulative_invested 
    from profit 
    order by rank_by_pct asc , stock_code asc
