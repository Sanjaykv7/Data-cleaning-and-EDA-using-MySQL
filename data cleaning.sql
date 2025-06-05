SELECT *
FROM layoffs1;


create table layoff_staging
like layoffs1;

select*
from layoff_staging;

INSERT layoff_staging
select *
from layoffs1;

select*
from layoff_staging;

select*,
row_number()over(
partition by company, location, industry,total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as row_num
from layoff_staging;

with duplicate_cte as 
(
select*,
row_number()over(partition by company, location, industry,total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as row_num
from layoff_staging
)
DELETE
from duplicate_cte
where row_num > 1;



CREATE TABLE `layoff_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


select*
from layoff_staging2;

INSERT INTO layoff_staging2
select*,
row_number()over(partition by company, location, industry,total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as row_num
from layoff_staging;
 
DELETE
from layoff_staging2
where row_num > 1;


select*
from layoff_staging2;

select company, TRIM(company)
from layoff_staging2;

UPDATE layoff_staging2
SET company = TRIM(company);



UPDATE layoff_staging2
SET company = TRIM(company);

select*
from layoff_staging2
where industry like 'crypto%';

update layoff_staging2
set industry ='Crypto'
where industry like 'crypto%';

select distinct country
from layoff_staging2
where country like 'United States'
order by 1;
select distinct country, trim(trailing '.' from country)
from layoff_staging2
order by 1;

update layoff_staging2
set country = trim(trailing '.' from country)
where country like 'United States%';

select `date`
from layoff_staging2;

update layoff_staging2
set date = str_to_date(`date`, '%m/%d/%Y');

alter table layoff_staging2
modify column `date` DATE;

select* from layoff_staging2;

select*
from layoff_staging2
where total_laid_off is null
and percentage_laid_off is null;

update layoff_staging2
set industry= NULL
where industry='';


select*
from layoff_staging2
where industry IS NULL OR industry=' ';

select*
from layoff_staging2 t1
join layoff_staging2 t2
on t1.company = t2.company
where t1.industry is null
and t2.industry is not null;

update layoff_staging2 t1
join layoff_staging2 t2
on t1.company = t2.company
set t1.industry= t2.industry
where t1.industry is null
and t2.industry is not null;

select*
from layoff_staging2;

DELETE
from layoff_staging2
where total_laid_off is null
and percentage_laid_off is null;

alter table layoff_staging2
drop column row_num;
select*
from layoff_staging2;