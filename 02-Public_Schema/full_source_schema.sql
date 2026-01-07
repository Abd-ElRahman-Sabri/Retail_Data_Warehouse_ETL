-- public.categories definition

-- Drop table

-- DROP TABLE public.categories;

CREATE TABLE public.categories (
	category_id int2 NOT NULL,
	category_name varchar(15) NOT NULL,
	description text NULL,
	picture bytea NULL,
	CONSTRAINT pk_categories PRIMARY KEY (category_id)
);


-- public.customer_demographics definition

-- Drop table

-- DROP TABLE public.customer_demographics;

CREATE TABLE public.customer_demographics (
	customer_type_id varchar(5) NOT NULL,
	customer_desc text NULL,
	CONSTRAINT pk_customer_demographics PRIMARY KEY (customer_type_id)
);


-- public.customers definition

-- Drop table

-- DROP TABLE public.customers;

CREATE TABLE public.customers (
	customer_id varchar(5) NOT NULL,
	company_name varchar(40) NOT NULL,
	contact_name varchar(30) NULL,
	contact_title varchar(30) NULL,
	address varchar(60) NULL,
	city varchar(15) NULL,
	region varchar(15) NULL,
	postal_code varchar(10) NULL,
	country varchar(15) NULL,
	phone varchar(24) NULL,
	fax varchar(24) NULL,
	CONSTRAINT pk_customers PRIMARY KEY (customer_id)
);


-- public.region definition

-- Drop table

-- DROP TABLE public.region;

CREATE TABLE public.region (
	region_id int2 NOT NULL,
	region_description varchar(60) NOT NULL,
	CONSTRAINT pk_region PRIMARY KEY (region_id)
);


-- public.shippers definition

-- Drop table

-- DROP TABLE public.shippers;

CREATE TABLE public.shippers (
	shipper_id int2 NOT NULL,
	company_name varchar(40) NOT NULL,
	phone varchar(24) NULL,
	CONSTRAINT pk_shippers PRIMARY KEY (shipper_id)
);


-- public.suppliers definition

-- Drop table

-- DROP TABLE public.suppliers;

CREATE TABLE public.suppliers (
	supplier_id int2 NOT NULL,
	company_name varchar(40) NOT NULL,
	contact_name varchar(30) NULL,
	contact_title varchar(30) NULL,
	address varchar(60) NULL,
	city varchar(15) NULL,
	region varchar(15) NULL,
	postal_code varchar(10) NULL,
	country varchar(15) NULL,
	phone varchar(24) NULL,
	fax varchar(24) NULL,
	homepage text NULL,
	CONSTRAINT pk_suppliers PRIMARY KEY (supplier_id)
);


-- public.us_states definition

-- Drop table

-- DROP TABLE public.us_states;

CREATE TABLE public.us_states (
	state_id int2 NOT NULL,
	state_name varchar(100) NULL,
	state_abbr varchar(2) NULL,
	state_region varchar(50) NULL,
	CONSTRAINT pk_usstates PRIMARY KEY (state_id)
);


-- public.customer_customer_demo definition

-- Drop table

-- DROP TABLE public.customer_customer_demo;

CREATE TABLE public.customer_customer_demo (
	customer_id varchar(5) NOT NULL,
	customer_type_id varchar(5) NOT NULL,
	CONSTRAINT pk_customer_customer_demo PRIMARY KEY (customer_id, customer_type_id),
	CONSTRAINT fk_customer_customer_demo_customer_demographics FOREIGN KEY (customer_type_id) REFERENCES public.customer_demographics(customer_type_id),
	CONSTRAINT fk_customer_customer_demo_customers FOREIGN KEY (customer_id) REFERENCES public.customers(customer_id)
);


-- public.employees definition

-- Drop table

-- DROP TABLE public.employees;

