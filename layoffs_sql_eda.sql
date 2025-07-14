select *
from  layoffs_staging2;

select  max(total_laid_off),max(percentage_laid_off)
from layoffs_staging2;

SELECT company, total_laid_off
FROM layoffs_staging2
ORDER BY total_laid_off DESC
LIMIT 1;

select *
from layoffs_staging2
where percentage_laid_off = 1
order by total_laid_off desc;

select *
from layoffs_staging2
where percentage_laid_off = 1
order by funds_raised_millions desc ;

select company , sum( total_laid_off)
from layoffs_staging2
group by company
order by 2 desc;

select min(`date`),max(`date`)
from layoffs_staging2;

select industry  , sum( total_laid_off)
from layoffs_staging2
group by industry
order by 2 desc;

select country  , sum( total_laid_off)
from layoffs_staging2
group by country
order by 2 desc;

select  year (`date`) , sum( total_laid_off)
from layoffs_staging2
group by year( `date`)
order by 1 desc;

select  stage , sum( total_laid_off)
from layoffs_staging2
group by stage
order by 2 desc;

select company , sum( total_laid_off)
from layoffs_staging2
group by company
order by 2 desc;

select substring(`date`,1,7) as `month`,sum(total_laid_off)
from layoffs_staging2
where substring(`date`,1,7) is not null
group by `month` 
order by `month`;

with rolling_total as (
select substring(`date`,1,7) as `month`,
sum(total_laid_off) as total_off
from layoffs_staging2
where substring(`date`,1,7) is not null
group by `month` 
order by `month`)

select `month`, total_off,
sum(total_off) over (order by `month` ) as rolling_sum
from rolling_total;

select company , year(`date`),sum( total_laid_off)
from layoffs_staging2
group by company,year(`date`)
order by 3 desc;


with company_years  (company, years,total_laid_off) as 
(select company , year(`date`),sum( total_laid_off)
from layoffs_staging2
group by company,year(`date`)
), company_year_rank as (
select * ,
dense_rank() over (partition by years order  by total_laid_off desc) as ranking
from company_years
where years is not null)
select * from company_year_rank
where ranking <=5


