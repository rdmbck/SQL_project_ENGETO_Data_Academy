CREATE OR REPLACE TABLE t_rdm_bck_project_SQL_primary_final AS    
SELECT * 
FROM (
		SELECT 	cp.payroll_year,
				cp.industry_branch_code,
				cpib.name AS industry_branch_name,
				round(avg(cp.value), 0) AS average_industry_wage
		FROM czechia_payroll cp
		LEFT JOIN czechia_payroll_industry_branch cpib -- pripojeni nazvu odvetvi
			ON cp.industry_branch_code = cpib.code 
		WHERE value_type_code = "5958" 
		GROUP BY payroll_year, industry_branch_code 
		ORDER BY payroll_year
		) t_payroll
LEFT JOIN 
		(
		SELECT 	year(cp.date_from) AS `year`,
				round(avg(cp.value), 2) AS average_price,
				cpc.code AS food_code,
				cpc.name AS food_name
		FROM czechia_price cp 
		LEFT JOIN czechia_price_category cpc 
			ON cp.category_code = cpc.code 
		GROUP BY `year`, cpc.code, cpc.name  
		) t_price
ON t_payroll.payroll_year = t_price.`year`