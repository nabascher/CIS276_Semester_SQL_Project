# CIS276_Semester_SQL_Project
A repository of the SQL scripts that I used with my proximity analysis spatial database project.  

I conducted this final project for a SQL Server college course with the intention to explore SQL Server and its capabilities for managing spatial data. 

The project is a proximity analysis for identifying features near a buffered survey area polygon located in the City of Scottsdale, Arizona.

I used GDAL to load the spatial data into SQL Server. 

1. [Database Diagram](https://github.com/nabascher/CIS276_Semester_SQL_Project/blob/main/Database_Diagram.png):  Shows the diagram of the spatial database that I created in SQL Server.  The connectors represent a spatial relationship rather than a PK/FK relationship.  spatial_ref_sys is useful metadata about the coordinate system that is added when running ogr2ogr to import data.
2. [Ogr2ogr_Insert_Shapefiles](https://github.com/nabascher/CIS276_Semester_SQL_Project/blob/main/Ogr2ogr_Insert_Shapefiles.txt): A handy ETL tool for uploading all shapefiles in a specific directory to SQL Server.
3. [StoredProcedure_InsertBuffer](https://github.com/nabascher/CIS276_Semester_SQL_Project/blob/main/StoredProcedure_InsertBuffer.sql): A stored procedure for inserting buffers based on a user-inputted width into the survey area dataset.
4. [Trigger_SurveyAreaInsert](https://github.com/nabascher/CIS276_Semester_SQL_Project/blob/main/Trigger_SurveyAreaInsert.sql): Implements a QC check for preventing the insert of empty geometry.  Works in tandem with the buffer insert stored procedure.  
5. [UDF_LongestRoad](https://github.com/nabascher/CIS276_Semester_SQL_Project/blob/main/UDF_LongestRoad.sql): A user defined function that returns the longest road of a specified road type and distance away from the survey area.  
6. [View_LandOwnershipInfo](https://github.com/nabascher/CIS276_Semester_SQL_Project/blob/main/View_LandOwnershipInfo.sql): Returns some useful summary information about the BLM land ownership in close proximity to the survey area. Also identifies what township, range, and section the survey area is located in.  
7. [View_ParcelSubset](https://github.com/nabascher/CIS276_Semester_SQL_Project/blob/main/View_ParcelSubset.sql): Returns a subset of parcels in close proximity to the survey area. Also joins the subdivision name to the survey area.
8. [View_StreetsStats](https://github.com/nabascher/CIS276_Semester_SQL_Project/blob/main/View_StreetsStats.sql): Uses aggregates to return summary information about the length of roads near the survey area polygon. 
9. [View_SurveyAreaSummmary](https://github.com/nabascher/CIS276_Semester_SQL_Project/blob/main/View_SurveyAreaSummmary.sql): Returns additional summary information about the survey area.  Also includes a subquery to return the spatial reference information from the spatial_ref_sys metadata table.  
