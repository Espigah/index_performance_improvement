
CREATE SCHEMA denormalized;

CREATE TABLE denormalized.product
(
	product_id serial ,
	product_name varchar(100) NOT NULL,
	product_brand_name  varchar(80) NOT NULL,
	product_weight varchar NOT NULL,
	product_size_description varchar(200) NOT NULL,
	CONSTRAINT product_pk PRIMARY KEY (product_id)
);
------------------------------------------------------------------
--
------------------------------------------------------------------
CREATE TABLE denormalized.customer
(
	customer_id serial,
	customer_cpf varchar(13) NULL,
	customer_email varchar(60) NULL,
	customer_name varchar(80) NULL,
	customer_zipcode varchar(12) NULL,
	customer_street varchar(80) NULL,
	customer_created timestamp NULL DEFAULT now(),
	CONSTRAINT customer_pk PRIMARY KEY (customer_id)
);
------------------------------------------------------------------
--
------------------------------------------------------------------
CREATE TABLE denormalized.purchase
(
	purchase_id serial,
	product_id int2 NOT NULL,
	customer_id int2 NOT NULL,
	purchase_detail_status varchar(13) NULL,
	purchase_product_quantity int2 NULL DEFAULT 1,
	purchase_created timestamp NULL DEFAULT now(),
	purchase_updated timestamp NULL DEFAULT now(),
	CONSTRAINT purchase_pk PRIMARY KEY (purchase_id),
	CONSTRAINT product_id_fk FOREIGN KEY (product_id) REFERENCES denormalized.product(product_id),
	CONSTRAINT customer_id_fk FOREIGN KEY (customer_id) REFERENCES denormalized.customer(customer_id)
);