CREATE TABLE public.employees (
	employee_id int2 NOT NULL,
	last_name varchar(20) NOT NULL,
	first_name varchar(10) NOT NULL,
	title varchar(30) NULL,
	title_of_courtesy varchar(25) NULL,
	birth_date date NULL,
	hire_date date NULL,
	address varchar(60) NULL,
	city varchar(15) NULL,
	region varchar(15) NULL,
	postal_code varchar(10) NULL,
	country varchar(15) NULL,
	home_phone varchar(24) NULL,
	"extension" varchar(4) NULL,
	photo bytea NULL,
	notes text NULL,
	reports_to int2 NULL,
	photo_path varchar(255) NULL,
	CONSTRAINT pk_employees PRIMARY KEY (employee_id),
	CONSTRAINT fk_employees_employees FOREIGN KEY (reports_to) REFERENCES public.employees(employee_id)
);


-- public.orders definition

-- Drop table

-- DROP TABLE public.orders;

CREATE TABLE public.orders (
	order_id int2 NOT NULL,
	customer_id varchar(5) NULL,
	employee_id int2 NULL,
	order_date date NULL,
	required_date date NULL,
	shipped_date date NULL,
	ship_via int2 NULL,
	freight float4 NULL,
	ship_name varchar(40) NULL,
	ship_address varchar(60) NULL,
	ship_city varchar(15) NULL,
	ship_region varchar(15) NULL,
	ship_postal_code varchar(10) NULL,
	ship_country varchar(15) NULL,
	CONSTRAINT pk_orders PRIMARY KEY (order_id),
	CONSTRAINT fk_orders_customers FOREIGN KEY (customer_id) REFERENCES public.customers(customer_id),
	CONSTRAINT fk_orders_employees FOREIGN KEY (employee_id) REFERENCES public.employees(employee_id),
	CONSTRAINT fk_orders_shippers FOREIGN KEY (ship_via) REFERENCES public.shippers(shipper_id)
);


-- public.products definition

-- Drop table

-- DROP TABLE public.products;

CREATE TABLE public.products (
	product_id int2 NOT NULL,
	product_name varchar(40) NOT NULL,
	supplier_id int2 NULL,
	category_id int2 NULL,
	quantity_per_unit varchar(20) NULL,
	unit_price float4 NULL,
	units_in_stock int2 NULL,
	units_on_order int2 NULL,
	reorder_level int2 NULL,
	discontinued int4 NOT NULL,
	CONSTRAINT pk_products PRIMARY KEY (product_id),
	CONSTRAINT fk_products_categories FOREIGN KEY (category_id) REFERENCES public.categories(category_id),
	CONSTRAINT fk_products_suppliers FOREIGN KEY (supplier_id) REFERENCES public.suppliers(supplier_id)
);


-- public.territories definition

-- Drop table

-- DROP TABLE public.territories;

CREATE TABLE public.territories (
	territory_id varchar(20) NOT NULL,
	territory_description varchar(60) NOT NULL,
	region_id int2 NOT NULL,
	CONSTRAINT pk_territories PRIMARY KEY (territory_id),
	CONSTRAINT fk_territories_region FOREIGN KEY (region_id) REFERENCES public.region(region_id)
);


-- public.employee_territories definition

-- Drop table

-- DROP TABLE public.employee_territories;

CREATE TABLE public.employee_territories (
	employee_id int2 NOT NULL,
	territory_id varchar(20) NOT NULL,
	CONSTRAINT pk_employee_territories PRIMARY KEY (employee_id, territory_id),
	CONSTRAINT fk_employee_territories_employees FOREIGN KEY (employee_id) REFERENCES public.employees(employee_id),
	CONSTRAINT fk_employee_territories_territories FOREIGN KEY (territory_id) REFERENCES public.territories(territory_id)
);


-- public.order_details definition

-- Drop table

-- DROP TABLE public.order_details;

CREATE TABLE public.order_details (
	order_id int2 NOT NULL,
	product_id int2 NOT NULL,
	unit_price float4 NOT NULL,
	quantity int2 NOT NULL,
	discount float4 NOT NULL,
	CONSTRAINT pk_order_details PRIMARY KEY (order_id, product_id),
	CONSTRAINT fk_order_details_orders FOREIGN KEY (order_id) REFERENCES public.orders(order_id),
	CONSTRAINT fk_order_details_products FOREIGN KEY (product_id) REFERENCES public.products(product_id)
);
