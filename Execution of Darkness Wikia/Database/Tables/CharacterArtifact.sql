USE [ExecutionOfDarknessWikia]
GO

/****** Object:  Table [dbo].[CharacterArtifact]    Script Date: 20/04/2026 20:26:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CharacterArtifact](
	[CharacterId] [int] NOT NULL,
	[ArtifactId] [int] NOT NULL,
	[Notes] [nvarchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[CharacterId] ASC,
	[ArtifactId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[CharacterArtifact]  WITH CHECK ADD  CONSTRAINT [FK_CharacterArtifact_ArtifactEntry] FOREIGN KEY([ArtifactId])
REFERENCES [dbo].[ArtifactEntry] ([Id])
GO

ALTER TABLE [dbo].[CharacterArtifact] CHECK CONSTRAINT [FK_CharacterArtifact_ArtifactEntry]
GO

ALTER TABLE [dbo].[CharacterArtifact]  WITH CHECK ADD  CONSTRAINT [FK_CharacterArtifact_CharacterProfile] FOREIGN KEY([CharacterId])
REFERENCES [dbo].[CharacterProfile] ([Id])
GO

ALTER TABLE [dbo].[CharacterArtifact] CHECK CONSTRAINT [FK_CharacterArtifact_CharacterProfile]
GO

