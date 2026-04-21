USE [ExecutionOfDarknessWikia]
GO

/****** Object:  Table [dbo].[TimelineEvent]    Script Date: 20/04/2026 20:29:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TimelineEvent](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](200) NOT NULL,
	[Slug] [nvarchar](200) NOT NULL,
	[Summary] [nvarchar](500) NULL,
	[Description] [nvarchar](max) NULL,
	[Era] [nvarchar](100) NULL,
	[VolumeId] [int] NULL,
	[ChapterId] [int] NULL,
	[EventDateText] [nvarchar](80) NULL,
	[ImportanceLevel] [nvarchar](50) NULL,
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

ALTER TABLE [dbo].[TimelineEvent] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO

ALTER TABLE [dbo].[TimelineEvent] ADD  DEFAULT (getdate()) FOR [UpdatedAt]
GO

ALTER TABLE [dbo].[TimelineEvent]  WITH CHECK ADD  CONSTRAINT [FK_TimelineEvent_ChapterEntry] FOREIGN KEY([ChapterId])
REFERENCES [dbo].[ChapterEntry] ([Id])
GO

ALTER TABLE [dbo].[TimelineEvent] CHECK CONSTRAINT [FK_TimelineEvent_ChapterEntry]
GO

ALTER TABLE [dbo].[TimelineEvent]  WITH CHECK ADD  CONSTRAINT [FK_TimelineEvent_VolumeEntry] FOREIGN KEY([VolumeId])
REFERENCES [dbo].[VolumeEntry] ([Id])
GO

ALTER TABLE [dbo].[TimelineEvent] CHECK CONSTRAINT [FK_TimelineEvent_VolumeEntry]
GO

