USE [ExecutionOfDarknessWikia]
GO

/****** Object:  Table [dbo].[CharacterPower]    Script Date: 20/04/2026 20:26:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CharacterPower](
	[CharacterId] [int] NOT NULL,
	[PowerId] [int] NOT NULL,
	[Notes] [nvarchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[CharacterId] ASC,
	[PowerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[CharacterPower]  WITH CHECK ADD  CONSTRAINT [FK_CharacterPower_CharacterProfile] FOREIGN KEY([CharacterId])
REFERENCES [dbo].[CharacterProfile] ([Id])
GO

ALTER TABLE [dbo].[CharacterPower] CHECK CONSTRAINT [FK_CharacterPower_CharacterProfile]
GO

ALTER TABLE [dbo].[CharacterPower]  WITH CHECK ADD  CONSTRAINT [FK_CharacterPower_PowerEntry] FOREIGN KEY([PowerId])
REFERENCES [dbo].[PowerEntry] ([Id])
GO

ALTER TABLE [dbo].[CharacterPower] CHECK CONSTRAINT [FK_CharacterPower_PowerEntry]
GO

