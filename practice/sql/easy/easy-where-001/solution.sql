-- Xom Data · Filter products by category
-- Problem: https://xomdata.com/practice/easy-where-001
-- Solved: 2026-05-19

-- Filter Electronics
SELECT name, price, categories
FROM products
WHERE categories = 'Electronics';
