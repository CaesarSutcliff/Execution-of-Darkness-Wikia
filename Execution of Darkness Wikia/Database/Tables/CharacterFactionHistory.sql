USE [ExecutionOfDarknessWikia]
GO

/****** Object:  Table [dbo].[CharacterFactionHistory]    Script Date: 20/04/2026 20:26:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CharacterFactionHistory](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CharacterId] [int] NOT NULL,
	[FactionId] [int] NOT NULL,
	[RoleName] [nvarchar](120) NULL,
	[StartMarker] [nvarchar](80) NULL,
	[EndMarker] [nvarchar](80) NULL,
	[IsCurrent] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[CharacterFactionHistory] ADD  DEFAULT ((1)) FOR [IsCurrent]
GO

ALTER TABLE [dbo].[CharacterFactionHistory]  WITH CHECK ADD  CONSTRAINT [FK_CharacterFactionHistory_CharacterProfile] FOREIGN KEY([CharacterId])
REFERENCES [dbo].[CharacterProfile] ([Id])
GO

ALTER TABLE [dbo].[CharacterFactionHistory] CHECK CONSTRAINT [FK_CharacterFactionHistory_CharacterProfile]
GO

ALTER TABLE [dbo].[CharacterFactionHistory]  WITH CHECK ADD  CONSTRAINT [FK_CharacterFactionHistory_Faction] FOREIGN KEY([FactionId])
REFERENCES [dbo].[Faction] ([Id])
GO

ALTER TABLE [dbo].[CharacterFactionHistory] CHECK CONSTRAINT [FK_CharacterFactionHistory_Faction]
GO

