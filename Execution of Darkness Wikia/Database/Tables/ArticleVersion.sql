USE [ExecutionOfDarknessWikia]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ArticleVersion](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ArticleId] [int] NOT NULL,
	[VersionNumber] [int] NOT NULL,
	[TitleSnapshot] [nvarchar](200) NOT NULL,
	[ContentSnapshot] [nvarchar](max) NULL,
	[AuthorName] [nvarchar](200) NULL,
	[ChangeSummary] [nvarchar](500) NULL,
	[CreatedAt] [datetime] NOT NULL,
	[UpdatedAt] [datetime] NOT NULL,
	[IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[ArticleVersion] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO

ALTER TABLE [dbo].[ArticleVersion] ADD  DEFAULT (getdate()) FOR [UpdatedAt]
GO

ALTER TABLE [dbo].[ArticleVersion] ADD  DEFAULT ((1)) FOR [IsActive]
GO

ALTER TABLE [dbo].[ArticleVersion]  WITH CHECK ADD  CONSTRAINT [FK_ArticleVersion_WikiArticle] FOREIGN KEY([ArticleId])
REFERENCES [dbo].[WikiArticle] ([Id])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[ArticleVersion] CHECK CONSTRAINT [FK_ArticleVersion_WikiArticle]
GO
