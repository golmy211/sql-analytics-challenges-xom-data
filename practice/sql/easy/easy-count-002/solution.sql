-- Xom Data · Number of delivered orders
-- Problem: https://xomdata.com/practice/easy-count-002
-- Solved: 2026-05-19

-- Đếm đơn Delivered
SELECT COUNT(*) as order_count
FROM orders
WHERE status = 'Delivered'
