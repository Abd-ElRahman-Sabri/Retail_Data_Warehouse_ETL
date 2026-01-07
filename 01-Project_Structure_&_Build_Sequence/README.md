# 🛒 Retail Data Warehouse Project (End-to-End)

## 📌 Project Overview
This project demonstrates the complete lifecycle of building an Enterprise Data Warehouse (EDW) from scratch. The goal is to migrate data from a transactional system (OLTP) to an analytical system (OLAP) to enable historical analysis and business intelligence reporting.

### 🛠️ Tech Stack
* **Source Database:** PostgreSQL (Normalized 3NF Schema).
* **ETL Tool:** Pentaho Data Integration (PDI / Kettle).
* **Target Data Warehouse:** PostgreSQL (Star Schema).
* **Concepts Applied:** SCD Type 2, Surrogate Keys, Fact/Dimension Design, Data Quality Handling.

---

## 📊 1. Data Dictionary & Schema Design

### A. Source System (`public` schema)
The source is a retail transactional database containing the following key tables:

| Table Name | Description | Key Columns (Data Types) |
| :--- | :--- | :--- |
| **Orders** | Header information for each sales order. | `order_id` (PK, int), `customer_id` (varchar), `order_date` (date), `ship_country` (varchar). |
| **Order_Details** | Line items for each order (transactional data). | `order_id` (FK, int), `product_id` (FK, int), `unit_price` (decimal), `quantity` (int). |
| **Products** | Product master data. | `product_id` (PK, int), `product_name` (varchar), `category_id` (int), `unit_price` (decimal). |
| **Customers** | Customer details. | `customer_id` (PK, varchar), `company_name` (varchar), `country` (varchar). |
| **Employees** | Sales representatives data. | `employee_id` (PK, int), `last_name` (varchar), `title` (varchar). |

*(See `source_erd.png` in this folder for the complete Entity Relationship Diagram)*.

### B. Data Warehouse (`dwh` schema)
The target is a **Star Schema** optimized for reporting:

| Table Name | Type | Description & Key Columns |
| :--- | :--- | :--- |
| **fact_sales** | **Fact** | Contains transactional metrics.<br>**Keys:** `sales_sk` (PK), `product_sk`, `customer_sk`, `date_sk`.<br>**Measures:** `quantity`, `total_amount`, `discount`. |
| **dim_products** | **Dimension** | Tracks product history (SCD Type 2).<br>**Cols:** `product_sk`, `product_id`, `unit_price`, `version`, `date_from`, `date_to`. |
| **dim_customers** | **Dimension** | Stores customer attributes.<br>**Cols:** `customer_sk`, `customer_id`, `company_name`, `country`. |
| **dim_date** | **Dimension** | A calendar table for time-based analysis.<br>**Cols:** `date_key` (int YYYYMMDD), `year`, `quarter`, `month_name`. |

*(See `dwh_erd.png` in this folder for the Star Schema Diagram)*.

---

## 🚀 2. Build Sequence (How to Run)

To replicate this project locally, execute the folders in the following strict order:

1.  **`02-Public_Schema/`**: Run the SQL script to create the empty structure of the Source Database.
2.  **`03-Data_Source/`**: Run the `INSERT` script to populate the source tables with raw data.
3.  **`04-DWH_Schema/`**: Run the SQL script to create the empty Star Schema (Facts & Dimensions).
4.  **`05-Warehouse_Data/`**:
    * Open Pentaho Data Integration.
    * Run Dimension transformations first (e.g., `load_dim_products`).
    * Run Fact transformations (`load_fact_sales`).
5.  **`06-Reports/`**: Execute the analytical SQL queries to view insights (e.g., Price Change Analysis).

---
*Project maintained by Abd EL-Rahman Sabri*
