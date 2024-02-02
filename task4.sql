SELECT
a.calendar_year,
round (AVG (((a.avg_payroll-b.avg_payroll)/b.avg_payroll)*100),2) AS average_payroll_difference_in_percentage,
round (AVG (((a.avg_product_value-b.avg_product_value)/b.avg_product_value)*100), 2) AS average_price_difference_in_percentage,
round (AVG (((a.avg_product_value-b.avg_product_value)/b.avg_product_value)*100)- AVG(((a.avg_payroll-b.avg_payroll)/b.avg_payroll)*100), 2) AS price_payroll_difference,
IF ((AVG (((a.avg_product_value-b.avg_product_value)/b.avg_product_value)*100)-(AVG (((a.avg_payroll-b.avg_payroll)/b.avg_payroll)*100)))> 10, 1, 0) AS is_desired
FROM t_zuzana_hasanova_project_SQL_primary_final a 
LEFT JOIN t_zuzana_hasanova_project_SQL_primary_final AS b
ON a.calendar_year = b.calendar_year + 1
AND a.ind_branch = b.ind_branch
AND a.product_name = b.product_name 
GROUP BY a.calendar_year
HAVING a.calendar_year >= 2007
ORDER BY calendar_year;