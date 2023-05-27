/*
 * vytvoreni sekundarni tabulky
 */

CREATE OR REPLACE TABLE t_rdm_bck_project_SQL_secondary_final 
SELECT 	e.country,
		e.`year`,
		e.GDP,
		e.gini,
		e.taxes 
FROM economies e 
JOIN countries c 
	ON c.country = e.country
WHERE c.continent = "europe"
ORDER BY e.country
;