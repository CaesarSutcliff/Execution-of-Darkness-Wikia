USE ExecutionOfDarknessWikia;
GO

IF COL_LENGTH('dbo.Faction', 'FactionType') IS NULL
    ALTER TABLE dbo.Faction ADD FactionType NVARCHAR(80) NULL;
IF COL_LENGTH('dbo.Faction', 'CrestUrl') IS NULL
    ALTER TABLE dbo.Faction ADD CrestUrl NVARCHAR(300) NULL;

IF COL_LENGTH('dbo.Location', 'LocationType') IS NULL
    ALTER TABLE dbo.Location ADD LocationType NVARCHAR(80) NULL;
IF COL_LENGTH('dbo.Location', 'FirstAppearanceVolumeId') IS NULL
    ALTER TABLE dbo.Location ADD FirstAppearanceVolumeId INT NULL;

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
IF COL_LENGTH('dbo.CharacterProfile', 'CurrentLocationId') IS NULL
    ALTER TABLE dbo.CharacterProfile ADD CurrentLocationId INT NULL;

IF OBJECT_ID('dbo.VolumeEntry', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.VolumeEntry
    (
        Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
        VolumeNumber INT NOT NULL,
        Title NVARCHAR(200) NOT NULL,
        Subtitle NVARCHAR(200) NULL,
        Summary NVARCHAR(MAX) NULL,
        CoverImageUrl NVARCHAR(300) NULL,
        CreatedAt DATETIME NOT NULL DEFAULT(GETDATE()),
        UpdatedAt DATETIME NOT NULL DEFAULT(GETDATE()),
        IsPublished BIT NOT NULL DEFAULT(1)
    );
END

IF OBJECT_ID('dbo.ChapterEntry', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.ChapterEntry
    (
        Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
        VolumeId INT NOT NULL,
        ChapterNumber INT NOT NULL,
        Title NVARCHAR(250) NOT NULL,
        Summary NVARCHAR(MAX) NULL,
        SortOrder INT NOT NULL,
        CreatedAt DATETIME NOT NULL DEFAULT(GETDATE()),
        UpdatedAt DATETIME NOT NULL DEFAULT(GETDATE()),
        CONSTRAINT FK_ChapterEntry_VolumeEntry FOREIGN KEY (VolumeId) REFERENCES dbo.VolumeEntry(Id)
    );
END

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
        SourceType NVARCHAR(80) NULL,
        RiskLevel NVARCHAR(80) NULL,
        CreatedAt DATETIME NOT NULL DEFAULT(GETDATE()),
        UpdatedAt DATETIME NOT NULL DEFAULT(GETDATE())
    );
END

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
        CurrentOwnerCharacterId INT NULL,
        CreatedAt DATETIME NOT NULL DEFAULT(GETDATE()),
        UpdatedAt DATETIME NOT NULL DEFAULT(GETDATE())
    );
END

IF OBJECT_ID('dbo.ArticleVersion', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.ArticleVersion
    (
        Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
        ArticleId INT NOT NULL,
        VersionNumber INT NOT NULL,
        TitleSnapshot NVARCHAR(200) NOT NULL,
        ContentSnapshot NVARCHAR(MAX) NULL,
        CreatedAt DATETIME NOT NULL DEFAULT(GETDATE()),
        UpdatedAt DATETIME NOT NULL DEFAULT(GETDATE()),
        IsActive BIT NOT NULL DEFAULT(1),
        AuthorName NVARCHAR(120) NULL,
        ChangeSummary NVARCHAR(500) NULL,
        CONSTRAINT FK_ArticleVersion_WikiArticle FOREIGN KEY (ArticleId) REFERENCES dbo.WikiArticle(Id)
    );
END
ELSE
BEGIN
    IF COL_LENGTH('dbo.ArticleVersion', 'CreatedAt') IS NULL
        ALTER TABLE dbo.ArticleVersion ADD CreatedAt DATETIME NOT NULL DEFAULT(GETDATE());
    IF COL_LENGTH('dbo.ArticleVersion', 'UpdatedAt') IS NULL
        ALTER TABLE dbo.ArticleVersion ADD UpdatedAt DATETIME NOT NULL DEFAULT(GETDATE());
    IF COL_LENGTH('dbo.ArticleVersion', 'IsActive') IS NULL
        ALTER TABLE dbo.ArticleVersion ADD IsActive BIT NOT NULL DEFAULT(1);
END

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
        CONSTRAINT FK_Comment_Parent FOREIGN KEY (ParentCommentId) REFERENCES dbo.Comment(Id)
    );
