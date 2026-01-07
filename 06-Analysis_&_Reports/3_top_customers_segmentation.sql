/*
 * ======================================================================================
 * Script Purpose: Customer Segmentation based on Total Spend (RFM Analysis Base)
 * ======================================================================================
 * Description:
 * This query segments customers into tiers (VIP, Gold, Standard) based on their 
 * total lifetime value (LTV) stored in the Data Warehouse.
 *
 * logic:
 * - Join `fact_sales` with `dim_customers`.
 * - Aggregate total spend per customer.
 * - Apply conditional logic (`CASE`) to assign segment labels.
 * ======================================================================================
 */

SELECT 
    c.company_name,
    c.country,
    COUNT(DISTINCT f.sales_sk) AS total_orders,
    SUM(f.total_amount) AS total_spent,
    CASE 
        WHEN SUM(f.total_amount) > 10000 THEN 'VIP'
        WHEN SUM(f.total_amount) > 5000 THEN 'Gold'
        ELSE 'Standard'
    END AS customer_segment
FROM dwh.fact_sales f
JOIN dwh.dim_customers c ON f.customer_sk = c.customer_sk
GROUP BY 
    c.company_name, 
    c.country
ORDER BY 
    total_spent DESC;
