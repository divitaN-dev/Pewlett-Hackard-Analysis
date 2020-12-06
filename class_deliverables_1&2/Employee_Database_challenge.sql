---------------------------------
-- Retirement titles table script
---------------------------------
SELECT e.emp_no, e.first_name, e.last_name, ti.title, ti.from_date, ti.to_date
INTO retirement_titles
FROM employees AS e INNER JOIN titles as ti ON e.emp_no = ti.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no
----------------------------
-- Unique titles table script
----------------------------
SELECT DISTINCT ON
(rt.emp_no) rt.emp_no, rt.first_name, rt.last_name, rt.title
INTO unique_titles
FROM retirement_titles AS rt
ORDER BY rt.emp_no ASC, rt.to_date DESC;
------------------------------
-- Retiring titles table script
------------------------------
SELECT COUNT (ut.title), ut.title
INTO retiring_titles
FROM unique_titles AS ut
GROUP BY ut.title
ORDER BY COUNT(ut.title) DESC
SELECT *
FROM retiring_titles
------------------------------
-- mentorship_eligibility table script
------------------------------
SELECT DISTINCT ON
(e.emp_no) e.emp_no, e.first_name, e.last_name, e.birth_date, de.from_date, de.to_date, ti.title
INTO mentorship_eligibility
FROM employees AS e
INNER JOIN dept_employees AS de ON
(e.emp_no = de.emp_no)
INNER JOIN titles AS ti ON
(e.emp_no = ti.emp_no)
WHERE
(de.to_date = '9999-01-01')
AND
(e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no ASC