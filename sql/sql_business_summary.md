# SQL Business Summary

This note summarises the business questions, outputs, anomalies, trend findings, and commercial implications from the SQL analysis scripts.

The SQL analysis uses a local SQLite database built from two raw CSV files:

- `transaction_data`
- `product`

Raw CSV files and local database files are not included in the repository.

## Query 1: Sales Overview

File: `01_sales_overview.sql`

### Business Question

What is the overall scale of the transaction dataset, and what are the core basket-level sales KPIs?

### Main Output

- Transaction rows: 2,595,732
- Unique baskets: 276,484
- Unique households: 2,500
- Unique products purchased: 92,339
- Total sales: 8,057,463.08
- Average basket value: 29.14

### Interpretation

The dataset is large enough for meaningful basket analysis, with over 276k baskets across 2,500 households. The average basket value of 29.14 provides a useful baseline for evaluating category performance, basket pair opportunities, and anomaly checks.

## Query 2: Top Categories by Sales

File: `02_top_categories_by_sales.sql`

### Business Question

Which product categories generate the highest sales value, and which categories should be prioritised for merchandising or promotional review?

### Main Output

Top categories by total sales:

| Rank | Category | Basket Count | Total Sales |
|---:|---|---:|---:|
| 1 | COUPON/MISC ITEMS | 27,705 | 639,878.56 |
| 2 | SOFT DRINKS | 71,699 | 327,647.30 |
| 3 | BEEF | 36,733 | 312,103.22 |
| 4 | FLUID MILK PRODUCTS | 69,278 | 205,356.05 |
| 5 | CHEESE | 46,898 | 189,528.18 |
| 6 | FRZN MEAT/MEAT DINNERS | 22,777 | 160,517.17 |
| 7 | BAG SNACKS | 42,037 | 148,375.16 |
| 8 | BEERS/ALES | 15,527 | 147,344.45 |
| 9 | FROZEN PIZZA | 23,174 | 146,037.25 |
| 10 | BAKED BREAD/BUNS/ROLLS | 60,311 | 145,930.85 |

### Interpretation

High-sales categories combine both routine household staples and higher-value categories. Soft drinks, milk products, bread, cheese, and snacks appear in large numbers of baskets, suggesting strong relevance for basket-building and cross-sell strategies.

### Commercial Decisions Supported

- Prioritise high-sales and high-frequency categories for promotion planning.
- Use routine categories such as milk, bread, cheese, and soft drinks as basket anchors.
- Review `COUPON/MISC ITEMS` separately because it is the top category but may represent a special or mixed category rather than a normal product group.

## Query 3: Category Pair Analysis

File: `03_category_pair_analysis.sql`

### Business Question

Which categories frequently appear together in the same basket, and where are the strongest cross-sell opportunities?

### Main Output

Top category pairs by shared basket count:

| Rank | Category A | Category B | Shared Baskets |
|---:|---|---|---:|
| 1 | BAKED BREAD/BUNS/ROLLS | FLUID MILK PRODUCTS | 31,010 |
| 2 | FLUID MILK PRODUCTS | SOFT DRINKS | 25,452 |
| 3 | CHEESE | FLUID MILK PRODUCTS | 24,584 |
| 4 | BAKED BREAD/BUNS/ROLLS | SOFT DRINKS | 24,519 |
| 5 | BAKED BREAD/BUNS/ROLLS | CHEESE | 23,937 |
| 6 | BAG SNACKS | SOFT DRINKS | 20,573 |
| 7 | BAG SNACKS | BAKED BREAD/BUNS/ROLLS | 19,643 |
| 8 | CHEESE | SOFT DRINKS | 18,886 |
| 9 | BAKED BREAD/BUNS/ROLLS | BEEF | 18,822 |
| 10 | BAG SNACKS | FLUID MILK PRODUCTS | 18,356 |

### Interpretation

The strongest category pairs reflect practical household shopping missions:

- Bread and milk products suggest routine staple replenishment.
- Cheese, bread, and milk products suggest breakfast, lunch, or family meal baskets.
- Bag snacks and soft drinks suggest occasion-based baskets such as parties, lunch boxes, or casual consumption.
- Beef with bread or cheese suggests meal-building missions.

### Commercial Decisions Supported

- Place high-affinity staples closer together in-store.
- Test bundle offers such as bread with cheese, snacks with soft drinks, and meal-building combinations.
- Use basket-based digital recommendations when a customer adds one category but not its frequent partner.

## Query 4: Data Quality Checks

File: `04_data_quality_checks.sql`

### Business Question

Are there data quality issues or anomalies that could affect analysis reliability?

### Main Output

| Check | Result |
|---|---:|
| Missing basket IDs | 0 |
| Missing product IDs | 0 |
| Negative sales rows | 0 |
| Zero sales rows | 18,850 |
| Duplicate transaction record groups | 0 |
| Extra duplicate rows | 0 |
| Transactions without product match | 0 |
| Non-positive baskets | 942 |
| Maximum basket value | 961.49 |

### Anomalies Found

- There are 18,850 zero-sales transaction rows.
- There are 942 baskets with total basket value less than or equal to zero.
- The highest basket value is 961.49, which is much higher than the average basket value of 29.14.

### Interpretation

