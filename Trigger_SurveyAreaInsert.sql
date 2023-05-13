USE Database_Project
GO

IF OBJECT_ID('survey_area_Copy') IS NOT NULL
	DROP TABLE survey_area_Copy
GO

SELECT * INTO survey_area_Copy FROM survey_area

IF OBJECT_ID('Survey_Area_INSERT') IS NOT NULL
	DROP TRIGGER Survey_Area_INSERT
GO

CREATE TRIGGER Survey_Area_INSERT
	ON survey_area_Copy
	AFTER INSERT
AS
	BEGIN
		IF EXISTS (SELECT * 
					FROM inserted
					WHERE Shape.STIsEmpty() = 1
					) 
			BEGIN
				RAISERROR('Geometry is empty!', 16, 1)
				ROLLBACK TRAN 
			END
	END