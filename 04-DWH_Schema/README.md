# 04 - Data Warehouse Schema (Star Schema) ⭐

## Description
This folder contains the **DDL** scripts to create the analytical Data Warehouse structure in the `dwh` schema.

Unlike the source system (3NF), this schema follows a **Star Schema** design methodology, optimized for fast retrieval and aggregation in BI tools like Power BI or Tableau.

## Schema Design
The warehouse consists of:
1.  **Fact Tables:**
    * `fact_sales`: The central table containing business metrics (revenue, quantity) and foreign keys to dimensions.
2.  **Dimension Tables:**
    * `dim_products`: Implements **SCD Type 2** to track historical price changes.
    * `dim_customers`: Stores customer attributes.
    * `dim_date`: A calendar lookup table for time-series analysis.
    * `dim_employees`, `dim_shippers`: Supporting dimensions.

## File Contents
* `full_dwh_schema.sql`: Contains `CREATE TABLE` statements defining the Star Schema structure, including Surrogate Keys (SKs) and relationships.

## How to Run
1.  Connect to your PostgreSQL database.
2.  Create a new schema named `dwh` (if not exists): `CREATE SCHEMA dwh;`
3.  Execute the `full_dwh_schema.sql` script.
4.  Verify that the tables are created in the `dwh` schema (empty tables ready for ETL).
