-- ============================================================
-- Execution of Darkness Wikia - Schema Completo (Fresh Install)
-- Gerado em: 2026-04-20
-- Descrição: Cria todas as tabelas do zero. 
--            Dropa tabelas existentes na ordem correta (FKs).
-- ============================================================

USE ExecutionOfDarknessWikia;
GO

-- ============================================================
-- DROP na ordem inversa de dependência
-- ============================================================
IF OBJECT_ID('dbo.Comment', 'U') IS NOT NULL DROP TABLE dbo.Comment;
IF OBJECT_ID('dbo.ArticleVersion', 'U') IS NOT NULL DROP TABLE dbo.ArticleVersion;
IF OBJECT_ID('dbo.EventLocation', 'U') IS NOT NULL DROP TABLE dbo.EventLocation;
IF OBJECT_ID('dbo.EventCharacter', 'U') IS NOT NULL DROP TABLE dbo.EventCharacter;
IF OBJECT_ID('dbo.CharacterRelationship', 'U') IS NOT NULL DROP TABLE dbo.CharacterRelationship;
IF OBJECT_ID('dbo.CharacterFactionHistory', 'U') IS NOT NULL DROP TABLE dbo.CharacterFactionHistory;
IF OBJECT_ID('dbo.CharacterPower', 'U') IS NOT NULL DROP TABLE dbo.CharacterPower;
IF OBJECT_ID('dbo.CharacterArtifact', 'U') IS NOT NULL DROP TABLE dbo.CharacterArtifact;
IF OBJECT_ID('dbo.ArticleTag', 'U') IS NOT NULL DROP TABLE dbo.ArticleTag;
IF OBJECT_ID('dbo.ArticleSection', 'U') IS NOT NULL DROP TABLE dbo.ArticleSection;
IF OBJECT_ID('dbo.QuoteEntry', 'U') IS NOT NULL DROP TABLE dbo.QuoteEntry;
IF OBJECT_ID('dbo.TimelineEvent', 'U') IS NOT NULL DROP TABLE dbo.TimelineEvent;
IF OBJECT_ID('dbo.ChapterEntry', 'U') IS NOT NULL DROP TABLE dbo.ChapterEntry;
IF OBJECT_ID('dbo.WikiArticle', 'U') IS NOT NULL DROP TABLE dbo.WikiArticle;
IF OBJECT_ID('dbo.CharacterProfile', 'U') IS NOT NULL DROP TABLE dbo.CharacterProfile;
IF OBJECT_ID('dbo.ArtifactEntry', 'U') IS NOT NULL DROP TABLE dbo.ArtifactEntry;
IF OBJECT_ID('dbo.PowerEntry', 'U') IS NOT NULL DROP TABLE dbo.PowerEntry;
IF OBJECT_ID('dbo.VolumeEntry', 'U') IS NOT NULL DROP TABLE dbo.VolumeEntry;
IF OBJECT_ID('dbo.Location', 'U') IS NOT NULL DROP TABLE dbo.Location;
IF OBJECT_ID('dbo.Faction', 'U') IS NOT NULL DROP TABLE dbo.Faction;
IF OBJECT_ID('dbo.TagEntry', 'U') IS NOT NULL DROP TABLE dbo.TagEntry;
IF OBJECT_ID('dbo.[User]', 'U') IS NOT NULL DROP TABLE dbo.[User];
GO

-- ============================================================
-- 1. Tabelas base (sem FK para outras tabelas do domínio)
-- ============================================================

CREATE TABLE dbo.[User]
(
    Id              INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Username        NVARCHAR(100)  NOT NULL UNIQUE,
    Email           NVARCHAR(200)  NOT NULL UNIQUE,
    PasswordHash    NVARCHAR(256)  NOT NULL,
    Salt            NVARCHAR(128)  NOT NULL,
    DisplayName     NVARCHAR(150)  NULL,
    IsActive        BIT            NOT NULL DEFAULT(1),
    IsAdmin         BIT            NOT NULL DEFAULT(0),
    CreatedAt       DATETIME       NOT NULL DEFAULT(GETDATE()),
    UpdatedAt       DATETIME       NOT NULL DEFAULT(GETDATE()),
    LastLoginAt     DATETIME       NULL
);
GO

