-- Data Cleaning

SELECT *
FROM layoffs
order by company asc;

-- 1. Remove Duplicates
-- 2. Standarize the Data
-- 3. Null Values or Blank Values
-- 4. Remove any Columns

CREATE TABLE layoffs_staging
LIKE layoffs;

SELECT * 
FROM layoffs_staging;

INSERT layoffs_staging
SELECT * 
FROM layoffs;

-- 1. Remove Duplicates
