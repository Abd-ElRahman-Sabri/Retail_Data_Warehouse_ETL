# 02 - Source System Schema (Public Schema) 🏗️

## Description
This folder contains the **Data Definition Language (DDL)** script required to initialize the structure of the source OLTP database (PostgreSQL `public` schema).

It creates the empty tables with their relationships (Foreign Keys) and constraints, representing the retail transactional system structure.

## File Contents
* `full_source_schema.sql`: A single SQL script containing all `CREATE TABLE` statements for:
    * `orders`, `order_details`
    * `products`, `categories`, `suppliers`
    * `customers`, `employees`, `shippers`
    * ...and other lookup tables.

## How to Run
1. Connect to your source PostgreSQL database.
2. Ensure you are targeting the `public` schema.
3. Execute the `full_source_schema.sql` script.
4. Verify that tables are created (they will be empty at this stage).
