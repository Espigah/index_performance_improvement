--- Clientes ativos? com compra no ultimo ano
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
	WHERE pu.purchase_updated >= current_date - INTERVAL '1 YEAR'  
		AND pu.purchase_updated <= now() 
	OR  pu.purchase_created >= now() - INTERVAL '1 YEAR'  
		AND pu.purchase_created <= current_date 
	GROUP BY
		pu.customer_id, pu.purchase_updated, pr.product_name
) AS max_purchase ON max_purchase.customer_id = c.customer_id 
WHERE c.customer_name = 'wHzRGocvluHkJngldDrtBBipXoKikYRrmXWHnYfdEsTZbrOeUJiZfosSkflOqikaTrkbEuxuwptPisgh'
;

---- Marca mais vendida? 
CREATE OR REPLACE VIEW denormalized.brand_purchase_count as 
SELECT pr.product_brand_name, count(1) 
FROM denormalized.product pr 
JOIN denormalized.purchase pu  USiNG(product_id)
WHERE (
	pr.product_name  = 'sKhKNXAjVETXggXsaJmGVNsLMcVJqhMRXJCDQSshPSDSvixWnAtEnPUBxsXRUeUqFGznNqeZbAIvTKxWsbpPoGweXFqAyBtwUcKd'
	and pr.product_brand_name  = 'iZfrTQElElEhPPeIdtiRFvXmRNkJeQrzAoQuTAtirWPuwrZNmptbVSrbHTYxYhrmjlClDtvfIZIiISYT'
)
AND pu.purchase_detail_status  = 'COMPLETED'
GROUP BY pr.product_brand_name 
ORDER BY 2 DESC 
;

--- Total de venda no ultimo ano?
CREATE OR REPLACE VIEW denormalized.purchase_count as 
SELECT  p.purchase_detail_status, count(1) 
FROM denormalized.purchase p
WHERE 
	p.purchase_detail_status = 'CANCELED'
	and
	(
		p.purchase_updated >= current_date - INTERVAL '1 YEAR'  
			AND p.purchase_updated <= now() 
		OR  p.purchase_created >= current_date - INTERVAL '1 YEAR'  
			AND p.purchase_created <= now() 
	)
GROUP BY  p.purchase_detail_status
ORDER BY 2 DESC 
;


---- Compras pendentes detalhadas de cada customer
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
;