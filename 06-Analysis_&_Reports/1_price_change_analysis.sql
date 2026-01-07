/*
 * ======================================================================================
 * Script Purpose: Analyze Product Performance Across Price Changes (SCD Type 2)
 * ======================================================================================
 * Description:
 * This query demonstrates the power of Slowly Changing Dimensions (SCD Type 2).
 * It groups sales data by product versions (historical prices) to show revenue 
 * generated at each price point during its effective period.
 *
 * logic:
 * - Join `fact_sales` with `dim_products`.
 * - Group by `unit_price` and validity dates (`start_date`, `end_date`).
 * - Calculate total revenue and quantity for each version.
 * ======================================================================================
 */

SELECT 
    p.product_name,
    p.unit_price,
    p.start_date AS effective_from,
    p.end_date AS effective_to,
    CASE 
        WHEN p.end_date IS NULL THEN 'Current' 
        ELSE 'Expired' 
    END AS price_status,
    COUNT(f.sales_sk) AS total_orders,
    SUM(f.quantity) AS total_units_sold,
    SUM(f.total_amount) AS total_revenue
FROM dwh.fact_sales f
JOIN dwh.dim_products p ON f.product_sk = p.product_sk
GROUP BY 
    p.product_name, 
    p.unit_price, 
    p.start_date, 
    p.end_date
ORDER BY 
    p.product_name, 
    p.start_date;
