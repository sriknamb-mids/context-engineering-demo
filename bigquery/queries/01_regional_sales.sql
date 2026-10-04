SELECT
  c.region,
  COUNT(DISTINCT o.order_id) AS completed_orders,
  SUM(oi.quantity * oi.unit_price) AS gross_sales
FROM `databryte.context_engineering_demo.orders` AS o
JOIN `databryte.context_engineering_demo.customers` AS c USING (customer_id)
JOIN `databryte.context_engineering_demo.order_items` AS oi USING (order_id)
WHERE o.order_status = 'complete'
GROUP BY c.region
ORDER BY gross_sales DESC;
