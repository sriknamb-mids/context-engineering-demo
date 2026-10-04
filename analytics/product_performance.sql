-- Product performance model. Order status is filtered before aggregation so
-- refunded orders do not contribute to the revenue report.
SELECT
  p.product_id,
  p.product_name,
  p.category,
  SUM(oi.quantity) AS units_sold,
  SUM(oi.quantity * oi.unit_price) AS revenue
FROM `databryte.context_engineering_demo.order_items` AS oi
JOIN `databryte.context_engineering_demo.products` AS p USING (product_id)
JOIN `databryte.context_engineering_demo.orders` AS o USING (order_id)
WHERE o.order_status = 'complete'
GROUP BY p.product_id, p.product_name, p.category;
