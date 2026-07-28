-- Query 3: Category Pair Analysis
-- Purpose:
-- Identify product categories that frequently appear in the same shopping basket.
--
-- Key idea:
-- This is a SQL version of a simple market basket analysis. It first creates a
-- basket-category table, then self-joins it to form category pairs within the
-- same basket.

WITH basket_categories AS (
    -- One row per basket-category combination.
    -- DISTINCT prevents the same category from being counted multiple times
    -- within a single basket.
    SELECT DISTINCT
        t.BASKET_ID,
        p.COMMODITY_DESC AS category
    FROM transaction_data t
    JOIN product p
        ON t.PRODUCT_ID = p.PRODUCT_ID
    WHERE p.COMMODITY_DESC IS NOT NULL
      AND p.COMMODITY_DESC != 'NO COMMODITY DESCRIPTION'
),
category_pairs AS (
    -- Self-join basket_categories to create category pairs within each basket.
    -- a.category < b.category prevents duplicate pairs and self-pairs.
    SELECT
        a.category AS category_a,
        b.category AS category_b,
        COUNT(*) AS basket_count
    FROM basket_categories a
    JOIN basket_categories b
        ON a.BASKET_ID = b.BASKET_ID
       AND a.category < b.category
    GROUP BY
        a.category,
        b.category
)
SELECT
    category_a,
    category_b,
    basket_count
FROM category_pairs
ORDER BY basket_count DESC
LIMIT 20;

