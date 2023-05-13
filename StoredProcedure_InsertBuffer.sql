USE Database_Project;
GO

IF OBJECT_ID('spSurveyAreaBuffer') IS NOT NULL
	DROP PROCEDURE spSurveyAreaBuffer;
GO

CREATE PROCEDURE spSurveyAreaBuffer
	@BufferDistance decimal
AS 
BEGIN
	DECLARE @existing_polygon geometry
	DECLARE @Buffer geometry 
	
	IF EXISTS(SELECT TOP 1 Shape FROM survey_area_Copy)	
	BEGIN
		SET @existing_polygon = (SELECT TOP 1 Shape FROM survey_area_Copy)
		SET @Buffer = @existing_polygon.STBuffer(@BufferDistance) 

		INSERT INTO survey_area_Copy (Shape)
			VALUES (@Buffer)
	END
	ELSE
	BEGIN
		RAISERROR('No existing geometry in the dataset!', 11, 1)
	END
END;
GO

BEGIN TRY
	EXEC spSurveyAreaBuffer 1000
END TRY
BEGIN CATCH
	PRINT 'The buffer insert failed'
	PRINT 'Message: ' + ERROR_MESSAGE()
END CATCH