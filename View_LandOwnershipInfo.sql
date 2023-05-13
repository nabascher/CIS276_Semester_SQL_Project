USE Database_Project
GO

IF OBJECT_ID('vwOwnershipInfo') IS NOT NULL
DROP VIEW vwOwnershipInfo
GO

CREATE VIEW vwOwnershipInfo
AS
	SELECT LO_ID, lo.Shape, CATEGORY AS LandOwnershipCategory, DESC_ AS LandCoverDesc, 
		CAST(PERIMETER AS numeric(38, 2)) AS Perimeter, CAST(ACRES AS numeric(38, 2)) AS Acres, 
		CAST(HECTARES AS numeric(38, 2)) AS Hectares, CONCAT(section_na, ' ', quadrant) AS TRS_Label
	FROM survey_area sa, LandOwnership lo JOIN QuarterSections q
		ON lo.Shape.STIntersects(q.Shape) = 1
	WHERE lo.Shape.STDistance(sa.Shape) < 26400
	AND CATEGORY <> 'Private'
	AND ADMIN_TYPE IS NOT NULL

GO
SELECT * FROM vwOwnershipInfo;  