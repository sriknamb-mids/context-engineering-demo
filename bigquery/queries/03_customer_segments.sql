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