CREATE TABLE dbo.Faction
(
    Id              INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Name            NVARCHAR(150)  NOT NULL,
    Slug            NVARCHAR(200)  NOT NULL UNIQUE,
    Summary         NVARCHAR(500)  NULL,
    Description     NVARCHAR(MAX)  NULL,
    FactionType     NVARCHAR(80)   NULL,
    Alignment       NVARCHAR(80)   NULL,
    Motto           NVARCHAR(150)  NULL,
    CrestUrl        NVARCHAR(300)  NULL,
    CreatedAt       DATETIME       NOT NULL DEFAULT(GETDATE()),
    UpdatedAt       DATETIME       NOT NULL DEFAULT(GETDATE()),
    IsActive        BIT            NOT NULL DEFAULT(1)
);
GO

CREATE TABLE dbo.Location
(
    Id                          INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Name                        NVARCHAR(150)  NOT NULL,
    Slug                        NVARCHAR(200)  NOT NULL UNIQUE,
    Summary                     NVARCHAR(500)  NULL,
    Description                 NVARCHAR(MAX)  NULL,
    Region                      NVARCHAR(100)  NULL,
    DangerLevel                 NVARCHAR(80)   NULL,
    LocationType                NVARCHAR(80)   NULL,
    FirstAppearanceVolumeId     INT            NULL,
    ImageUrl                    NVARCHAR(300)  NULL,
    CreatedAt                   DATETIME       NOT NULL DEFAULT(GETDATE()),
    UpdatedAt                   DATETIME       NOT NULL DEFAULT(GETDATE()),
    IsActive                    BIT            NOT NULL DEFAULT(1)
);
GO

CREATE TABLE dbo.TagEntry
(
    Id              INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Name            NVARCHAR(100)  NOT NULL,
    Slug            NVARCHAR(100)  NOT NULL UNIQUE,
    CreatedAt       DATETIME       NOT NULL DEFAULT(GETDATE())
);
GO

CREATE TABLE dbo.VolumeEntry
(
    Id              INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Title           NVARCHAR(200)  NOT NULL,
    Slug            NVARCHAR(200)  NOT NULL UNIQUE,
    Summary         NVARCHAR(500)  NULL,
    VolumeNumber    INT            NOT NULL,
    CoverImageUrl   NVARCHAR(300)  NULL,
    CreatedAt       DATETIME       NOT NULL DEFAULT(GETDATE()),
    UpdatedAt       DATETIME       NOT NULL DEFAULT(GETDATE())
);
GO

CREATE TABLE dbo.PowerEntry
(
    Id              INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Name            NVARCHAR(150)  NOT NULL,
    Slug            NVARCHAR(200)  NOT NULL UNIQUE,
    Summary         NVARCHAR(500)  NULL,
    Description     NVARCHAR(MAX)  NULL,
    PowerType       NVARCHAR(80)   NULL,
    CreatedAt       DATETIME       NOT NULL DEFAULT(GETDATE()),
    UpdatedAt       DATETIME       NOT NULL DEFAULT(GETDATE())
);
GO

CREATE TABLE dbo.ArtifactEntry
(
    Id              INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Name            NVARCHAR(150)  NOT NULL,
    Slug            NVARCHAR(200)  NOT NULL UNIQUE,
    Summary         NVARCHAR(500)  NULL,
    Description     NVARCHAR(MAX)  NULL,
    ArtifactType    NVARCHAR(80)   NULL,
    ImageUrl        NVARCHAR(300)  NULL,
    CreatedAt       DATETIME       NOT NULL DEFAULT(GETDATE()),
    UpdatedAt       DATETIME       NOT NULL DEFAULT(GETDATE())
);
GO

-- ============================================================
-- 2. Tabelas com FK para tabelas base
-- ============================================================

CREATE TABLE dbo.ChapterEntry
(
    Id              INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    VolumeId        INT            NOT NULL,
    Title           NVARCHAR(200)  NOT NULL,
    Slug            NVARCHAR(200)  NOT NULL UNIQUE,
    Summary         NVARCHAR(500)  NULL,
    ChapterNumber   INT            NOT NULL,
    CreatedAt       DATETIME       NOT NULL DEFAULT(GETDATE()),
    UpdatedAt       DATETIME       NOT NULL DEFAULT(GETDATE()),
    CONSTRAINT FK_ChapterEntry_VolumeEntry FOREIGN KEY (VolumeId) REFERENCES dbo.VolumeEntry(Id)
);
GO

