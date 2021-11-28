--insert into EmployeeDemographics values
--(1001, 'Jim', 'Halpert', 30, 'male'),
--(1002, 'dwight','Schrute', 29, 'male'),
--(1003, 'mona', 'mahapa',30,'female'),
--(1004, 'chandan', 'baliya', 37, 'male'),
--(1005,'monisha', 'singh', 27, 'female'),
--(1006, 'suresh','sahoo', 25,'male'),
--(1007, 'Ramesh', 'patra', 42, 'male'),
--(1008, 'kurup', 'kurup', 31, 'male'),
--(1009, 'mass', 'akineni',52, 'male')


--insert into EmployeeSalary values
--(1001, 'Salesman', 60000),
--(1002, 'receptionist', 45000),
--(1003,	'researcher', 35000),
--(1004, 'manager', 80000),
--(1005, 'teacher', 75000),
--(1006, 'driver', 50000),
--(1007, 'driver', 50000),
--(1008, 'gangster', 300000),
--(1009, 'producer', 150000)

--create the third table

-- create table warehouseemployeedemographics
--  (
--  employeeID int,
--  firstname varchar(50),
--  lastname varchar(50),
--  age int,
--  gender varchar(50)
--  )

--    insert into warehouseemployeedemographics values
--(1010, 'michael','smith',32, 'male'),
--(1011, 'simona', 'baker',25, 'female'),
--(1012,	'drake', 'kyle',36, 'male'),
--(1013, 'manoj', 'mishra',31, 'male'),
--(1014, 'simon', 'sinek',42, 'male'),
--(1015, 'ragnar', 'ragnar',39, 'male'),
--(1016, 'thomas', 'cooper',51, 'male'),
--(1017, 'paul', 'james',35, 'male'),
--(1018, 'Avinash', 'pandey',27, 'male')

select FIRSTname, lastname
from EmployeeDemographics

--select top 5 of everything

select top 5 *
from EmployeeDemographics

select distinct (gender)
from EmployeeDemographics

select distinct (employeeid)
from EmployeeDemographics

select count(lastname) as last_name_count
from EmployeeDemographics

--find out the maximum, and minimum salary and age. We will do this by using the inner join function . Taking data from both tables; employee demographics and employee salary.
select max(salary) as maximum_salary, min(salary) as minimum_salary, 
max(age) as Maximum_age, min(age) as Minimum_age
from EmployeeDemographics
	inner join EmployeeSalary
	on EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID;

--findout the everage salary of all employees
select avg(salary) as average_salary_of_employees
from EmployeeSalary

 --lets join the two tables, employeedemographics and employeesalary and then order then by first name and last name

 select *
 from EmployeeDemographics	
	inner join employeeSalary
	on EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
	--order by FirstName
	order by lastName desc

--Lets see how to call a table if the database name is different above. Right now the data base name is SQL tutorial,
--If we change that to another database, while using the select function to call a table first mention the data base name and then the table name.

select *
from [SQL tutorial].dbo.EmployeeDemographics

select *
from [SQL tutorial].dbo.EmployeeSalary

-- time to learn the where statement
-- use the following commands =, <>, <, >, And, Or, Like, Null, NotNull, In 
-- the where statement help to limit the amount of data and specify what data you want in return
-- =, equal to, and != / <> is not equal to 
select*
from EmployeeDemographics
--where firstname <> 'chandan'
--where firstname = 'chandan'
--where age >= 30
--where age <= 35
--where age<=32 and Gender = 'male'
where age<=32 or Gender = 'male'

