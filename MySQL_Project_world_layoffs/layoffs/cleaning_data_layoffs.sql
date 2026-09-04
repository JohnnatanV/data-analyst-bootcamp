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

alter table layoffs_staging
drop source;

-- 1. Remove Duplicates

with duplicate_cte as (
	select *,
    row_number() over (
    partition by company, location, total_laid_off, `date`, percentage_laid_off, industry, stage, funds_raised, country
    ) as row_num
    from layoffs_staging
)
select *
from duplicate_cte
order by row_num desc;

-- -- Metodo 1 para crear la copia de la tabla para trabajar los datos sin alterar su origen
create TABLE layoffs_clean_staging like layoffs_staging;

ALTER TABLE layoffs_clean_staging
ADD COLUMN row_num INT;

INSERT into layoffs_clean_staging
select *,
    row_number() over (
    partition by company, location, total_laid_off, `date`, percentage_laid_off, industry, stage, funds_raised, country, date_added
    ) as row_num
from layoffs_staging;

-- -- Metodo 2 para crear la copia de la tabla para trabajar los datos sin alterar su origen
CREATE TABLE `layoffs_clean_staging` (
  `company` text,
  `location` text,
  `total_laid_off` text,
  `date` text,
  `percentage_laid_off` text,
  `industry` text,
  `stage` text,
  `funds_raised` text,
  `country` text,
  `date_added` text,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT into layoffs_clean_staging
select *,
    row_number() over (
    partition by company, location, total_laid_off, `date`, percentage_laid_off, industry, stage, funds_raised, country
    ) as row_num
from layoffs_staging;

-- -----------------------------------------------
delete from layoffs_clean_staging
where row_num > 1
ORDER BY company;

select * from layoffs_clean_staging;

-- 2. Standardizing the Data

select distinct company
from layoffs_clean_staging
order by 1;

select company, trim(company)
from layoffs_clean_staging;

update layoffs_clean_staging
set company = trim(company);

select distinct industry
from layoffs_clean_staging
order by 1;

select distinct location
from layoffs_clean_staging
order by 1;

select * from layoffs_clean_staging
where location like '%, non-u.s.' and country = 'united states';

select * from layoffs_clean_staging
where location like '%, non-u.s.';

update layoffs_clean_staging 
set 
	country = case
		when location like 'Tel Aviv%' then 'Israel'
        when location like 'Haifa%' then 'Israel'
        when location like 'Jerusalem%' then 'Israel'
        when location like 'vancouver%' then 'Canada'
        when location like 'Dublin%' then 'Ireland'
	end,
    location = replace(location, ', Non-U.S.', '')
where location like '%, Non-U.S.%';

select distinct country
from layoffs_clean_staging
order by 1;

select `date`,
str_to_date(`date`, '%m/%d/%Y'),
date_added,
str_to_date(date_added, '%m/%d/%Y')
from layoffs_clean_staging;

update layoffs_clean_staging
set
	`date` = str_to_date(`date`, '%m/%d/%Y'),
    date_added = str_to_date(date_added, '%m/%d/%Y')
where `date` like '%/%/%' or date_added like '%/%/%';

select 
	`date`,
	date_added
from layoffs_clean_staging;

alter table layoffs_clean_staging
MODIFY COLUMN `date` date,
MODIFY column date_added date;

-- 3. Null Values or Blank Values

select * from layoffs_clean_staging
where total_laid_off = ''
and percentage_laid_off = '';

select * from layoffs_clean_staging
where country is null;

select 
	t1.location,
    t1.country pais_actual,
    t2.location,
    t2.country nuevo_pais
from layoffs_clean_staging t1
	join layoffs_clean_staging t2
    on t1.location = t2.location
where t1.country is null
and t2.country is not null;


update layoffs_clean_staging t1
	join layoffs_clean_staging t2
    on t1.location = t2.location
set t1.country = t2.country
where t1.country is null
and t2.country is not null;

UPDATE layoffs_clean_staging
SET country = CASE
    WHEN location IN ('Melbourne', 'Sydney') THEN 'Australia'
    WHEN location IN ('Linz', 'Vienna') THEN 'Austria'
    WHEN location IN ('Manama') THEN 'Bahrain'
    WHEN location IN ('Brussels', 'Ghent') THEN 'Belgium'
    WHEN location IN ('Belo Horizonte', 'Blumenau', 'Brasilia', 'Curitiba', 'FlorianÃ³polis', 'Joinville', 'Porto Alegre', 'Sao Paulo') THEN 'Brazil'
    WHEN location IN ('Sofia') THEN 'Bulgaria'
    WHEN location IN ('Calgary', 'Ferdericton', 'Kitchener', 'Ottawa', 'Quebec', 'Saskatoon', 'Toronto', 'Victoria', 'Waterloo', 'Winnipeg') THEN 'Canada'
    WHEN location IN ('Santiago') THEN 'Chile'
    WHEN location IN ('Beijing', 'Hangzhou', 'Shanghai', 'Shenzen', "Xi'an") THEN 'China'
    WHEN location IN ('Limassol') THEN 'Cyprus'
    WHEN location IN ('Brno', 'Prague') THEN 'Czech Republic'
    WHEN location IN ('Copenhagen') THEN 'Denmark'
    WHEN location IN ('Cairo') THEN 'Egypt'
    WHEN location IN ('Tallinn') THEN 'Estonia'
    WHEN location IN ('Espoo', 'Helsinki') THEN 'Finland'
    WHEN location IN ('Paris', 'Toulouse') THEN 'France'
    WHEN location IN ('Berlin', 'Chemnitz', 'Cologne', 'Dresden', 'DÃ¼sseldorf', 'Dusseldorf', 'Frankfurt', 'Hamburg', 'Karlsruhe', 'Kiel', 'Munich', 'Walldorf') THEN 'Germany'
    WHEN location IN ('Accra') THEN 'Ghana'
    WHEN location IN ('Athens') THEN 'Greece'
    WHEN location IN ('Hong Kong') THEN 'Hong Kong'
    WHEN location IN ('Budapest') THEN 'Hungary'
    WHEN location IN ('Ahmedabad', 'Chennai', 'Hyderabad', 'Indore', 'Kolkata', 'Nashik', 'New Delhi', 'Noida', 'Patna', 'Pune', 'Trivandrum') THEN 'India'
    WHEN location IN ('Jakarta') THEN 'Indonesia'
    WHEN location IN ('Cork') THEN 'Ireland'
    WHEN location IN ('Kfar Saba', "Ra'anana", 'Sderot', 'Yavne') THEN 'Israel'
    WHEN location IN ('Milan') THEN 'Italy'
    WHEN location IN ('Tokyo') THEN 'Japan'
    WHEN location IN ('Nairobi') THEN 'Kenya'
    WHEN location IN ('Vilnius') THEN 'Lithuania'
    WHEN location IN ('Luxembourg') THEN 'Luxembourg'
    WHEN location IN ('Selangor') THEN 'Malaysia'
    WHEN location IN ('Sliema') THEN 'Malta'
    WHEN location IN ('Guadalajara', 'Mexico City', 'Monterrey') THEN 'Mexico'
    WHEN location IN ('Yangon') THEN 'Myanmar'
    WHEN location IN ('Amsterdam', 'Eindhoven', 'The Hague', 'Utrecht', 'Veldhoven') THEN 'Netherlands'
    WHEN location IN ('Wellington') THEN 'New Zealand'
    WHEN location IN ('Abuja', 'Ibadan', 'Lagos') THEN 'Nigeria'
    WHEN location IN ('FÃ¸rde', 'Oslo', 'Sandnes') THEN 'Norway'
    WHEN location IN ('Islamabad', 'Karachi', 'Lahore') THEN 'Pakistan'
    WHEN location IN ('Lima') THEN 'Peru'
    WHEN location IN ('Manila') THEN 'Philippines'
    WHEN location IN ('Gydnia', 'Krakow', 'Lodz', 'Warsaw', 'WrocÅ‚aw') THEN 'Poland'
    WHEN location IN ('Coimbra', 'Lisbon') THEN 'Portugal'
    WHEN location IN ('Bucharest', 'Cluj-Napoca') THEN 'Romania'
    WHEN location IN ('Moscow') THEN 'Russia'
    WHEN location IN ('Riyadh') THEN 'Saudi Arabia'
    WHEN location IN ('Dakar') THEN 'Senegal'
    WHEN location IN ('Beau Vallon') THEN 'Seychelles'
    WHEN location IN ('Cape Town') THEN 'South Africa'
    WHEN location IN ('Seoul') THEN 'South Korea'
    WHEN location IN ('Barcelona', 'Madrid') THEN 'Spain'
    WHEN location IN ('Gothenburg', 'Malmo', 'MalmÃ¶', 'Stockholm') THEN 'Sweden'
    WHEN location IN ('Geneva', 'St. Gallen', 'Zug', 'Zurich') THEN 'Switzerland'
    WHEN location IN ('Bangkok') THEN 'Thailand'
    WHEN location IN ('Istanbul') THEN 'Turkey'
    WHEN location IN ('Kyiv') THEN 'Ukraine'
    WHEN location IN ('Dubai') THEN 'United Arab Emirates'
    WHEN location IN ('Bristol', 'Chester', 'Edinburgh', 'Leeds', 'Manchester', 'Oxford', 'Salisbury') THEN 'United Kingdom'
    WHEN location IN ('Montevideo') THEN 'Uruguay'
    WHEN location IN ('Hanoi', 'Ho Chi Minh City') THEN 'Vietnam'
    ELSE country
END
WHERE country IS NULL;


select * from layoffs_clean_staging
WHERE binary location like '%Ã%';

update layoffs_clean_staging
SET location = CASE

    WHEN location LIKE 'Florian%' THEN 'Florianopolis'
    WHEN location LIKE 'Malm%' THEN 'Malmo'
    ELSE location
END
WHERE location LIKE '%Ã%';


select * 
from layoffs_clean_staging
where location = '';

select * 
from layoffs_clean_staging
where location = "Non-U.S.";

delete
from layoffs_clean_staging
where location = "Non-U.S.";

--------------------------------------

alter table layoffs_clean_staging
drop column row_num;

select * from layoffs_clean_staging
where percentage_laid_off < 1;

select count(*) from layoffs_clean_staging
where percentage_laid_off = '';

describe layoffs_clean_staging;

select * from layoffs_clean_staging;


SELECT year(`date`), sum(total_laid_off)
from layoffs_clean_staging
GROUP BY year(`date`)
ORDER BY 1 desc;

SELECT country, sum(total_laid_off)
from layoffs_clean_staging
GROUP BY country
ORDER BY 2 desc;

SELECT industry, sum(total_laid_off)
from layoffs_clean_staging
GROUP BY industry
ORDER BY 2 desc;

select substring(`date`, 1, 7) as `MONTH`, sum(total_laid_off)
from layoffs_clean_staging
GROUP BY `MONTH`
order by 1 asc;

with Rolling_Total AS
(
select substring(`date`, 1, 7) as `MONTH`, sum(total_laid_off) as total_off
from layoffs_clean_staging
GROUP BY `MONTH`
order by 1 asc
)
select `MONTH`, total_off, sum(total_off) over(order by `MONTH`) as rolling_total
from Rolling_Total;


select company, year(`date`), sum(total_laid_off)
from layoffs_clean_staging
GROUP BY company, year(`date`)
order by company asc;