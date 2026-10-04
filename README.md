# Context Engineering Demo

This public demo repository pairs a small analytics codebase with synthetic BigQuery tables. It is intended for testing repository and BigQuery ingestion in Context Layer.

## Publish the demo repository

From this directory, after installing and authenticating the GitHub CLI as `sriknamb-mids`, create the public repository and push the demo:

```sh
git init -b main
git add .
git commit -m "Add Context Layer ingestion demo"
gh repo create sriknamb-mids/context-engineering-demo --public --source=. --remote=origin --push
```

## BigQuery setup

The examples target project `databryte` and dataset `context_engineering_demo`. Create the dataset and synthetic tables by running [`bigquery/setup.sql`](bigquery/setup.sql) in the BigQuery console or with the `bq` command:

```sh
bq query --project_id=databryte --use_legacy_sql=false < bigquery/setup.sql
```

Then run each sample query separately as the same Google account you connect to Context Layer. This creates three distinct BigQuery query jobs:

```sh
for query in bigquery/queries/*.sql; do
  bq query --project_id=databryte --use_legacy_sql=false < "$query"
done
```

BigQuery query history is recorded as jobs, not as rows in a table. Context Layer reads recent jobs from the selected BigQuery project, so run these queries in `databryte` under your connected account. Job history visibility depends on the permissions granted to that account. [`workload.sql`](bigquery/workload.sql) contains the same queries in one script for convenience, but running that script creates a single job.

## Add the demo in Context Layer

1. Connect the Google account that ran `workload.sql`.
2. Create a project and select BigQuery project `databryte`.
3. Select dataset `context_engineering_demo` and tables `customers`, `orders`, `order_items`, and `products`.
4. Select this public GitHub repository and its `main` branch.
5. Build context and review table samples, query history, and links between SQL and tables.

The dataset contains only deterministic, synthetic retail data. The SQL is safe to rerun: it replaces only these four tables in the demo dataset. Do not put credentials or real customer data in this repository.