CREATE TABLE dbo.CharacterProfile
(
    Id                  INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Name                NVARCHAR(150)  NOT NULL,
    Slug                NVARCHAR(200)  NOT NULL UNIQUE,
    Alias               NVARCHAR(200)  NULL,
    Summary             NVARCHAR(500)  NULL,
    Biography           NVARCHAR(MAX)  NULL,
    AgeText             NVARCHAR(50)   NULL,
    Clan                NVARCHAR(120)  NULL,
    Occupation          NVARCHAR(250)  NULL,
    RankTitle           NVARCHAR(100)  NULL,
    StatusText          NVARCHAR(80)   NULL,
    FirstAppearance     NVARCHAR(100)  NULL,
    Race                NVARCHAR(80)   NULL,
    Gender              NVARCHAR(40)   NULL,
    Alignment           NVARCHAR(80)   NULL,
    BirthPlace          NVARCHAR(150)  NULL,
    Residence           NVARCHAR(150)  NULL,
    Personality         NVARCHAR(MAX)  NULL,
    Appearance          NVARCHAR(MAX)  NULL,
    AbilitiesOverview   NVARCHAR(MAX)  NULL,
    Quote               NVARCHAR(500)  NULL,
    AvatarUrl           NVARCHAR(300)  NULL,
    BannerUrl           NVARCHAR(300)  NULL,
    FactionId           INT            NULL,
    CurrentLocationId   INT            NULL,
    LocationId          INT            NULL,
    IsFeaturedOnHome    BIT            NOT NULL DEFAULT(0),
    FeaturedOrder       INT            NULL,
    CreatedAt           DATETIME       NOT NULL DEFAULT(GETDATE()),
    UpdatedAt           DATETIME       NOT NULL DEFAULT(GETDATE()),
    IsActive            BIT            NOT NULL DEFAULT(1),
    CONSTRAINT FK_CharacterProfile_Faction    FOREIGN KEY (FactionId)          REFERENCES dbo.Faction(Id),
    CONSTRAINT FK_CharacterProfile_Location   FOREIGN KEY (CurrentLocationId)  REFERENCES dbo.Location(Id),
    CONSTRAINT FK_CharacterProfile_LocationId FOREIGN KEY (LocationId)         REFERENCES dbo.Location(Id)
);
GO

CREATE TABLE dbo.WikiArticle
(
    Id                  INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Title               NVARCHAR(200)  NOT NULL,
    Slug                NVARCHAR(200)  NOT NULL UNIQUE,
    Summary             NVARCHAR(500)  NULL,
    Content             NVARCHAR(MAX)  NULL,
    Category            NVARCHAR(100)  NULL,
    RelatedCharacterId  INT            NULL,
    RelatedFactionId    INT            NULL,
    RelatedLocationId   INT            NULL,
    RelatedVolumeId     INT            NULL,
    IsPublished         BIT            NOT NULL DEFAULT(1),
    PublishedAt         DATETIME       NULL,
    CoverImageUrl       NVARCHAR(300)  NULL,
    CreatedAt           DATETIME       NOT NULL DEFAULT(GETDATE()),
    UpdatedAt           DATETIME       NOT NULL DEFAULT(GETDATE()),
    CONSTRAINT FK_WikiArticle_CharacterProfile FOREIGN KEY (RelatedCharacterId) REFERENCES dbo.CharacterProfile(Id),
    CONSTRAINT FK_WikiArticle_Faction          FOREIGN KEY (RelatedFactionId)   REFERENCES dbo.Faction(Id),
    CONSTRAINT FK_WikiArticle_Location         FOREIGN KEY (RelatedLocationId)  REFERENCES dbo.Location(Id),
    CONSTRAINT FK_WikiArticle_VolumeEntry      FOREIGN KEY (RelatedVolumeId)    REFERENCES dbo.VolumeEntry(Id)
);
GO

CREATE TABLE dbo.TimelineEvent
(
    Id              INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Title           NVARCHAR(200)  NOT NULL,
    Slug            NVARCHAR(200)  NOT NULL UNIQUE,
    Summary         NVARCHAR(500)  NULL,
    Description     NVARCHAR(MAX)  NULL,
    Era             NVARCHAR(100)  NULL,
    VolumeId        INT            NULL,
    ChapterId       INT            NULL,
    EventDateText   NVARCHAR(80)   NULL,
    ImportanceLevel NVARCHAR(50)   NULL,
    CreatedAt       DATETIME       NOT NULL DEFAULT(GETDATE()),
    UpdatedAt       DATETIME       NOT NULL DEFAULT(GETDATE()),
    CONSTRAINT FK_TimelineEvent_VolumeEntry  FOREIGN KEY (VolumeId)  REFERENCES dbo.VolumeEntry(Id),
    CONSTRAINT FK_TimelineEvent_ChapterEntry FOREIGN KEY (ChapterId) REFERENCES dbo.ChapterEntry(Id)
);
GO

