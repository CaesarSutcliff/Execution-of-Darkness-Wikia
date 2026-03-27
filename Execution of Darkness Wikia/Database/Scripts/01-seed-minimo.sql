INSERT INTO dbo.Faction (CreatedAt, UpdatedAt, IsActive, Name, Slug, Summary, Description, Motto, Alignment, EmblemUrl)
VALUES (GETDATE(), GETDATE(), 1, 'Executores', 'executores', 'Ordem central ligada ao combate contra as trevas.', 'Seed inicial da wiki.', 'Luz contra a escuridão.', 'Ordem', NULL);

INSERT INTO dbo.Location (CreatedAt, UpdatedAt, IsActive, Name, Slug, Summary, Description, Region, DangerLevel, ImageUrl)
VALUES (GETDATE(), GETDATE(), 1, 'Mansão DeRose', 'mansao-derose', 'Local importante do universo inicial.', 'Seed inicial da wiki.', 'Domínio DeRose', 'Moderado', NULL);

INSERT INTO dbo.WikiArticle (CreatedAt, UpdatedAt, IsActive, Title, Slug, Summary, Content, Category, IsPublished, PublishedAt, CoverImageUrl)
VALUES (GETDATE(), GETDATE(), 1, 'Execution of Darkness', 'execution-of-darkness', 'Artigo central da wiki.', 'Use este artigo como portal principal da lore.', 'Lore', 1, GETDATE(), NULL);

INSERT INTO dbo.TimelineEvent (CreatedAt, UpdatedAt, IsActive, Title, Slug, Summary, Description, EventDate, Era, ImportanceLevel)
VALUES (GETDATE(), GETDATE(), 1, 'Princípio de Tudo', 'principio-de-tudo', 'Marco inicial para timeline.', 'Seed inicial da linha do tempo.', GETDATE(), 'Era Atual', 'Alta');

DECLARE @FactionId INT = (SELECT TOP 1 Id FROM dbo.Faction WHERE Slug = 'executores');
DECLARE @LocationId INT = (SELECT TOP 1 Id FROM dbo.Location WHERE Slug = 'mansao-derose');

INSERT INTO dbo.CharacterProfile (CreatedAt, UpdatedAt, IsActive, Name, Slug, Alias, Summary, Biography, Rank, Status, FirstAppearance, AvatarUrl, FactionId, LocationId)
VALUES (GETDATE(), GETDATE(), 1, 'Julian DeRose', 'julian-derose', 'Julian', 'Protagonista em conflito com o próprio legado.', 'Seed inicial de personagem.', 'Aprendiz', 'Vivo', 'Volume 1', NULL, @FactionId, @LocationId);
