# Pewlett-Hackard-Analysis

## Overview of the analysis: Explain the purpose of this analysis.

The purpose of this analysis is to prepare Pewlett-Hackard for the upcoming “Silver Tsunami”. I was asked to conduct an analysis for the upcoming retirees. Pewlett-Hackard wants know how many positions will they need to replace in the coming years and what are the opprotunities for mentorship before the majority of senior staff retires.
The types of information the HR Department and Management needs is:


### Background: 
I use QuickDBD to outline relationships between dataframes, this allowed a visual representation of the how the primary and forgein key relationships interact with eachother. I utilized PostgreSQL, an open-source relational database management system and PgAdmin the open-source management tool for Postgres. Where I created, imported, and queried the data with several intermediate-level queries to answer important business questions for the company’s HR department.

### ERD
An Entity Relationship (ER) Diagram is a type of flowchart that illustrates how “entities” such as people, objects or concepts relate to each other within a relationsal database system. 


## Results: Provide a bulleted list with four major points from the two analysis deliverables. Use images as support where needed.

Identify current employees that are elligible for retirement and the positions they have held while they have worked for Pewlett-Hackard.

	There are 133,776 items populated for current employees and their positions. At-a-glace the data shows multiple duplications of our primary key - employee number. This is because the query contains all the information for all the positions someone has worked over the years. A single person could have move departments several times, this would cause duplication in our data. To resolve this we must ensure each primary key is unique and each employee holds only one job. 

After identifying of the current employees elligible for retirement, determining what are their current position. Ensuring that there is only one position per employee. 

	There are 72,458 people that will soon retire after duplication is removed.

Determine the sum of retiring employees grouped by titles.

	insert picture 

Identify the employees eligible for participation in the mentorship program.

	Of the 72,458 people retiring, only 1,549 are elligible to participate in mentorship. 

## Summary: Provide high-level responses to the following questions, then provide two additional queries or tables that may provide more insight into the upcoming "silver tsunami."

How many roles will need to be filled as the "silver tsunami" begins to make an impact?
	The total roles that will need to be filled is 72,458, but its more meaningful to consider how many people will retire per title. 

	25916	Senior Engineer
	24926	Senior Staff
	9285	Engineer
	7636	Staff
	3603	Technique Leader
	1090	Assistant Engineer
	2		Manager

	Old Total: 72,458


Are there enough qualified, retirement-ready employees in the departments to mentor the next generation of Pewlett Hackard employees?

Before answering this question its important to define what a "qualified" and "retirement-ready" employee may be. It could be assumed that a qualified profressional is someone who holds a higher ranking title such as a Senior Engineer, Senior Staff, Technique Leader, and Manager. A person who is retirement ready is anyone born from January 1, 1955 to December 31, 1965.

	I ran an addition query that returns only employees in higher positions, assuming that those are considered "qualified" as mentors. With the command WHERE ut.title IN ('Senior Engineer', 'Senior Staff', 'Technique Leader', 'Manager') the results include only staff on higher positions that will be retiring soon.

	25916	Senior Engineer
	24926	Senior Staff
	3603	Technique Leader
	2		Manager

	New Total: 54,447
	Pewlett Hackard will be loosing 54,447 high ranking positions and will need to be replaced with the coming "Silver Tsunami". Of the 54,447 high ranking profressionals 13,971 are "retirement-ready" and are elligible to mentor the next generation of PH employees. 

	In order to get this metric I ran an additional query where I limited the query to these parameters-
		1. Only analyze employees that hold jobs as Senior Engineer, Senior Staff, Technique Leader, Manager
		2. Only consider current employees
		3. Only consider people born from January 1, 1955 to December 31, 1965

				SELECT DISTINCT ON(t1.emp_no) t1.emp_no, t1.title, t2.first_name, t2.last_name, t2.birth_date, t3.from_date, t3.to_date
				FROM qualified_roles t1
				JOIN employees t2
				ON t1.emp_no = t2.emp_no
				JOIN dept_emp t3
				ON t1.emp_no = t3.emp_no
				WHERE (t3.to_date = '9999-01-01') AND t2.birth_date BETWEEN '1955-01-01' AND '1965-12-31';