-- ============================================================
-- 3. Tabelas de junção e dependentes
-- ============================================================

CREATE TABLE dbo.ArticleVersion
(
    Id              INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    ArticleId       INT            NOT NULL,
    VersionNumber   INT            NOT NULL,
    TitleSnapshot   NVARCHAR(200)  NOT NULL,
    ContentSnapshot NVARCHAR(MAX)  NULL,
    AuthorName      NVARCHAR(200)  NULL,
    ChangeSummary   NVARCHAR(500)  NULL,
    CreatedAt       DATETIME       NOT NULL DEFAULT(GETDATE()),
    UpdatedAt       DATETIME       NOT NULL DEFAULT(GETDATE()),
    IsActive        BIT            NOT NULL DEFAULT(1),
    CONSTRAINT FK_ArticleVersion_WikiArticle FOREIGN KEY (ArticleId) REFERENCES dbo.WikiArticle(Id) ON DELETE CASCADE
);
GO

CREATE TABLE dbo.ArticleSection
(
    Id              INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    ArticleId       INT            NOT NULL,
    SectionTitle    NVARCHAR(200)  NOT NULL,
    SectionContent  NVARCHAR(MAX)  NULL,
    SortOrder       INT            NOT NULL DEFAULT(0),
    CreatedAt       DATETIME       NOT NULL DEFAULT(GETDATE()),
    UpdatedAt       DATETIME       NOT NULL DEFAULT(GETDATE()),
    CONSTRAINT FK_ArticleSection_WikiArticle FOREIGN KEY (ArticleId) REFERENCES dbo.WikiArticle(Id)
);
GO

CREATE TABLE dbo.ArticleTag
(
    Id              INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    ArticleId       INT            NOT NULL,
    TagId           INT            NOT NULL,
    CONSTRAINT FK_ArticleTag_WikiArticle FOREIGN KEY (ArticleId) REFERENCES dbo.WikiArticle(Id),
    CONSTRAINT FK_ArticleTag_TagEntry    FOREIGN KEY (TagId)     REFERENCES dbo.TagEntry(Id)
);
GO

CREATE TABLE dbo.Comment
(
    Id              INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    ArticleId       INT            NOT NULL,
    UserId          INT            NOT NULL,
    ParentCommentId INT            NULL,
    Content         NVARCHAR(MAX)  NOT NULL,
    CreatedAt       DATETIME       NOT NULL DEFAULT(GETDATE()),
    UpdatedAt       DATETIME       NOT NULL DEFAULT(GETDATE()),
    IsActive        BIT            NOT NULL DEFAULT(1),
    IsDeleted       BIT            NOT NULL DEFAULT(0),
    CONSTRAINT FK_Comment_WikiArticle    FOREIGN KEY (ArticleId)       REFERENCES dbo.WikiArticle(Id),
    CONSTRAINT FK_Comment_User           FOREIGN KEY (UserId)          REFERENCES dbo.[User](Id),
    CONSTRAINT FK_Comment_ParentComment  FOREIGN KEY (ParentCommentId) REFERENCES dbo.Comment(Id)
);
GO

CREATE TABLE dbo.CharacterRelationship
(
    Id                  INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    CharacterId         INT            NOT NULL,
    RelatedCharacterId  INT            NOT NULL,
    RelationshipType    NVARCHAR(80)   NOT NULL,
    Summary             NVARCHAR(500)  NULL,
    CONSTRAINT FK_CharacterRelationship_Character        FOREIGN KEY (CharacterId)        REFERENCES dbo.CharacterProfile(Id),
    CONSTRAINT FK_CharacterRelationship_RelatedCharacter FOREIGN KEY (RelatedCharacterId) REFERENCES dbo.CharacterProfile(Id)
);
GO

