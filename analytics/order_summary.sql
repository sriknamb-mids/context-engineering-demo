-- Daily order summary used by the demo reporting job.
SELECT
  o.order_date,
  c.region,
  COUNT(DISTINCT o.order_id) AS order_count,
  SUM(oi.quantity * oi.unit_price) AS gross_sales
FROM `databryte.context_engineering_demo.orders` AS o
JOIN `databryte.context_engineering_demo.customers` AS c USING (customer_id)
JOIN `databryte.context_engineering_demo.order_items` AS oi USING (order_id)
WHERE o.order_status = 'complete'
GROUP BY o.order_date, c.region;
