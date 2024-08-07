Use Ciudadano
GO 
CREATE TABLE [dbo].Individuo(
[NOM1][nvarchar](25) NULL,
[NOM2][nvarchar](25) NULL,
[APE1][nvarchar](25) NULL,
[APE2][nvarchar](25) NULL,
[APE3][nvarchar](25) NULL,
[FECNACIMIE][datetime2](7) NULL,
[EDAD][smallint] NULL,
[GENERO][smallint]NULL,
[CODDEP][smallint]NULL,
[CODMUN][nvarchar](25) NULL,
[CODCOM][FLOAT](25) NULL,
[DIRECCION][nvarchar](80) NULL,
[NRO_CASA][nvarchar](8) NULL,
[NRO_ZONA][smallint] NULL,
[ORDEN_CED][nvarchar](3) NULL,
[NUMREG_CED][float]NULL,
[DPI][float] NULL,
[NROBOLETA] [float] NULL,
[STATUS][nvarchar](6) NULL,
[COD_GEO][nvarchar](20) NULL,
[FECH_INSCR] [datetime2](7) NULL,
[FECH_MODIF] [datetime2](7) NULL,
[MUESTRA][nvarchar](1) NULL,
[FILTRO][nvarchar](1) NULL
) ON [PRIMARY]
GO

CREATE CLUSTERED INDEX IDX_CEDULA ON Individuo (ORDEN_CED, NUMREG_CED)
GO

CREATE NONCLUSTERED INDEX NIDX_APELLIDOS ON Individuo (APE1, APE2) INCLUDE (NOM1)
GO

INSERT INTO INDIVIDUO
SELECT * FROM CIUDADANO WHERE APE1 LIKE '[A-C]%'
GO

INSERT INTO INDIVIDUO
SELECT * FROM CIUDADANO WHERE APE1 LIKE '[D-F]%'
GO

INSERT INTO INDIVIDUO
SELECT * FROM CIUDADANO WHERE APE1 LIKE '[G-I]%'
GO

INSERT INTO INDIVIDUO
SELECT * FROM CIUDADANO WHERE APE1 LIKE '[A]%'
GO

DBCC SHOWCONTIG(INDIVIDUO)
GO

ALTER INDEX IDX_CEDULA ON INDIVIDUO REORGANIZE;

ALTER INDEX IDX_CEDULA ON INDIVIDUO 
REBUILD WITH (FILLFACTOR=80);