SELECT 
a.ind_branch,
a.calendar_year AS current_year,
a.avg_payroll AS current_year_payroll,
b.calendar_year AS previous_year,
b.avg_payroll AS previous_year_payroll,
round (((a.avg_payroll-b.avg_payroll)/b.avg_payroll)*100,2) AS payroll_difference_in_percentage
FROM t_zuzana_hasanova_project_SQL_primary_final AS a
LEFT JOIN t_zuzana_hasanova_project_SQL_primary_final AS b
ON a.calendar_year = b.calendar_year + 1
AND a.ind_branch = b.ind_branch
GROUP BY a.calendar_year, a.ind_branch
HAVING previous_year IS NOT NULL
ORDER BY payroll_difference_in_percentage, a.ind_branch, current_year;