GO
CREATE TRIGGER project_tracking_trigger
ON Project
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Project
    SET 
        UCR = COALESCE(i.UCR, SUSER_NAME()),
        DCR = COALESCE(i.DCR, GETDATE()),
        ULC = SUSER_NAME(),
        DLC = GETDATE()
    FROM Project p
    INNER JOIN inserted i ON p.project_id = i.project_id;
END;

GO
CREATE TRIGGER customer_tracking_trigger
ON Customer
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Customer
    SET 
        UCR = COALESCE(i.UCR, SUSER_NAME()),
        DCR = COALESCE(i.DCR, GETDATE()),
        ULC = SUSER_NAME(),
        DLC = GETDATE()
    FROM Customer c
    INNER JOIN inserted i ON c.customer_id = i.customer_id;
END;

GO
CREATE TRIGGER performer_tracking_trigger
ON Performer
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Performer
    SET 
        UCR = COALESCE(i.UCR, SUSER_NAME()),
        DCR = COALESCE(i.DCR, GETDATE()),
        ULC = SUSER_NAME(),
        DLC = GETDATE()
    FROM Performer p
    INNER JOIN inserted i ON p.performer_id = i.performer_id;
END;

GO
CREATE TRIGGER project_performers_tracking_trigger
ON Project_Perforemers
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Project_Perforemers
    SET 
        UCR = COALESCE(i.UCR, SUSER_NAME()),
        DCR = COALESCE(i.DCR, GETDATE()),
        ULC = SUSER_NAME(),
        DLC = GETDATE()
    FROM Project_Perforemers pp
    INNER JOIN inserted i ON pp.project_performer_id = i.project_performer_id;
END;

GO
CREATE TRIGGER customer_bill_tracking_trigger
ON Customer_Bill
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Customer_Bill
    SET 
        UCR = COALESCE(i.UCR, SUSER_NAME()),
        DCR = COALESCE(i.DCR, GETDATE()),
        ULC = SUSER_NAME(),
        DLC = GETDATE()
    FROM Customer_Bill cb
    INNER JOIN inserted i ON cb.customer_bill_id = i.customer_bill_id;
END;

GO
CREATE TRIGGER difficulty_category_tracking_trigger
ON Difficulty_Category
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Difficulty_Category
    SET 
        UCR = COALESCE(i.UCR, SUSER_NAME()),
        DCR = COALESCE(i.DCR, GETDATE()),
        ULC = SUSER_NAME(),
        DLC = GETDATE()
    FROM Difficulty_Category dc
    INNER JOIN inserted i ON dc.dificult_category_id = i.dificult_category_id;
END;

GO
CREATE TRIGGER position_tracking_trigger
ON Position
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Position
    SET 
        UCR = COALESCE(i.UCR, SUSER_NAME()),
        DCR = COALESCE(i.DCR, GETDATE()),
        ULC = SUSER_NAME(),
        DLC = GETDATE()
    FROM Position p
    INNER JOIN inserted i ON p.position_id = i.position_id;
END;

GO
CREATE TRIGGER qualification_tracking_trigger
ON Qualification
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Qualification
    SET 
        UCR = COALESCE(i.UCR, SUSER_NAME()),
        DCR = COALESCE(i.DCR, GETDATE()),
        ULC = SUSER_NAME(),
        DLC = GETDATE()
    FROM Qualification q
    INNER JOIN inserted i ON q.qualification_id = i.qualification_id;
END;

GO
CREATE TRIGGER reports_tracking_trigger
ON Reports
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Reports
    SET 
        UCR = COALESCE(i.UCR, SUSER_NAME()),
        DCR = COALESCE(i.DCR, GETDATE()),
        ULC = SUSER_NAME(),
        DLC = GETDATE()
    FROM Reports r
    INNER JOIN inserted i ON r.report_id = i.report_id;
END;

GOCREATE TRIGGER salary_tracking_trigger
ON Salary
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Salary
    SET 
        UCR = COALESCE(i.UCR, SUSER_NAME()),
        DCR = COALESCE(i.DCR, GETDATE()),
        ULC = SUSER_NAME(),
        DLC = GETDATE()
    FROM Salary s
    INNER JOIN inserted i ON s.salary_id = i.salary_id;
END;
