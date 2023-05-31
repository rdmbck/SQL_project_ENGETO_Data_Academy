/*
 * Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?
 */

WITH t1 AS (
	SELECT 
		payroll_year,
		round(avg(average_price), 2) AS average_food_price,
		round(avg(average_industry_wage), 2) AS average_payroll
	FROM t_rdm_bck_project_sql_primary_final 
	WHERE payroll_year BETWEEN 2006 AND 2018
	GROUP BY payroll_year 
),
t2 AS (
	SELECT 
		payroll_year,
		round((average_food_price - lag(average_food_price) OVER (ORDER BY payroll_year)) / lag(average_food_price) OVER (ORDER BY payroll_year) * 100, 1) AS YoY_food_price_change,
		round((average_payroll - lag(average_payroll) OVER (ORDER BY payroll_year)) / lag(average_payroll) OVER (ORDER BY payroll_year) * 100, 1) AS YoY_payroll_change
	FROM t1
)
SELECT 
	*,
	(YoY_food_price_change) - (YoY_payroll_change) AS YoY_difference
FROM t2
;
