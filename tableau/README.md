# Tableau Dashboard Data

This folder contains Tableau-ready summary outputs for a market basket and cross-sell dashboard. The files are derived from the local SQLite analysis and are intentionally small enough to publish in GitHub without including the raw transaction dataset.

## Dashboard Purpose

The Tableau dashboard is designed to answer:

- What is the overall commercial scale of the basket data?
- How do sales and basket activity change across derived monthly periods?
- Which product categories contribute the most sales?
- Which category combinations appear together most frequently?
- Are there data quality issues that should be checked before using the analysis for commercial decisions?

## Files

| File | Tableau Use | Key Fields |
|---|---|---|
| `tableau_kpi_summary.csv` | KPI cards | `total_sales`, `basket_count`, `avg_basket_value` |
| `tableau_monthly_sales.csv` | Line chart | `month_number`, `monthly_sales`, `basket_count`, `avg_basket_value`, `sales_change`, `sales_change_pct` |
| `tableau_top_categories.csv` | Bar chart | `category`, `basket_count`, `total_sales`, `sales_per_basket` |
| `tableau_category_pairs.csv` | Bar chart or table | `category_pair`, `category_a`, `category_b`, `basket_count` |
| `tableau_data_quality.csv` | Data quality KPI box | `zero_sales_rows`, `non_positive_baskets`, `unmatched_product_rows`, `duplicate_record_groups` |

## Recommended Dashboard Layout

1. KPI cards:
   - Total sales
   - Basket count
   - Average basket value
2. Monthly sales trend:
   - Line chart using `month_number` and `monthly_sales`
3. Category performance:
   - Bar chart using `category` and `total_sales`
4. Category pair analysis:
   - Bar chart or table using `category_pair` and `basket_count`
5. Data quality summary:
   - Small text or KPI box showing zero-sales rows, non-positive baskets, unmatched products, and duplicate record groups

## Notes

- `month_number` is an approximate 30-day period derived from the dataset's `DAY` field. It is not a real calendar month because the raw dataset does not include calendar dates.
- The category-pair dashboard uses shared basket counts. This complements the Python notebook, which focuses on support, confidence, and lift.
- The dashboard uses separate summary CSVs rather than joining all files together. Each CSV should be used as a separate data source in Tableau.

## Key Findings for Dashboard Annotation

- Total sales in the analysed transaction data are approximately 8.06 million, across 276,484 baskets.
- Average basket value is approximately 29.14.
- Coupon/misc items, soft drinks, beef, and fluid milk products are among the leading sales categories.
- Common category pairs include baked bread with fluid milk products, fluid milk products with soft drinks, and cheese with fluid milk products.
- Data quality checks found zero unmatched product records and zero duplicate transaction groups, but there are zero-sales rows and non-positive basket values that should be treated carefully in commercial interpretation.
