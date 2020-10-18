CREATE SCHEMA normalized;


CREATE TABLE normalized.weight_unit (
	weight_unit_id serial ,
    weight_unit varchar(5) NOT NULL,
	CONSTRAINT weight_unit_pk PRIMARY KEY (weight_unit_id)
);


CREATE TABLE normalized.weight (
	weight_id serial ,
    weight_unit_id int2 NOT NULL,
	weight_value varchar(10) NOT NULL,
	CONSTRAINT weight_pk PRIMARY KEY (weight_id),
    CONSTRAINT weight_fk FOREIGN KEY (weight_unit_id) REFERENCES normalized.weight_unit(weight_unit_id)
);


CREATE TABLE normalized.brand (
	brand_id serial ,
    brand_name varchar(80) NOT NULL,
	CONSTRAINT brand_pk PRIMARY KEY (brand_id)
);


CREATE TABLE normalized.product_size (
	product_size_id serial ,
	product_size_description varchar(200) NOT NULL,
	CONSTRAINT product_size_pk PRIMARY KEY (product_size_id)
);


CREATE TABLE normalized.product (
	product_id serial ,
	product_name varchar(100) NOT NULL,
	brand_id int2 NOT NULL,
	weight_id int2 NOT NULL,
	product_size_id int2 NOT NULL,
	CONSTRAINT product_pk PRIMARY KEY (product_id),
    CONSTRAINT product_weight_fk FOREIGN KEY (weight_id) REFERENCES normalized.weight(weight_id),
    CONSTRAINT product_brand_fk FOREIGN KEY (brand_id) REFERENCES normalized.brand(brand_id),
    CONSTRAINT product_product_size_fk FOREIGN KEY (product_size_id) REFERENCES normalized.product_size(product_size_id)
);
------------------------------------------------------------------
--
------------------------------------------------------------------
CREATE TABLE normalized.customer_address (
	customer_address_id serial,
	customer_address_zipcode varchar(12) NULL,
	customer_address_street varchar(80) NULL,
	CONSTRAINT customer_address_pk PRIMARY KEY (customer_address_id)
);
CREATE TABLE normalized.customer (
	customer_id serial,
    customer_address_id int2 NOT NULL,
	customer_cpf varchar(13) NULL,
	customer_email varchar(60) NULL,
	customer_name varchar(80) NULL,
	customer_created timestamp NULL DEFAULT now(),
	CONSTRAINT customer_pk PRIMARY KEY (customer_id),
    CONSTRAINT customer_address_id_fk FOREIGN KEY (customer_address_id) REFERENCES normalized.customer_address(customer_address_id)
);
------------------------------------------------------------------
--
------------------------------------------------------------------
CREATE TABLE normalized.purchase (
	purchase_id serial,
	purchase_created timestamp NULL DEFAULT now(),
    purchase_updated timestamp NULL DEFAULT now(),
	CONSTRAINT purchase_pk PRIMARY KEY (purchase_id)
);

CREATE TABLE normalized.purchase_detail_status (
	purchase_detail_status_id serial,
	purchase_detail_status varchar(13) NULL,
    CONSTRAINT purchase_detail_status_pk PRIMARY KEY (purchase_detail_status_id)
);

CREATE TABLE normalized.purchase_detail (
	purchase_detail_id serial,
    purchase_id  int2 NOT NULL,
    purchase_detail_status_id  int2 NOT NULL,
	product_id int2 NOT NULL,
	customer_id int2 NOT NULL,
	purchase_detail_product_quantity int2 NULL DEFAULT 1,
	CONSTRAINT purchase_detail_pk PRIMARY KEY (purchase_detail_id),
    CONSTRAINT purchase_id_fk FOREIGN KEY (purchase_id) REFERENCES normalized.purchase(purchase_id),
    CONSTRAINT purchase_detail_status_id_fk FOREIGN KEY (purchase_detail_status_id) REFERENCES normalized.purchase_detail_status(purchase_detail_status_id),
    CONSTRAINT product_id_fk FOREIGN KEY (product_id) REFERENCES normalized.product(product_id),
    CONSTRAINT customer_id_fk FOREIGN KEY (customer_id) REFERENCES normalized.customer(customer_id)
);
