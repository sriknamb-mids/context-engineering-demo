-- Synthetic retail dataset for the Context Layer ingestion demo.
-- This script replaces only tables in the dedicated demo dataset.
CREATE SCHEMA IF NOT EXISTS `databryte.context_engineering_demo`;

CREATE OR REPLACE TABLE `databryte.context_engineering_demo.customers` (
  customer_id INT64 NOT NULL,
  customer_segment STRING,
  signup_date DATE,
  region STRING
);

INSERT INTO `databryte.context_engineering_demo.customers` VALUES
  (1001, 'everyday', DATE '2024-01-12', 'west'),
  (1002, 'premium', DATE '2024-02-03', 'northeast'),
  (1003, 'everyday', DATE '2024-03-18', 'south'),
  (1004, 'business', DATE '2024-04-06', 'midwest'),
  (1005, 'premium', DATE '2024-05-21', 'west');

CREATE OR REPLACE TABLE `databryte.context_engineering_demo.products` (
  product_id INT64 NOT NULL,
  product_name STRING,
  category STRING,
  unit_price NUMERIC
);

INSERT INTO `databryte.context_engineering_demo.products` VALUES
  (501, 'Trail Bottle', 'outdoors', 24.00),
  (502, 'Commuter Pack', 'bags', 78.00),
  (503, 'Desk Lamp', 'home', 46.50),
  (504, 'Merino Socks', 'apparel', 18.00);

CREATE OR REPLACE TABLE `databryte.context_engineering_demo.orders` (
  order_id INT64 NOT NULL,
  customer_id INT64 NOT NULL,
  order_date DATE,
  order_status STRING
);

INSERT INTO `databryte.context_engineering_demo.orders` VALUES
  (9001, 1001, DATE '2025-01-05', 'complete'),
  (9002, 1002, DATE '2025-01-08', 'complete'),
  (9003, 1001, DATE '2025-01-14', 'complete'),
  (9004, 1003, DATE '2025-02-02', 'refunded'),
  (9005, 1004, DATE '2025-02-11', 'complete'),
  (9006, 1005, DATE '2025-02-17', 'complete'),
  (9007, 1002, DATE '2025-03-03', 'complete');

CREATE OR REPLACE TABLE `databryte.context_engineering_demo.order_items` (
  order_item_id INT64 NOT NULL,
  order_id INT64 NOT NULL,
  product_id INT64 NOT NULL,
  quantity INT64 NOT NULL,
  unit_price NUMERIC NOT NULL
);

INSERT INTO `databryte.context_engineering_demo.order_items` VALUES
  (1, 9001, 501, 2, 24.00),
  (2, 9001, 504, 3, 18.00),
  (3, 9002, 502, 1, 78.00),
  (4, 9003, 503, 1, 46.50),
  (5, 9003, 501, 1, 24.00),
  (6, 9004, 504, 2, 18.00),
  (7, 9005, 502, 2, 78.00),
  (8, 9006, 503, 1, 46.50),
  (9, 9006, 501, 1, 24.00),
  (10, 9007, 504, 4, 18.00);
