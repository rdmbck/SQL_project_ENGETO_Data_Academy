/*
 * vytvoreni sekundarni tabulky
 */

CREATE OR REPLACE TABLE t_rdm_bck_project_SQL_secondary_final 
SELECT 	
	e.country,
	e.`year`,
	e.GDP,
	e.gini,
	e.taxes 
FROM economies e 
JOIN countries c 
	ON c.country = e.country
WHERE c.continent = "europe"
AND e.`year` BETWEEN 2006 AND 2018
ORDER BY e.country, e.`year` 
;
