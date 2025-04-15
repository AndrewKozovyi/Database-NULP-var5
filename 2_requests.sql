----------------------LAB 2 REQUESTS----------------------

--Get customers who are not related to any project--
SELECT p.project_id
FROM Project p
LEFT JOIN Customer c ON p.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

--Get employees who are not working on any project--
SELECT p.project_id
FROM Project p
LEFT JOIN Project_Perforemers pp ON p.project_id = pp.project_id
WHERE pp.project_id IS NULL;

--Get customers who are not related to the billing table--
SELECT cp.customer_bill_id
FROM Customer_Bill cp
LEFT JOIN Customer c ON cp.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

--Get all projects that are not related to any category--
SELECT p.project_id
FROM Project p
LEFT JOIN Difficulty_Category dc ON p.difficulty_category_id = dc.dificult_category_id
WHERE dc.dificult_category_id IS NULL;

--Get all employees who do not have a position--
SELECT pe.performer_id
FROM Performer pe
LEFT JOIN Position p ON pe.position_id = p.position_id
WHERE p.position_id IS NULL;

--Get all employees and their hourly rate--
SELECT p.name, q.hourly_rate
FROM Performer p
JOIN Qualification q ON p.qualification_id = q.qualification_id
WHERE p.position_id IN (SELECT position_id FROM Position WHERE hourly_rate_bonus > 1)
  AND p.qualification_id IN (SELECT qualification_id FROM Qualification WHERE hourly_rate >= 1)
ORDER BY q.hourly_rate DESC;

--Get project, its customer and total worked hours, where difficulty rate is above 1 and total hours is more than 10--
SELECT pr.name, c.name AS client_name, SUM(r.work_time) AS total_work_time
FROM Project pr
JOIN Customer c ON pr.customer_id = c.customer_id
JOIN Reports r ON pr.project_id = r.project_id
WHERE pr.difficulty_category_id IN (
    SELECT difficulty_category_id FROM Difficulty_Category WHERE dificulty_rate_bonus > 1
)
GROUP BY pr.project_id, c.name, pr.name
HAVING SUM(r.work_time) > 10
ORDER BY total_work_time DESC;

--Get project, its owner, and performers--
SELECT pr.name, c.name AS client_name, p.name AS performer_name
FROM Project pr
LEFT OUTER JOIN Project_Perforemers pe ON pr.project_id = pe.project_id
LEFT OUTER JOIN Performer p ON pe.performer_id = p.performer_id
JOIN Customer c ON pr.customer_id = c.customer_id;

--Get report ID, performer name, project name, and worked hours from report--
SELECT r.report_id, p.name AS performer_name, pr.name AS project_name, r.work_time
FROM Reports r
JOIN Performer p ON r.performer_id = p.performer_id
JOIN Project pr ON r.project_id = pr.project_id
WHERE r.date BETWEEN '2024-03-03' AND '2025-03-06'
  AND r.work_time > 5
  AND EXISTS (
    SELECT 1 FROM Qualification q WHERE p.qualification_id = q.qualification_id AND q.hourly_rate > 1.1
  );

--Get project name and total worked time on it--
SELECT pr.name, SUM(r.work_time) AS total_work_time
FROM Reports r
JOIN Project pr ON r.project_id = pr.project_id
GROUP BY pr.project_id, pr.name;

--Get category, project name, calculated current cost and total cost--
SELECT
    Difficulty_Category.name AS difficulty_category,
    Project.name AS project_name,
    COALESCE(SUM(Reports.work_time * (Qualification.hourly_rate * Position.hourly_rate_bonus) * 1.4), 0) AS total_project_cost,
    COALESCE(payments.total_paid, 0) AS total_paid
FROM Project
JOIN Difficulty_Category ON Project.difficulty_category_id = Difficulty_Category.dificult_category_id 
JOIN Reports ON Project.project_id = Reports.project_id
JOIN Performer ON Reports.performer_id = Performer.performer_id
JOIN Qualification ON Performer.qualification_id = Qualification.qualification_id
JOIN Position ON Performer.position_id = Position.position_id
LEFT JOIN (
    SELECT project_id,
           SUM(payment) AS total_paid
    FROM Customer_Bill
    WHERE paid = 1
      AND MONTH(date) = MONTH(GETDATE())
      AND YEAR(date) = YEAR(GETDATE())
    GROUP BY project_id
) AS payments
ON Project.project_id = payments.project_id
GROUP BY Difficulty_Category.name, Project.name, payments.total_paid
ORDER BY Difficulty_Category, total_project_cost DESC;

--Get employee's position, name, total worked hours and salary for the current month--
SELECT
    Position.name AS position_name,
    Performer.name AS performer_name,
    SUM(Reports.work_time) AS total_hours,
    SUM(Reports.work_time * (Qualification.hourly_rate * Position.hourly_rate_bonus)) AS salary
FROM Reports
JOIN Performer ON Reports.performer_id = Performer.performer_id
JOIN Position ON Performer.position_id = Position.position_id
JOIN Qualification ON Performer.qualification_id = Qualification.qualification_id
WHERE MONTH(date) = MONTH(GETDATE())
  AND YEAR(date) = YEAR(GETDATE())
GROUP BY Position.name, Performer.name
ORDER BY salary DESC;

--Get employee name, report date, description, worked time and cost of this report--
SELECT
    Performer.name AS performer_name,
    Reports.date,
    Reports.description,
    Reports.work_time,
    (Reports.work_time * (Qualification.hourly_rate * Position.hourly_rate_bonus)) AS cost
FROM Reports
JOIN Performer ON Reports.performer_id = Performer.performer_id
JOIN Position ON Performer.position_id = Position.position_id
JOIN Qualification ON Performer.qualification_id = Qualification.qualification_id
WHERE Reports.project_id = 1
  AND MONTH(date) = MONTH(GETDATE())
  AND YEAR(date) = YEAR(GETDATE())
ORDER BY Reports.date;

--Get clients who have already paid for the project--
SELECT
    Customer.name AS client_name,
    SUM(Customer_Bill.payment) AS total_paid
FROM Customer 
LEFT JOIN Customer_Bill ON Customer.customer_id = Customer_Bill.customer_id
WHERE Customer_Bill.paid = 1
GROUP BY Customer.name;

--Get employees and their worked hours--
SELECT
    perf.name AS performer_name,
    SUM(r.work_time) AS total_hours
FROM Reports r
JOIN Performer perf ON r.performer_id = perf.performer_id
GROUP BY perf.name
ORDER BY total_hours DESC;

--Get projects and the number of employees currently assigned to them--
SELECT
    p.name AS project_name,
    COUNT(DISTINCT pe.performer_id) AS total_executors
FROM Project p
LEFT JOIN Project_Perforemers pe ON p.project_id = pe.project_id
GROUP BY p.name
ORDER BY total_executors DESC;

--Delete all salary data--
DELETE FROM Salary;