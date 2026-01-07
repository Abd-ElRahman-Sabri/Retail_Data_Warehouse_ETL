-- dwh.dim_customers definition

-- Drop table

-- DROP TABLE dwh.dim_customers;

CREATE TABLE dwh.dim_customers (
	customer_sk serial4 NOT NULL,
	start_date timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
	end_date timestamp NULL,
	"version" int4 NULL,
	contact_title varchar(30) NULL,
	address varchar(60) NULL,
	region varchar(15) NULL,
	postal_code varchar(10) NULL,
	phone varchar(24) NULL,
	fax varchar(24) NULL,
	customer_id varchar(5) NULL,
	company_name varchar(40) NULL,
	contact_name varchar(30) NULL,
	city varchar(15) NULL,
	country varchar(15) NULL,
	CONSTRAINT dim_customers_pkey PRIMARY KEY (customer_sk)
);
CREATE INDEX idx_dim_customers_lookup ON dwh.dim_customers USING btree (customer_id);
CREATE INDEX idx_dim_customers_tk ON dwh.dim_customers USING btree (customer_sk);


-- dwh.dim_date definition

-- Drop table

-- DROP TABLE dwh.dim_date;

CREATE TABLE dwh.dim_date (
	date_key int4 NOT NULL,
	date_actual date NOT NULL,
	weekday varchar(9) NOT NULL,
	weekday_num int4 NOT NULL,
	day_month int4 NOT NULL,
	day_of_year int4 NOT NULL,
	week_of_year int4 NOT NULL,
	iso_week bpchar(10) NOT NULL,
	month_num int4 NOT NULL,
	month_name varchar(9) NOT NULL,
	month_name_short bpchar(3) NOT NULL,
	quarter int4 NOT NULL,
	"year" int4 NOT NULL,
	first_day_of_month date NOT NULL,
	last_day_of_month date NOT NULL,
	yyyymm bpchar(7) NOT NULL,
	weekend_indr bpchar(10) NOT NULL,
	CONSTRAINT dim_date_pk PRIMARY KEY (date_key)
);
CREATE INDEX d_date_date_actual_idx ON dwh.dim_date USING btree (date_actual);


-- dwh.dim_employees definition

-- Drop table

-- DROP TABLE dwh.dim_employees;

CREATE TABLE dwh.dim_employees (
	employee_sk serial4 NOT NULL,
	employee_id int2 NULL,
	birth_date date NULL,
	hire_date date NULL,
	start_date timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	end_date timestamp NULL,
	"version" int4 NULL,
	last_name varchar(20) NULL,
	first_name varchar(10) NULL,
	full_name text NULL,
	title varchar(30) NULL,
	city varchar(15) NULL,
	country varchar(15) NULL,
	CONSTRAINT dim_employees_pkey PRIMARY KEY (employee_sk)
);
CREATE INDEX idx_dim_employees_lookup ON dwh.dim_employees USING btree (employee_id);
CREATE INDEX idx_dim_employees_tk ON dwh.dim_employees USING btree (employee_sk);


-- dwh.dim_products definition

-- Drop table

-- DROP TABLE dwh.dim_products;

CREATE TABLE dwh.dim_products (
	product_sk serial4 NOT NULL,
	product_id int2 NULL,
	unit_price float4 NULL,
	discontinued int4 NULL,
	start_date timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	end_date timestamp NULL,
	"version" int4 NULL,
	product_name varchar(40) NULL,
	category_name varchar(15) NULL,
	supplier_company_name varchar(40) NULL,
	CONSTRAINT dim_products_pkey PRIMARY KEY (product_sk)
);
CREATE INDEX idx_dim_products_lookup ON dwh.dim_products USING btree (product_id);
CREATE INDEX idx_dim_products_tk ON dwh.dim_products USING btree (product_sk);


-- dwh.dim_shippers definition

-- Drop table

-- DROP TABLE dwh.dim_shippers;

CREATE TABLE dwh.dim_shippers (
	shipper_sk serial4 NOT NULL,
	shipper_id int2 NULL,
	phone varchar(24) NULL,
	end_date timestamp NULL,
	"version" int4 NULL,
	start_date timestamp NULL,
	company_name varchar(40) NULL,
	CONSTRAINT dim_shippers_pkey PRIMARY KEY (shipper_sk)
);
CREATE INDEX idx_dim_shippers_lookup ON dwh.dim_shippers USING btree (shipper_id);
CREATE INDEX idx_dim_shippers_tk ON dwh.dim_shippers USING btree (shipper_sk);


-- dwh.fact_sales definition

-- Drop table

-- DROP TABLE dwh.fact_sales;

CREATE TABLE dwh.fact_sales (
	sales_sk serial4 NOT NULL,
	order_id int4 NULL,
	product_sk int4 NULL,
	customer_sk int4 NULL,
	date_sk int4 NULL,
	employee_sk int4 NULL,
	shipper_sk int4 NULL,
	unit_price float4 NULL,
	quantity int4 NULL,
	discount float4 NULL,
	total_amount float4 NULL,
	CONSTRAINT fact_sales_pkey PRIMARY KEY (sales_sk),
	CONSTRAINT fact_sales_customer_sk_fkey FOREIGN KEY (customer_sk) REFERENCES dwh.dim_customers(customer_sk),
	CONSTRAINT fact_sales_date_sk_fkey FOREIGN KEY (date_sk) REFERENCES dwh.dim_date(date_key),
	CONSTRAINT fact_sales_employee_sk_fkey FOREIGN KEY (employee_sk) REFERENCES dwh.dim_employees(employee_sk),
	CONSTRAINT fact_sales_product_sk_fkey FOREIGN KEY (product_sk) REFERENCES dwh.dim_products(product_sk),
	CONSTRAINT fact_sales_shipper_sk_fkey FOREIGN KEY (shipper_sk) REFERENCES dwh.dim_shippers(shipper_sk)
);
