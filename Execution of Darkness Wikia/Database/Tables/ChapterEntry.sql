USE [ExecutionOfDarknessWikia]
GO

/****** Object:  Table [dbo].[ChapterEntry]    Script Date: 20/04/2026 20:26:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ChapterEntry](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[VolumeId] [int] NOT NULL,
	[ChapterNumber] [int] NOT NULL,
	[Title] [nvarchar](250) NOT NULL,
	[Summary] [nvarchar](max) NULL,
	[SortOrder] [int] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[UpdatedAt] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[ChapterEntry] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO

ALTER TABLE [dbo].[ChapterEntry] ADD  DEFAULT (getdate()) FOR [UpdatedAt]
GO

ALTER TABLE [dbo].[ChapterEntry]  WITH CHECK ADD  CONSTRAINT [FK_ChapterEntry_VolumeEntry] FOREIGN KEY([VolumeId])
REFERENCES [dbo].[VolumeEntry] ([Id])
GO

ALTER TABLE [dbo].[ChapterEntry] CHECK CONSTRAINT [FK_ChapterEntry_VolumeEntry]
GO

