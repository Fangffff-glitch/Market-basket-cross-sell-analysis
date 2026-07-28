-- Query 4: Data Quality Checks
-- Purpose:
-- Run basic validation checks on transaction and product data before analysis.
--
-- Checks covered:
-- 1. NULL or blank basket/product identifiers
-- 2. Negative or zero sales values
-- 3. Duplicated transaction records
-- 4. Transaction records without a matching product record
-- 5. Baskets with abnormal total values

-- 1. Missing key identifiers
SELECT
    'missing_key_identifiers' AS check_name,
    SUM(CASE WHEN BASKET_ID IS NULL OR TRIM(BASKET_ID) = '' THEN 1 ELSE 0 END) AS missing_basket_id_rows,
    SUM(CASE WHEN PRODUCT_ID IS NULL OR TRIM(PRODUCT_ID) = '' THEN 1 ELSE 0 END) AS missing_product_id_rows,
    COUNT(*) AS total_rows
FROM transaction_data;

-- 2. Negative or zero sales values
SELECT
    'non_positive_sales_values' AS check_name,
    SUM(CASE WHEN CAST(SALES_VALUE AS REAL) < 0 THEN 1 ELSE 0 END) AS negative_sales_rows,
    SUM(CASE WHEN CAST(SALES_VALUE AS REAL) = 0 THEN 1 ELSE 0 END) AS zero_sales_rows,
    COUNT(*) AS total_rows
FROM transaction_data;

-- 3. Duplicated transaction records
-- A duplicate is defined as an exact match across the main transaction fields.
WITH duplicate_records AS (
    SELECT
        household_key,
        BASKET_ID,
        DAY,
        PRODUCT_ID,
        QUANTITY,
        SALES_VALUE,
        STORE_ID,
        RETAIL_DISC,
        TRANS_TIME,
        WEEK_NO,
        COUPON_DISC,
        COUPON_MATCH_DISC,
        COUNT(*) AS duplicate_count
    FROM transaction_data
    GROUP BY
        household_key,
        BASKET_ID,
        DAY,
        PRODUCT_ID,
        QUANTITY,
        SALES_VALUE,
        STORE_ID,
        RETAIL_DISC,
        TRANS_TIME,
        WEEK_NO,
        COUPON_DISC,
        COUPON_MATCH_DISC
    HAVING COUNT(*) > 1
)
SELECT
    'duplicated_transaction_records' AS check_name,
    COUNT(*) AS duplicated_record_groups,
    SUM(duplicate_count - 1) AS extra_duplicate_rows
FROM duplicate_records;

-- 4. Transactions without a matching product record
SELECT
    'transactions_without_product_match' AS check_name,
    COUNT(*) AS unmatched_transaction_rows
FROM transaction_data t
LEFT JOIN product p
    ON t.PRODUCT_ID = p.PRODUCT_ID
WHERE p.PRODUCT_ID IS NULL;

-- 5a. Basket-level value summary
WITH basket_values AS (
    SELECT
        BASKET_ID,
        ROUND(SUM(CAST(SALES_VALUE AS REAL)), 2) AS basket_value
    FROM transaction_data
    GROUP BY BASKET_ID
)
SELECT
    'basket_value_summary' AS check_name,
    COUNT(*) AS basket_count,
    ROUND(MIN(basket_value), 2) AS min_basket_value,
    ROUND(AVG(basket_value), 2) AS avg_basket_value,
    ROUND(MAX(basket_value), 2) AS max_basket_value,
    SUM(CASE WHEN basket_value <= 0 THEN 1 ELSE 0 END) AS non_positive_baskets
FROM basket_values;

-- 5b. Top high-value baskets for anomaly review
WITH basket_values AS (
    SELECT
        BASKET_ID,
        COUNT(*) AS item_rows,
        ROUND(SUM(CAST(SALES_VALUE AS REAL)), 2) AS basket_value
    FROM transaction_data
    GROUP BY BASKET_ID
)
SELECT
    BASKET_ID,
    item_rows,
    basket_value
FROM basket_values
ORDER BY basket_value DESC
LIMIT 20;