CREATE TABLE dbo.CharacterFactionHistory
(
    Id              INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    CharacterId     INT            NOT NULL,
    FactionId       INT            NOT NULL,
    JoinedAt        NVARCHAR(100)  NULL,
    LeftAt          NVARCHAR(100)  NULL,
    Role            NVARCHAR(150)  NULL,
    Notes           NVARCHAR(500)  NULL,
    CONSTRAINT FK_CharacterFactionHistory_Character FOREIGN KEY (CharacterId) REFERENCES dbo.CharacterProfile(Id),
    CONSTRAINT FK_CharacterFactionHistory_Faction   FOREIGN KEY (FactionId)   REFERENCES dbo.Faction(Id)
);
GO

CREATE TABLE dbo.CharacterPower
(
    Id              INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    CharacterId     INT            NOT NULL,
    PowerId         INT            NOT NULL,
    Notes           NVARCHAR(500)  NULL,
    CONSTRAINT FK_CharacterPower_Character  FOREIGN KEY (CharacterId) REFERENCES dbo.CharacterProfile(Id),
    CONSTRAINT FK_CharacterPower_PowerEntry FOREIGN KEY (PowerId)     REFERENCES dbo.PowerEntry(Id)
);
GO

CREATE TABLE dbo.CharacterArtifact
(
    Id              INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    CharacterId     INT            NOT NULL,
    ArtifactId      INT            NOT NULL,
    Notes           NVARCHAR(500)  NULL,
    CONSTRAINT FK_CharacterArtifact_Character      FOREIGN KEY (CharacterId) REFERENCES dbo.CharacterProfile(Id),
    CONSTRAINT FK_CharacterArtifact_ArtifactEntry  FOREIGN KEY (ArtifactId)  REFERENCES dbo.ArtifactEntry(Id)
);
GO

CREATE TABLE dbo.QuoteEntry
(
    Id              INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    CharacterId     INT            NULL,
    Content         NVARCHAR(1000) NOT NULL,
    Context         NVARCHAR(300)  NULL,
    VolumeId        INT            NULL,
    ChapterId       INT            NULL,
    CreatedAt       DATETIME       NOT NULL DEFAULT(GETDATE()),
    CONSTRAINT FK_QuoteEntry_CharacterProfile FOREIGN KEY (CharacterId) REFERENCES dbo.CharacterProfile(Id),
    CONSTRAINT FK_QuoteEntry_VolumeEntry      FOREIGN KEY (VolumeId)    REFERENCES dbo.VolumeEntry(Id),
    CONSTRAINT FK_QuoteEntry_ChapterEntry     FOREIGN KEY (ChapterId)   REFERENCES dbo.ChapterEntry(Id)
);
GO

CREATE TABLE dbo.EventCharacter
(
    Id                  INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    TimelineEventId     INT            NOT NULL,
    CharacterId         INT            NOT NULL,
    Role                NVARCHAR(100)  NULL,
    CONSTRAINT FK_EventCharacter_TimelineEvent    FOREIGN KEY (TimelineEventId) REFERENCES dbo.TimelineEvent(Id),
    CONSTRAINT FK_EventCharacter_CharacterProfile FOREIGN KEY (CharacterId)     REFERENCES dbo.CharacterProfile(Id)
);
GO

CREATE TABLE dbo.EventLocation
(
    Id                  INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    TimelineEventId     INT            NOT NULL,
    LocationId          INT            NOT NULL,
    CONSTRAINT FK_EventLocation_TimelineEvent FOREIGN KEY (TimelineEventId) REFERENCES dbo.TimelineEvent(Id),
    CONSTRAINT FK_EventLocation_Location      FOREIGN KEY (LocationId)      REFERENCES dbo.Location(Id)
);
GO

-- ============================================================
-- 4. Índices úteis
-- ============================================================
CREATE INDEX IX_CharacterProfile_Name   ON dbo.CharacterProfile(Name);
CREATE INDEX IX_CharacterProfile_Slug   ON dbo.CharacterProfile(Slug);
CREATE INDEX IX_WikiArticle_Title       ON dbo.WikiArticle(Title);
CREATE INDEX IX_TimelineEvent_Title     ON dbo.TimelineEvent(Title);
CREATE INDEX IX_Faction_Slug            ON dbo.Faction(Slug);
CREATE INDEX IX_Location_Slug           ON dbo.Location(Slug);
CREATE INDEX IX_Comment_ArticleId       ON dbo.Comment(ArticleId);
CREATE INDEX IX_ArticleVersion_ArticleId ON dbo.ArticleVersion(ArticleId);
GO
