USE [ExecutionOfDarknessWikia]
GO

/****** Object:  Table [dbo].[EventCharacter]    Script Date: 20/04/2026 20:27:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[EventCharacter](
	[EventId] [int] NOT NULL,
	[CharacterId] [int] NOT NULL,
	[ParticipationType] [nvarchar](80) NULL,
PRIMARY KEY CLUSTERED 
(
	[EventId] ASC,
	[CharacterId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[EventCharacter]  WITH CHECK ADD  CONSTRAINT [FK_EventCharacter_CharacterProfile] FOREIGN KEY([CharacterId])
REFERENCES [dbo].[CharacterProfile] ([Id])
GO

ALTER TABLE [dbo].[EventCharacter] CHECK CONSTRAINT [FK_EventCharacter_CharacterProfile]
GO

ALTER TABLE [dbo].[EventCharacter]  WITH CHECK ADD  CONSTRAINT [FK_EventCharacter_TimelineEvent] FOREIGN KEY([EventId])
REFERENCES [dbo].[TimelineEvent] ([Id])
GO

ALTER TABLE [dbo].[EventCharacter] CHECK CONSTRAINT [FK_EventCharacter_TimelineEvent]
GO

