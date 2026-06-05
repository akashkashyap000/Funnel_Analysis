SELECT COUNT(*) FROM orders;
SELECT COUNT(*) FROM payments;
SELECT COUNT(*) FROM reviews;
SELECT COUNT(*) FROM items;
SELECT COUNT(*) FROM customers;

-- ============================================================
-- QUERY 1: OVERALL ORDER STATUS DISTRIBUTION
-- Count orders by status to understand funnel overview
-- ============================================================
SELECT 
    order_status,
    COUNT(*) as total_orders,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) as percentage
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;

-- ============================================================
-- QUERY 2: FUNNEL DROP-OFF ANALYSIS
-- Calculate how many orders drop at each stage
-- ============================================================
SELECT
    COUNT(*) as orders_placed,
    SUM(CASE WHEN order_approved_at IS NOT NULL THEN 1 ELSE 0 END) as orders_approved,
    SUM(CASE WHEN order_delivered_carrier_date IS NOT NULL THEN 1 ELSE 0 END) as shipped_to_carrier,
    SUM(CASE WHEN order_delivered_customer_date IS NOT NULL THEN 1 ELSE 0 END) as delivered_to_customer
FROM orders;

-- ============================================================
-- QUERY 3: DELIVERY PERFORMANCE — ON TIME VS LATE
-- Compare actual delivery date vs estimated delivery date
-- ============================================================
SELECT
    CASE 
        WHEN order_delivered_customer_date <= order_estimated_delivery_date THEN 'On Time'
        ELSE 'Late'
    END as delivery_status,
    COUNT(*) as total_orders,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) as percentage
FROM orders
WHERE order_status = 'delivered'
AND order_delivered_customer_date IS NOT NULL
GROUP BY delivery_status
ORDER BY total_orders DESC;

-- ============================================================
-- QUERY 4: REVENUE ANALYSIS BY PAYMENT TYPE
-- Total revenue and order count by payment method
-- ============================================================
SELECT
    payment_type,
    COUNT(DISTINCT order_id) as total_orders,
    ROUND(SUM(payment_value::numeric), 2) as total_revenue,
    ROUND(AVG(payment_value::numeric), 2) as avg_order_value,
    ROUND(COUNT(DISTINCT order_id) * 100.0 / SUM(COUNT(DISTINCT order_id)) OVER(), 2) as percentage
FROM payments
GROUP BY payment_type
ORDER BY total_revenue DESC;

-- ============================================================
-- QUERY 5: TOTAL REVENUE SUMMARY
-- Overall revenue, avg order value and total orders
-- ============================================================
SELECT
    COUNT(DISTINCT order_id) as total_orders,
    ROUND(SUM(payment_value::numeric), 2) as total_revenue,
    ROUND(AVG(payment_value::numeric), 2) as avg_order_value
FROM payments;

-- ============================================================
-- QUERY 6: CUSTOMER SATISFACTION — REVIEW SCORE DISTRIBUTION
-- Count orders by review score and calculate percentage
-- ============================================================
SELECT
    review_score,
    COUNT(*) as total_reviews,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) as percentage
FROM reviews
GROUP BY review_score
ORDER BY review_score DESC;

-- ============================================================
-- QUERY 7: LATE DELIVERY IMPACT ON REVIEW SCORE
-- Compare avg review score for late vs on-time deliveries
-- ============================================================
SELECT
    CASE 
        WHEN o.order_delivered_customer_date <= o.order_estimated_delivery_date THEN 'On Time'
        ELSE 'Late'
    END as delivery_status,
    COUNT(*) as total_orders,
    ROUND(AVG(r.review_score::numeric), 2) as avg_review_score
FROM orders o
JOIN reviews r ON o.order_id = r.order_id
WHERE o.order_status = 'delivered'
AND o.order_delivered_customer_date IS NOT NULL
GROUP BY delivery_status
ORDER BY avg_review_score DESC;

-- ============================================================
-- QUERY 8: REVENUE LOSS FROM CANCELLED ORDERS
-- Calculate how much revenue was lost due to cancellations
-- ============================================================
SELECT
    o.order_status,
    COUNT(DISTINCT o.order_id) as total_orders,
    ROUND(SUM(p.payment_value::numeric), 2) as revenue,
    ROUND(AVG(p.payment_value::numeric), 2) as avg_order_value
FROM orders o
JOIN payments p ON o.order_id = p.order_id
WHERE o.order_status IN ('canceled', 'unavailable')
GROUP BY o.order_status
ORDER BY revenue DESC;


-- ============================================================
-- OLIST FUNNEL ANALYSIS — SQL INSIGHTS SUMMARY
-- ============================================================

-- DATASET OVERVIEW:
-- Total Orders: 99,441
-- Total Revenue: R$16,008,872.12
-- Average Order Value: R$154.10

-- FUNNEL DROP-OFF:
-- Orders Placed:        99,441
-- Orders Approved:      99,281  (-160 drop)
-- Shipped to Carrier:   97,658  (-1,623 drop) ← Highest Drop
-- Delivered:            96,476  (-1,182 drop)

-- KEY FINDINGS:
-- 1. 97.02% orders delivered successfully
-- 2. Highest drop-off at Shipped to Carrier stage — 1,623 orders lost
-- 3. 8.11% orders delivered late — 7,826 orders
-- 4. Credit card dominates — 75.24% orders, R$12,542,084 revenue
-- 5. Late delivery avg review: 2.57 vs On-time: 4.29
-- 6. Revenue loss from