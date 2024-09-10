create database project1;

use project1;


#table structure
create table sales(

transactions_id	INT primary key,
sale_date	Date,
sale_time   Time,	
customer_id	 int,
gender	varchar(15),
age	int,
category varchar(15),	
quantiy	int,
price_per_unit	float,
cogs	float,
total_sale float
);

#viewing whole table
select * 
from sales;

#top 10 rows
select * 
from sales
limit 10;

#total no. of rows
select count(*) 
from sales;


#checking where quantity is null
select *
from sales
where quantiy is null;


#checking nulls in multiple columns
select * 
from sales
where 
     quantiy =null
     or
     price_per_unit = null
     or
     cogs = null
     or
     total_sale = null;
     
#deleting null from the tables     
delete from sales
where 
   quantiy =null
     or
     price_per_unit = null
     or
     cogs = null
     or
     total_sale = null;


# data exploration


# unique_customers

select count(distinct customer_id)
from sales;
#we have 155 distinct customers

#unique categories
select count(distinct category)
from sales;
# only 3 different categories

select distinct category
from sales;
#there names are beauty,clothing,electronics

#male and female populations
select gender, count(gender)
from sales
group by gender;
#there are 975 male and 1012 female

#distribution of age category
select age, count(age)
from sales
group by age
order by age;

# distribution of age in male and female
select age,gender, count(age)
from sales
group by age,gender
order by age;




#transaction details of date 2022-11-05
select * 
from sales
where sale_date="2022-11-05";

#selecting where category is clothing and quantity is greater than in novemeber
select *
from sales
where category="Clothing" and quantiy>10 and sale_date like"2022-11-%";

#where category is clothing and quantity is greater than 2 and month is novemeber
SELECT *
FROM sales
WHERE category = "Clothing" 
  AND quantiy > 2 
  AND sale_date LIKE "2022-11-%";
  
  #categorywise sale
 select category,sum(total_sale)
 from sales
 group by category;
 
 
 #average age of customer where category is beauty
 select avg(age)
 from sales
 where category="Beauty";
 
 
 #rounding off the previous one 
 select round(avg(age),2)
 from sales
 where category="Beauty";
 
 
 #sale where total_sale>1000
 select *
 from sales
 where total_sale>1000;
 
 #no. of rows in previous one
 select count(*)
 from sales
 where total_sale>1000;
 
 #counting transaction_id groupby gender and category
 select gender,category, count(transactions_id) as transactionn
 from sales
 group by gender,category
 order by gender;
 
 
 #average sale of each month in 2022
 SELECT DATE_FORMAT(sale_date, '%Y-%m') AS sale_month, 
       AVG(total_sale) AS average_sale 
FROM sales
WHERE sale_date LIKE '2022-%'
GROUP BY sale_month
ORDER BY sale_month;

SELECT MONTH(sale_date) AS months, 
       YEAR(sale_date) AS years, 
       AVG(total_sale) AS average_sale
FROM sales
WHERE YEAR(sale_date) = 2022
GROUP BY years, months
ORDER BY average_sale desc
LIMIT 0, 1000;



select * from sales
order by total_sale desc
limit 5;



#customer_id wise totalsale
select customer_id,sum(total_sale) as Total_sales from sales
group by customer_id
order by Total_sales desc
limit 5;


select count(distinct category)
from sales;

select customer_id
from sales
group by customer_id ;


#customer_id of every_customer who purchase every category
select customer_id
from sales
group by customer_id
having count(distinct category)=(select count(distinct category)
from sales);
#these both are same , but below one is mine buddhi
select customer_id,count(distinct category)
from sales
group by customer_id 
having count(distinct category)=3;
#counting the no. of rows
SELECT COUNT(*)
FROM (
    SELECT customer_id
    FROM sales
    GROUP BY customer_id
    HAVING COUNT(DISTINCT category) = 3
) AS subquery;



#extarcting the hours from table
select *
from sales;

select *, hour(sale_time) as hh
from sales;

#making the shift from hour time
SELECT *, 
       HOUR(sale_time) AS hh,
       CASE
           WHEN HOUR(sale_time) >= 6 AND HOUR(sale_time) < 14 THEN 'Morning'
           WHEN HOUR(sale_time) >= 14 AND HOUR(sale_time) < 18 THEN 'Afternoon'
           WHEN HOUR(sale_time) >= 18 AND HOUR(sale_time) < 24 THEN 'Evening'
           ELSE 'Night'
       END AS Shift_timings
FROM sales;


#creating a table from the previous one and counting the total_sale of shiftwise
WITH hourly_sale AS
(
    Select *, 
           HOUR(sale_time) AS hh,
           CASE
               WHEN HOUR(sale_time) >= 6 AND HOUR(sale_time) < 14 THEN 'Morning'
               WHEN HOUR(sale_time) >= 14 AND HOUR(sale_time) < 18 THEN 'Afternoon'
               WHEN HOUR(sale_time) >= 18 AND HOUR(sale_time) < 24 THEN 'Evening'
               ELSE 'Night'
           END AS Shift_timings
    from sales
)

Select Shift_timings, SUM(total_sale) AS total_sales
From hourly_sale
GROUP BY Shift_timings;


















