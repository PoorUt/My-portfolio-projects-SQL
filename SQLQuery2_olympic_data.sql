select*
from athlete_events$

select*
from noc_regions$

--Query 1 Fetch the top 5 athletes who have won the most gold medals

with t1 as
	(select Name, count(1) as total_medal
	from athlete_events$
	where Medal='Gold'
	group by Name
	),
t2 as
	(select*, dense_rank() over(order by total_medal desc) as rnk
	from t1)
select*
from t2
where rnk<=5

-- Query 2 list down total gold, silver, and bronze medal won by each country
--in this case we have to convert row level data to column level data. We can use a pivot table (pivot function) or crosstab(does the exact same thing).



select nr.region as country, Medal, count(1) as total_medals
				from athlete_events$ oh
				join
				noc_regions$ nr
				on oh.NOC=nr.NOC
				where Medal <> 'NA'
				group by nr.region, Medal
				order by nr.region, Medal
		
--crosstab function is a part of the extension function. so first call the function


