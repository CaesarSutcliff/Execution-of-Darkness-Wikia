USE [ExecutionOfDarknessWikia]
GO

/****** Object:  Table [dbo].[WikiArticle]    Script Date: 20/04/2026 20:29:25 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[WikiArticle](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](200) NOT NULL,
	[Slug] [nvarchar](200) NOT NULL,
	[Summary] [nvarchar](500) NULL,
	[Content] [nvarchar](max) NULL,
	[Category] [nvarchar](100) NULL,
	[RelatedCharacterId] [int] NULL,
	[RelatedFactionId] [int] NULL,
	[RelatedLocationId] [int] NULL,
	[RelatedVolumeId] [int] NULL,
	[IsPublished] [bit] NOT NULL,
	[PublishedAt] [datetime] NULL,
	[CoverImageUrl] [nvarchar](300) NULL,
	[CreatedAt] [datetime] NOT NULL,
	[UpdatedAt] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Slug] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[WikiArticle] ADD  DEFAULT ((1)) FOR [IsPublished]
GO

ALTER TABLE [dbo].[WikiArticle] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO

ALTER TABLE [dbo].[WikiArticle] ADD  DEFAULT (getdate()) FOR [UpdatedAt]
GO

ALTER TABLE [dbo].[WikiArticle]  WITH CHECK ADD  CONSTRAINT [FK_WikiArticle_CharacterProfile] FOREIGN KEY([RelatedCharacterId])
REFERENCES [dbo].[CharacterProfile] ([Id])
GO

ALTER TABLE [dbo].[WikiArticle] CHECK CONSTRAINT [FK_WikiArticle_CharacterProfile]
GO

ALTER TABLE [dbo].[WikiArticle]  WITH CHECK ADD  CONSTRAINT [FK_WikiArticle_Faction] FOREIGN KEY([RelatedFactionId])
REFERENCES [dbo].[Faction] ([Id])
GO

ALTER TABLE [dbo].[WikiArticle] CHECK CONSTRAINT [FK_WikiArticle_Faction]
GO

ALTER TABLE [dbo].[WikiArticle]  WITH CHECK ADD  CONSTRAINT [FK_WikiArticle_Location] FOREIGN KEY([RelatedLocationId])
REFERENCES [dbo].[Location] ([Id])
GO

ALTER TABLE [dbo].[WikiArticle] CHECK CONSTRAINT [FK_WikiArticle_Location]
GO

ALTER TABLE [dbo].[WikiArticle]  WITH CHECK ADD  CONSTRAINT [FK_WikiArticle_VolumeEntry] FOREIGN KEY([RelatedVolumeId])
REFERENCES [dbo].[VolumeEntry] ([Id])
GO

ALTER TABLE [dbo].[WikiArticle] CHECK CONSTRAINT [FK_WikiArticle_VolumeEntry]
GO

