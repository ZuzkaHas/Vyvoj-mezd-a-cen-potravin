SELECT 
a.product_name, 
round (sum (((a.avg_product_value-b.avg_product_value)/b.avg_product_value)*100), 0) AS total_price_difference_in_percentage
FROM t_zuzana_hasanova_project_SQL_primary_final AS a
LEFT JOIN t_zuzana_hasanova_project_SQL_primary_final AS b
ON a.calendar_year = b.calendar_year + 1
AND a.product_name = b.product_name
GROUP BY a.product_name
ORDER BY total_price_difference_in_percentage;