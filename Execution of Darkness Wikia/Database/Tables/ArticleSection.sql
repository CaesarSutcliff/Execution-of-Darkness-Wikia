USE [ExecutionOfDarknessWikia]
GO

/****** Object:  Table [dbo].[ArticleSection]    Script Date: 20/04/2026 20:25:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ArticleSection](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ArticleId] [int] NOT NULL,
	[Title] [nvarchar](150) NOT NULL,
	[SectionType] [nvarchar](80) NULL,
	[Body] [nvarchar](max) NULL,
	[SortOrder] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[ArticleSection] ADD  DEFAULT ((0)) FOR [SortOrder]
GO

ALTER TABLE [dbo].[ArticleSection]  WITH CHECK ADD  CONSTRAINT [FK_ArticleSection_WikiArticle] FOREIGN KEY([ArticleId])
REFERENCES [dbo].[WikiArticle] ([Id])
GO

ALTER TABLE [dbo].[ArticleSection] CHECK CONSTRAINT [FK_ArticleSection_WikiArticle]
GO

