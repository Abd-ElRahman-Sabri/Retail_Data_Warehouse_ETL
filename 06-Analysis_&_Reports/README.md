# 06 - Analytics & BI Reports 📊

## Description
This folder contains advanced **SQL Analysis Scripts** that demonstrate the analytical capabilities of the Data Warehouse. 
By joining the Fact table with Dimensions, we perform historical analysis that was difficult to achieve in the transactional system.

## Reports Included
1.  **Price Change Impact (`1_price_change_analysis.sql`):**
    * Analysis of **SCD Type 2** data in `dim_products`.
    * Break down of revenue for each historical price version (`unit_price`) during its effective dates (`start_date` to `end_date`).
    
2.  **Monthly Growth (`2_monthly_sales_growth.sql`):**
    * Uses SQL Window Functions (`LAG`) to calculate **Month-over-Month (MoM)** revenue growth percentage.

3.  **Customer Segmentation (`3_top_customers_segmentation.sql`):**
    * Aggregates sales volume by customer.
    * Segments customers into **VIP**, **Gold**, and **Standard** tiers based on total spend threshold.

## How to Run
Execute these `.sql` files in your SQL Client (e.g., DBeaver) connected to the `dwh` schema.
