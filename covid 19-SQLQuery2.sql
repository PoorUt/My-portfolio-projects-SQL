
select*
from [Portfolio project]..[covid deaths] 

select*
from [Portfolio project]..[covid vaccination]

--global numbers
select date, sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_deaths, sum(cast(new_deaths as int))/sum(new_cases)*100 as DeathPercentage
from [Portfolio project]..[covid deaths]
where continent is not null
group by date
order by 1,2

--Lets join the two tables
--looking at total population vs vaccination

select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
,sum(convert(int,vac.new_vaccinations)) over(partition by dea.location order by dea.location, dea.date) as rollingpeoplevaccinated
from [Portfolio project]..[covid deaths] dea
join [Portfolio project]..[covid vaccination] vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
order by 2,3

--use CTE

with PopvsVac (Continent, Location, Date, Population, new_vaccinations, RollingPeoplevaccinated)
as 
(
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
,sum(convert(int,vac.new_vaccinations)) over(partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
from [Portfolio project]..[covid deaths] dea
join [Portfolio project]..[covid vaccination] vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
--order by 2,3
)
select*, (RollingPeoplevaccinated/Population)*100
from PopvsVac


--Temp Table


Drop Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location varchar(255),
Date datetime,
Population numeric,
New_Vaccinations numeric,
RollingPeopleVaccinated numeric
)

insert into #PercentPopulationVaccinated
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
,sum(convert(int,vac.new_vaccinations)) over(partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
from [Portfolio project]..[covid deaths] dea
join [Portfolio project]..[covid vaccination] vac
	on dea.location = vac.location
	and dea.date = vac.date
--where dea.continent is not null
--order by 2,3
select*, (RollingPeoplevaccinated/Population)*100
from #PercentPopulationVaccinated
 

 --Creating view to store date  for later visualizations

 Create View PercentPopulationVaccinated
 Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
,sum(convert(int,vac.new_vaccinations)) over(partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
from [Portfolio project]..[covid deaths] dea
join [Portfolio project]..[covid vaccination] vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
--order by 2,3