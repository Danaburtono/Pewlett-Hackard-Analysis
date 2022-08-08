-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (______) _____,
______,
______,
______

INTO nameyourtable
FROM _______
WHERE _______
ORDER BY _____, _____ DESC;

--Joining employees table and titles table to make retirement_titles table
SELECT t1.emp_no, t1.first_name, t1.last_name, t2.title, t2.from_date, t2.to_date
INTO retirement_titles
FROM employees t1
JOIN titles t2
ON t1.emp_no = t2.emp_no
WHERE (t1.birth_date BETWEEN '1952-01-01' AND '1955-12-31');

--Filtering for people who are still with the company and named the table unique_titles
SELECT DISTINCT ON (emp_no) emp_no, first_name, last_name, title
INTO unique_titles 
FROM retirement_titles
WHERE to_date = '9999-01-01'
ORDER BY emp_no ASC, to_date DESC;

--Counting the people still with the company by job title
SELECT COUNT(emp_no) emp_no, title
INTO retiring_titles
FROM unique_titles
GROUP BY title 
ORDER BY emp_no DESC;

--Create a Mentorship Eligibility Table
SELECT DISTINCT ON(t1.emp_no) t1.emp_no, t1.first_name, t1.last_name, t1.birth_date, t2.from_date, t2.to_date, t3.title
INTO mentorship_eligibilty
FROM employees t1
JOIN dept_emp t2
ON t1.emp_no = t2.emp_no
JOIN titles t3
ON t1.emp_no = t3.emp_no
WHERE (t2.to_date = '9999-01-01') AND (t1.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY t1.emp_no ASC;


--Extra queries 

--Determine what is considered a "qualifed" position
SELECT COUNT(emp_no) emp_no, title
INTO qualified_roles
FROM unique_titles
WHERE title IN('Senior Engineer', 'Senior Staff', 'Technique Leader', 'Manager')
GROUP BY title 
ORDER BY emp_no DESC;

SELECT DISTINCT ON(t1.emp_no) t1.emp_no, t1.title, t2.first_name, t2.last_name, t2.birth_date, t3.from_date, t3.to_date
FROM qualified_roles t1
JOIN employees t2
ON t1.emp_no = t2.emp_no
JOIN dept_emp t3
ON t1.emp_no = t3.emp_no
WHERE (t3.to_date = '9999-01-01') AND t2.birth_date BETWEEN '1955-01-01' AND '1965-12-31';