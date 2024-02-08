SELECT 
x.product_name,
round (sum (x.price_difference_in_percentage), 2) AS total_price_difference_in_percentage
FROM (
SELECT DISTINCT 
a.product_name, 
a.calendar_year,
((a.avg_product_value-b.avg_product_value)/b.avg_product_value)*100 AS price_difference_in_percentage
FROM t_zuzana_hasanova_project_SQL_primary_final AS a
LEFT JOIN t_zuzana_hasanova_project_SQL_primary_final AS b
ON a.calendar_year = b.calendar_year + 1
AND a.product_name = b.product_name
) AS x
GROUP BY x.product_name
HAVING x.product_name != 'Jakostní víno bílé'
ORDER BY total_price_difference_in_percentage;