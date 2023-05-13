USE Database_Project
GO

IF OBJECT_ID('vwParcelSubset') IS NOT NULL
DROP VIEW vwParcelSubset
GO

CREATE VIEW vwParcelSubset
AS
SELECT name AS SubdivisionName, Parcel_ID, p.Shape, APN, 
	Floor, Area, StreetNumb AS StreetNum, StreetDir AS StreetDirection, StreetName, StreetType,
	StPostDir, UnitNumber, City, ZipCode, (SELECT AVG(Area)
											FROM Parcels p, survey_area sa
											WHERE p.Shape.STDistance(sa.Shape) < 2640) AS AVGParcelArea_ft
FROM survey_area sa, parcels p JOIN subdivisions s
	ON p.Shape.STWithin(s.Shape) = 1
WHERE p.Shape.STDistance(sa.Shape) < 2640;

GO 
SELECT * FROM vwParcelSubset; 