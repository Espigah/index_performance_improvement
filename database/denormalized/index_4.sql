--------------------------------------------------------
--mode4 -   index parcial
--------------------------------------------------------
-- active_clients_last_year

-- drop index denormalized.purchase_purchase_created_idx;
-- drop index denormalized.purchase_purchase_updated_idx;
CREATE INDEX  IF NOT EXISTS purchase_purchase_created_idx ON "denormalized".purchase (purchase_created) 
where purchase_created > '2019-01-01'
;
CREATE INDEX  IF NOT EXISTS purchase_purchase_updated_idx ON "denormalized".purchase (purchase_updated) 
where purchase_updated > '2019-01-01'
;


-- drop index denormalized.customer_customer_name_idx;
CREATE  INDEX  IF NOT EXISTS customer_customer_name_idx ON denormalized.customer (customer_name) 
INCLUDE (customer_id,customer_email,customer_zipcode)
where customer_name = 'wHzRGocvluHkJngldDrtBBipXoKikYRrmXWHnYfdEsTZbrOeUJiZfosSkflOqikaTrkbEuxuwptPisgh'
;

-- drop index denormalized.product_id_name_idx;
CREATE INDEX  IF NOT EXISTS product_id_name_idx ON denormalized.product (product_id, product_name);
;



--===============================================================================================================
--
--  brand_purchase_count
-- 

---- drop index denormalized.purchase_product_id_idx;
CREATE INDEX  IF NOT EXISTS purchase_product_id_idx ON denormalized.purchase (product_id,purchase_detail_status) where  purchase_detail_status = 'COMPLETED'
;


---- drop index denormalized.product_name_idx;
CREATE INDEX  IF NOT EXISTS product_name_idx ON denormalized.product (product_name, product_brand_name, product_id) where product_name = 'sKhKNXAjVETXggXsaJmGVNsLMcVJqhMRXJCDQSshPSDSvixWnAtEnPUBxsXRUeUqFGznNqeZbAIvTKxWsbpPoGweXFqAyBtwUcKd'
;

--===============================================================================================================
--
--  purchase_count
--

CREATE INDEX  IF NOT EXISTS purchase_purchase_created_idx ON "denormalized".purchase (purchase_created) where purchase_created > '20200101' ;
CREATE INDEX  IF NOT EXISTS purchase_purchase_updated_idx ON "denormalized".purchase (purchase_updated) where purchase_updated  > '20200101' ;
CREATE INDEX  IF NOT EXISTS purchase_detail_status_idx ON "denormalized".purchase (purchase_detail_status) where purchase_detail_status = 'CANCELED';
--===============================================================================================================
--
--  customer_purchase_detail
-- 

---- drop index denormalized.purchase_customer_id_idx;
CREATE INDEX  IF NOT EXISTS purchase_customer_id_idx ON denormalized.purchase (customer_id, purchase_detail_status, product_id) 
where purchase_detail_status = 'PENDING'
;


---- drop index denormalized.customer_customer_created_idx;
CREATE INDEX  IF NOT EXISTS customer_customer_created_idx ON denormalized.customer (customer_created, customer_id) include (customer_name)
where customer_created > '20190101'
;

CREATE INDEX  IF NOT EXISTS purchase_purchase_detail_status_idx ON denormalized.product (product_id) include (product_name,product_brand_name,product_size_description,product_weight)
;

---------------------------
CREATE OR REPLACE VIEW denormalized.active_clients_last_year as 
SELECT 
c.customer_email 
, c.customer_zipcode 
, max_purchase.purchase_updated
, max_purchase.product_name
FROM denormalized.customer c 
LEFT JOIN (
	SELECT
		pu.customer_id
		,max(pr.product_size_description) AS product_size_description
		, pu.purchase_updated
		, pr.product_name 
	FROM denormalized.purchase pu
	JOIN denormalized.product pr using(product_id)
	WHERE (
		pu.purchase_updated >= current_date - INTERVAL '1 YEAR'  
		AND pu.purchase_updated <= now() 
		and  purchase_created > '2019-01-01'
	)
	OR  (
		pu.purchase_created >= now() - INTERVAL '1 YEAR'  
		AND pu.purchase_created <= current_date 
		and  purchase_created > '2019-01-01'
	)
	GROUP BY
		pu.customer_id, pu.purchase_updated, pr.product_name
) AS max_purchase ON max_purchase.customer_id = c.customer_id 
WHERE c.customer_name = 'wHzRGocvluHkJngldDrtBBipXoKikYRrmXWHnYfdEsTZbrOeUJiZfosSkflOqikaTrkbEuxuwptPisgh'
;

CREATE OR REPLACE VIEW denormalized.purchase_count as 
SELECT  p.purchase_detail_status, count(1) 
FROM denormalized.purchase p
WHERE 
p.purchase_detail_status = 'CANCELED'
and
(
	p.purchase_updated > '20190101'
	AND p.purchase_updated >= current_date - INTERVAL '1 YEAR'  
		AND p.purchase_updated <= now() 
	OR  
		p.purchase_created > '20190101'
	AND p.purchase_created >= current_date - INTERVAL '1 YEAR'  
		AND p.purchase_created <= now() 
)
GROUP BY  p.purchase_detail_status
ORDER BY 2 DESC ;

CREATE OR REPLACE VIEW denormalized.customer_purchase_detail as 
SELECT  
	c.customer_id 
	,c.customer_name
	,pr.product_brand_name 
	,pr.product_name
	,pr.product_size_description 
	,pr.product_weight
	,pu.purchase_detail_status
FROM denormalized.customer c
JOIN denormalized.purchase pu USING (customer_id)
JOIN denormalized.product pr USING (product_id)
WHERE pu.purchase_detail_status = 'PENDING'
AND c.customer_created >= current_date - INTERVAL '3 YEAR'  
AND c.customer_created < current_date - INTERVAL '2 YEAR' 
AND customer_created > '20190101'
;
