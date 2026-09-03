-- Data Cleaning

SELECT *
FROM layoffs l ;

SELECT COUNT(*) FROM layoffs l;

-- 1. Remove Duplicates
-- 2. Standardize the data
-- 3. Null Values or Blank Values
-- 4. Remove any Columns

-- To keep the raw data, we creat a copy of the DB to manipulate and use
CREATE TABLE layoffs_staging
LIKE layoffs;

SELECT * FROM layoffs_staging ls;
SELECT COUNT(*) FROM layoffs_staging ls;

INSERT layoffs_staging 
SELECT * FROM layoffs;

ALTER TABLE layoffs_staging 
DROP COLUMN source;

-- Search for duplicates

WITH duplicate_cte AS (
	SELECT *,
		ROW_NUMBER() OVER(
			PARTITION BY company, location, total_laid_off, `date`, percentage_laid_off, industry, stage, funds_raised, country
		) AS row_num
	FROM layoffs_staging ls
	ORDER BY row_num DESC
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;

CREATE TABLE layoffs_staging_row LIKE layoffs_staging;

SELECT * FROM layoffs_staging_row lsr; 

ALTER TABLE layoffs_staging_row ADD COLUMN row_num INT;

INSERT layoffs_staging_row 
SELECT *,
	ROW_NUMBER() OVER(
		PARTITION BY company, location, total_laid_off, `date`, percentage_laid_off, industry, stage, funds_raised, country
		ORDER BY date_added ASC
	) AS row_num
FROM layoffs_staging;

DELETE
FROM layoffs_staging_row lsr 
WHERE lsr.row_num > 1; 

SELECT * FROM layoffs_staging_row lsr; 
SELECT COUNT(*)
FROM layoffs_staging_row lsr;

RENAME layoffs