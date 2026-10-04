"""Small example showing application code querying the demo warehouse."""

from google.cloud import bigquery


def completed_sales_by_region(client: bigquery.Client) -> list[dict]:
    """Return completed order totals grouped by customer region."""
    query = """
        SELECT c.region, SUM(oi.quantity * oi.unit_price) AS gross_sales
        FROM `databryte.context_engineering_demo.orders` AS o
        JOIN `databryte.context_engineering_demo.customers` AS c USING (customer_id)
        JOIN `databryte.context_engineering_demo.order_items` AS oi USING (order_id)
        WHERE o.order_status = 'complete'
        GROUP BY c.region
    """
    return [dict(row) for row in client.query(query).result()]
