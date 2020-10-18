
--------------------------------------------------------
--mode1 - index por campo
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

---- drop index denormalized.product_id_idx;
CREATE INDEX  IF NOT EXISTS product_id_idx ON denormalized.product (product_id)
;

---- drop index denormalized.product_name_idx;
CREATE INDEX  IF NOT EXISTS product_name_idx ON denormalized.product (product_name)
;

--===============================================================================================================
--
--  brand_purchase_count
-- 
CREATE INDEX  IF NOT EXISTS purchase_product_id_idx ON denormalized.purchase (product_id)
;

CREATE INDEX  IF NOT EXISTS purchase_detail_status_idx ON denormalized.purchase (purchase_detail_status)
;

---- drop index denormalized.product_name_idx;
CREATE INDEX  IF NOT EXISTS product_name_idx ON denormalized.product (product_name)
;

---- drop index denormalized.product_brand_name_idx;
CREATE INDEX  IF NOT EXISTS product_brand_name_idx ON denormalized.product (product_brand_name)
;

--===============================================================================================================
--
--  purchase_count
-- 
CREATE INDEX  IF NOT EXISTS  purchase_purchase_created_idx ON "denormalized".purchase (purchase_created);
CREATE INDEX  IF NOT EXISTS  purchase_purchase_updated_idx ON "denormalized".purchase (purchase_updated);
CREATE INDEX  IF NOT EXISTS  purchase_detail_status_idx ON "denormalized".purchase (purchase_detail_status);
;
--===============================================================================================================
--
--  customer_purchase_detail
-- 
CREATE INDEX  IF NOT EXISTS purchase_customer_id_idx ON denormalized.purchase (customer_id)
;

CREATE INDEX  IF NOT EXISTS purchase_purchase_detail_status_idx ON denormalized.purchase (purchase_detail_status)
;

CREATE INDEX  IF NOT EXISTS customer_customer_created_idx ON denormalized.customer (customer_created)
;



