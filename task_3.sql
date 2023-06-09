/*
 * Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?
 */

SELECT 	
	`year`,
	average_price,
	food_code,
	food_name,
	round(((average_price - (lag(average_price) OVER (PARTITION BY food_name ORDER BY `year`))) * 100)
	/ (lag(average_price) OVER (PARTITION BY food_name ORDER BY `year`)), 2) AS YoY_change
FROM t_rdm_bck_project_sql_primary_final
GROUP BY food_name, `year`
ORDER BY YoY_change ASC
;
