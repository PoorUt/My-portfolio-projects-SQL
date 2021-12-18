select *
from athlete_events$

select*
from noc_regions$

--Query 1 (how many olympic games have been held)

select count(distinct Games)
from athlete_events$

-- Query 2 (list down all olympic games held so far)

select distinct(year), Season
from athlete_events$
order by Year

--Query 3 (Mention the total no of nations participated in each olympics game?)
select distinct(Team), Year, Season
from athlete_events$
--where Team = 'India' (this query is to find out the participation of a single country)
order by Team

--Query 4 (Which year saw the highest and lowest no of countries participating in olympics?)
select *
from athlete_events$


select Year, count(distinct(Team)) as 'number of countries partipated'
from athlete_events$
group by year
order by 'number of countries partipated' asc

--select count(distinct (team)) (This is the query to find out the number of participating countries in a particular year)
--from athlete_events$
--where year=1896

--Query 5 (Which nation has participated in all of the olympic games?) start from this
   --number of olympics held is 51 times
 --- now we need to find which country participated 51 times? for this we have to find out number of times of NOC occurences and group them
 select *
from athlete_events$

select*
from noc_regions$
drop table if exists tot_games

with tot_games as
	(select count(distinct(games)) as total_games
	from athlete_events$),
countries as
	(select Games,noc_regions$.region as 'country'
	from athlete_events$
	join
	noc_regions$
	on athlete_events$.NOC = noc_regions$.NOC
	group by Games, noc_regions$.region),
countries_participated as
	(select country, count(1) as total_participated_games
              from countries
              group by country)
 select cp.*
      from countries_participated cp
      join tot_games tg on tg.total_games = cp.total_participated_games
      order by 1;
-------------------------------------
with all_games as (
select count(distinct(games)) as total_games
	from athlete_events$),

nations as(
select Games,noc_regions$.region as 'country'
	from athlete_events$ join noc_regions$
	on athlete_events$.NOC = noc_regions$.NOC
	group by Games, noc_regions$.region),

count_nations as(

select country, count(1) as total_games_participated
	from nations
	group by country)

select *
	from count_nations
	join all_games
	on all_games.total_games=count_nations.total_games_participated
	order by 1


--Query 6 (Identify the sport which was played in all summer olympics)
	--find total number of summer olympic games
    --find for each sport, how many games(1), where they played in (2)
	--compare 1 & 2
drop table if exists t1

with t1 as
	(select count(distinct Games) as total_summer_games
	from athlete_events$
	where season = 'summer'),
t2 as
	(Select distinct(sport), games
	from athlete_events$
	where season = 'summer'),
	--order by Games),
t3 as
	(select sport, count(games) as no_of_games
	 from t2
	 group by sport)
select*
 from t3
 order by 2 desc;
  
--query 7 (Which Sports were just played only once in the olympics?)

select *
from athlete_events$

select*
from noc_regions$

select distinct (Games)
from athlete_events$
 drop table if exists t1


with t1 as (
	select distinct games, sport
	from athlete_events$
	),
t2 as
    (select sport, count(1) as no_of_games
     from t1
    group by sport)
select t2.*, t1.games
from t2 join t1 on t1.Sport=t2.Sport
where t2.no_of_games = 1
order by t1.Sport

--select sport, count(sport) as 'number of times played'
--from athlete_events$
--group by Sport
--order by Sport

