-- Run these queries in project databryte to create real BigQuery job history.
-- Use the same Google account that is connected to Context Layer.

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

SELECT
  c.customer_segment,
  COUNT(DISTINCT o.customer_id) AS active_customers,
  AVG(order_totals.order_value) AS average_order_value
FROM `databryte.context_engineering_demo.orders` AS o
JOIN `databryte.context_engineering_demo.customers` AS c USING (customer_id)
JOIN (
  SELECT order_id, SUM(quantity * unit_price) AS order_value
  FROM `databryte.context_engineering_demo.order_items`
  GROUP BY order_id
) AS order_totals USING (order_id)
WHERE o.order_status = 'complete'
GROUP BY c.customer_segment
ORDER BY average_order_value DESC;
