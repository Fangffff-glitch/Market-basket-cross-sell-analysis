-- Query 1: Sales Overview
-- Purpose:
-- Summarise the size of the transaction dataset and calculate core sales KPIs.
--
-- Output:
-- - transaction_rows: number of transaction-level rows
-- - basket_count: number of unique shopping baskets
-- - household_count: number of unique households
-- - product_count: number of unique products purchased
-- - total_sales: total sales value
-- - avg_basket_value: average sales value per basket

SELECT
    COUNT(*) AS transaction_rows,
    COUNT(DISTINCT BASKET_ID) AS basket_count,
    COUNT(DISTINCT household_key) AS household_count,
    COUNT(DISTINCT PRODUCT_ID) AS product_count,
    ROUND(SUM(SALES_VALUE), 2) AS total_sales,
    ROUND(SUM(SALES_VALUE) / COUNT(DISTINCT BASKET_ID), 2) AS avg_basket_value
FROM transaction_data;

