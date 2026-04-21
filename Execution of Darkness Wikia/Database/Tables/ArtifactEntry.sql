USE [ExecutionOfDarknessWikia]
GO

/****** Object:  Table [dbo].[ArtifactEntry]    Script Date: 20/04/2026 20:26:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ArtifactEntry](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](150) NOT NULL,
	[Slug] [nvarchar](200) NOT NULL,
	[Summary] [nvarchar](500) NULL,
	[Description] [nvarchar](max) NULL,
	[ArtifactType] [nvarchar](80) NULL,
	[CurrentOwnerCharacterId] [int] NULL,
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

ALTER TABLE [dbo].[ArtifactEntry] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO

ALTER TABLE [dbo].[ArtifactEntry] ADD  DEFAULT (getdate()) FOR [UpdatedAt]
GO

ALTER TABLE [dbo].[ArtifactEntry]  WITH CHECK ADD  CONSTRAINT [FK_ArtifactEntry_CharacterProfile] FOREIGN KEY([CurrentOwnerCharacterId])
REFERENCES [dbo].[CharacterProfile] ([Id])
GO

ALTER TABLE [dbo].[ArtifactEntry] CHECK CONSTRAINT [FK_ArtifactEntry_CharacterProfile]
GO

