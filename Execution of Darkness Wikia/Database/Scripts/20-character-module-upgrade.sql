USE ExecutionOfDarknessWikia;
GO

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
BEGIN
    ALTER TABLE dbo.CharacterProfile ADD IsFeaturedOnHome BIT NOT NULL CONSTRAINT DF_CharacterProfile_IsFeaturedOnHome DEFAULT(0);
END
IF COL_LENGTH('dbo.CharacterProfile', 'FeaturedOrder') IS NULL
    ALTER TABLE dbo.CharacterProfile ADD FeaturedOrder INT NULL;
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
        CONSTRAINT FK_CharacterRelationship_CharacterProfile FOREIGN KEY (CharacterId) REFERENCES dbo.CharacterProfile(Id),
        CONSTRAINT FK_CharacterRelationship_RelatedCharacter FOREIGN KEY (RelatedCharacterId) REFERENCES dbo.CharacterProfile(Id)
    );
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_CharacterProfile_Slug' AND object_id = OBJECT_ID('dbo.CharacterProfile'))
    CREATE UNIQUE INDEX IX_CharacterProfile_Slug ON dbo.CharacterProfile(Slug);
GO
