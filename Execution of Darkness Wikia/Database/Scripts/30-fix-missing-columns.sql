-- ============================================================
-- Fix: Adiciona todas as colunas faltantes no banco existente
-- Rode este script se o SchemaCompare mostra colunas faltando
-- ============================================================
USE ExecutionOfDarknessWikia;
GO

-- CharacterProfile - colunas do character module
IF COL_LENGTH('dbo.CharacterProfile', 'AgeText') IS NULL
    ALTER TABLE dbo.CharacterProfile ADD AgeText NVARCHAR(50) NULL;
IF COL_LENGTH('dbo.CharacterProfile', 'Clan') IS NULL
    ALTER TABLE dbo.CharacterProfile ADD Clan NVARCHAR(120) NULL;
IF COL_LENGTH('dbo.CharacterProfile', 'Occupation') IS NULL
    ALTER TABLE dbo.CharacterProfile ADD Occupation NVARCHAR(250) NULL;
IF COL_LENGTH('dbo.CharacterProfile', 'RankTitle') IS NULL
    ALTER TABLE dbo.CharacterProfile ADD RankTitle NVARCHAR(100) NULL;
IF COL_LENGTH('dbo.CharacterProfile', 'StatusText') IS NULL
    ALTER TABLE dbo.CharacterProfile ADD StatusText NVARCHAR(80) NULL;
IF COL_LENGTH('dbo.CharacterProfile', 'Race') IS NULL
    ALTER TABLE dbo.CharacterProfile ADD Race NVARCHAR(80) NULL;
IF COL_LENGTH('dbo.CharacterProfile', 'Gender') IS NULL
    ALTER TABLE dbo.CharacterProfile ADD Gender NVARCHAR(40) NULL;
IF COL_LENGTH('dbo.CharacterProfile', 'Alignment') IS NULL
    ALTER TABLE dbo.CharacterProfile ADD Alignment NVARCHAR(80) NULL;
IF COL_LENGTH('dbo.CharacterProfile', 'BirthPlace') IS NULL
    ALTER TABLE dbo.CharacterProfile ADD BirthPlace NVARCHAR(150) NULL;
IF COL_LENGTH('dbo.CharacterProfile', 'Residence') IS NULL
    ALTER TABLE dbo.CharacterProfile ADD Residence NVARCHAR(150) NULL;
IF COL_LENGTH('dbo.CharacterProfile', 'Personality') IS NULL
    ALTER TABLE dbo.CharacterProfile ADD Personality NVARCHAR(MAX) NULL;
IF COL_LENGTH('dbo.CharacterProfile', 'Appearance') IS NULL
    ALTER TABLE dbo.CharacterProfile ADD Appearance NVARCHAR(MAX) NULL;
IF COL_LENGTH('dbo.CharacterProfile', 'AbilitiesOverview') IS NULL
    ALTER TABLE dbo.CharacterProfile ADD AbilitiesOverview NVARCHAR(MAX) NULL;
IF COL_LENGTH('dbo.CharacterProfile', 'Quote') IS NULL
    ALTER TABLE dbo.CharacterProfile ADD Quote NVARCHAR(500) NULL;
IF COL_LENGTH('dbo.CharacterProfile', 'BannerUrl') IS NULL
    ALTER TABLE dbo.CharacterProfile ADD BannerUrl NVARCHAR(300) NULL;
IF COL_LENGTH('dbo.CharacterProfile', 'IsFeaturedOnHome') IS NULL
    ALTER TABLE dbo.CharacterProfile ADD IsFeaturedOnHome BIT NOT NULL DEFAULT(0);
IF COL_LENGTH('dbo.CharacterProfile', 'FeaturedOrder') IS NULL
    ALTER TABLE dbo.CharacterProfile ADD FeaturedOrder INT NULL;
IF COL_LENGTH('dbo.CharacterProfile', 'CurrentLocationId') IS NULL
    ALTER TABLE dbo.CharacterProfile ADD CurrentLocationId INT NULL;
IF COL_LENGTH('dbo.CharacterProfile', 'LocationId') IS NULL
    ALTER TABLE dbo.CharacterProfile ADD LocationId INT NULL;
GO

-- Faction - colunas novas
IF COL_LENGTH('dbo.Faction', 'FactionType') IS NULL
    ALTER TABLE dbo.Faction ADD FactionType NVARCHAR(80) NULL;
IF COL_LENGTH('dbo.Faction', 'CrestUrl') IS NULL
    ALTER TABLE dbo.Faction ADD CrestUrl NVARCHAR(300) NULL;
