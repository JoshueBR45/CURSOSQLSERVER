use Ciudadano
go 

-- NUmero de Gesitro de ciudadano 
Select COUNT (*) from Ciudadano
go

-- hacer Una consulta a Ciudadno 
Select NOM1, NOM2, APE1, APE2 FROM Ciudadano
WHERE APE1= 'CARDENAS' AND APE2='VALENZUELA'
GO

--CREACION DE UN INDICE COLUMNAR
Create clustered COLUMNSTORE INDEX CL_CIUDADANO 
ON CIUDADANO;

--Liberar la cache 
DBCC FREEPRACCACHE WITH NO_INFOMSGS;
DBCC DROPCLEANBUFFERS WITH NO_INFOMSGS;


Drop index CL_CIUDADANO
ON CIUDADNO

SP_HELPINDEX CIUDADNO;