USE [ExecutionOfDarknessWikia]
GO

/****** Object:  Table [dbo].[CharacterProfile]    Script Date: 20/04/2026 20:27:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CharacterProfile](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](150) NOT NULL,
	[Slug] [nvarchar](200) NOT NULL,
	[Alias] [nvarchar](200) NULL,
	[Summary] [nvarchar](500) NULL,
	[Biography] [nvarchar](max) NULL,
	[AgeText] [nvarchar](50) NULL,
	[Clan] [nvarchar](120) NULL,
	[Occupation] [nvarchar](250) NULL,
	[RankTitle] [nvarchar](100) NULL,
	[StatusText] [nvarchar](80) NULL,
	[FirstAppearance] [nvarchar](100) NULL,
	[AvatarUrl] [nvarchar](300) NULL,
	[FactionId] [int] NULL,
	[CurrentLocationId] [int] NULL,
	[CreatedAt] [datetime] NOT NULL,
	[UpdatedAt] [datetime] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[Race] [nvarchar](80) NULL,
	[Gender] [nvarchar](40) NULL,
	[Alignment] [nvarchar](80) NULL,
	[BirthPlace] [nvarchar](150) NULL,
	[Residence] [nvarchar](150) NULL,
	[Personality] [nvarchar](max) NULL,
	[Appearance] [nvarchar](max) NULL,
	[AbilitiesOverview] [nvarchar](max) NULL,
	[Quote] [nvarchar](500) NULL,
	[BannerUrl] [nvarchar](300) NULL,
	[IsFeaturedOnHome] [bit] NOT NULL,
	[FeaturedOrder] [int] NULL,
	[LocationId] [int] NULL,
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

ALTER TABLE [dbo].[CharacterProfile] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO

ALTER TABLE [dbo].[CharacterProfile] ADD  DEFAULT (getdate()) FOR [UpdatedAt]
GO

ALTER TABLE [dbo].[CharacterProfile] ADD  DEFAULT ((1)) FOR [IsActive]
GO

ALTER TABLE [dbo].[CharacterProfile] ADD  CONSTRAINT [DF_CharacterProfile_IsFeaturedOnHome]  DEFAULT ((0)) FOR [IsFeaturedOnHome]
GO

ALTER TABLE [dbo].[CharacterProfile]  WITH CHECK ADD  CONSTRAINT [FK_CharacterProfile_Faction] FOREIGN KEY([FactionId])
REFERENCES [dbo].[Faction] ([Id])
GO

ALTER TABLE [dbo].[CharacterProfile] CHECK CONSTRAINT [FK_CharacterProfile_Faction]
GO

ALTER TABLE [dbo].[CharacterProfile]  WITH CHECK ADD  CONSTRAINT [FK_CharacterProfile_Location] FOREIGN KEY([CurrentLocationId])
REFERENCES [dbo].[Location] ([Id])
GO

ALTER TABLE [dbo].[CharacterProfile] CHECK CONSTRAINT [FK_CharacterProfile_Location]
GO

ALTER TABLE [dbo].[CharacterProfile]  WITH CHECK ADD  CONSTRAINT [FK_CharacterProfile_LocationId] FOREIGN KEY([LocationId])
REFERENCES [dbo].[Location] ([Id])
GO

ALTER TABLE [dbo].[CharacterProfile] CHECK CONSTRAINT [FK_CharacterProfile_LocationId]
GO

