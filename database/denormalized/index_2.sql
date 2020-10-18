
--------------------------------------------------------
--mode2 - index mult campos
--------------------------------------------------------
--
--  active_clients_last_year
-- 

---- drop index denormalized.purchase_purchase_created_idx;
---- drop index denormalized.purchase_purchase_updated_idx;
CREATE INDEX  IF NOT EXISTS purchase_purchase_created_idx ON "denormalized".purchase (purchase_created);
CREATE INDEX  IF NOT EXISTS purchase_purchase_updated_idx ON "denormalized".purchase (purchase_updated);
;

---- drop index denormalized.customer_customer_name_idx;
CREATE INDEX  IF NOT EXISTS customer_customer_name_idx ON denormalized.customer (customer_name)
;

---- drop index denormalized.product_id_name_idx;
CREATE INDEX  IF NOT EXISTS product_id_name_idx ON denormalized.product (product_id, product_name)
;

--===============================================================================================================
--
--  brand_purchase_count
-- 

---- drop index denormalized.purchase_product_id_idx;
CREATE INDEX  IF NOT EXISTS purchase_product_id_idx ON denormalized.purchase (product_id)
;


---- drop index denormalized.product_name_idx;
CREATE INDEX  IF NOT EXISTS product_name_idx ON denormalized.product (product_name, product_brand_name)
;

--===============================================================================================================
--
--  purchase_count
--

CREATE INDEX  IF NOT EXISTS purchase_purchase_created_idx ON "denormalized".purchase (purchase_created);
CREATE INDEX  IF NOT EXISTS purchase_purchase_updated_idx ON "denormalized".purchase (purchase_updated);
CREATE INDEX  IF NOT EXISTS purchase_detail_status_idx ON "denormalized".purchase (purchase_detail_status);

--===============================================================================================================
--
--  customer_purchase_detail
-- 

---- drop index denormalized.purchase_customer_id_idx;
CREATE INDEX  IF NOT EXISTS purchase_customer_id_idx ON denormalized.purchase (customer_id, purchase_detail_status, product_id) 
;


---- drop index denormalized.customer_customer_created_idx;
CREATE INDEX  IF NOT EXISTS customer_customer_created_idx ON denormalized.customer (customer_id, customer_created)
;