GO

-- Location - colunas novas
IF COL_LENGTH('dbo.Location', 'LocationType') IS NULL
    ALTER TABLE dbo.Location ADD LocationType NVARCHAR(80) NULL;
IF COL_LENGTH('dbo.Location', 'FirstAppearanceVolumeId') IS NULL
    ALTER TABLE dbo.Location ADD FirstAppearanceVolumeId INT NULL;
GO

-- Tabelas que podem não existir ainda
IF OBJECT_ID('dbo.[User]', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.[User]
    (
        Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
        Username NVARCHAR(100) NOT NULL UNIQUE,
        Email NVARCHAR(200) NOT NULL UNIQUE,
        PasswordHash NVARCHAR(256) NOT NULL,
        Salt NVARCHAR(128) NOT NULL,
        DisplayName NVARCHAR(150) NULL,
        IsActive BIT NOT NULL DEFAULT(1),
        IsAdmin BIT NOT NULL DEFAULT(0),
        CreatedAt DATETIME NOT NULL DEFAULT(GETDATE()),
        UpdatedAt DATETIME NOT NULL DEFAULT(GETDATE()),
        LastLoginAt DATETIME NULL
    );
END
GO

IF OBJECT_ID('dbo.Comment', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Comment
    (
        Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
        ArticleId INT NOT NULL,
        UserId INT NOT NULL,
        ParentCommentId INT NULL,
        Content NVARCHAR(MAX) NOT NULL,
        CreatedAt DATETIME NOT NULL DEFAULT(GETDATE()),
        UpdatedAt DATETIME NOT NULL DEFAULT(GETDATE()),
        IsActive BIT NOT NULL DEFAULT(1),
        IsDeleted BIT NOT NULL DEFAULT(0),
        CONSTRAINT FK_Comment_WikiArticle FOREIGN KEY (ArticleId) REFERENCES dbo.WikiArticle(Id),
        CONSTRAINT FK_Comment_User FOREIGN KEY (UserId) REFERENCES dbo.[User](Id),
        CONSTRAINT FK_Comment_ParentComment FOREIGN KEY (ParentCommentId) REFERENCES dbo.Comment(Id)
    );
END
GO

IF OBJECT_ID('dbo.ArticleVersion', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.ArticleVersion
    (
        Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
        ArticleId INT NOT NULL,
        VersionNumber INT NOT NULL,
        TitleSnapshot NVARCHAR(200) NOT NULL,
        ContentSnapshot NVARCHAR(MAX) NULL,
        AuthorName NVARCHAR(200) NULL,
        ChangeSummary NVARCHAR(500) NULL,
        CreatedAt DATETIME NOT NULL DEFAULT(GETDATE()),
        UpdatedAt DATETIME NOT NULL DEFAULT(GETDATE()),
        IsActive BIT NOT NULL DEFAULT(1),
        CONSTRAINT FK_ArticleVersion_WikiArticle FOREIGN KEY (ArticleId) REFERENCES dbo.WikiArticle(Id) ON DELETE CASCADE
    );
END
ELSE
BEGIN
    IF COL_LENGTH('dbo.ArticleVersion', 'AuthorName') IS NULL
        ALTER TABLE dbo.ArticleVersion ADD AuthorName NVARCHAR(200) NULL;
    IF COL_LENGTH('dbo.ArticleVersion', 'ChangeSummary') IS NULL
        ALTER TABLE dbo.ArticleVersion ADD ChangeSummary NVARCHAR(500) NULL;
    IF COL_LENGTH('dbo.ArticleVersion', 'UpdatedAt') IS NULL
        ALTER TABLE dbo.ArticleVersion ADD UpdatedAt DATETIME NOT NULL DEFAULT(GETDATE());
    IF COL_LENGTH('dbo.ArticleVersion', 'IsActive') IS NULL
        ALTER TABLE dbo.ArticleVersion ADD IsActive BIT NOT NULL DEFAULT(1);
END
GO

IF OBJECT_ID('dbo.VolumeEntry', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.VolumeEntry
    (
        Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
        Title NVARCHAR(200) NOT NULL,
        Slug NVARCHAR(200) NOT NULL UNIQUE,
        Summary NVARCHAR(500) NULL,
        VolumeNumber INT NOT NULL,
        CoverImageUrl NVARCHAR(300) NULL,
        CreatedAt DATETIME NOT NULL DEFAULT(GETDATE()),
        UpdatedAt DATETIME NOT NULL DEFAULT(GETDATE())
    );
END
GO

IF OBJECT_ID('dbo.ChapterEntry', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.ChapterEntry
    (
        Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
        VolumeId INT NOT NULL,
        Title NVARCHAR(200) NOT NULL,
        Slug NVARCHAR(200) NOT NULL UNIQUE,
        Summary NVARCHAR(500) NULL,
        ChapterNumber INT NOT NULL,
        CreatedAt DATETIME NOT NULL DEFAULT(GETDATE()),
        UpdatedAt DATETIME NOT NULL DEFAULT(GETDATE()),
        CONSTRAINT FK_ChapterEntry_VolumeEntry FOREIGN KEY (VolumeId) REFERENCES dbo.VolumeEntry(Id)
    );
END
GO

IF OBJECT_ID('dbo.PowerEntry', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.PowerEntry
    (
        Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
        Name NVARCHAR(150) NOT NULL,
        Slug NVARCHAR(200) NOT NULL UNIQUE,
        Summary NVARCHAR(500) NULL,
        Description NVARCHAR(MAX) NULL,
        PowerType NVARCHAR(80) NULL,
        CreatedAt DATETIME NOT NULL DEFAULT(GETDATE()),
        UpdatedAt DATETIME NOT NULL DEFAULT(GETDATE())
    );
END
GO

IF OBJECT_ID('dbo.ArtifactEntry', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.ArtifactEntry
    (
        Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
        Name NVARCHAR(150) NOT NULL,
        Slug NVARCHAR(200) NOT NULL UNIQUE,
        Summary NVARCHAR(500) NULL,
        Description NVARCHAR(MAX) NULL,
        ArtifactType NVARCHAR(80) NULL,
        ImageUrl NVARCHAR(300) NULL,
        CreatedAt DATETIME NOT NULL DEFAULT(GETDATE()),
        UpdatedAt DATETIME NOT NULL DEFAULT(GETDATE())
    );
END
GO

IF OBJECT_ID('dbo.TagEntry', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.TagEntry
    (
        Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
        Name NVARCHAR(100) NOT NULL,
        Slug NVARCHAR(100) NOT NULL UNIQUE,
        CreatedAt DATETIME NOT NULL DEFAULT(GETDATE())
    );
END
GO

IF OBJECT_ID('dbo.ArticleSection', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.ArticleSection
    (
        Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
        ArticleId INT NOT NULL,
        SectionTitle NVARCHAR(200) NOT NULL,
        SectionContent NVARCHAR(MAX) NULL,
        SortOrder INT NOT NULL DEFAULT(0),
        CreatedAt DATETIME NOT NULL DEFAULT(GETDATE()),
        UpdatedAt DATETIME NOT NULL DEFAULT(GETDATE()),
        CONSTRAINT FK_ArticleSection_WikiArticle FOREIGN KEY (ArticleId) REFERENCES dbo.WikiArticle(Id)
    );
END
GO

IF OBJECT_ID('dbo.ArticleTag', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.ArticleTag
    (
        Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
        ArticleId INT NOT NULL,
        TagId INT NOT NULL,
        CONSTRAINT FK_ArticleTag_WikiArticle FOREIGN KEY (ArticleId) REFERENCES dbo.WikiArticle(Id),
        CONSTRAINT FK_ArticleTag_TagEntry FOREIGN KEY (TagId) REFERENCES dbo.TagEntry(Id)
    );
END
GO

IF OBJECT_ID('dbo.CharacterRelationship', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.CharacterRelationship
    (
        Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
        CharacterId INT NOT NULL,
        RelatedCharacterId INT NOT NULL,
        RelationshipType NVARCHAR(80) NOT NULL,
        Summary NVARCHAR(500) NULL,
        CONSTRAINT FK_CharacterRelationship_Character FOREIGN KEY (CharacterId) REFERENCES dbo.CharacterProfile(Id),
        CONSTRAINT FK_CharacterRelationship_RelatedCharacter FOREIGN KEY (RelatedCharacterId) REFERENCES dbo.CharacterProfile(Id)
    );
END
GO

IF OBJECT_ID('dbo.CharacterFactionHistory', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.CharacterFactionHistory
    (
        Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
        CharacterId INT NOT NULL,
        FactionId INT NOT NULL,
        JoinedAt NVARCHAR(100) NULL,
        LeftAt NVARCHAR(100) NULL,
        Role NVARCHAR(150) NULL,
        Notes NVARCHAR(500) NULL,
        CONSTRAINT FK_CFH_Character FOREIGN KEY (CharacterId) REFERENCES dbo.CharacterProfile(Id),
        CONSTRAINT FK_CFH_Faction FOREIGN KEY (FactionId) REFERENCES dbo.Faction(Id)
    );
END
GO

IF OBJECT_ID('dbo.CharacterPower', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.CharacterPower
    (
        Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
        CharacterId INT NOT NULL,
        PowerId INT NOT NULL,
        Notes NVARCHAR(500) NULL,
        CONSTRAINT FK_CP_Character FOREIGN KEY (CharacterId) REFERENCES dbo.CharacterProfile(Id),
        CONSTRAINT FK_CP_PowerEntry FOREIGN KEY (PowerId) REFERENCES dbo.PowerEntry(Id)
    );
END
GO

IF OBJECT_ID('dbo.CharacterArtifact', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.CharacterArtifact
    (
        Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
        CharacterId INT NOT NULL,
        ArtifactId INT NOT NULL,
        Notes NVARCHAR(500) NULL,
        CONSTRAINT FK_CA_Character FOREIGN KEY (CharacterId) REFERENCES dbo.CharacterProfile(Id),
        CONSTRAINT FK_CA_ArtifactEntry FOREIGN KEY (ArtifactId) REFERENCES dbo.ArtifactEntry(Id)
    );
END
GO

IF OBJECT_ID('dbo.QuoteEntry', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.QuoteEntry
    (
        Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
        CharacterId INT NULL,
        Content NVARCHAR(1000) NOT NULL,
        Context NVARCHAR(300) NULL,
        VolumeId INT NULL,
        ChapterId INT NULL,
        CreatedAt DATETIME NOT NULL DEFAULT(GETDATE()),
        CONSTRAINT FK_QE_Character FOREIGN KEY (CharacterId) REFERENCES dbo.CharacterProfile(Id),
        CONSTRAINT FK_QE_Volume FOREIGN KEY (VolumeId) REFERENCES dbo.VolumeEntry(Id),
        CONSTRAINT FK_QE_Chapter FOREIGN KEY (ChapterId) REFERENCES dbo.ChapterEntry(Id)
    );
END
GO

IF OBJECT_ID('dbo.TimelineEvent', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.TimelineEvent
    (
        Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
        Title NVARCHAR(200) NOT NULL,
        Slug NVARCHAR(200) NOT NULL UNIQUE,
        Summary NVARCHAR(500) NULL,
        Description NVARCHAR(MAX) NULL,
        Era NVARCHAR(100) NULL,
        VolumeId INT NULL,
        ChapterId INT NULL,
        EventDateText NVARCHAR(80) NULL,
        ImportanceLevel NVARCHAR(50) NULL,
        CreatedAt DATETIME NOT NULL DEFAULT(GETDATE()),
        UpdatedAt DATETIME NOT NULL DEFAULT(GETDATE()),
        CONSTRAINT FK_TE_Volume FOREIGN KEY (VolumeId) REFERENCES dbo.VolumeEntry(Id),
        CONSTRAINT FK_TE_Chapter FOREIGN KEY (ChapterId) REFERENCES dbo.ChapterEntry(Id)
    );
END
GO

IF OBJECT_ID('dbo.EventCharacter', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.EventCharacter
    (
        Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
        TimelineEventId INT NOT NULL,
        CharacterId INT NOT NULL,
        Role NVARCHAR(100) NULL,
        CONSTRAINT FK_EC_TimelineEvent FOREIGN KEY (TimelineEventId) REFERENCES dbo.TimelineEvent(Id),
        CONSTRAINT FK_EC_Character FOREIGN KEY (CharacterId) REFERENCES dbo.CharacterProfile(Id)
    );
END
GO

IF OBJECT_ID('dbo.EventLocation', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.EventLocation
    (
        Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
        TimelineEventId INT NOT NULL,
        LocationId INT NOT NULL,
        CONSTRAINT FK_EL_TimelineEvent FOREIGN KEY (TimelineEventId) REFERENCES dbo.TimelineEvent(Id),
        CONSTRAINT FK_EL_Location FOREIGN KEY (LocationId) REFERENCES dbo.Location(Id)
    );
END
GO

-- FKs que podem estar faltando
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_CharacterProfile_LocationId')
BEGIN
    IF COL_LENGTH('dbo.CharacterProfile', 'LocationId') IS NOT NULL
        ALTER TABLE dbo.CharacterProfile ADD CONSTRAINT FK_CharacterProfile_LocationId 
            FOREIGN KEY (LocationId) REFERENCES dbo.Location(Id);
END
GO

PRINT 'Script 30-fix-missing-columns executado com sucesso.';
GO
