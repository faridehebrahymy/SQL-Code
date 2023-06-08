-- Section1
UPDATE products
JOIN (SELECT product_id,
       SUM(quantity * p.price) AS correct_profit
FROM products p JOIN order_details od ON p.id = od.product_id
GROUP BY product_id) AS p2 ON products.id=p2.product_id
SET total_profit= correct_profit
-- Section2
SELECT delivery_center_id FROM deliveries
WHERE  delivered_at IS NOT NULL
GROUP BY  delivery_center_id
ORDER BY AVG(delivered_at - received_at)
LIMIT 5;

