SELECT
x.calendar_year,
x.average_payroll_difference_in_percentage,
IF (x.average_payroll_difference_in_percentage > 5,1,0) AS significant_payroll_growth,
x.average_price_difference_in_percentage,
IF (x.average_price_difference_in_percentage > 5,1,0) AS significant_price_growth,
y.GDP_difference_in_percentage,
IF (y.GDP_difference_in_percentage > 5,1,0) AS significant_GDP_growth
FROM 
(SELECT 
a.calendar_year,
round (AVG (((a.avg_payroll-b.avg_payroll)/b.avg_payroll)*100),2) AS average_payroll_difference_in_percentage,
round (AVG (((a.avg_product_value-b.avg_product_value)/b.avg_product_value)*100), 2) AS average_price_difference_in_percentage
FROM t_zuzana_hasanova_project_SQL_primary_final a 
LEFT JOIN t_zuzana_hasanova_project_SQL_primary_final AS b
ON a.calendar_year = b.calendar_year + 1
AND a.ind_branch = b.ind_branch
AND a.product_name = b.product_name 
GROUP BY a.calendar_year) x
LEFT JOIN 
(SELECT 
c.`year`,
round((((c.GDP-d.GDP)/d.GDP)*100),2) AS GDP_difference_in_percentage
FROM t_zuzana_hasanova_project_SQL_secondary_final c
LEFT JOIN t_zuzana_hasanova_project_SQL_secondary_final d 
ON c.country = d.country
AND c.`year` = d.`year` + 1
AND c.country = 'Czech Republic') y
ON x.calendar_year = y.`year`
GROUP BY x.calendar_year
HAVING x.calendar_year >= 2007
ORDER BY x.calendar_year;