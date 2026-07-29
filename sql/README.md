# SQL Analysis

This folder contains simple SQL queries for exploring the retail transaction dataset in SQLite.

The SQL analysis is designed to complement the Python notebook by showing how core data analyst tasks can be done directly from relational tables:

- Inspect transaction and product data
- Calculate sales KPIs
- Join transaction records with product attributes
- Identify top-performing product categories
- Extract category pairs that often appear in the same basket

## How to Use

1. Open DB Browser for SQLite.
2. Create or open a local SQLite database.
3. Import the local CSV files as tables:
   - `transaction_data.csv` as `transaction_data`
   - `product.csv` as `product`
4. Open the `Execute SQL` tab.
5. Run the scripts in this folder.

Raw CSV files and local SQLite database files are not committed to GitHub.

## Scripts

```text
01_sales_overview.sql
02_top_categories_by_sales.sql
03_category_pair_analysis.sql
04_data_quality_checks.sql
05_monthly_sales_trends.sql
sql_business_summary.md
```

`sql_business_summary.md` summarises the business questions, main outputs, anomalies, trend findings, and commercial implications from the SQL analysis.

## SQL Skills Demonstrated

- `SELECT`
- `COUNT`
- `COUNT(DISTINCT ...)`
- `SUM`
- `ROUND`
- `JOIN`
- `WHERE`
- `GROUP BY`
- `ORDER BY`
- `LIMIT`
- Common table expressions using `WITH`
- Self joins for market basket-style pair analysis
- Data quality checks for missing keys, duplicates, unmatched joins, and anomalous baskets
- Window functions such as `LAG()` and `RANK()`
