# 05 - ETL Pipelines (Pentaho / PDI) 🔄

## Description
This folder contains the **Extract, Transform, Load (ETL)** workflows built with **Pentaho Data Integration (Kettle)**.

The pipelines are responsible for migrating data from the source (OLTP) to the Data Warehouse (OLAP), handling data cleaning, transformation, and Surrogate Key generation.

## File Contents
### 1. Orchestration Job (`main_job.kjb`)
* **Description:** The master job that coordinates the execution sequence.
* **Logic:** It executes all Dimension transformations first (sequentially) to ensure referential integrity. Only upon their success does it trigger the Fact table load.

### 2. Transformations (`.ktr`)
* **`load_dim_products.ktr`**: Implements **SCD Type 2** logic to track historical price changes.
* **`load_dim_customers.ktr`, `load_dim_employees.ktr`, `load_dim_shippers.ktr`**: Handle Type 1 updates (Insert/Update) for reference data.
* **`load_fact_sales.ktr`**: The main transformation that performs lookups for Surrogate Keys (SKs) and loads transactional metrics into `fact_sales`.

## How to Run
1. Open **Pentaho Data Integration (Spoon)**.
2. Open the `main_job.kjb` file.
3. Check your database connections (`Source_DB`, `Target_DWH`).
4. Run the Job to populate the entire Data Warehouse.
