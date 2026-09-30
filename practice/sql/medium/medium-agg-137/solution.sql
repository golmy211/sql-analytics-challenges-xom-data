-- Xom Data · Investor trade summary
-- Problem: https://xomdata.com/practice/medium-agg-137
-- Solved: 2026-09-30

-- Summarize buy/sell totals per investor
with total as (
SELECT
  i.full_name,
  i.segment,
  count(t.id) as total_trades,
  sum(case when side = 'buy' then amount else 0 end) as total_bought,
  sum(case when side = 'sell' then amount else 0 end) as total_sold
FROM investors i
JOIN trades t ON t.investor_id = i.id
group by 1,2
) 
select full_name,
        segment,
        total_trades,
        total_bought,
        total_sold as total_sold,
        total_bought - total_sold as net_position,
        case 
          when total_bought > total_sold then 'Bull'
          when total_bought < total_sold then 'Bear'
          else 'Neutral'
          end as stance,
        dense_rank()over(
          partition by segment
          order by total_bought + total_sold desc 
        ) as rank_in_segment
from total
order by total_bought + total_sold desc , full_name asc