END

IF OBJECT_ID('dbo.ArticleSection', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.ArticleSection
    (
        Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
        ArticleId INT NOT NULL,
        Title NVARCHAR(150) NOT NULL,
        SectionType NVARCHAR(80) NULL,
        Body NVARCHAR(MAX) NULL,
        SortOrder INT NOT NULL DEFAULT(0),
        CONSTRAINT FK_ArticleSection_WikiArticle FOREIGN KEY (ArticleId) REFERENCES dbo.WikiArticle(Id)
    );
END

IF OBJECT_ID('dbo.TagEntry', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.TagEntry
    (
        Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
        Name NVARCHAR(100) NOT NULL,
        Slug NVARCHAR(120) NOT NULL UNIQUE
    );
END

IF OBJECT_ID('dbo.ArticleTag', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.ArticleTag
    (
        ArticleId INT NOT NULL,
        TagId INT NOT NULL,
        PRIMARY KEY (ArticleId, TagId),
        CONSTRAINT FK_ArticleTag_WikiArticle FOREIGN KEY (ArticleId) REFERENCES dbo.WikiArticle(Id),
        CONSTRAINT FK_ArticleTag_TagEntry FOREIGN KEY (TagId) REFERENCES dbo.TagEntry(Id)
    );
END

IF OBJECT_ID('dbo.QuoteEntry', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.QuoteEntry
    (
        Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
        CharacterId INT NULL,
        ArticleId INT NULL,
        VolumeId INT NULL,
        ChapterId INT NULL,
        QuoteText NVARCHAR(MAX) NOT NULL,
        ContextText NVARCHAR(500) NULL
    );
END

IF OBJECT_ID('dbo.CharacterRelationship', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.CharacterRelationship
    (
        Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
        CharacterId INT NOT NULL,
        RelatedCharacterId INT NOT NULL,
        RelationshipType NVARCHAR(80) NOT NULL,
        Summary NVARCHAR(500) NULL
    );
END

IF OBJECT_ID('dbo.CharacterFactionHistory', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.CharacterFactionHistory
    (
        Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
        CharacterId INT NOT NULL,
        FactionId INT NOT NULL,
        RoleName NVARCHAR(120) NULL,
        StartMarker NVARCHAR(80) NULL,
        EndMarker NVARCHAR(80) NULL,
        IsCurrent BIT NOT NULL DEFAULT(1)
    );
END

IF OBJECT_ID('dbo.CharacterPower', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.CharacterPower
    (
        CharacterId INT NOT NULL,
        PowerId INT NOT NULL,
        Notes NVARCHAR(500) NULL,
        PRIMARY KEY (CharacterId, PowerId)
    );
END

IF OBJECT_ID('dbo.CharacterArtifact', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.CharacterArtifact
    (
        CharacterId INT NOT NULL,
        ArtifactId INT NOT NULL,
        Notes NVARCHAR(500) NULL,
        PRIMARY KEY (CharacterId, ArtifactId)
    );
END

IF OBJECT_ID('dbo.EventCharacter', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.EventCharacter
    (
        EventId INT NOT NULL,
        CharacterId INT NOT NULL,
        ParticipationType NVARCHAR(80) NULL,
        PRIMARY KEY (EventId, CharacterId)
    );
END

IF OBJECT_ID('dbo.EventLocation', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.EventLocation
    (
        EventId INT NOT NULL,
        LocationId INT NOT NULL,
        PRIMARY KEY (EventId, LocationId)
    );
END
GO
