USE [ExecutionOfDarknessWikia]
GO

/****** Object:  Table [dbo].[QuoteEntry]    Script Date: 20/04/2026 20:28:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[QuoteEntry](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CharacterId] [int] NULL,
	[ArticleId] [int] NULL,
	[VolumeId] [int] NULL,
	[ChapterId] [int] NULL,
	[QuoteText] [nvarchar](max) NOT NULL,
	[ContextText] [nvarchar](500) NULL,
	[CreatedAt] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[QuoteEntry] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO

ALTER TABLE [dbo].[QuoteEntry]  WITH CHECK ADD  CONSTRAINT [FK_QuoteEntry_ChapterEntry] FOREIGN KEY([ChapterId])
REFERENCES [dbo].[ChapterEntry] ([Id])
GO

ALTER TABLE [dbo].[QuoteEntry] CHECK CONSTRAINT [FK_QuoteEntry_ChapterEntry]
GO

ALTER TABLE [dbo].[QuoteEntry]  WITH CHECK ADD  CONSTRAINT [FK_QuoteEntry_CharacterProfile] FOREIGN KEY([CharacterId])
REFERENCES [dbo].[CharacterProfile] ([Id])
GO

ALTER TABLE [dbo].[QuoteEntry] CHECK CONSTRAINT [FK_QuoteEntry_CharacterProfile]
GO

ALTER TABLE [dbo].[QuoteEntry]  WITH CHECK ADD  CONSTRAINT [FK_QuoteEntry_VolumeEntry] FOREIGN KEY([VolumeId])
REFERENCES [dbo].[VolumeEntry] ([Id])
GO

ALTER TABLE [dbo].[QuoteEntry] CHECK CONSTRAINT [FK_QuoteEntry_VolumeEntry]
GO

ALTER TABLE [dbo].[QuoteEntry]  WITH CHECK ADD  CONSTRAINT [FK_QuoteEntry_WikiArticle] FOREIGN KEY([ArticleId])
REFERENCES [dbo].[WikiArticle] ([Id])
GO

ALTER TABLE [dbo].[QuoteEntry] CHECK CONSTRAINT [FK_QuoteEntry_WikiArticle]
GO

