/*
 * Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?
 * mleko 1 l = 114201, chleb 1 kg = 111301
 * year 2006 a 2018
*/

WITH quantity_of_food AS (
	SELECT *
	FROM t_rdm_bck_project_sql_primary_final
	WHERE food_code = "114201" OR food_code = "111301" 
	GROUP BY `year`, food_code, industry_branch_name  
)
SELECT 	
	payroll_year,
	average_price,
	food_code,
	food_name,
	round((average_industry_wage / average_price), 0) AS food_quantity
FROM quantity_of_food
WHERE `year` IN (2006, 2018)
GROUP BY payroll_year , food_code 
;
