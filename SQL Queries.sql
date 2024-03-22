select * from hr_1;
select * from 
hr_2;

# 1. Average Attrition rate for all Departments


select a.Department, concat(format(avg(a.attrition_y)*100,2),'%') as Attrition_Rate
from  
( select department,attrition,
case when attrition='Yes'
then 1
Else 0
End as attrition_y from hr_1 ) as a
group by a.department;

# 2. Average Hourly rate of Male Research Scientist

select JobRole, format(avg(hourlyrate),2) as Average_HourlyRate,Gender
from hr_1
where upper(jobrole)= 'RESEARCH SCIENTIST' and upper(gender)='MALE'
group by jobrole,gender;

# 3. Attrition rate Vs Monthly income stats

alter table hr_2 change column `Employee ID` EmployeeId varchar(255) NOT NULL;

select a.department, concat(format(avg(a.attrition_rate)*100,2),'%') as Average_attrition,format(avg(b.monthlyincome),2) as Average_Monthly_Income
from ( select department,attrition,employeenumber,
case when attrition = 'yes' then 1
else 0
end as attrition_rate from hr_1) as a
inner join hr_2 as b on b.employeeid = a.employeenumber
group by a.department;

# 4. Average working years for each Department

select a.department, format(avg(b.TotalWorkingYears),1) as Average_Working_Year
from hr_1 as a
inner join hr_2 as b on b.EmployeeID=a.EmployeeNumber
group by a.department;


# 5. Job Role Vs Work life balanc

select a.JobRole,concat(format(avg(a.attrition_rate)*100,2),'%') as Average_Attrition_Rate,
format(avg(b.YearsSinceLastPromotion),2) as Average_YearsSinceLastPromotion
from ( select JobRole,attrition,employeenumber,
case when attrition = 'yes' then 1
else 0
end as attrition_rate from hr_1) as a
inner join hr_2 as b on b.employeeid = a.employeenumber
group by a.JobRole;

# 6. Attrition rate Vs Year since last promotion relation

select a.JobRole,
sum(case when performancerating = 1 then 1 else 0 end) as Total_PerformanceRating1,
sum(case when performancerating = 2 then 1 else 0 end) as Total_PerformanceRating2,
sum(case when performancerating = 3 then 1 else 0 end) as Total_PerformanceRating3,
sum(case when performancerating = 4 then 1 else 0 end) as Total_PerformanceRating4, 
count(b.performancerating) as Total_Employee, format(avg(b.WorkLifeBalance),2) as Average_WorkLifeBalance_Rating
from hr_1 as a
inner join hr_2 as b on b.EmployeeID = a.Employeenumber
group by a.jobrole;
