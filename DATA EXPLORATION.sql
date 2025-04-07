USE world_layoffs2;

SELECT * FROM layoffs_staging2;


SELECT MAX(total_laid_off) max_total_laid, MAX(percentage_laid_off) max_percentage
FROM layoffs_staging2;

SELECT * FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised DESC;

SELECT * FROM layoffs_staging2
WHERE company >2;

DELETE t2
FROM layoffs_staging2 t1 JOIN layoffs_staging2 t2
  ON t1.company = t2.company
  AND t1.location = t2.location
  AND t1.industry = t2.industry
  AND t1.total_laid_off = t2.total_laid_off
  AND t1.percentage_laid_off = t2.percentage_laid_off
  AND t1.date = t2.date
  AND t1.stage = t2.stage
  AND t1.country = t2.country
  AND t1.funds_raised = t2.funds_raised
WHERE t1.company > t2.company
OR ( t1.company > t2.company
 AND t1.location > t2.location)
OR ( t1.company > t2.company
  AND t1.industry > t2.industry)
OR ( t1.company > t2.company  
  AND t1.total_laid_off > t2.total_laid_off)
OR ( t1.company > t2.company
  AND t1.percentage_laid_off > t2.percentage_laid_off)
OR ( t1.company > t2.company
  AND t1.date > t2.date)
OR ( t1.company > t2.company
  AND t1.stage > t2.stage)
OR ( t1.company > t2.company
  AND t1.country > t2.country)
OR ( t1.company > t2.company
  AND t1.funds_raised > t2.funds_raised);


SELECT * FROM layoffs_staging2;

SELECT company, SUM(total_laid_off) 
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

SELECT YEAR(date), SUM(total_laid_off) 
FROM layoffs_staging2
GROUP BY YEAR(date)
ORDER BY 2 DESC;


SELECT COUNT(*)
FROM layoffs_staging2;

SELECT MIN(date), MAX(date)
FROM layoffs_staging2;

USE world_layoffs2;


SELECT YEAR(date), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY YEAR(date)
ORDER BY YEAR(date) DESC;

SELECT stage, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC;

SELECT company, AVG(percentage_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

SELECT * FROM layoffs_staging2;

SELECT substring(date, 1, 7) AS `MONTH`, SUM(total_laid_off)
FROM layoffs_staging2
WHERE substring(date, 1, 7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1;

WITH Rolling_total AS (
SELECT substring(date, 1, 7) AS `MONTH`, 
SUM(total_laid_off) AS Total_off
FROM layoffs_staging2
WHERE substring(date, 1, 7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1)
SELECT `MONTH`, Total_off,
SUM(Total_off) OVER(ORDER BY `MONTH`) AS rolling_total
FROM Rolling_total;


SELECT company, SUM(total_laid_off) 
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

SELECT company, year(date), SUM(total_laid_off) 
FROM layoffs_staging2
GROUP BY company, year(date)
order by 3 DESC;

WITH Company_year(company, years, total_laid_off) AS (
SELECT company, year(date), SUM(total_laid_off) 
FROM layoffs_staging2
GROUP BY company, year(date)
), Company_year_rank AS (
SELECT *, DENSE_RANK() OVER (partition by years ORDER BY
total_laid_off DESC) AS ranking
FROM Company_year
WHERE years IS NOT NULL)
SELECT *
FROM Company_year_rank
WHERE ranking <= 5;


USE world_layoffs2;

SELECT industry, SUBSTRING(date, 1, 7) AS Year, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY industry, Year;

WITH industry_year AS (
SELECT  SUBSTRING(date, 1, 7) AS `Year`, SUM(total_laid_off) AS total_off
FROM layoffs_staging2
GROUP BY `Year`
ORDER BY 2
)
SELECT `Year`, total_off,  SUM(total_off) OVER(ORDER BY `Year`) AS Rolling_Total
FROM industry_year;




















