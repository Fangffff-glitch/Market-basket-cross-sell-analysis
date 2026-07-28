-- Query 5: Monthly Sales Trends
-- Purpose:
-- Create a simple time-series sales view using a derived month number.
--
-- Data note:
-- The dataset contains DAY and WEEK_NO rather than a calendar date. For this
-- portfolio query, month_number is approximated by grouping every 30 days:
-- month_number = ((DAY - 1) / 30) + 1.
--
-- Skills demonstrated:
-- - time-period aggregation
-- - month-on-month comparison with LAG()
-- - category performance ranking with RANK()

-- 1. Monthly sales KPIs with month-on-month change
WITH transaction_months AS (
    SELECT
        CAST(((CAST(DAY AS INTEGER) - 1) / 30) + 1 AS INTEGER) AS month_number,
        BASKET_ID,
        CAST(SALES_VALUE AS REAL) AS sales_value
    FROM transaction_data
),
monthly_sales AS (
    SELECT
        month_number,
        ROUND(SUM(sales_value), 2) AS monthly_sales,
        COUNT(DISTINCT BASKET_ID) AS basket_count,
        ROUND(SUM(sales_value) / COUNT(DISTINCT BASKET_ID), 2) AS avg_basket_value
    FROM transaction_months
    GROUP BY month_number
),
monthly_sales_with_lag AS (
    SELECT
        month_number,
        monthly_sales,
        basket_count,
        avg_basket_value,
        LAG(monthly_sales) OVER (ORDER BY month_number) AS previous_month_sales,
        LAG(basket_count) OVER (ORDER BY month_number) AS previous_month_baskets
    FROM monthly_sales
)
SELECT
    month_number,
    monthly_sales,
    basket_count,
    avg_basket_value,
    previous_month_sales,
    ROUND(monthly_sales - previous_month_sales, 2) AS sales_change,
    ROUND(
        (monthly_sales - previous_month_sales) / NULLIF(previous_month_sales, 0),
        4
    ) AS sales_change_pct,
    previous_month_baskets,
    basket_count - previous_month_baskets AS basket_count_change
FROM monthly_sales_with_lag
ORDER BY month_number;

-- 2. Monthly category performance ranking
WITH transaction_months AS (
    SELECT
        CAST(((CAST(t.DAY AS INTEGER) - 1) / 30) + 1 AS INTEGER) AS month_number,
        t.BASKET_ID,
        CAST(t.SALES_VALUE AS REAL) AS sales_value,
        p.COMMODITY_DESC AS category
    FROM transaction_data t
    JOIN product p
        ON t.PRODUCT_ID = p.PRODUCT_ID
    WHERE p.COMMODITY_DESC IS NOT NULL
      AND p.COMMODITY_DESC != 'NO COMMODITY DESCRIPTION'
),
category_monthly_sales AS (
    SELECT
        month_number,
        category,
        ROUND(SUM(sales_value), 2) AS category_sales,
        COUNT(DISTINCT BASKET_ID) AS category_baskets
    FROM transaction_months
    GROUP BY
        month_number,
        category
),
ranked_categories AS (
    SELECT
        month_number,
        category,
        category_sales,
        category_baskets,
        RANK() OVER (
            PARTITION BY month_number
            ORDER BY category_sales DESC
        ) AS category_sales_rank
    FROM category_monthly_sales
)
SELECT
    month_number,
    category_sales_rank,
    category,
    category_sales,
    category_baskets
FROM ranked_categories
WHERE category_sales_rank <= 5
ORDER BY
    month_number,
    category_sales_rank;

