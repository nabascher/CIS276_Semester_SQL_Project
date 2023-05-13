USE Database_Project
GO

IF OBJECT_ID('vwStreetsStats') IS NOT NULL
DROP VIEW vwStreetsStats
GO

CREATE VIEW vwStreetsStats
AS
	SELECT 
		street_nam AS StreetName, status, road_type AS RoadType, traffic_fl AS TrafficFlow, jurisdicti AS Jurisdiction, 
		AVG(sc.Shape.STLength()) AS AvgStreetLength, MAX(sc.Shape.STLength()) AS MaxStreetLength,
		MIN(sc.Shape.STLength()) AS MinStreetLength, SUM(sc.Shape.STLength()) AS SumStreetLength
	FROM survey_area sa, street_centerlines sc
	WHERE LEN(street_nam) > 10
	AND status NOT IN ('ND', 'NB')
	AND sa.Shape.STDistance(sc.Shape) < 5000 
	GROUP BY street_nam, traffic_fl, jurisdicti, status, road_type

GO 
SELECT * FROM vwStreetsStats; 