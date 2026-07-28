-- Query 2: Top Categories by Sales
-- Purpose:
-- Join transaction data with product attributes and identify the product categories
-- generating the highest total sales.
--
-- Key idea:
-- transaction_data contains basket and sales information, while product contains
-- product category information. Joining them by PRODUCT_ID allows category-level
-- sales analysis.

SELECT
    p.COMMODITY_DESC AS category,
    COUNT(*) AS transaction_rows,
    COUNT(DISTINCT t.BASKET_ID) AS basket_count,
    ROUND(SUM(t.SALES_VALUE), 2) AS total_sales,
    ROUND(SUM(t.SALES_VALUE) / COUNT(DISTINCT t.BASKET_ID), 2) AS sales_per_basket
FROM transaction_data t
JOIN product p
    ON t.PRODUCT_ID = p.PRODUCT_ID
WHERE p.COMMODITY_DESC IS NOT NULL
  AND p.COMMODITY_DESC != 'NO COMMODITY DESCRIPTION'
GROUP BY p.COMMODITY_DESC
ORDER BY total_sales DESC
LIMIT 20;

