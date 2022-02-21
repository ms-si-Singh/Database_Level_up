USE master;
GO

CREATE DATABASE SCA_DB;
GO

USE SCA_DB;
GO


CREATE TABLE dbo.[Gender_Lookup] (
  [Gender_ID] [INT] IDENTITY (1,1) NOT NULL PRIMARY KEY,
  [Gender_Description] [varchar](150) NOT NULL
);
GO

CREATE TABLE dbo.[Race_Lookup] (
  [Race_ID] [INT] IDENTITY (1,1) NOT NULL PRIMARY KEY,
  [Race_Description] [varchar](150) NOT NULL
);
GO

CREATE TABLE dbo.[User] (
  [User_ID] [INT] IDENTITY (1,1) PRIMARY KEY NOT NULL,
  [Gender_ID] [INT] NOT NULL,
  [Race_ID] [INT] NOT NULL,
  [Phone_Number] varchar(15) NOT NULL,
  [Age] [INT] NULL,
  CONSTRAINT [FK_User.Gender_ID]
    FOREIGN KEY ([Gender_ID])
      REFERENCES [Gender_Lookup]([Gender_ID]),
  CONSTRAINT [FK_User.Race_ID]
    FOREIGN KEY ([Race_ID])
      REFERENCES [Race_Lookup]([Race_ID])
);
GO

CREATE TABLE dbo.[Assailant] (
  [Assailant_ID] [INT] IDENTITY (1,1) PRIMARY KEY NOT NULL,
  [Race_ID] [INT] NOT NULL,
  [Gender_ID] [INT] NOT NULL,
  [Description] [varchar](500) NULL,
  CONSTRAINT [FK_Assailant.Gender_ID]
    FOREIGN KEY ([Gender_ID])
      REFERENCES [Gender_Lookup]([Gender_ID]),
  CONSTRAINT [FK_Assailant.Race_ID]
    FOREIGN KEY ([Race_ID])
      REFERENCES [Race_Lookup]([Race_ID])
);
GO


CREATE TABLE [Area] (
  [Area_ID] [INT] IDENTITY(1,1) PRIMARY KEY NOT NULL,
  [ZIP_Code] [INT] NOT NULL,
  [Suburb] [varchar](150) NOT NULL,
  [City] [varchar](150) NOT NULL,
  [Province] [varchar](150) NOT NULL,
);
GO



INSERT INTO [dbo].[Area]
           ([ZIP_Code]
		   ,[Suburb]
		   ,[City]
		   ,[Province]
		   )

VALUES    (6, 7708, 'Claremont', 'Cape Town', 'Western Cape'),
	(7, 7700, 'Rondebosch', 'Cape Town', 'Western Cape'),
	(8, 8000, 'Cape Town City Centre', 'Cape Town', 'Western Cape'),
	(9, 7925, 'Observatory', 'Cape Town', 'Western Cape'),
	(10, 7925, 'Woodstock', 'Cape Town', 'Western Cape'),
	(11, 8001, 'Bo Kaap', 'Cape Town', 'Western Cape'),
	(12, 8005, 'Green Point', 'Cape Town', 'Western Cape'),
	(13, 8005, 'Sea Point', 'Cape Town', 'Western Cape'),
	(14, 8005, 'Camps Bay', 'Cape Town', 'Western Cape'),
	(15, 2055, 'Fourways', 'Johannesburg', 'Gauteng'),
	(16, 2001, 'Hillbrow', 'Johannesburg', 'Gauteng'),
	(17, 2194, 'Ferndale', 'Johannesburg', 'Gauteng'),
	(18, 2193, 'Parkhurst', 'Johannesburg', 'Gauteng'),
	(19, 2109, 'Melville', 'Johannesburg', 'Gauteng'),
	(20, 2057, 'Morningside', 'Johannesburg', 'Gauteng')
GO



CREATE TABLE [Location] (
  [Location_ID] [INT] IDENTITY(1,1) PRIMARY KEY NOT NULL,
  [Area_Code_ID] [INT] FOREIGN KEY REFERENCES [Area]([Area_ID]) NOT NULL,
  [Street_Number] [INT] NULL,
  [Street_Name] [varchar](250) NULL,
  [Latitude] [decimal](10,6) NOT NULL,
  [Longitude] [decimal](10,6) NOT NULL,
);
GO

INSERT INTO [dbo].[Location]
           ([Location_ID],
		   [Area_Code_ID],
		   [Street_Number],
		   [Street_Name],
		   [Latitude],
		   [Longitude]
		   )

