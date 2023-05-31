/*
 * Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
 * pomoci WITH pripojim totoznou tabulku s rokem +1 a vytvorim sloupec s rozdilem mezd, nasledne vyberu jen radky, ve kterych byl mezirocni rozdil mensi nez 0
 */

-- Radim B. #9021

-- zobrazi pouze nazvy odvetvi, ve kterych mezirocne mzdy i klesaly 

WITH year_comparsion AS (
	SELECT 	t1.payroll_year,
		t1.industry_branch_code,
		t1.industry_branch_name,
		t1.average_industry_wage,
		t2.average_industry_wage AS average_industry_wage_last_year,
		round((t1.average_industry_wage - t2.average_industry_wage) / t2.average_industry_wage * 100, 1) AS wage_change
	FROM t_rdm_bck_project_sql_primary_final AS t1
	JOIN t_rdm_bck_project_sql_primary_final AS t2
		ON t1.industry_branch_code = t2.industry_branch_code 
		AND t1.payroll_year = t2.payroll_year + 1 
	GROUP BY payroll_year, industry_branch_code 
	ORDER BY payroll_year
) 
SELECT DISTINCT industry_branch_name 
FROM year_comparsion
WHERE wage_change < 0
;


-- zobrazi i roky, kod odvetvi, hodnoty mezd a mezirocni zmenu v procentech  

WITH year_comparsion AS (
	SELECT 	t1.payroll_year,
		t1.industry_branch_code,
		t1.industry_branch_name,
		t1.average_industry_wage,
		t2.average_industry_wage AS average_industry_wage_last_year,
		round((t1.average_industry_wage - t2.average_industry_wage) / t2.average_industry_wage * 100, 1) AS wage_change
	FROM t_rdm_bck_project_sql_primary_final AS t1
	JOIN t_rdm_bck_project_sql_primary_final AS t2
		ON t1.industry_branch_code = t2.industry_branch_code 
		AND t1.payroll_year = t2.payroll_year + 1 
	GROUP BY payroll_year, industry_branch_code 
	ORDER BY payroll_year
) 
SELECT *
FROM year_comparsion
WHERE wage_change < 0
;
