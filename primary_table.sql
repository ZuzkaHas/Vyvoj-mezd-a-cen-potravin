CREATE OR REPLACE TABLE t_zuzana_hasanova_project_SQL_primary_final AS 
SELECT 
a.payroll_year AS calendar_year,
a.payroll_quarter AS calendar_quarter,
a.ind_branch,
a.avg_payroll,
b.product_name,
b.product_amount,
b.product_unit,
b.avg_product_value
FROM(
SELECT 
cpi.name AS ind_branch,
cp.value AS avg_payroll,
cp.payroll_year,
cp.payroll_quarter 
FROM czechia_payroll cp 
JOIN czechia_payroll_industry_branch cpi 
ON cpi.code = cp.industry_branch_code
WHERE cp.value_type_code = 5958 AND cp.calculation_code = 200 AND cp.industry_branch_code IS NOT NULL AND cp.payroll_year BETWEEN 2006 AND 2018 
) a
JOIN (
SELECT 
cpc.name AS product_name,
cpc.price_value AS product_amount,
cpc.price_unit AS product_unit,
round (AVG(cp.value), 2) AS avg_product_value,
YEAR (cp.date_from) AS product_year,
quarter (cp.date_from) AS product_quarter
FROM czechia_price cp 
JOIN czechia_price_category cpc 
ON cp.category_code = cpc.code 
WHERE cp.region_code IS NULL
GROUP BY product_name, product_year, product_quarter
) b
ON a.payroll_year = b.product_year AND a.payroll_quarter = b.product_quarter
ORDER BY a.ind_branch, a.payroll_year, a.payroll_quarter;

SELECT 
*
FROM t_zuzana_hasanova_project_SQL_primary_final;
