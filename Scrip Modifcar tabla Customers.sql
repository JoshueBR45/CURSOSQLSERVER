Use northwind

Alter table dbo.customers

ADD SysStartTime datetime2 GENERATED ALWAYS AS ROW START NOT NULL
DEFAULT GETUTCDATE(),
        SysEndTime datetime2 GENERATED ALWAYS AS ROW END NOT NULL
        DEFAULT CAST('9999-12-31 23:59:59.9999999' AS datetime2 ),
		PERIOD FOR SYSTEM_TIME (SysStartTime, SysEndTime)
Go