VALUES    (6, 8, 247, 'Long street', CAST(-33.926054 AS Decimal(10, 6)), CAST(18.415200 AS Decimal(10, 6))),
	(7, 8, 181, 'Long street', CAST(-33.924547 AS Decimal(10, 6)), CAST(18.416808 AS Decimal(10, 6))),
	(8, 8, 69, 'Bree street', CAST(-33.919747 AS Decimal(10, 6)), CAST(18.419777 AS Decimal(10, 6))),
	(9, 6, 15, 'Stegman road', CAST(-33.978993 AS Decimal(10, 6)), CAST(18.465411 AS Decimal(10, 6))),
	(10, 7, 5, 'Burg road', CAST(-33.958057 AS Decimal(10, 6)), CAST(18.472109 AS Decimal(10, 6))),
	(11, 9, 11, 'Oxford road', CAST(-33.939796 AS Decimal(10, 6)), CAST(18.468154 AS Decimal(10, 6))),
	(12, 9, 4, 'Lynton road', CAST(-33.938139 AS Decimal(10, 6)), CAST(18.471944 AS Decimal(10, 6))),
	(13, 11, 2, 'Bryant street', CAST(-33.922092 AS Decimal(10, 6)), CAST(18.414132 AS Decimal(10, 6))),
	(14, 10, 25, 'Sussex street', CAST(-33.927660 AS Decimal(10, 6)), CAST(18.446797 AS Decimal(10, 6))),
	(15, 19, 9, '7th street', CAST(-26.176250 AS Decimal(10, 6)), CAST(28.008750 AS Decimal(10, 6))),
	(16, 19, 70, '3rd avenue', CAST(-26.176077 AS Decimal(10, 6)), CAST(28.006872 AS Decimal(10, 6))),
	(17, 15, 39, 'Kingfisher drive', CAST(-26.028808 AS Decimal(10, 6)), CAST(28.003300 AS Decimal(10, 6))),
	(18, 16, 55, 'Leyds street', CAST(-26.194933 AS Decimal(10, 6)), CAST(28.050231 AS Decimal(10, 6))),
	(19, 17, 20, 'Dover street', CAST(-26.089414 AS Decimal(10, 6)), CAST(28.001703 AS Decimal(10, 6))),
	(20, 18, 100, '14th street', CAST(-26.137625 AS Decimal(10, 6)), CAST(28.018493 AS Decimal(10, 6)))
GO



CREATE TABLE dbo.[Incident] (
  [Incident_ID] [INT] IDENTITY (1,1) NOT NULL PRIMARY KEY,
  [User_ID] [INT] NOT NULL,
  [Location_ID] [INT] NOT NULL,
  [Date] [DATE] NOT NULL,
  [Time] [TIME] NOT NULL,
  [Description] [varchar](150) NULL,
  CONSTRAINT [FK_Incident.Location_ID]
    FOREIGN KEY ([Location_ID])
      REFERENCES [Location]([Location_ID]),
  CONSTRAINT [FK_Incident.User_ID]
    FOREIGN KEY ([User_ID])
      REFERENCES [User]([User_ID])
);
GO

CREATE TABLE dbo.[Incident_Type] (
  [Incident_Type_ID] INT IDENTITY (1,1) NOT NULL PRIMARY KEY,
  [Incident_Description] [varchar](150) NOT NULL
);
GO

CREATE TABLE [Assailant_Incident] (
  [Assailant_Incident_ID] INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
  [Assailant_ID] [int],
  [Incident_ID] [int],
  CONSTRAINT [FK_Assailant_Incident.Incident_ID]
    FOREIGN KEY ([Incident_ID])
      REFERENCES [Incident]([Incident_ID]),
  CONSTRAINT [FK_Assailant_Incident.Assailant_ID]
    FOREIGN KEY ([Assailant_ID])
      REFERENCES [Assailant]([Assailant_ID])
);
GO

CREATE TABLE [Incident_Report] (
  [Incident_Report_ID] INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
  [Incident_ID] [int],
  [Incident_Type_ID] [int],
  CONSTRAINT [FK_Incident_Report.Incident_ID]
    FOREIGN KEY ([Incident_ID])
      REFERENCES [Incident]([Incident_ID]),
  CONSTRAINT [FK_Incident_Report.Incident_Type_ID]
    FOREIGN KEY ([Incident_Type_ID])
      REFERENCES [Incident_Type]([Incident_Type_ID])
);
GO

CREATE TABLE [Hospital] (
  [ID] [INT] IDENTITY(1,1) NOT NULL,
  [Location_ID] [INT] NOT NULL,
  [Name] [varchar](150) NOT NULL,
  [Phone Number] [varchar](15) NOT NULL,
  PRIMARY KEY ([ID]),
  CONSTRAINT [FK_Hospital.Location_ID]
    FOREIGN KEY ([Location_ID])
      REFERENCES [Location]([Location_ID]),
);
GO

CREATE TABLE [SAPS] (
  [ID] [int] IDENTITY(1,1) NOT NULL,
  [Location_ID] [INT] NOT NULL,
  [Name] [varchar](150) NOT NULL,
  [Phone Number] [varchar](15) NOT NULL,
  PRIMARY KEY ([ID]),
  CONSTRAINT [FK_SAPS.Location_ID]
    FOREIGN KEY ([Location_ID])
      REFERENCES [Location]([Location_ID]),
);
GO
