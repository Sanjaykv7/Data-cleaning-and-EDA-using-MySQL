SELECT * FROM layoffs.layoff_staging2;

SELECT * FROM layoffs.layoff_staging2;

select max(total_laid_off), max(percentage_laid_off)
from layoff_staging2;

select*
from layoff_staging2
where percentage_laid_off=1
order by total_laid_off desc;

select*
from layoff_staging2
where percentage_laid_off=1
order by funds_raised_millions desc;

select company, sum(total_laid_off)
from layoff_staging2
group by company
order by 2 desc;

select max(`date`),min(`date`)
from layoff_staging2;

select YEAR(`date`), sum(total_laid_off)
from layoff_staging2
group by year(`date`)
order by 2 desc;


with rolling_total as (
  select substring(`date`, 1, 7) as `month`,
         sum(total_laid_off) as laid_off
  from layoff_staging2
  where substring(`date`, 1, 7) is not null
  group by `month`
)
select `month`, 
       sum(laid_off) over(order by `month`) as rolling_total
from rolling_total;