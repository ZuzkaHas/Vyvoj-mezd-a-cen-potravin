-- The affordable amount of food per average payroll in each industry branch in each year:
SELECT 
*,
round (avg_payroll/avg_product_value, 0) AS affordable_food_amount
FROM t_zuzana_hasanova_project_SQL_primary_final AS a
WHERE product_name IN ('Mléko polotučné pasterované', 'Chléb konzumní kmínový') 
AND calendar_year IN (2006, 2018)
ORDER BY calendar_year, ind_branch;

-- The affordable amount of food per average of average payrolls in each year:
SELECT
calendar_year,
round (AVG (avg_payroll), 2) AS avg_avg_payroll,
product_name,
avg_product_value,
round (AVG (avg_payroll)/avg_product_value, 0) AS affordable_food_amount
FROM t_zuzana_hasanova_project_SQL_primary_final AS a
WHERE product_name IN ('Mléko polotučné pasterované', 'Chléb konzumní kmínový') 
AND calendar_year IN (2006, 2018)
GROUP BY calendar_year, product_name;
