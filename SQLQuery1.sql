select *
from [Portfolio project]..['covid deaths$']
order by 3,4

--select *
--from [Portfolio project]..['covid vaccination$']
--order by 3,4

--select the data that we are going to use


select Location, Date, total_cases, new_cases, total_deaths, population
from [Portfolio project]..['covid deaths$']
order by 1,2

--We are goin to be looking at the total cases vs the total deaths
-- shows the likelihood of death if you have covid in india

select Location, Date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
from [Portfolio project]..['covid deaths$']
where location = 'India'
order by 1,2

--Looking at the total cases vs population
--this part shows what percentage of the population is affected on that date

select Location, Date, population, total_cases,  (total_cases/population)*100 as TotalCasePercentage
from [Portfolio project]..['covid deaths$']
--where location ='India'
order by 1,2 

--Lets see which country have the highest total case percentage/ highest percapita cases
-- this can be done by dividing total cases by population
--since we have that calculated, we need simply need to arrange the total case percentage in descending order

select Location, Date, population, total_cases,  (total_cases/population)*100 as TotalCasePercentage
from [Portfolio project]..['covid deaths$']
order by TotalCasePercentage desc

--Lets see the highest infection count per country and see if we can arrange it

select Location, population, max(total_cases)as 'Highest infection count', max((total_cases/population))*100 as 'percentage of population infected'
from [Portfolio project]..['covid deaths$']
Group by Location, population
order by [percentage of population infected] desc

--Lets see the highest infection ever in any country

select Location, population, max(total_cases)as 'Highest infection count', max((total_cases/population))*100 as 'percentage of population infected'
from [Portfolio project]..['covid deaths$']
Group by Location, population
order by [Highest infection count] desc

--Lets see the infection rate in India or United states
select Location, population, max(total_cases)as 'Highest infection count', max((total_cases/population))*100 as 'percentage of population infected'
from [Portfolio project]..['covid deaths$']
where Location = 'India' or Location = 'United states'
Group by Location, population

--Lets see countries with highest death count per population

select Location, max (cast(total_deaths as int)) as Totaldeathcount, max((total_deaths/population))*100 as 'Percentage of death in population', 
max((total_deaths/total_cases))*100 as 'Percentage of death per number of cases'
from [Portfolio project]..['covid deaths$']
group by Location
order by Totaldeathcount desc

--now we see that world, north america  or Asia are not country. The problem lies in the data set. Where continent = Null The location = continent name
-- To rectify this error use where continent is not null

select Location, max (cast(total_deaths as int)) as Totaldeathcount, max((total_deaths/population))*100 as 'Percentage of death in population', 
max((total_deaths/total_cases))*100 as 'Percentage of death per number of cases'
from [Portfolio project]..['covid deaths$']
where continent is not null
group by Location
order by Totaldeathcount desc


-- LET'S break things down by CONTINENT, Showing the continents with the exact death counts

select continent, max (cast(total_deaths as int)) as Totaldeathcount, max((total_deaths/population))*100 as 'Percentage of death in population', 
max((total_deaths/total_cases))*100 as 'Percentage of death per number of cases'
from [Portfolio project]..['covid deaths$']
where continent is not null
group by continent
order by Totaldeathcount desc

--showing the continet with the highest death count

select continent, max(total_cases)as 'max total case',  max(cast (total_deaths as int)) as 'max total death'
from [Portfolio project]..['covid deaths$']
where continent is not null
group by continent
order by 1,2

--global numbers 
select date , SUM(new_cases) as total_cases, SUM (Cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)* 100 as deathpercentage
from [Portfolio project]..['covid deaths$']
where continent is not null
group by date
order by 1,2

--Lets join two tables on location and date looking at total populaion and vaccination	
select *
from [Portfolio project]..['covid deaths$']
join [Portfolio project]..['covid vaccination$']
	on ['covid deaths$'].location = ['covid vaccination$'].location
	and ['covid deaths$'].date = ['covid vaccination$'].date

--looking at total population vs vaccination ordered by date 

 select ['covid deaths$'].continent, ['covid deaths$'].location, ['covid deaths$'].date, ['covid deaths$'].population,isnull(['covid vaccination$'].new_vaccinations,0) as new_vaccinations

 From [Portfolio project]..['covid deaths$']
join [Portfolio project]..['covid vaccination$']
	on ['covid deaths$'].location = ['covid vaccination$'].location
	and ['covid deaths$'].date = ['covid vaccination$'].date
where ['covid deaths$'].continent is not null
order by 1,2,3






-- join specific columns from the two tables on location and date.	(there is an error in this part regardin the null values)		
--select ['covid deaths$'].continent, ['covid deaths$'].location, ['covid deaths$'].date, ['covid deaths$'].population, 
--isnull(['covid vaccination$'].new_vaccinations,0),isnull(sum(convert(int,['covid vaccination$'].new_vaccinations )),0) 
----OVER (partition by ['covid deaths$'].location order by ['covid deaths$'].location, ['covid deaths$'].date) 
----as 'Rolling people vaccinated',(Rolling people vaccinated/population)*100
----sum(cast(['covid vaccination$'].new_vaccinations as int)) OVER (partition by ['covid deaths$'].location)
--From [Portfolio project]..['covid deaths$']
--join [Portfolio project]..['covid vaccination$']
--	on ['covid deaths$'].location = ['covid vaccination$'].location
--	and ['covid deaths$'].date = ['covid vaccination$'].date
--	--where ['covid deaths$'].continent is not null 
--	--where ['covid vaccination$'].new_vaccinations is not null
--	order by 2,3


--Use CTE
--with popvsvac (continent, location, date, population, new_vaccinations, RollingPeopleVaccinated)
--as
--(
--select ['covid deaths$'].continent, ['covid deaths$'].location, ['covid deaths$'].date, ['covid deaths$'].population, 
--['covid vaccination$'].new_vaccinations,
--sum(convert(int,['covid vaccination$'].new_vaccinations )) OVER (partition by ['covid deaths$'].location order by ['covid deaths$'].location, ['covid deaths$'].date) 
----as 'Rolling people vaccinated',(Rolling people vaccinated/population)*100
----sum(cast(['covid vaccination$'].new_vaccinations as int)) OVER (partition by ['covid deaths$'].location)
--From [Portfolio project]..['covid deaths$']
--join [Portfolio project]..['covid vaccination$']
--	on ['covid deaths$'].location = ['covid vaccination$'].location
--	and ['covid deaths$'].date = ['covid vaccination$'].date
--where ['covid deaths$'].continent is not null 
--	--where ['covid vaccination$'].new_vaccinations is not null
)





