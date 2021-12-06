select* 
from dbo.['2018$']

select*
from dbo.['2019$']

select *
from dbo.['2020$']

select*
from dbo.market_segment$

select*
from dbo.meal_cost$

--We need to be able to see all the data at one place. So lets perform a union.

select* 
from dbo.['2018$']
union
select*
from dbo.['2019$']
union
select *
from dbo.['2020$']

--Lets try to answer the first question. " Is our hotel's revenue growing?"
--So lets do some exploratory data analysis using sql.

;with hotels as ( 
select* from dbo.['2018$']
union
select* from dbo.['2019$']
union
select * from dbo.['2020$'])
select arrival_date_year, hotel,
round(sum((stays_in_weekend_nights+stays_in_week_nights)*adr),2) as 'revenue'
from hotels
group by arrival_date_year, hotel


--lets call the other two tables and join them with our CTE hotels table
select*
from dbo.market_segment$

select*
from dbo.meal_cost$


;with hotels as ( 
select* from dbo.['2018$']
union
select* from dbo.['2019$']
union
select * from dbo.['2020$'])
select * from hotels
left join dbo.market_segment$
on hotels.market_segment=market_segment$.market_segment
left join dbo.meal_cost$
on meal_cost$.meal = hotels.meal



--Now we dont have a revenue column. But what we have is adr and stays in weekend nights and stays in week nights
 --so lets find out total number of nights of stays by adding stays in weekend nights  and stays in week nights.
 --Step 1- 
 --(create CTE hotel for analysis)
-- ;with hotels as ( 
--select* from dbo.['2018$']
--union
--select* from dbo.['2019$']
--union
--select * from dbo.['2020$'])
--select *
--from hotels

--Step 2 (add two columns)

-- ;with hotels as ( 
--select* from dbo.['2018$']
--union
--select* from dbo.['2019$']
--union
--select * from dbo.['2020$'])
--select stays_in_weekend_nights+stays_in_week_nights
--from hotels

--step 3 multiply the addition with adr.

--;with hotels as ( 
--select* from dbo.['2018$']
--union
--select* from dbo.['2019$']
--union
--select * from dbo.['2020$'])
--select (stays_in_weekend_nights+stays_in_week_nights)*adr as 'revenue'
--from hotels

--step 4 compare the above value along with another column that mentions date.


--;with hotels as ( 
--select* from dbo.['2018$']
--union
--select* from dbo.['2019$']
--union
--select * from dbo.['2020$'])
--select arrival_date_year, 
--(stays_in_weekend_nights+stays_in_week_nights)*adr as 'revenue'
--from hotels

--step 5, group the values by year and then calculate the sum of revenue.

--;with hotels as ( 
--select* from dbo.['2018$']
--union
--select* from dbo.['2019$']
--union
--select * from dbo.['2020$'])
--select arrival_date_year, 
--sum((stays_in_weekend_nights+stays_in_week_nights)*adr) as 'revenue'
--from hotels
--group by arrival_date_year

--step 6, again group the value by hotel type

--;with hotels as ( 
--select* from dbo.['2018$']
--union
--select* from dbo.['2019$']
--union
--select * from dbo.['2020$'])
--select arrival_date_year, hotel,
--sum((stays_in_weekend_nights+stays_in_week_nights)*adr) as 'revenue'
--from hotels
--group by arrival_date_year, hotel

--step 7, then we round up the value. See the code above

--step 8
--lets call the other two tables and join them with our CTE hotels table

--;with hotels as ( 
--select* from dbo.['2018$']
--union
--select* from dbo.['2019$']
--union
--select * from dbo.['2020$'])
--select * from hotels
--left join dbo.market_segment$
--on hotels.market_segment=market_segment$.market_segment
--left join dbo.meal_cost$
--on meal_cost$.meal = hotels.meal
 
