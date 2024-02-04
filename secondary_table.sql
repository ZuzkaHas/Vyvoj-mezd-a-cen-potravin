CREATE OR REPLACE TABLE t_zuzana_hasanova_project_SQL_secondary_final AS
SELECT 
e.country,
e.`year`,
e.GDP,
e.population, 
e.gini 
FROM economies e
JOIN countries c 
ON e.country = c.country 
AND c.continent = 'Europe'
AND e.`year` BETWEEN 2006 AND 2018;