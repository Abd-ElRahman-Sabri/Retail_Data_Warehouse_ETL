# 03 - Source Data Seed (Raw Data) 💾

## Description
This folder contains the **Data Manipulation Language (DML)** script required to populate the source database with sample data.

After creating the schema structure in step `02`, this script inserts raw records into the tables (Orders, Customers, Products, etc.) to simulate a live retail environment.

## File Contents
* `raw_data_seed.sql`: A comprehensive SQL script containing bulk `INSERT` statements for all source tables.
    * **Note:** This file is generated from the original dataset and ensures data consistency across all tables.

## How to Run
1. Ensure you have successfully executed step `02-Public_Schema` and created the empty tables.
2. Connect to your PostgreSQL database.
3. Execute the `raw_data_seed.sql` script.
4. Verify that tables are now populated with rows (e.g., `SELECT COUNT(*) FROM orders`).
