USE [ExecutionOfDarknessWikia]
GO

/****** Object:  Table [dbo].[EventLocation]    Script Date: 20/04/2026 20:27:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[EventLocation](
	[EventId] [int] NOT NULL,
	[LocationId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[EventId] ASC,
	[LocationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[EventLocation]  WITH CHECK ADD  CONSTRAINT [FK_EventLocation_Location] FOREIGN KEY([LocationId])
REFERENCES [dbo].[Location] ([Id])
GO

ALTER TABLE [dbo].[EventLocation] CHECK CONSTRAINT [FK_EventLocation_Location]
GO

ALTER TABLE [dbo].[EventLocation]  WITH CHECK ADD  CONSTRAINT [FK_EventLocation_TimelineEvent] FOREIGN KEY([EventId])
REFERENCES [dbo].[TimelineEvent] ([Id])
GO

ALTER TABLE [dbo].[EventLocation] CHECK CONSTRAINT [FK_EventLocation_TimelineEvent]
GO

