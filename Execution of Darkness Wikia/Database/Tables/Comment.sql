USE [ExecutionOfDarknessWikia]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Comment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ArticleId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[ParentCommentId] [int] NULL,
	[Content] [nvarchar](max) NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[UpdatedAt] [datetime] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[Comment] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO

ALTER TABLE [dbo].[Comment] ADD  DEFAULT (getdate()) FOR [UpdatedAt]
GO

ALTER TABLE [dbo].[Comment] ADD  DEFAULT ((1)) FOR [IsActive]
GO

ALTER TABLE [dbo].[Comment] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO

ALTER TABLE [dbo].[Comment]  WITH CHECK ADD  CONSTRAINT [FK_Comment_WikiArticle] FOREIGN KEY([ArticleId])
REFERENCES [dbo].[WikiArticle] ([Id])
GO

ALTER TABLE [dbo].[Comment] CHECK CONSTRAINT [FK_Comment_WikiArticle]
GO

ALTER TABLE [dbo].[Comment]  WITH CHECK ADD  CONSTRAINT [FK_Comment_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([Id])
GO

ALTER TABLE [dbo].[Comment] CHECK CONSTRAINT [FK_Comment_User]
GO

ALTER TABLE [dbo].[Comment]  WITH CHECK ADD  CONSTRAINT [FK_Comment_ParentComment] FOREIGN KEY([ParentCommentId])
REFERENCES [dbo].[Comment] ([Id])
GO

ALTER TABLE [dbo].[Comment] CHECK CONSTRAINT [FK_Comment_ParentComment]
GO
