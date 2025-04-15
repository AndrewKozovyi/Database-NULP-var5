-------------3 LAB TRIGGER FOR ALL PERFORMERS--------------------
CREATE OR ALTER PROCEDURE calculate_salaries_for_all
    @p_date DATE
AS
BEGIN
    DECLARE @v_performer_id INT;

    DECLARE performer_cursor CURSOR FOR
    SELECT performer_id FROM Performer;

    OPEN performer_cursor;
    FETCH NEXT FROM performer_cursor INTO @v_performer_id;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        EXEC calculate_salary @v_performer_id, @p_date;
        FETCH NEXT FROM performer_cursor INTO @v_performer_id;
    END

    CLOSE performer_cursor;
    DEALLOCATE performer_cursor;
END;

EXEC calculate_salaries_for_all '2025-03-07';