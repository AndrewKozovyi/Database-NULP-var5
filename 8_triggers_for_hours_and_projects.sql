GO
CREATE TRIGGER trigger_check_unpaid_projects
ON Project
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1 
        FROM inserted i
        JOIN Customer_Bill cp ON i.customer_id = cp.customer_id
        WHERE cp.paid = 0
          AND cp.date < DATEADD(MONTH, -3, GETDATE())
    )
    BEGIN
        RAISERROR ('Customer has unpaid projects for 3 months or more. New project can''t be added.', 16, 1);
        ROLLBACK TRANSACTION;
    END;
END;

GO
CREATE OR ALTER TRIGGER trigger_check_daily_work_hours
ON Reports
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1
        FROM inserted i
        CROSS APPLY (
            SELECT SUM(work_time) AS total_hours
            FROM Reports
            WHERE performer_id = i.performer_id AND CAST(date AS DATE) = CAST(i.date AS DATE)
        ) AS daily_hours
        WHERE daily_hours.total_hours > 10
    )
    BEGIN
        RAISERROR('Performer cannot work more than 10 hours per day.', 16, 1);
        ROLLBACK TRANSACTION;
    END;
END;