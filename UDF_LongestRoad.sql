USE Database_Project
GO

IF OBJECT_ID('fnLongestRoad') IS NOT NULL
DROP FUNCTION dbo.fnLongestRoad
GO

CREATE FUNCTION fnLongestRoad(@RoadType varchar(11), @Distance int)
	RETURNS int
BEGIN
	RETURN (SELECT MAX(sc.Shape.STLength()) AS MaxRoadLength
			FROM street_centerlines sc, survey_area sa 
			WHERE road_type = @RoadType
			AND sc.Shape.STDistance(sa.Shape) < @Distance
			)
END;

GO
PRINT 'The longest road is ' + CONVERT(varchar, dbo.fnLongestRoad('RESIDENTIAL', 500)) + ' feet.' 