--Query 8 (Fetch the total no of sports played in each olympic games.


select *
from athlete_events$

drop table if exists t1
drop table if exists t2

--with t1 as (
--	select distinct(Games), Sport
--	from athlete_events$
--	)
--select  sport, count(1) as total_no_of_times_played
--from t1
--group by sport
--order by 2
with t1 as(
select distinct(games), sport
from athlete_events$),
t2 as 
(select games, count(1) as no_of_sports
from t1
group by Games)

select *
from t2
order by no_of_sports desc;

---query 9 (Fetch oldest athletes to win a gold medal)

select name, age, Medal
from athlete_events$
where Medal='Gold' and age=64
order by Age desc

--query 10  Find the Ratio of male and female athletes participated in all olympic games.
drop table if exists t1
drop table if exists t2

with t1 as(
select Sex, count(1) as cnt
from athlete_events$
group by Sex),

t2 as

(select *, row_number() over(order by cnt) as rn
        	 from t1),
min_cnt as
        	(select cnt from t2	where rn = 1),
        max_cnt as
        	(select cnt from t2	where rn = 2)
    select concat('1 : ', round(max_cnt.cnt::decimal/min_cnt.cnt, 2)) as ratio
    from min_cnt, max_cnt;


	--Query 11- Fetch the top 5 athletes who have won the most gold medals.
select *
from athlete_events$


select distinct(Name) as 'NME', count(Medal) as no_of_medals
from athlete_events$
Where Medal = 'Gold'
group by Name
order by no_of_medals desc

--Query 12 Fetch the top 5 athletes who have won the most medals (gold/silver/bronze).

select *
from athlete_events$


select Distinct(Name), count(Medal) as Total_medals_won
from athlete_events$
where medal = 'Gold' or Medal = 'Silver' or Medal = 'Bronze'
Group by Name
order by Total_medals_won desc
--Limit 5

--Query 13 Fetch the top 5 most successful countries in olympics. Success is defined by no of medals won.
select  athlete_events$.NOC, region, count(Medal) as no_of_medals_per_country
from athlete_events$
join noc_regions$ on athlete_events$.NOC=noc_regions$.NOC
where medal = 'Gold' or Medal = 'Silver' or Medal = 'Bronze' 
group by athlete_events$.NOC, noc_regions$.region
order by no_of_medals_per_country desc

--Query 14 List down total gold, silver and bronze medals won by each country.

select *
from athlete_events$

select*
from noc_regions$
--first join and see
select *
from athlete_events$
join noc_regions$ on athlete_events$.NOC=noc_regions$.NOC
where medal = 'Gold' or Medal = 'Silver' or Medal = 'Bronze' 

with 
tot_gold as (
select athlete_events$.NOC, region, count(medal) as total_gold
from athlete_events$
join noc_regions$ on athlete_events$.NOC=noc_regions$.NOC
where medal = 'Gold' 
group by athlete_events$.NOC, region),

tot_silver as(
select athlete_events$.NOC, region, count(medal) as total_silver
from athlete_events$
join noc_regions$ on athlete_events$.NOC=noc_regions$.NOC
where Medal = 'Silver'
group by athlete_events$.NOC, region),

tot_bronze as(
select athlete_events$.NOC, region, count(medal) as total_bronze
from athlete_events$
join noc_regions$ on athlete_events$.NOC=noc_regions$.NOC
where Medal = 'Bronze' 
group by athlete_events$.NOC, region)

select tot_gold.NOC, tot_gold.region, total_gold, total_silver, total_bronze
from tot_gold
join	tot_silver on tot_gold.NOC=tot_silver.NOC
join 	tot_bronze on tot_gold.NOC=tot_bronze.NOC
order by total_gold desc

--List down total gold, silver and bronze medals won by each country corresponding to each olympic games.

select *
from athlete_events$

select*
from noc_regions$

select *
from athlete_events$
join noc_regions$ on athlete_events$.NOC=noc_regions$.NOC

with tot_1 as(
select games, region, noc_regions$.NOC, count(Medal) as gold
from athlete_events$
join noc_regions$ on athlete_events$.NOC=noc_regions$.NOC
where Medal='Gold'
Group by Games, region, noc_regions$.NOC
--order by region, Games
),

tot_2 as (

select games, region, noc_regions$.NOC, count(Medal) as silver
from athlete_events$
join noc_regions$ on athlete_events$.NOC=noc_regions$.NOC
where Medal = 'Silver'
Group by Games, region, noc_regions$.NOC
),

tot_3 as (

select games, region, noc_regions$.NOC, count(Medal) as bronze
from athlete_events$
join noc_regions$ on athlete_events$.NOC=noc_regions$.NOC
where Medal = 'Bronze'
Group by Games, region, noc_regions$.NOC
)

select *
from tot_1
join tot_2 on tot_1.Games = tot_2.Games
join tot_3 on tot_1.Games = tot_3.Games
order by tot_1.Games, tot_1.region


