USE [ExecutionOfDarknessWikia]
GO

/****** Object:  Table [dbo].[ArticleTag]    Script Date: 20/04/2026 20:25:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ArticleTag](
	[ArticleId] [int] NOT NULL,
	[TagId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ArticleId] ASC,
	[TagId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[ArticleTag]  WITH CHECK ADD  CONSTRAINT [FK_ArticleTag_TagEntry] FOREIGN KEY([TagId])
REFERENCES [dbo].[TagEntry] ([Id])
GO

ALTER TABLE [dbo].[ArticleTag] CHECK CONSTRAINT [FK_ArticleTag_TagEntry]
GO

ALTER TABLE [dbo].[ArticleTag]  WITH CHECK ADD  CONSTRAINT [FK_ArticleTag_WikiArticle] FOREIGN KEY([ArticleId])
REFERENCES [dbo].[WikiArticle] ([Id])
GO

ALTER TABLE [dbo].[ArticleTag] CHECK CONSTRAINT [FK_ArticleTag_WikiArticle]
GO

