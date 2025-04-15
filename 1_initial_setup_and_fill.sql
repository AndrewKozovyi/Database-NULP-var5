----------------DB SETUP----------------
CREATE TABLE Position(
	position_id INT PRIMARY KEY IDENTITY(1,1),
	name NVARCHAR(255) NOT NULL,
	hourly_rate_bonus DECIMAL(5,2) NOT NULL
)

CREATE TABLE Qualification(
	qualification_id INT PRIMARY KEY IDENTITY(1,1),
	name NVARCHAR(255) NOT NULL,
	hourly_rate DECIMAL(6,2) NOT NULL
)

CREATE TABLE Customer(
	customer_id INT PRIMARY KEY IDENTITY(1,1),
	name NVARCHAR(255) NOT NULL
)

CREATE TABLE Difficulty_Category(
	dificult_category_id INT PRIMARY KEY IDENTITY(1,1),
	name NVARCHAR(255) NOT NULL,
	dificulty_rate_bonus DECIMAL(5,2) NOT NULL
)

CREATE TABLE Performer(
	performer_id INT PRIMARY KEY IDENTITY(1,1),
	name NVARCHAR(255) NOT NULL,
	position_id INT,
	qualification_id INT,
	FOREIGN KEY (position_id) REFERENCES Position(position_id),
	FOREIGN KEY (qualification_id) REFERENCES Qualification(qualification_id)
)

CREATE TABLE Salary(
	salary_id INT PRIMARY KEY IDENTITY(1,1),
	salary DECIMAL(8,2) NOT NULL,
	performer_id INT,
	FOREIGN KEY (performer_id) REFERENCES Performer(performer_id)
)

CREATE TABLE Project(
	project_id INT PRIMARY KEY IDENTITY(1,1),
	name NVARCHAR(255) NOT NULL,
	customer_id INT,
	project_manager NVARCHAR(255) NOT NULL,
	duration INT NOT NULL,
	difficulty_category_id INT,
	start_time DATETIME NOT NULL,
	FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
	FOREIGN KEY (difficulty_category_id) REFERENCES Difficulty_Category(dificult_category_id)
)	

CREATE TABLE Project_Perforemers(
	project_performer_id INT PRIMARY KEY IDENTITY(1,1),
	project_id INT,
	performer_id INT,
	FOREIGN KEY (project_id) REFERENCES Project(project_id),
	FOREIGN KEY (performer_id) REFERENCES Performer(performer_id)
)	

CREATE TABLE Customer_Bill(
	customer_bill_id INT PRIMARY KEY IDENTITY(1,1),
	project_id INT,
	customer_id INT,
	payment DECIMAL(9,2) NOT NULL,
	paid BIT NOT NULL,
	date DATETIME NOT NULL,
	FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
	FOREIGN KEY (project_id) REFERENCES Project(project_id)
)	

CREATE TABLE Reports(
	report_id INT PRIMARY KEY IDENTITY(1,1),
	project_id INT,
	performer_id INT,
	date DATETIME NOT NULL,
	description NVARCHAR(MAX) NOT NULL,
	work_time DECIMAL(4,2) NOT NULL,
	FOREIGN KEY (performer_id) REFERENCES Performer(performer_id),
	FOREIGN KEY (project_id) REFERENCES Project(project_id)
)	

ALTER TABLE Reports
ADD CONSTRAINT work_time CHECK (work_time >= 0 and work_time <=10)

ALTER TABLE Qualification
ADD CONSTRAINT hourly_rate CHECK (hourly_rate >= 0)

ALTER TABLE Customer_Bill
ADD CONSTRAINT chk_payment CHECK (payment >= 0);

ALTER TABLE Difficulty_Category
ADD CONSTRAINT dificulty_rate_bonus CHECK (dificulty_rate_bonus >= 0)

ALTER TABLE Difficulty_Category
ADD CONSTRAINT unique_name UNIQUE (name)

----------------DB FILL----------------
INSERT Position (name, hourly_rate_bonus)
VALUES ('business analyst', 1.25), ('project manager', 1.35), ('full stack', 1.4), ('designer', 1.15)

INSERT Qualification(name, hourly_rate)
VALUES ('junior', 1.05), ('middle', 1.08), ('senior', 1.10), ('team lead', 1.15)

INSERT Customer(name)
VALUES ('Iarynovskyi Dima'), ('Lesiak Roma'), ('Ali Beruf'), (' Muchamed Iroh')

INSERT Difficulty_Category(name, dificulty_rate_bonus)
VALUES ('Easy', 1.03), ('Medium', 1.06), ('DIfficult', 1.09), ('Extremely difficult', 1.12)

INSERT Performer(name, position_id, qualification_id)
VALUES ('Martynyshyn Vlad', 2, 2), ('Protsiv Taras', 3, 1), ('Puto Alina', 4, 3), ('Abedu Rahman ALi ', 1, 4)

INSERT Project(name, customer_id, project_manager, duration, difficulty_category_id, start_time)
VALUES ('QSport', 1, 'Ihor Toporynskiy', 150, 4, '2025-02-28'),
('Bordiurs Lviv', 2, 'MC Petia', 110, 3, '2025-03-03'),
('Gamblimg Site', 3, 'Juicy Slots', 30, 2, '2025-06-01'),
('Travel App', 4, 'Bueno Dio', 25, 1, '2026-01-01')

INSERT Project_Perforemers(performer_id, project_id)
VALUES (2, 1), (2, 2), (3, 1), (1, 1), (4, 2)

INSERT Customer_Bill(project_id, customer_id, payment, paid, date)
VALUES (1, 1, 900000.00, 1, '2025-02-28'),
(4, 4, 30000.00, 0, '2026-01-01'),
(2, 2, 130000.00, 0, '2025-03-03'),
(3, 3, 45000.00, 0, '2025-06-01')

INSERT Reports(project_id, performer_id, date, description, work_time)
VALUES (1, 1, '2025-03-05', 'It''s tough working on this project right now, as Taras merged everything into itself', 0.08),
(1, 2, '2025-03-05', 'mErGeD everything into itself, I WANT MORE MONEYYYYYYYYYY', 10),
(1, 3, '2025-03-05', 'I''ve created a design for a few pages', 8.5),
(1, 4, '2025-03-05', 'I am plesed that Taras broke everything not on my project', 6)