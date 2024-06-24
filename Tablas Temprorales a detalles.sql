Use Ciudadano;


CREATE TABLE. dbo.Costomer(
CustomerID int NOT NULL PRIMARY KEY CLUSTERED,
PersonaID int NULL,
TerritoryID int NULL,
AccountNumber nvarchar(25),
SysStartTime datetime2 GENERATED ALWAYS AS ROW START NOT NULL,
 SysEndtime datetime2 GENERATED ALWAYS  AS ROW END NOT NULL,
 PERIOD FOR SYSTEM_TIME (SysStartTime, SYsEndTime)
 )
 WITH (SYSTEM_VERSIONING = ON)
 GO