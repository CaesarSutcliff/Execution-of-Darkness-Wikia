USE [ExecutionOfDarknessWikia]
GO

/****** Object:  Table [dbo].[VolumeEntry]    Script Date: 20/04/2026 20:29:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[VolumeEntry](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[VolumeNumber] [int] NOT NULL,
	[Title] [nvarchar](200) NOT NULL,
	[Subtitle] [nvarchar](200) NULL,
	[Summary] [nvarchar](max) NULL,
	[CoverImageUrl] [nvarchar](300) NULL,
	[CreatedAt] [datetime] NOT NULL,
	[UpdatedAt] [datetime] NOT NULL,
	[IsPublished] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[VolumeEntry] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO

ALTER TABLE [dbo].[VolumeEntry] ADD  DEFAULT (getdate()) FOR [UpdatedAt]
GO

ALTER TABLE [dbo].[VolumeEntry] ADD  DEFAULT ((1)) FOR [IsPublished]
GO

