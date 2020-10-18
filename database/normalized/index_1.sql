
--------------------------------------------------------
--mode1 - index por campo
--------------------------------------------------------
-- active_clients_last_year
---- drop index normalized.purchase_detail_purchase_id_idx;
CREATE INDEX  IF NOT EXISTS purchase_detail_purchase_id_idx ON "normalized".purchase_detail (purchase_id); -- NOT

---- drop index normalized.product_product_id_idx;
CREATE INDEX  IF NOT EXISTS product_product_id_idx ON "normalized".product (product_id);

---- drop index normalized.purchase_purchase_created_idx;
CREATE INDEX  IF NOT EXISTS purchase_purchase_created_idx ON "normalized".purchase (purchase_created);

---- drop index normalized.purchase_purchase_updated_idx;
CREATE INDEX  IF NOT EXISTS purchase_purchase_updated_idx ON "normalized".purchase (purchase_updated);

---- drop index normalized.customer_name_idx;
CREATE INDEX  IF NOT EXISTS customer_name_idx ON "normalized".customer (customer_name);




-- brand_purchase_count
---- drop index normalized.product_brand_id_idx
CREATE INDEX  IF NOT EXISTS product_brand_id_idx ON "normalized".product (brand_id); -- NOT

---- drop index normalized.product_name_idx
CREATE INDEX  IF NOT EXISTS product_name_idx ON "normalized".product (product_name);

---- drop index normalized.purchase_detail_product_id_idx
CREATE INDEX  IF NOT EXISTS purchase_detail_product_id_idx ON "normalized".purchase_detail (product_id);

---- drop index normalized.purchase_detail_status_id_idx
CREATE INDEX  IF NOT EXISTS purchase_detail_status_id_idx ON "normalized".purchase_detail (purchase_detail_status_id);

---- drop index normalized.brand_name_idx
CREATE INDEX  IF NOT EXISTS brand_name_idx ON "normalized".brand (brand_name);



-- purchase_count

---- drop index normalized.purchase_detail_purchase_id_idx;
CREATE INDEX  IF NOT EXISTS purchase_detail_purchase_id_idx ON "normalized".purchase_detail (purchase_id);


---- drop index normalized.purchase_detail_status_id_idx
CREATE INDEX  IF NOT EXISTS purchase_detail_status_id_idx ON "normalized".purchase_detail (purchase_detail_status_id);

---- drop index normalized.purchase_purchase_created_idx;
CREATE INDEX  IF NOT EXISTS purchase_purchase_created_idx ON "normalized".purchase (purchase_created);

---- drop index normalized.purchase_purchase_updated_idx;
CREATE INDEX  IF NOT EXISTS purchase_purchase_updated_idx ON "normalized".purchase (purchase_updated);



-- customer_purchase_detail
CREATE INDEX  IF NOT EXISTS purchase_detail_customer_id_idx ON "normalized".purchase_detail (customer_id);
CREATE INDEX  IF NOT EXISTS product_product_id_idx ON "normalized".product (product_id);


--------------------------------------------------------dump
--mode2 - index mult campos
--------------------------------------------------------
-- active_clients_last_year
---- drop index normalized.purchase_detail_customer_id_idx;	
CREATE INDEX  IF NOT EXISTS purchase_detail_customer_id_idx ON normalized.purchase_detail (customer_id)
;

---- drop index normalized.purchase_detail_status_id_idx;	
CREATE INDEX  IF NOT EXISTS purchase_detail_status_id_idx ON normalized.purchase_detail (purchase_detail_status_id)
;

---- drop index normalized.purchase_detail_purchase_id_idx;
CREATE INDEX  IF NOT EXISTS customer_customer_created_idx ON normalized.customer (customer_created) -- NOT
;


-- brand_purchase_count
-- purchase_count
-- customer_purchase_detail
--------------------------------------------------------
--mode3 -   force index only
--------------------------------------------------------
-- active_clients_last_year
-- brand_purchase_count
-- purchase_count
-- customer_purchase_detail

--------------------------------------------------------
--mode4 -   index parcial
--------------------------------------------------------
-- active_clients_last_year
-- brand_purchase_count
-- purchase_count
-- customer_purchase_detail