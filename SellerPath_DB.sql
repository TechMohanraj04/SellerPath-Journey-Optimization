create database sellerpath_db;

use sellerpath_db;

CREATE TABLE IF NOT EXISTS seller_data (
    seller_id INT,
    platform VARCHAR(50),
    category VARCHAR(100),
    kind VARCHAR(50),
    region VARCHAR(50),
    impressions INT,
    clicks INT,
    enrolled INT,
    risk_rating DECIMAL(3,1),
    manual_file_ingested VARCHAR(10),
    optin_cta_tagged VARCHAR(10),
    impression_tag_valid VARCHAR(10),
    click_date DATE,
    enrollment_date DATE,
    product_opted VARCHAR(100),
    campaign_id VARCHAR(50),
    seller_tenure_months INT,
    conversion_rate DECIMAL(5,2)
);

SELECT COUNT(*) FROM seller_data;
SELECT * FROM seller_data as sd;

-- Q1. What is the total number of impressions, clicks, and enrollments overall?

select sum(sd.impressions) as total_impressions,
sum(sd.clicks) as total_clicks,sum(sd.enrolled) as total_enrollments from seller_data as sd;

-- Q2. What is the overall CTR % and Enroll %?

select round(100* sum(clicks)/sum(impressions),2) as ctr_pct,
round(100* sum(enrolled)/sum(clicks),2) as enroll_pct from seller_data;

-- Q3. Which platform has the highest enrollment rate?

select sd.platform, sum(sd.impressions) as total_impressions,
sum(sd.clicks) as total_clicks,sum(sd.enrolled) as total_enrollments
,round(100*sum(sd.enrolled)/nullif(sum(sd.clicks),0),2) as ctr_pct
from seller_data  as sd
group by sd.platform 
order by ctr_pct desc;

-- Q4. Which category shows the biggest drop-off from clicks to enrollments?

select sd.category,sum(sd.impressions) as total_impressions,
sum(sd.clicks) as total_clicks,sum(sd.enrolled) as total_enrollments,
(sum(clicks) - sum(enrolled)) as drop_off,
ROUND(100.0 * SUM(enrolled)/NULLIF(SUM(clicks),0),2) AS enroll_pct
from seller_data  as sd
group by sd.category
order by drop_off desc;

SELECT * FROM seller_data as sd;


-- Tag Diagnostics---

-- Q5. How many sellers have invalid impression tags?

select count(*) as invali_impresions_tags
from seller_data as sd
where impression_tag_valid = 'No';

-- Q6. Conversion difference between valid vs invalid tags?

SELECT 
    impression_tag_valid,
    SUM(clicks) AS clicks,
    SUM(enrolled) AS enrolled,
    ROUND(100.0 * SUM(enrolled)/NULLIF(SUM(clicks),0),2) AS enroll_pct
FROM seller_data
GROUP BY impression_tag_valid;

-- Q7. Does missing CTA tagging reduce enrollment?

select optin_cta_tagged ,
SUM(clicks) AS clicks,
    SUM(enrolled) AS enrolled,
    ROUND(100.0 * SUM(enrolled)/NULLIF(SUM(clicks),0),2) AS enroll_pct
from seller_data
group by optin_cta_tagged;

-- Q8. Do new sellers (<3 months) convert better or worse than experienced sellers (12+ months)?

select
case when seller_tenure_months < 3 then '<3m'
when seller_tenure_months > 12 then '12m+>'
end as seller_groups,
SUM(clicks) AS clicks,
    SUM(enrolled) AS enrolled,
    ROUND(100.0 * SUM(enrolled)/NULLIF(SUM(clicks),0),2) AS enroll_pct
from seller_data
WHERE seller_tenure_months < 3 OR seller_tenure_months >= 12
group by seller_groups;

-- Q9. Does risk_rating affect conversion rates?

-- Q9. Does risk_rating affect conversion rates?

 
SELECT risk_rating,
    SUM(clicks) AS clicks,
    SUM(enrolled) AS enrolled,
    ROUND(100.0 * SUM(enrolled)/NULLIF(SUM(clicks),0),2) AS enroll_pct
FROM seller_data
GROUP BY risk_rating
ORDER BY risk_rating;

-- Q10. Which products are most popular among enrolled sellers?

select product_opted,
sum(enrolled) as total_enrolled
from seller_data
group by product_opted
order by total_enrolled;

select * from seller_data;

-- Q11. Which campaign delivered the best enrollment %?

select campaign_id,sum(enrolled) as total_enrolled,
ROUND(100.0 * SUM(enrolled)/NULLIF(SUM(clicks),0),2) AS enroll_pct
from seller_data
group by campaign_id
order by enroll_pct desc
limit 5;

-- Q12. Which region has the lowest CTR?

select region,sum(sd.impressions) as total_impressions,
sum(sd.clicks) as total_clicks,
round(100* sum(clicks)/sum(impressions),2) as ctr_pct
from seller_data as sd
group by region
order by ctr_pct asc
limit 5;

-- Q13. How do enrollments trend over time (daily)?

select click_date,
sum(enrolled) as total_enrolled
from seller_data 
group by click_date
order by click_date;

-- Q14. category wise find products purchased by the individual?

select category,
product_opted
 from seller_data
 where Kind = 'Individual';
 
 select * from seller_data;


