--use of like (find out every body whose last name started with 's'. % - is called wild card
 select*
from EmployeeDemographics
where LastName like('s%')
--%is called wild card
--where LastName like('%s')

--use of null
 select*
from EmployeeDemographics
where firstname is null

select*
from EmployeeDemographics
where firstname is not null

-- use of in
select*
from EmployeeDemographics
where firstname in ('jim', 'dwight', 'mona', 'chandan')

--use the group by and order by statements
select*
from EmployeeDemographics
order by LastName desc

select distinct (gender)
from EmployeeDemographics

select gender, count (gender) as gender_count
from EmployeeDemographics
group by gender
order by gender

select *
from EmployeeDemographics
order by  2 desc

--Lets start SQL Intermediate

--Joins
--select*
--from EmployeeDemographics

--select * 
-- from EmployeeSalary 


 select FirstName, LastName, JobTitle, Salary
from EmployeeDemographics
	inner join EmployeeSalary (-- join == inner join (default))
	on EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
	order by Salary desc
	-- other types of joins 
	--right outer join - all elelments in the right table link to the corresponding elelments in the left table,
	--left outer join - all elements in the left table link to the corresponding elements in the right table,
	--full outer join - All elelments in both tables joined based on a common column.

		 select *
from EmployeeDemographics
	inner join EmployeeSalary 
	on EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
		


	 select FirstName, LastName, JobTitle, Salary
from EmployeeDemographics
	right outer join EmployeeSalary 
	on EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
	where FirstName!='Ramesh'
	order by Salary desc

	 select jobtitle, count(jobtitle)
from EmployeeDemographics
	inner join EmployeeSalary 
	on EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
	group by JobTitle
	--where FirstName!='Ramesh'
	--order by Salary desc

	--calculate the average salary for salesmen and other jobtitles and order them and grouo them

	select jobtitle, AVG(Salary) as average_salary_of_all_salesmen
from EmployeeDemographics
	inner join EmployeeSalary 
	on EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
	--where JobTitle='salesman'
	group by JobTitle
	order by 2 
	--where FirstName!='Ramesh'
	--order by Salary desc
 
 
 --full outer join
 select *
from EmployeeDemographics
	full outer join warehouseemployeedemographics 
	on EmployeeDemographics.EmployeeID = warehouseemployeedemographics.EmployeeID
	

--Unions 
--(unions and joins are somehow similar in function. In case of joins we get the collumns, on which the join happen, repeated. 
--In case of joins no columns gets repeated. Union will aslo remove duplicate.
-- use 'union all' to include all duplicates
--Becareful when using a Union. The data and the data type you select must be the same for an error free union.

select employeeID, firstname, LastName
from EmployeeDemographics
union all
select* 
from warehouseemployeedemographics
  -----[The below code is a trial. To check union of three tables and the putput]
select employeeID, firstname
from EmployeeDemographics

union

select employeeID,jobtitle
from EmployeeSalary

union

select employeeID,firstname
from warehouseemployeedemographics

--------------------------------------------------

--Case statements

select* 
from EmployeeDemographics

select*
from EmployeeSalary

select *
from warehouseemployeedemographics


select firstname, lastname, age,
case  
	when age = 42 then 'special customer' --(if we put this condition any below it wont execute. Because in case statement conditions execute in order)
	when age>30 then 'old'                --(you can use many when statements as long as the conditions are met)
	
	when age between 27 and 30 then 'young' 
	
	else 'baby'
end as 'status'
from EmployeeDemographics
order by age desc

--Lets try a use case (salesmen get 10 % bonus, drivers get 8% bonus, and researchers get 6% bonus).

select FirstName, LastName, JobTitle, Salary,
case
	when jobtitle = 'salesman' then '10% bouns'
	when jobtitle = 'driver' then '8% bonus'
	when jobtitle = 'researcher' then '6% bonus'
	else '5% bonus'
end as 'bonus_status',
case
	when jobtitle = 'salesman' then salary*1.10
	when jobtitle = 'driver' then salary*1.08
	when jobtitle = 'researcher' then salary*1.06
	else salary*1.05
	end as salary_after_bonus
from EmployeeDemographics
	join EmployeeSalary
	on EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID


--having vs group by statements

select jobtitle, count(jobtitle)
from EmployeeDemographics
	join EmployeeSalary
	on EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
	--where count(jobtitle)>1  (--here the where command wont work. We can not use this aggregate function in a where statement)
	group by JobTitle
	having count(jobtitle)>1 --(so we need a having clause)
	

--updating/deleting data insert into - creates a new row in your table)
--updating alters the value in an existing row in your table.
--delete - specify what row you want to remove.

update EmployeeDemographics
set FirstName = 'monaa'
where
FirstName = 'mona' and LastName = 'mahapa'

--we can update multiple cells using the following command
--set FirstName = 'monaa', Age = 29, gender = 'male'
--instead of using the first name and last name as reference, I could have used the employeedID, which is unique in our data.

--Lets use the delete statement (to remove an entire row from our table)

		--delete from EmployeeDemographics
		--where EmployeeID = 'some data'
--Be very careful while using the delete statement. Once the data is gone, there is noway to get it back.
--A better way to use the delete statement is to isolate the data you want to delete using a select statement, then change the select statement to delete.
--using the selelct statement to delete is a good safeguard against accidental delete of data.


--partition by (repeat again)


select FirstName, LastName, Gender, Salary,count(gender) over (partition by gender) as total_gender
from EmployeeDemographics as edemo
join EmployeeSalary as esal
	on edemo.employeeID = esal.employeeID



--data types


--aliasing (temporarily changing the name of a column)

select FirstName
from EmployeeDemographics

select FirstName as F_name
from EmployeeDemographics

--or

select FirstName  F_name --(the use of as is not mandatory)
from EmployeeDemographics

select firstname + ' ' +lastname as fullname
from EmployeeDemographics

--or 

select avg(age) as averageage
from EmployeeDemographics

--aliasing for table name (can be useful when you have to do a lot of joins or when you are selelcting a lot of columns to perform your joins)
--aliasig improve the readabiity of your code and easy to refer back to your columns.

select edemo.firstname, edemo.lastname, esal.JobTitle, esal.Salary
from EmployeeDemographics as edemo
join EmployeeSalary as esal
on edemo.EmployeeID = esal.EmployeeID

--creating views

--GETDATE()
--Primary key vs foreign key


																				--SQL advanced concepts



--CTEs (common table expression) (we can query data of the CTE like a temp table)
--CTEs are not stored anywhere
with CTE_employee as 
	(select FirstName, LastName, Gender, Salary,count(gender) over (partition by gender) as total_gender
		from EmployeeDemographics as edemo
		join EmployeeSalary as esal
			on edemo.employeeID = esal.employeeID
	)
--select*
--from CTE_employee

select firstname,Salary
from CTE_employee


--Temp Tables (very useful and can be used many times. For CTEs you have to run the CTE code everytime you want to use it. But in Temp Table you can use the same table for many times.)

select*
from EmployeeDemographics


create table #temp_employee(
employee_ID int,
firstname varchar(50),
lastname varchar (50),
job_title Varchar(50),
salary int
)