No missing key identifiers, duplicate transaction records, or unmatched product joins were found, which supports the reliability of product-level and category-level joins.

However, zero-sales rows and non-positive baskets should be investigated before using revenue-based metrics. These records may represent coupons, returns, free items, data-entry behaviour, or special transaction handling.

High-value baskets should also be reviewed. They may be valid large shopping trips, but they can influence average basket value and category sales calculations.

### Commercial Decisions Supported

- Separate normal sales from zero-value or promotional transactions when building revenue KPIs.
- Validate high-value baskets before using them for customer value segmentation.
- Keep unmatched product checks in recurring reporting pipelines to detect product master data issues early.

## Query 5: Monthly Sales Trends

File: `05_monthly_sales_trends.sql`

### Business Question

How do sales, basket count, and category performance change over time?

### Data Note

The dataset contains `DAY` and `WEEK_NO`, but not a true calendar date. The SQL therefore derives `month_number` by grouping every 30 days:

```sql
month_number = ((DAY - 1) / 30) + 1
```

This should be interpreted as an approximate 30-day period rather than a real calendar month.

### Main Output

The monthly sales query produces:

- monthly sales
- basket count
- average basket value
- previous month sales using `LAG()`
- month-on-month sales change
- month-on-month sales change percentage
- previous month basket count
- basket count change

Examples from the output:

| Month | Monthly Sales | Basket Count | Avg Basket Value | Sales Change | Sales Change % |
|---:|---:|---:|---:|---:|---:|
| 1 | 55,507.48 | 1,897 | 29.26 | - | - |
| 3 | 214,878.77 | 8,016 | 26.81 | 93,882.13 | 77.59% |
| 10 | 379,657.89 | 12,469 | 30.45 | 6,052.70 | 1.62% |
| 22 | 400,471.28 | 12,585 | 31.82 | 9,904.13 | 2.54% |
| 23 | 396,478.04 | 12,420 | 31.92 | -3,993.24 | -1.00% |
| 24 | 272,038.16 | 8,374 | 32.49 | -124,439.88 | -31.39% |

### Trend Interpretation

- Sales increase strongly from the early periods as basket count rises.
- From approximately month 9 onward, monthly sales stabilise mostly around the mid-to-high 300k range.
- Month 22 is the highest observed month in this summary at 400,471.28.
- Month 24 shows a sharp decline, but this should not be over-interpreted without checking whether the final period is incomplete.

### Categories with Sales Growth

Comparing month 3 with month 23, categories with the largest increases include:

| Category | Month 3 Sales | Month 23 Sales | Sales Change |
|---|---:|---:|---:|
| COUPON/MISC ITEMS | 11,194.92 | 27,945.20 | 16,750.28 |
| FLUID MILK PRODUCTS | 5,108.99 | 10,602.67 | 5,493.68 |
| SOFT DRINKS | 10,131.43 | 15,354.83 | 5,223.40 |
| BEEF | 9,949.76 | 14,630.05 | 4,680.29 |
| SOUP | 1,522.00 | 6,187.28 | 4,665.28 |
| CHEESE | 4,992.82 | 9,555.98 | 4,563.16 |
| FRZN MEAT/MEAT DINNERS | 3,945.20 | 8,418.49 | 4,473.29 |
| BAG SNACKS | 4,340.46 | 7,813.16 | 3,472.70 |
| FROZEN PIZZA | 4,009.30 | 7,425.66 | 3,416.36 |
| BAKED BREAD/BUNS/ROLLS | 3,968.88 | 7,312.17 | 3,343.29 |

### Categories with Sales Decline or Weak Growth

Comparing month 3 with month 23, the clearest decline is:

| Category | Month 3 Sales | Month 23 Sales | Sales Change |
|---|---:|---:|---:|
| SPRING/SUMMER SEASONAL | 1,245.80 | 103.65 | -1,142.15 |

This looks commercially plausible because the category is seasonal. Other categories in the lower-growth list show small positive changes rather than major declines.

### Commercial Decisions Supported

- Use growing categories such as milk products, soft drinks, beef, soup, cheese, frozen meals, snacks, and frozen pizza for campaign planning and inventory focus.
- Treat `SPRING/SUMMER SEASONAL` as seasonal rather than structurally weak.
- Investigate the sharp month 24 decline before making commercial conclusions, because it may reflect an incomplete final period.
- Use monthly category ranking to identify which categories consistently stay in the top 5 and which categories are temporary peaks.

## Overall SQL Findings

The SQL analysis supports several commercial decisions:

- Basket-building categories such as bread, milk, cheese, soft drinks, and snacks are strong candidates for cross-sell recommendations.
- High-frequency category pairs can support in-store adjacency, bundle design, and app-based recommendation logic.
- Data quality checks show reliable product matching but flag zero-sales rows and non-positive baskets for investigation.
- Trend analysis shows sales stabilising after early ramp-up, with month 22 as the strongest derived period and month 24 requiring caution.
- Category growth patterns support promotion planning around routine household staples and meal-building categories.

## Interview Summary

This SQL work demonstrates how transaction and product data can be validated, joined, aggregated, and translated into commercial recommendations. The analysis covers KPI reporting, category performance, market basket-style pair extraction, data quality checks, anomaly investigation, month-on-month trend analysis, and category ranking using window functions.

