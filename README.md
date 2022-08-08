# Pewlett-Hackard-Analysis

## Overview of the Analysis:

The purpose of this analysis is to prepare Pewlett-Hackard for the upcoming “Silver Tsunami”. I was asked to analyze the upcoming retirees. Pewlett-Hackard wants to know how many positions will they need to replace in the coming years and what are the opportunities for mentorship before the majority of senior staff retire.

### Background: 
I use QuickDBD to outline relationships between dataframes, this allowed a visual representation of how the primary and foreign key relationships interact with each other. I utilized PostgreSQL, an open-source relational database management system, and PgAdmin the open-source management tool for Postgres. Where I created, imported, and queried the data with several intermediate-level queries to answer important business questions for the company’s HR department.

### ERD
An Entity Relationship (ER) Diagram is a type of flowchart that illustrates how “entities” such as people, objects, or concepts relate to each other within a relational database system. 

<img width="400" alt="Screen Shot 2022-08-07 at 11 32 56 PM" src="https://user-images.githubusercontent.com/107026442/183354196-8f3c41fe-cbb7-4ac2-8210-8eedda39fcf7.png">

## Resources
Data Source:<br/>
csv files
#### Software:<br/>
PostreSQL<br/>
pgAdmin 4<br/>
Quick DBD<br/>

## Results:
Identified four key results from the analysis. 
1) Identify current employees that are eligible for retirement and the positions they have held while they have worked for Pewlett-Hackard.

There are 133,776 items populated for current employees and their positions. At a glance, the data shows multiple duplications of our primary key - 'emp_no'. ❗This is because the query contains all the information for all the positions someone has worked on over the years. A single person could have moved departments several times, this would cause duplication in our data. To resolve this we must ensure each primary key is unique and each employee holds only one job. 
	
![retirement_titles](https://user-images.githubusercontent.com/107026442/183354324-10af56b4-0052-4f00-b43f-aeaf4483b52d.png)
	

2) After identifying the current employees eligible for retirement, determine what are their current position. Ensuring that there is only one position per employee. 

 After duplication is removed 72,458 people will soon retire.
	
![unique_titles](https://user-images.githubusercontent.com/107026442/183354386-24236b73-9a4e-441b-8a35-b54d3fe136b7.png)

3) Determined the sum of retiring employees grouped by titles.

![retiring_titles](https://user-images.githubusercontent.com/107026442/183354427-883a0e48-934b-4125-8ab6-7d6acc40d25c.png)

4) Identified the employees eligible for participation in the mentorship program.

Of the 72,458 people retiring, only 1,549 are eligible to participate in mentorship. 

## Summary

As the company is preparing for the upcoming "silver tsunami" a good planning is essential, especially when such a large number of the employees is involved. I believe that additional break down per department will be beneficial for the company. In order to retrieve department name information, I merged additional table departments into existing table retirement_titles with the inner join. After removing the duplicates, with `DISTINCT ON` command, the table was ready to be used for further analysis queries.

### Additional Questions
1) How many roles will need to be filled as the "silver tsunami" begins to make an impact?
The total roles that will need to be filled are 72,458, but it's more meaningful to consider how many people will retire per title. 

	25916	Senior Engineer
	24926	Senior Staff
	9285	Engineer
	7636	Staff
	3603	Technique Leader
	1090	Assistant Engineer
	2		Manager

	Old Total: 72,458


2) Are there enough qualified, retirement-ready employees in the departments to mentor the next generation of Pewlett Hackard employees?

Before answering this question it's important to define what a "qualified" and "retirement-ready" employee may be. It could be assumed that a qualified professional is someone who holds a higher ranking title such as a Senior Engineer, Senior Staff, Technique Leader, and Manager. A person who is retirement ready is anyone born from January 1, 1955, to December 31, 1965.

I ran an addition query that returns only employees in higher positions, assuming that those are considered "qualified" as mentors. With the command WHERE `t3.title IN ('Senior Engineer', 'Senior Staff', 'Technique Leader', 'Manager')` the results include only staff in higher positions that will be retiring soon.

	25916	Senior Engineer
	24926	Senior Staff
	3603	Technique Leader
	2		Manager

New Total: 54,447
Pewlett Hackard will be losing 54,447 high-ranking positions and will need to be replaced with the coming "Silver Tsunami". Of the 54,447 high-ranking profressionals, 13,971 are "retirement-ready" and are eligible to mentor the next generation of PH employees. 

To get this metric, I ran an additional query where I limited the query to these parameters-
1. Only analyze employees that hold jobs as Senior Engineer, Senior Staff, Technique Leader, Manager
2. Only consider current employees
3. Only consider people born from January 1, 1955, to December 31, 1965

		SELECT DISTINCT ON(t1.emp_no) t1.emp_no, t1.title, t2.first_name, t2.last_name, t2.birth_date, t3.from_date, t3.to_date
		FROM qualified_roles t1
		JOIN employees t2
		ON t1.emp_no = t2.emp_no
		JOIN dept_emp t3
		ON t1.emp_no = t3.emp_no
		WHERE (t3.to_date = '9999-01-01') AND t2.birth_date BETWEEN '1955-01-01' AND '1965-12-31';