select*
from #temp_employee

insert into #temp_employee values
('1001', 'HR', '45000'),
('1002', 'Sales', '52000')

delete 
from #temp_employee
where employee_ID = 1001


Drop table if exists #temp_employee2
create table #temp_employee2(
	first_name varchar (50),
	last_name int,
	job_title int,
	Salary int)

alter table #temp_employee2
	alter column job_title varchar(50)


select*
from #temp_employee2

--drop table #temp_employee2
--we can insert data into a temp table from two tables like this. We can also perform a join function

insert into #temp_employee2
select FirstName, LastName, JobTitle, Salary
from EmployeeDemographics
	inner join EmployeeSalary -- join == inner join (default))
	on EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
	

--SYS tables
--Subqueries

--String functions (Trim, LTRIM, RTRIM, Replace, Substring, Upper, Lower)
drop table if exists EmployeeErrors

create table EmployeeErrors (
EmployeeID varchar(50),
firstname varchar (50),
lastname varchar (50)
)

--there are errors in the below data. we have to clean them using the string functions. 
--Errors: spaces after and before employeeid, Jimbo should be Jim, T0by should be Toby, Halbert should be Halpert, take the extra part out from Flenderson - Fired.

insert into EmployeeErrors values
('1001   ','jimbo', 'halbert'),
('    1002','pamela','beasley'),
('1005', 'T0by', 'Flenderson - Fired')

select*
from EmployeeErrors

--use Ltrim, LTRIM, Trim(gets rid of blank spaces from front or back of the data)

select employeeID, trim(employeeid) as id_trim
from EmployeeErrors

select employeeID, ltrim(employeeid) as id_Ltrim
from EmployeeErrors

select employeeID, rtrim(employeeid) as id_Rtrim
from EmployeeErrors


--use replace (
select lastname, REPLACE(lastname, '- Fired', '') as lastname_fixed
from EmployeeErrors

--use substring

select firstname, SUBSTRING(firstname,1,3)
from EmployeeErrors

--we can also use substring like this. Here, because there is no common string values, so there is no output. However if we had two values such as Alex, and Alexander, we would have got an output.
select*
from EmployeeErrors
join EmployeeDemographics
--on EmployeeDemographics.EmployeeID = EmployeeErrors.EmployeeID
on substring(EmployeeDemographics.firstname,1,5) = SUBSTRING(EmployeeErrors.firstname,1,5)

--use upper and lower (convert characters in the text to upper case or lower case)

select firstname, upper(firstname), lastname, lower(lastname)
from EmployeeErrors
 

--Strored procedures (a group of sql statements that have been created and stored in that database for ease of use)
create procedure TEST
as
select*
from EmployeeDemographics

--how to use a stored procedure
exec TEST

--lets make it a little more complecated
--there are some errors in the below code
create procedure Temp_employee
as 
create table #temp_employee(
employee_ID int,
firstname varchar(50),
lastname varchar (50),
job_title Varchar(50),
salary int
)
insert into #temp_employee values
('1001', 'HR', '45000'),
('1002', 'Sales', '52000')

exec Temp_employee


--use sub queries (these are queries within a query)
--subqueries are used to return data that will be used in the main or outer query in relation to the data we want retreived.
-- we can use subqueries anywhere. in select, where, insert, update and delete statement.
--lets see how it works in select statements.
select *
from EmployeeDemographics

select EmployeeID,Age, (select avg(salary) from EmployeeSalary) as all_average_salary
from EmployeeDemographics

--ther are many other ways to use subqueries. Practice more to learn.


--regular expression
--Importing data from different file types / sources
--Exporting data to different file types 