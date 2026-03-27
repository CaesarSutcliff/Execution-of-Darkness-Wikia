IF OBJECT_ID('dbo.CharacterProfile', 'U') IS NOT NULL DROP TABLE dbo.CharacterProfile;
IF OBJECT_ID('dbo.WikiArticle', 'U') IS NOT NULL DROP TABLE dbo.WikiArticle;
IF OBJECT_ID('dbo.TimelineEvent', 'U') IS NOT NULL DROP TABLE dbo.TimelineEvent;
IF OBJECT_ID('dbo.Faction', 'U') IS NOT NULL DROP TABLE dbo.Faction;
IF OBJECT_ID('dbo.Location', 'U') IS NOT NULL DROP TABLE dbo.Location;
GO

CREATE TABLE dbo.Faction
(
    Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    CreatedAt DATETIME NOT NULL,
    UpdatedAt DATETIME NOT NULL,
    IsActive BIT NOT NULL,
    Name NVARCHAR(150) NOT NULL,
    Slug NVARCHAR(200) NOT NULL,
    Summary NVARCHAR(500) NULL,
    Description NVARCHAR(MAX) NULL,
    Motto NVARCHAR(150) NULL,
    Alignment NVARCHAR(100) NULL,
    EmblemUrl NVARCHAR(300) NULL
);
GO

CREATE TABLE dbo.Location
(
    Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    CreatedAt DATETIME NOT NULL,
    UpdatedAt DATETIME NOT NULL,
    IsActive BIT NOT NULL,
    Name NVARCHAR(150) NOT NULL,
    Slug NVARCHAR(200) NOT NULL,
    Summary NVARCHAR(500) NULL,
    Description NVARCHAR(MAX) NULL,
    Region NVARCHAR(100) NULL,
    DangerLevel NVARCHAR(100) NULL,
    ImageUrl NVARCHAR(300) NULL
);
GO

CREATE TABLE dbo.WikiArticle
(
    Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    CreatedAt DATETIME NOT NULL,
    UpdatedAt DATETIME NOT NULL,
    IsActive BIT NOT NULL,
    Title NVARCHAR(200) NOT NULL,
    Slug NVARCHAR(200) NOT NULL,
    Summary NVARCHAR(500) NULL,
    Content NVARCHAR(MAX) NULL,
    Category NVARCHAR(100) NULL,
    IsPublished BIT NOT NULL,
    PublishedAt DATETIME NULL,
    CoverImageUrl NVARCHAR(300) NULL
);
GO

CREATE TABLE dbo.TimelineEvent
(
    Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    CreatedAt DATETIME NOT NULL,
    UpdatedAt DATETIME NOT NULL,
    IsActive BIT NOT NULL,
    Title NVARCHAR(200) NOT NULL,
    Slug NVARCHAR(200) NOT NULL,
    Summary NVARCHAR(500) NULL,
    Description NVARCHAR(MAX) NULL,
    EventDate DATETIME NULL,
    Era NVARCHAR(100) NULL,
    ImportanceLevel NVARCHAR(50) NULL
);
GO

CREATE TABLE dbo.CharacterProfile
(
    Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    CreatedAt DATETIME NOT NULL,
    UpdatedAt DATETIME NOT NULL,
    IsActive BIT NOT NULL,
    Name NVARCHAR(150) NOT NULL,
    Slug NVARCHAR(200) NOT NULL,
    Alias NVARCHAR(150) NULL,
    Summary NVARCHAR(500) NULL,
    Biography NVARCHAR(MAX) NULL,
    Rank NVARCHAR(100) NULL,
    Status NVARCHAR(100) NULL,
    FirstAppearance NVARCHAR(100) NULL,
    AvatarUrl NVARCHAR(300) NULL,
    FactionId INT NULL,
    LocationId INT NULL
);
GO

ALTER TABLE dbo.CharacterProfile
    ADD CONSTRAINT FK_CharacterProfile_Faction
    FOREIGN KEY (FactionId) REFERENCES dbo.Faction (Id);
GO

ALTER TABLE dbo.CharacterProfile
    ADD CONSTRAINT FK_CharacterProfile_Location
    FOREIGN KEY (LocationId) REFERENCES dbo.Location (Id);
GO
