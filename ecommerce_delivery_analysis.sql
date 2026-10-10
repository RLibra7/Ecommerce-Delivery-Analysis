USE ecommerce_delivery;


-- =====================================================
-- 1. DATABASE EXPLORATION
-- =====================================================

-- View available tables
SHOW TABLES;

-- Check total and unique orders
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT order_id) AS unique_orders
FROM orders;

-- Check order status distribution
SELECT
    order_status,
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;

-- Check order date range
SELECT
    MIN(order_purchase_timestamp) AS first_order_date,
    MAX(order_purchase_timestamp) AS last_order_date
FROM orders;


-- =====================================================
-- 2. DATA QUALITY CHECKS
-- =====================================================

-- Check missing order IDs
SELECT COUNT(*) AS missing_order_ids
FROM orders
WHERE order_id IS NULL;

-- Check duplicate order IDs
SELECT
    order_id,
    COUNT(*) AS occurrences
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;

-- Check missing delivery dates for delivered orders
SELECT
    COUNT(*) AS missing_delivery_dates
FROM orders
WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NULL;

-- Check missing estimated delivery dates
SELECT
    COUNT(*) AS missing_estimated_dates
FROM orders
WHERE order_status = 'delivered'
  AND order_estimated_delivery_date IS NULL;


-- =====================================================
-- 3. DELIVERY ANALYSIS VIEW
-- =====================================================

CREATE OR REPLACE VIEW vw_delivery_analysis AS
SELECT
    order_id,
    order_purchase_timestamp,
    order_delivered_customer_date,
    order_estimated_delivery_date,

    TIMESTAMPDIFF(
        DAY,
        order_purchase_timestamp,
        order_delivered_customer_date
    ) AS actual_delivery_days,

    TIMESTAMPDIFF(
        DAY,
        order_purchase_timestamp,
        order_estimated_delivery_date
    ) AS estimated_delivery_days,

    TIMESTAMPDIFF(
        DAY,
        order_estimated_delivery_date,
        order_delivered_customer_date
    ) AS delay_days,

    CASE
        WHEN order_delivered_customer_date IS NULL
          OR order_estimated_delivery_date IS NULL
            THEN 'Missing delivery date'
        WHEN order_delivered_customer_date >
             order_estimated_delivery_date
            THEN 'Late'
        ELSE 'On Time'
    END AS delivery_performance

FROM orders
WHERE order_status = 'delivered';


-- =====================================================
-- 4. ON-TIME VS LATE DELIVERY ANALYSIS
-- =====================================================

SELECT
    delivery_performance,
    COUNT(*) AS total_orders,
    ROUND(
        100.0 * COUNT(*) /
        NULLIF((SELECT COUNT(*)
                FROM vw_delivery_analysis), 0),
        2
    ) AS percentage
FROM vw_delivery_analysis
GROUP BY delivery_performance
ORDER BY total_orders DESC;


-- Average actual delivery time
SELECT
    ROUND(AVG(actual_delivery_days), 2)
        AS average_delivery_days
FROM vw_delivery_analysis
WHERE actual_delivery_days IS NOT NULL;


-- =====================================================
-- 5. MONTHLY DELIVERY PERFORMANCE
-- =====================================================

SELECT
    DATE_FORMAT(
        order_purchase_timestamp, '%Y-%m'
    ) AS order_month,

    COUNT(*) AS delivered_orders,

    SUM(delivery_performance = 'Late')
        AS late_orders,

    ROUND(
        100.0 * SUM(delivery_performance = 'Late')
        / NULLIF(COUNT(*), 0),
        2
    ) AS late_percentage

FROM vw_delivery_analysis
WHERE delivery_performance IN ('Late', 'On Time')
GROUP BY DATE_FORMAT(order_purchase_timestamp, '%Y-%m')
ORDER BY order_month;


-- =====================================================
-- 6. STATE-WISE DELIVERY PERFORMANCE
-- =====================================================

SELECT
    c.customer_state,
    COUNT(*) AS delivered_orders,

    SUM(v.delivery_performance = 'Late')
        AS late_orders,

    ROUND(
        100.0 * SUM(v.delivery_performance = 'Late')
        / NULLIF(COUNT(*), 0),
        2
    ) AS late_percentage

FROM vw_delivery_analysis AS v

JOIN orders AS o
    ON v.order_id = o.order_id

JOIN olist_customers_dataset AS c
    ON o.customer_id = c.customer_id

WHERE v.delivery_performance IN ('Late', 'On Time')

GROUP BY c.customer_state
ORDER BY late_percentage DESC;


-- =====================================================
-- 7. PRODUCT CATEGORY DELIVERY ANALYSIS
-- =====================================================

SELECT
    COALESCE(
        t.product_category_name_english,
        p.product_category_name,
        'Unknown'
    ) AS product_category,

    COUNT(DISTINCT v.order_id) AS delivered_orders,

    COUNT(DISTINCT CASE
        WHEN v.delivery_performance = 'Late'
        THEN v.order_id
    END) AS late_orders,

    ROUND(
        100.0 * COUNT(DISTINCT CASE
            WHEN v.delivery_performance = 'Late'
            THEN v.order_id
        END)
        / NULLIF(COUNT(DISTINCT v.order_id), 0),
        2
    ) AS late_percentage

FROM vw_delivery_analysis AS v

JOIN olist_order_items_dataset AS i
    ON v.order_id = i.order_id

JOIN olist_products_dataset AS p
    ON i.product_id = p.product_id

LEFT JOIN product_category_name_translation AS t
    ON p.product_category_name = t.product_category_name

WHERE v.delivery_performance IN ('Late', 'On Time')

GROUP BY
    COALESCE(
        t.product_category_name_english,
        p.product_category_name,
        'Unknown'
    )

HAVING COUNT(DISTINCT v.order_id) >= 100

ORDER BY late_percentage DESC;


-- =====================================================
-- 8. PAYMENT METHOD ANALYSIS
-- =====================================================

-- Number of orders by payment method
SELECT
    payment_type,
    COUNT(DISTINCT order_id) AS total_orders
FROM olist_order_payments_dataset
GROUP BY payment_type
ORDER BY total_orders DESC;


-- Revenue by payment method
SELECT
    payment_type,
    ROUND(SUM(payment_value), 2) AS total_payment_value
FROM olist_order_payments_dataset
GROUP BY payment_type
ORDER BY total_payment_value DESC;