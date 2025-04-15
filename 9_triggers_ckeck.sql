INSERT Reports(project_id, performer_id, date, description, work_time)
VALUES (1, 2, '2025-03-18', 'I BROKE THE ENTIRE PROJECT HI HI HIIIIIII', 3)

INSERT Project(name, customer_id, project_manager, duration, difficulty_category_id, start_time)
VALUES ('Test2', 2, 'unknown', 150, 4, '2024-09-12')

INSERT Customer_Bill(project_id, customer_id, payment, paid, date)
VALUES (5, 2, 900000.00, 0, '2024-09-12')

UPDATE Reports
SET work_time = 9
WHERE report_id = 7
