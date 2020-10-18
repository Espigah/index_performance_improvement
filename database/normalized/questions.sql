--- Clientes ativos? com compra no ultimo ano
CREATE OR REPLACE VIEW "normalized".active_clients_last_year as 
SELECT 
c.customer_email 
, ca.customer_address_zipcode
, max_purchase.purchase_updated
, max_purchase.product_name
FROM normalized.customer c 
JOIN (
	SELECT
		pd.customer_id
		,max(pd.purchase_detail_id) AS purchase_detail_id
		, pu.purchase_updated
		, pr.product_name 
	FROM normalized.purchase pu
	JOIN normalized.purchase_detail pd USING (purchase_id)
	JOIN normalized.product pr USING (product_id)
	WHERE pu.purchase_updated >= current_date - INTERVAL '1 YEAR'  
		AND pu.purchase_updated <= current_date
	OR  pu.purchase_created >= current_date - INTERVAL '1 YEAR'  
		AND pu.purchase_created <= current_date
	GROUP BY
		pd.customer_id, pu.purchase_updated, pr.product_name
) AS max_purchase ON max_purchase.customer_id = c.customer_id 
JOIN normalized.customer_address ca USING(customer_address_id)
WHERE c.customer_name = 'wHzRGocvluHkJngldDrtBBipXoKikYRrmXWHnYfdEsTZbrOeUJiZfosSkflOqikaTrkbEuxuwptPisgh'
;


---- Marca mais vendida? 
CREATE OR REPLACE VIEW "normalized".brand_purchase_count as 
SELECT b.brand_name, count(1) 
FROM normalized.brand b
JOIN normalized.product pr USiNG(brand_id)
JOIN normalized.purchase_detail pd   USiNG(product_id)
JOIN normalized.purchase pu  USiNG(purchase_id)
WHERE (
	pr.product_name  = 'sKhKNXAjVETXggXsaJmGVNsLMcVJqhMRXJCDQSshPSDSvixWnAtEnPUBxsXRUeUqFGznNqeZbAIvTKxWsbpPoGweXFqAyBtwUcKd'
	and  b.brand_name  = 'iZfrTQElElEhPPeIdtiRFvXmRNkJeQrzAoQuTAtirWPuwrZNmptbVSrbHTYxYhrmjlClDtvfIZIiISYT'
)
AND pd.purchase_detail_status_id  = 1
GROUP BY b.brand_name 
ORDER BY 2 DESC 
;


--- Total de vendas no ultimo ano?
CREATE OR REPLACE VIEW "normalized".purchase_count as 
SELECT pds.purchase_detail_status, count(1) 
FROM normalized.purchase p
JOIN normalized.purchase_detail pd   USiNG(purchase_id)
JOIN normalized.purchase_detail_status pds   USiNG(purchase_detail_status_id)
WHERE
	pd.purchase_detail_status_id  = 1
	and
	(
		p.purchase_updated >= current_date - INTERVAL '1 YEAR'  
			AND p.purchase_updated <= now() 
		OR  p.purchase_created >= current_date - INTERVAL '1 YEAR'  
			AND p.purchase_created <= now() 
	)
GROUP BY pds.purchase_detail_status
ORDER BY 2 DESC 
;


---- Compras pendentes detalhadas de cada customer
CREATE OR REPLACE VIEW "normalized".customer_purchase_detail as 
SELECT  
	c.customer_id 
	,c.customer_name
	,b.brand_name 
	,pr.product_name
	,ps.product_size_description 
	,we.weight_value::text || ' ' || wu.weight_unit::TEXT AS weight
	,pds.purchase_detail_status
FROM normalized.customer c
JOIN normalized.purchase_detail pd   USiNG(customer_id)
JOIN normalized.purchase_detail_status pds  USiNG(purchase_detail_status_id)
JOIN normalized.purchase pu  USiNG(purchase_id)
JOIN normalized.product pr USiNG(product_id)
JOIN normalized.weight we   USiNG(weight_id)
JOIN normalized.weight_unit wu   USiNG(weight_unit_id)
JOIN normalized.product_size ps   USiNG(product_size_id)
JOIN normalized.brand b  USiNG(brand_id)
WHERE pd.purchase_detail_status_id = 1
AND c.customer_created >= current_date - INTERVAL '3 YEAR'  
AND c.customer_created < current_date - INTERVAL '2 YEAR'  
;