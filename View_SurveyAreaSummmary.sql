USE Database_Project
GO

IF OBJECT_ID('vwSurveyAreaSummary') IS NOT NULL
DROP VIEW vwSurveyAreaSummary
GO

CREATE VIEW vwSurveyAreaSummary
AS 
	SELECT SD_ID, q.Shape, name AS SubdivisionName, qs_num AS QuarterSectionNumber, 
		section_na AS SectionName, quadrant, srid, auth_name, srtext AS SpatialReferenceInfo
	FROM survey_area sa, QuarterSections q, subdivisions s, spatial_ref_sys
	WHERE srid IN 
		(SELECT sa.Shape.STSrid
		FROM survey_area sa)
	AND sa.Shape.STIntersects(s.Shape) = 1
	AND sa.Shape.STIntersects(q.Shape) = 1;

GO
SELECT * FROM vwSurveyAreaSummary;  