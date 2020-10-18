--------------------------------------------------------
--mode3 -   force index only
--------------------------------------------------------
-- active_clients_last_year

---- drop index normalized.purchase_detail_purchase_id_idx;
CREATE INDEX  IF NOT EXISTS purchase_detail_purchase_id_idx ON "normalized".purchase_detail (purchase_id) include(customer_id,purchase_detail_id); -- NOT

---- drop index normalized.product_product_id_idx;
CREATE INDEX  IF NOT EXISTS product_product_id_idx ON "normalized".product (product_id) include (product_name);

---- drop index normalized.purchase_purchase_created_idx;
CREATE INDEX  IF NOT EXISTS purchase_purchase_created_idx ON "normalized".purchase (purchase_created);

---- drop index normalized.purchase_purchase_updated_idx;
CREATE INDEX  IF NOT EXISTS purchase_purchase_updated_idx ON "normalized".purchase (purchase_updated);

---- drop index normalized.customer_name_idx;
CREATE INDEX  IF NOT EXISTS customer_name_idx ON "normalized".customer (customer_name) include(customer_id,customer_address_id,customer_email);

---- drop index normalized.customer_address_idx;
CREATE INDEX  IF NOT EXISTS customer_address_idx ON "normalized".customer_address (customer_address_id) include(customer_address_zipcode);






-- brand_purchase_count

---- drop index normalized.product_name_idx;
CREATE INDEX  IF NOT EXISTS product_name_idx ON "normalized".product (product_name) include (product_id, brand_id);


---- drop index normalized.purchase_detail_status_id_idx;
CREATE INDEX  IF NOT EXISTS purchase_detail_status_id_idx ON "normalized".purchase_detail (product_id, purchase_detail_status_id) include (purchase_id);

---- drop index normalized.brand_name_idx;
CREATE INDEX  IF NOT EXISTS brand_name_idx ON "normalized".brand (brand_name) include (brand_id);



-- purchase_count

---- drop index normalized.purchase_detail_purchase_id_idx;
CREATE INDEX  IF NOT EXISTS purchase_detail_purchase_id_idx ON "normalized".purchase_detail (purchase_detail_status_id) include(purchase_id);


---- drop index normalized.purchase_purchase_created_idx;
CREATE INDEX  IF NOT EXISTS purchase_purchase_created_idx ON "normalized".purchase (purchase_created);

---- drop index normalized.purchase_purchase_updated_idx;
CREATE INDEX  IF NOT EXISTS purchase_purchase_updated_idx ON "normalized".purchase (purchase_updated);

---- drop index normalized.purchase_purchase_updated_idx_plan_2;
CREATE INDEX  IF NOT EXISTS purchase_purchase_updated_idx_plan_2 ON "normalized".purchase (purchase_id)  include (purchase_created, purchase_updated);
-- faz mudar o plain para purchase_detail

---- drop index normalized.purchase_detail_status_idx;
CREATE INDEX  IF NOT EXISTS purchase_detail_status_idx ON "normalized".purchase_detail_status (purchase_detail_status_id) include (purchase_detail_status);




-- customer_purchase_detail


---- drop index normalized.purchase_detail_customer_id_idx;	
CREATE INDEX  IF NOT EXISTS purchase_detail_customer_id_idx ON normalized.purchase_detail (purchase_detail_status_id, customer_id) include (purchase_id, product_id)
;


---- drop index normalized.customer_customer_created_idx;
CREATE INDEX  IF NOT EXISTS customer_customer_created_idx ON normalized.customer (customer_created) include (customer_id, customer_name) 
;

---- drop index normalized.purchase_detail_status_idx;	
CREATE INDEX  IF NOT EXISTS purchase_detail_status_idx ON normalized.purchase_detail_status (purchase_detail_status_id) include (purchase_detail_status)
;


---- drop index normalized.product_id_include_idx;	
CREATE INDEX  IF NOT EXISTS product_id_include_idx ON normalized.product (product_id) include (weight_id, product_size_id, brand_id, product_name)
;

---- drop index normalized.weight_id_include_idx;	
CREATE INDEX  IF NOT EXISTS weight_id_include_idx ON normalized.weight (weight_id) include (weight_unit_id,weight_value)
;

---- drop index normalized.weight_unit_id_include_idx;	
CREATE INDEX  IF NOT EXISTS weight_unit_id_include_idx ON normalized.weight_unit (weight_unit_id) include (weight_unit)
;

---- drop index normalized.product_size_id_include_idx;	
CREATE INDEX  IF NOT EXISTS product_size_id_include_idx ON normalized.product_size (product_size_id) include (product_size_description)
;


---- drop index normalized.brand_id_include_idx;	
CREATE INDEX  IF NOT EXISTS brand_id_include_idx ON normalized.brand (brand_id) include (brand_name)
;


