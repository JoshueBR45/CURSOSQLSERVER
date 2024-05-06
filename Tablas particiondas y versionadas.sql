use  Empresa
go 

Create table Category 
( CategoryId int identity (1,1) not null primary key,
CategoryName varchar (200) not null unique,
Descriptions varchar (500) not  null 
)
Go 
CREATE TABLE Products
(
ProductID int IDENTITY (1,1) NOT NULL,
ProductName nvarchar (40) NOT NULL,
SupplierID int NULL,
CategoryID int NULL,
QuantityPerUnit nvarchar (20) NULL,
UnitPrice money NULL CONSTRAINT DF_Products_UnitPrice DEFAULT(0),
UnitsInStock smallint NULL CONSTRAINT DF_Products_UnitsInStock DEFAULT(0), 
UnitsOnOrder smallint NULL CONSTRAINT DF_Products_UnitsOnOrder DEFAULT (0),
ReorderLevel smallint NULL CONSTRAINT DF_Products_ReorderLevel DEFAULT(0),
CONSTRAINT PK_Products PRIMARY KEY CLUSTERED (ProductID),
CONSTRAINT FK_Products_Categories FOREIGN KEY (CategoryID)

REFERENCES dbo.Category(CategoryId) ON UPDATE CASCADE,
CONSTRAINT CK_Products_UnitPrice CHECK (UnitPrice >= 0),
CONSTRAINT CK_ReorderLevel CHECK (ReorderLevel >= 0),
CONSTRAINT CK_UnitsInStock CHECK (UnitsInStock >= 0),
CONSTRAINT CK_Units0nOrder CHECK (UnitsOnOrder >= 0)
)
GO

alter table Products
add constraint Df_Productoname default('****') for ProductName 
go 

Alter Table PRODUCTS
CHECK CONSTRAINT CK_ReorderLevel

Alter table Products
with nocheck 
add constrint  CK_UnitsOnOder CHECK (UnitsOnOrder >=0)
go 

---Tabla particionada 
Alter Database Empresa 
add Filegroup GrupoParti1
go 
Alter Database Empresa 
add Filegroup GrupoParti2
go 
Alter Database Empresa 
add Filegroup GrupoParti3
go 

---Asociar archivo 
ALTER DATABASE Empresa 
add file (name=empresav1, filename='C:\Data\EmpresaV1.ndf',
size=15mb, filegrowth=25%) to filegroup GrupoParti1
go
ALTER DATABASE Empresa 
add file (name=empresav2, filename='C:\Data\EmpresaV2.ndf',
size=15mb, filegrowth=25%) to filegroup GrupoParti2
go
ALTER DATABASE Empresa 
add file (name=empresav3, filename='C:\Data\EmpresaV3.ndf',
size=15mb, filegrowth=25%) to filegroup GrupoParti3
go

--- Creacion de la funcion de la particion
Create partition function funciondeparticion (varchar(150))
 as range right 
for values ('I','P')
go

---Creacion del esquema
Create partition scheme SchemaPartition as partition funciondeparticion 
to (GrupoParti1, GrupoParti2,GrupoParti3)
go

--Crear Tablas Particionada
Create Table Personas 
(numeroOrden varchar(10),
numeroRegistro bigint,
nombre1 varchar(150),
apellido1 varchar(150),
)
on SchemaPartition(apellido1)
go

----INSERTAR LOS DATOS 
Insert into Personas (numeroOrden, numeroRegistro, nombre1, apellido1)
Select orden_ced, numreg_ced, nom1, ape1 from ciudadano.dbo.Ciudadano

--- Verificar los datos en que particion estan 
Select apellido1, $partition.funciondeparticion(apellido1) as partition 
from personas 
go 

---- Tabla Tenproal (versionada)
Create table individuos 
(
numeroRegistro bigint identity(1,1) primary key,
nombre1 varchar(150),
nombre2 varchar(150),
apellido1 varchar(150),
apellido2 varchar(150),
SysStartTime datetime2 GENERATED ALWAYS AS ROW START NOT NULL,
SysEndTime datetime2 GENERATED ALWAYS AS ROW END NOT NULL,
PERIOD FOR SYSTEM_TiME (SysStartTime, SysEndTime)  
)
WITH (SYSTEM_VERSIONING = ON )

Insert into individuos(
nombre1 ,nombre2 ,apellido1,apellido2)
Select nom1, nom2, ape1, ape2
from Ciudadano.dbo.Ciudadano
where edad=50

Select * from [dbo].[MSSQL_TemporalHistoryFor_1525580473]S

Update individuos set nombre1='ARNOLDO'
WHERE nombre1='AROLDO '

