SELECT
  p.category,
  p.product_name,
  SUM(oi.quantity) AS units_sold,
  SUM(oi.quantity * oi.unit_price) AS revenue
FROM `databryte.context_engineering_demo.order_items` AS oi
JOIN `databryte.context_engineering_demo.products` AS p USING (product_id)
JOIN `databryte.context_engineering_demo.orders` AS o USING (order_id)
WHERE o.order_status = 'complete'
GROUP BY p.category, p.product_name
ORDER BY revenue DESC;
