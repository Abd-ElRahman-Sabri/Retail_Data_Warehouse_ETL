/*
 * ======================================================================================
 * Script Purpose: Calculate Month-over-Month (MoM) Sales Growth
 * ======================================================================================
 * Description:
 * This query performs time-series analysis to calculate the percentage growth 
 * of revenue compared to the previous month.
 *
 * logic:
 * - Join `fact_sales` with `dim_date`.
 * - Aggregate revenue by Year and Month.
 * - Use the Window Function `LAG()` to retrieve the previous month's revenue.
 * - Calculate the percentage difference and CAST to numeric for rounding.
 * ======================================================================================
 */

WITH MonthlySales AS (
    SELECT 
        d.year,
        d.month_num,
        d.month_name,
        SUM(f.total_amount) AS monthly_revenue
    FROM dwh.fact_sales f
    JOIN dwh.dim_date d ON f.date_sk = d.date_key
    GROUP BY 
        d.year, 
        d.month_num, 
        d.month_name
)
SELECT 
    year, 
    month_name, 
    monthly_revenue,
    LAG(monthly_revenue) OVER (ORDER BY year, month_num) AS previous_month_revenue,
    ROUND(
        (
            (monthly_revenue - LAG(monthly_revenue) OVER (ORDER BY year, month_num)) 
            / NULLIF(LAG(monthly_revenue) OVER (ORDER BY year, month_num), 0) * 100
        )::numeric  -- <== (Added casting here to fix the error)
    , 2) AS growth_percentage
FROM MonthlySales
ORDER BY 
    year, 
    month_num;
