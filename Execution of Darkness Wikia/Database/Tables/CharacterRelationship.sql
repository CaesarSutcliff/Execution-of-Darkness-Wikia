USE [ExecutionOfDarknessWikia]
GO

/****** Object:  Table [dbo].[CharacterRelationship]    Script Date: 20/04/2026 20:27:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CharacterRelationship](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CharacterId] [int] NOT NULL,
	[RelatedCharacterId] [int] NOT NULL,
	[RelationshipType] [nvarchar](80) NOT NULL,
	[Summary] [nvarchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[CharacterRelationship]  WITH CHECK ADD  CONSTRAINT [FK_CharacterRelationship_CharacterProfile] FOREIGN KEY([CharacterId])
REFERENCES [dbo].[CharacterProfile] ([Id])
GO

ALTER TABLE [dbo].[CharacterRelationship] CHECK CONSTRAINT [FK_CharacterRelationship_CharacterProfile]
GO

ALTER TABLE [dbo].[CharacterRelationship]  WITH CHECK ADD  CONSTRAINT [FK_CharacterRelationship_RelatedCharacter] FOREIGN KEY([RelatedCharacterId])
REFERENCES [dbo].[CharacterProfile] ([Id])
GO

ALTER TABLE [dbo].[CharacterRelationship] CHECK CONSTRAINT [FK_CharacterRelationship_RelatedCharacter]
GO

