-------------3 LAB TRIGGER FOR ONE PERFORMER--------------------
CREATE OR ALTER PROCEDURE calculate_salary
    @p_performer_id INT,
    @p_date DATE
AS
BEGIN
    DECLARE @v_total_hours INT;
    DECLARE @v_salary NUMERIC(18,2);

    SELECT @v_total_hours = SUM(R.work_time)
    FROM Reports R
    WHERE R.performer_id = @p_performer_id
      AND YEAR(R.date) = YEAR(@p_date)
      AND MONTH(R.date) = MONTH(@p_date);

    IF @v_total_hours IS NOT NULL
    BEGIN
        SELECT @v_salary = SUM(R.work_time * (Q.hourly_rate * P.hourly_rate_bonus))
        FROM Reports R
        JOIN Performer Pf ON R.performer_id = Pf.performer_id
        JOIN Position P ON Pf.position_id = P.position_id
        JOIN Qualification Q ON Pf.qualification_id = Q.qualification_id
        WHERE R.performer_id = @p_performer_id
          AND YEAR(R.date) = YEAR(@p_date)
          AND MONTH(R.date) = MONTH(@p_date);

        IF EXISTS (
            SELECT 1 FROM Salary
            WHERE performer_id = @p_performer_id
              AND YEAR(date) = YEAR(@p_date)
              AND MONTH(date) = MONTH(@p_date)
        )
        BEGIN
            UPDATE Salary
            SET salary = @v_salary, date = @p_date
            WHERE performer_id = @p_performer_id
              AND YEAR(date) = YEAR(@p_date)
              AND MONTH(date) = MONTH(@p_date);
        END
        ELSE
        BEGIN
            INSERT INTO Salary (performer_id, salary, date)
            VALUES (@p_performer_id, @v_salary, @p_date);
        END
    END
    ELSE
    BEGIN
        PRINT 'No hours worked for performer ' + CAST(@p_performer_id AS NVARCHAR) + ' in ' + CAST(@p_date AS NVARCHAR);
    END
END;