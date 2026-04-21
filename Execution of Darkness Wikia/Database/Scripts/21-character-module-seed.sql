USE ExecutionOfDarknessWikia;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.Faction WHERE Slug = 'executores')
    INSERT INTO dbo.Faction (CreatedAt, UpdatedAt, IsActive, Name, Slug, Summary, Description, Motto, Alignment)
    VALUES (GETDATE(), GETDATE(), 1, 'Executores', 'executores', 'Ordem ligada ao combate direto contra as trevas.', 'Base institucional de famílias como DeRose e Terine.', 'Luz contra a escuridão.', 'Ordem');

IF NOT EXISTS (SELECT 1 FROM dbo.Faction WHERE Slug = 'paladinos')
    INSERT INTO dbo.Faction (CreatedAt, UpdatedAt, IsActive, Name, Slug, Summary, Description, Motto, Alignment)
    VALUES (GETDATE(), GETDATE(), 1, 'Paladinos', 'paladinos', 'Nobreza guerreira marcada por glória e aparência.', 'Casa e honra caminham junto da política do reino.', 'Honra acima do medo.', 'Nobreza');

IF NOT EXISTS (SELECT 1 FROM dbo.Faction WHERE Slug = 'imperiais')
    INSERT INTO dbo.Faction (CreatedAt, UpdatedAt, IsActive, Name, Slug, Summary, Description, Motto, Alignment)
    VALUES (GETDATE(), GETDATE(), 1, 'Imperiais', 'imperiais', 'Braço institucional da Coroa.', 'Militarismo e protocolo a serviço do reino.', 'A Coroa permanece.', 'Estado');

IF NOT EXISTS (SELECT 1 FROM dbo.Location WHERE Slug = 'mansao-derose')
    INSERT INTO dbo.Location (CreatedAt, UpdatedAt, IsActive, Name, Slug, Summary, Description, Region, DangerLevel)
    VALUES (GETDATE(), GETDATE(), 1, 'Mansão DeRose', 'mansao-derose', 'Centro do drama íntimo da família DeRose.', 'Sede familiar e símbolo do peso do legado.', 'Domínio DeRose', 'Moderado');

IF NOT EXISTS (SELECT 1 FROM dbo.Location WHERE Slug = 'academia-lazarell')
    INSERT INTO dbo.Location (CreatedAt, UpdatedAt, IsActive, Name, Slug, Summary, Description, Region, DangerLevel)
    VALUES (GETDATE(), GETDATE(), 1, 'Academia Lazarell', 'academia-lazarell', 'Polo de formação das ordens.', 'Aqui nascem rivalidades, alianças e humilhações decisivas.', 'Ostium', 'Moderado');

IF NOT EXISTS (SELECT 1 FROM dbo.Location WHERE Slug = 'ostium')
    INSERT INTO dbo.Location (CreatedAt, UpdatedAt, IsActive, Name, Slug, Summary, Description, Region, DangerLevel)
    VALUES (GETDATE(), GETDATE(), 1, 'Ostium', 'ostium', 'Centro político e social do reino.', 'Cidade onde metal, fé, poder e podridão se cruzam.', 'Coração do Reino', 'Alto');

IF NOT EXISTS (SELECT 1 FROM dbo.Location WHERE Slug = 'pantano-das-almas-perdidas')
    INSERT INTO dbo.Location (CreatedAt, UpdatedAt, IsActive, Name, Slug, Summary, Description, Region, DangerLevel)
    VALUES (GETDATE(), GETDATE(), 1, 'Pântano das Almas Perdidas', 'pantano-das-almas-perdidas', 'Território corruptor e mentalmente hostil.', 'Zona crítica associada ao Vínculo de Rosanera e ruínas antigas.', 'Fronteira Sombria', 'Extremo');

DECLARE @ExecutoresId INT = (SELECT TOP 1 Id FROM dbo.Faction WHERE Slug = 'executores');
DECLARE @PaladinosId INT = (SELECT TOP 1 Id FROM dbo.Faction WHERE Slug = 'paladinos');
DECLARE @ImperiaisId INT = (SELECT TOP 1 Id FROM dbo.Faction WHERE Slug = 'imperiais');

DECLARE @MansaoDeRoseId INT = (SELECT TOP 1 Id FROM dbo.Location WHERE Slug = 'mansao-derose');
DECLARE @AcademiaLazarellId INT = (SELECT TOP 1 Id FROM dbo.Location WHERE Slug = 'academia-lazarell');
DECLARE @OstiumId INT = (SELECT TOP 1 Id FROM dbo.Location WHERE Slug = 'ostium');
DECLARE @PantanoId INT = (SELECT TOP 1 Id FROM dbo.Location WHERE Slug = 'pantano-das-almas-perdidas');

IF NOT EXISTS (SELECT 1 FROM dbo.CharacterProfile WHERE Slug = 'julian-derose')
BEGIN
    INSERT INTO dbo.CharacterProfile
    (
        CreatedAt, UpdatedAt, IsActive, Name, Slug, Alias, Summary, Biography, AgeText, Clan, Occupation,
        RankTitle, StatusText, FirstAppearance, Race, Gender, Alignment, BirthPlace, Residence,
        Personality, Appearance, AbilitiesOverview, Quote, AvatarUrl, BannerUrl,
        IsFeaturedOnHome, FeaturedOrder, FactionId, LocationId
    )
    VALUES
    (
        GETDATE(), GETDATE(), 1, 'Julian DeRose', 'julian-derose', 'Julian',
        'Executor e eixo central da saga, marcado por humilhação, pacto e transformação.',
        'Julian nasce dentro do peso do nome DeRose e atravessa rejeição, treino, perdas e ruptura até se tornar um lobo de guerra moldado por pactos e liderança.',
        'Jovem adulto', 'DeRose', 'Executor', 'Líder da Brigada das Rosas Negras', 'Vivo', 'Volume 1',
        'Humano', 'Masculino', 'Instável / Determinado', 'Mansão DeRose', 'Entre Ostium e a guerra',
        'Ferido, sarcástico, impulsivo, ferozmente leal e resistente à submissão.',
        'Olhar carregado, presença tensa e postura cada vez mais marcada pelo peso do pacto.',
        'Combate direto, resistência extrema, liderança em campo e sinergia anômala com Zerodawn.',
        'Nem todo monstro vem do inferno.',
        NULL, NULL, 1, 1, @ExecutoresId, @MansaoDeRoseId
    );
END

IF NOT EXISTS (SELECT 1 FROM dbo.CharacterProfile WHERE Slug = 'zerodawn-archworth')
BEGIN
    INSERT INTO dbo.CharacterProfile
    (
        CreatedAt, UpdatedAt, IsActive, Name, Slug, Alias, Summary, Biography, AgeText, Clan, Occupation,
        RankTitle, StatusText, FirstAppearance, Race, Gender, Alignment, BirthPlace, Residence,
        Personality, Appearance, AbilitiesOverview, Quote, AvatarUrl, BannerUrl,
        IsFeaturedOnHome, FeaturedOrder, FactionId, LocationId
    )
    VALUES
    (
        GETDATE(), GETDATE(), 1, 'Zerodawn Archworth', 'zerodawn-archworth', 'Zero',
        'Entidade primordial ligada a Julian por pacto, caos e intimidade letal.',
        'Mais antiga do que a maioria compreende, Zerodawn atravessa a história como força cósmica, vontade, ruína e parceria desconfortavelmente humana.',
        'Imensurável', 'Archworth', 'Entidade / Portão', 'Quarto Portão do Inferno', 'Ativa', 'Volume 1',
        'Entidade Primordial', 'Feminino', 'Caótica', 'Desconhecido', 'Onde Julian estiver',
        'Provocadora, violenta, brincalhona, íntima, predatória e absurdamente inteligente.',
        'Presença elegante, lunar e ameaçadora, entre beleza sobrenatural e terror puro.',
        'Pacto, energia primordial, domínio destrutivo, leitura psicológica e combate anômalo.',
        'Você me chamou. Agora viva com isso.',
        NULL, NULL, 1, 2, NULL, @OstiumId
    );
END

IF NOT EXISTS (SELECT 1 FROM dbo.CharacterProfile WHERE Slug = 'minerva-dandelion')
BEGIN
    INSERT INTO dbo.CharacterProfile
    (
        CreatedAt, UpdatedAt, IsActive, Name, Slug, Alias, Summary, Biography, AgeText, Clan, Occupation,
        RankTitle, StatusText, FirstAppearance, Race, Gender, Alignment, BirthPlace, Residence,
        Personality, Appearance, AbilitiesOverview, Quote, AvatarUrl, BannerUrl,
        IsFeaturedOnHome, FeaturedOrder, FactionId, LocationId
    )
    VALUES
    (
        GETDATE(), GETDATE(), 1, 'Minerva Dandelion', 'minerva-dandelion', 'Minerva',
        'Vidente e mente estratégica da brigada.',
        'Minerva combina sensibilidade, previsão curta e clareza tática, tornando-se peça indispensável em decisões que separam vida e massacre.',
        'Jovem adulta', 'Dandelion', 'Combatente / Vidente', 'Analista de Campo', 'Viva', 'Volume 1',
        'Humana', 'Feminino', 'Leal', 'Ostium', 'Ostium',
        'Inteligente, contida, observadora e mais firme do que a delicadeza sugere.',
        'Imagem refinada, postura segura e olhar sempre atento ao que os outros não veem.',
        'Previsão curta, leitura de risco e coordenação tática.',
        'Vencer às cegas nunca foi uma opção.',
        NULL, NULL, 1, 3, @ImperiaisId, @OstiumId
    );
END

IF NOT EXISTS (SELECT 1 FROM dbo.CharacterProfile WHERE Slug = 'reis-dandelion')
BEGIN
    INSERT INTO dbo.CharacterProfile
    (
        CreatedAt, UpdatedAt, IsActive, Name, Slug, Alias, Summary, Biography, AgeText, Clan, Occupation,
        RankTitle, StatusText, FirstAppearance, Race, Gender, Alignment, BirthPlace, Residence,
        Personality, Appearance, AbilitiesOverview, Quote, AvatarUrl, BannerUrl,
        IsFeaturedOnHome, FeaturedOrder, FactionId, LocationId
    )
    VALUES
    (
        GETDATE(), GETDATE(), 1, 'Reis Dandelion', 'reis-dandelion', 'Reis',
        'Suporte tático e cérebro frio da brigada.',
        'Reis é a âncora racional em confrontos onde impulso e descontrole custariam tudo.',
        'Jovem adulto', 'Dandelion', 'Combatente / Analista', 'Suporte Tático', 'Vivo', 'Volume 1',
        'Humano', 'Masculino', 'Leal', 'Ostium', 'Ostium',
        'Frio, eficiente, preciso e extremamente confiável sob pressão.',
        'Visual sóbrio e postura de quem já pensa três movimentos à frente.',
        'Análise tática, controle de cenário e apoio de combate.',
        'Sem leitura fria, coragem vira cadáver.',
        NULL, NULL, 1, 4, @ImperiaisId, @OstiumId
    );
END

IF NOT EXISTS (SELECT 1 FROM dbo.CharacterProfile WHERE Slug = 'andrei-wallen')
BEGIN
    INSERT INTO dbo.CharacterProfile
    (
        CreatedAt, UpdatedAt, IsActive, Name, Slug, Alias, Summary, Biography, AgeText, Clan, Occupation,
        RankTitle, StatusText, FirstAppearance, Race, Gender, Alignment, BirthPlace, Residence,
        Personality, Appearance, AbilitiesOverview, Quote, AvatarUrl, BannerUrl,
        IsFeaturedOnHome, FeaturedOrder, FactionId, LocationId
    )
    VALUES
    (
        GETDATE(), GETDATE(), 1, 'Andrei Wallen', 'andrei-wallen', 'Andrei',
        'Paladino de linha de frente que amadurece da arrogância ao respeito de guerra.',
        'Criado em prestígio e disciplina, Andrei precisa reaprender força, dor e companheirismo na prática brutal do campo.',
        'Jovem adulto', 'Wallen', 'Paladino', 'Linha de Frente', 'Vivo', 'Volume 1',
        'Humano', 'Masculino', 'Orgulhoso / Leal', 'Ostium', 'Ostium',
        'Competitivo, frontal, feroz e capaz de rever convicções sob fogo real.',
        'Postura nobre, presença marcante e força física evidente.',
        'Combate corpo a corpo, resistência e pressão ofensiva.',
        'Respeito se conquista sobrevivendo.',
        NULL, NULL, 1, 5, @PaladinosId, @AcademiaLazarellId
    );
END

IF NOT EXISTS (SELECT 1 FROM dbo.CharacterProfile WHERE Slug = 'fehrir-natalian')
BEGIN
    INSERT INTO dbo.CharacterProfile
    (
        CreatedAt, UpdatedAt, IsActive, Name, Slug, Alias, Summary, Biography, AgeText, Clan, Occupation,
        RankTitle, StatusText, FirstAppearance, Race, Gender, Alignment, BirthPlace, Residence,
        Personality, Appearance, AbilitiesOverview, Quote, AvatarUrl, BannerUrl,
        IsFeaturedOnHome, FeaturedOrder, FactionId, LocationId
    )
    VALUES
    (
        GETDATE(), GETDATE(), 1, 'Fehrir Natalian', 'fehrir-natalian', 'Fehrir',
        'Serva, curandeira, espiã e lâmina escondida no coração da saga.',
        'Fehrir reúne cuidado, silêncio e letalidade com uma humanidade rara em meio ao horror.',
        'Jovem adulta', 'Natalian', 'Serva / Curandeira', 'Guardião Silencioso', 'Viva', 'Volume 1',
        'Humana', 'Feminino', 'Leal', 'Desconhecido', 'Entre o dever e a matilha',
        'Empática, reservada, resiliente e perigosamente eficiente quando decide agir.',
        'Presença discreta, quase suave, contrastando com a violência que pode esconder.',
        'Cura, infiltração, leitura social e letalidade contida.',
        'Nem toda ternura é fraqueza.',
        NULL, NULL, 1, 6, NULL, @OstiumId
    );
END

IF NOT EXISTS (SELECT 1 FROM dbo.CharacterProfile WHERE Slug = 'geen-derose')
BEGIN
    INSERT INTO dbo.CharacterProfile
    (
        CreatedAt, UpdatedAt, IsActive, Name, Slug, Alias, Summary, Biography, AgeText, Clan, Occupation,
        RankTitle, StatusText, FirstAppearance, Race, Gender, Alignment, BirthPlace, Residence,
        Personality, Appearance, AbilitiesOverview, Quote, AvatarUrl, BannerUrl,
        IsFeaturedOnHome, FeaturedOrder, FactionId, LocationId
    )
    VALUES
    (
        GETDATE(), GETDATE(), 1, 'Geen DeRose', 'geen-derose', 'Geen',
        'Primogênito exemplar aos olhos do mundo e sombra insuportável para Julian.',
        'Geen encarna prestígio, disciplina e a face perfeita do legado DeRose, tornando-se ao mesmo tempo modelo e veneno dentro da família.',
        'Jovem adulto', 'DeRose', 'Executor', 'Primogênito DeRose', 'Vivo', 'Volume 1',
        'Humano', 'Masculino', 'Controlado', 'Mansão DeRose', 'Mansão DeRose',
        'Polido, superior, disciplinado e esmagadoramente seguro de si.',
        'Aparência impecável, postura régia e presença que humilha sem esforço.',
        'Treinamento refinado, disciplina marcial e autoridade natural.',
        'Nem todos nasceram para carregar um nome.',
        NULL, NULL, 1, 7, @ExecutoresId, @MansaoDeRoseId
    );
END

DECLARE @JulianId INT = (SELECT TOP 1 Id FROM dbo.CharacterProfile WHERE Slug = 'julian-derose');
DECLARE @ZeroId INT = (SELECT TOP 1 Id FROM dbo.CharacterProfile WHERE Slug = 'zerodawn-archworth');
DECLARE @MinervaId INT = (SELECT TOP 1 Id FROM dbo.CharacterProfile WHERE Slug = 'minerva-dandelion');
DECLARE @ReisId INT = (SELECT TOP 1 Id FROM dbo.CharacterProfile WHERE Slug = 'reis-dandelion');
DECLARE @AndreiId INT = (SELECT TOP 1 Id FROM dbo.CharacterProfile WHERE Slug = 'andrei-wallen');
DECLARE @FehrirId INT = (SELECT TOP 1 Id FROM dbo.CharacterProfile WHERE Slug = 'fehrir-natalian');
DECLARE @GeenId INT = (SELECT TOP 1 Id FROM dbo.CharacterProfile WHERE Slug = 'geen-derose');

IF NOT EXISTS (SELECT 1 FROM dbo.CharacterRelationship WHERE CharacterId = @JulianId AND RelatedCharacterId = @ZeroId AND RelationshipType = 'Pacto')
    INSERT INTO dbo.CharacterRelationship (CharacterId, RelatedCharacterId, RelationshipType, Summary)
    VALUES (@JulianId, @ZeroId, 'Pacto', 'Vínculo central da saga, feito de dependência, conflito, poder e intimidade perigosa.');

IF NOT EXISTS (SELECT 1 FROM dbo.CharacterRelationship WHERE CharacterId = @JulianId AND RelatedCharacterId = @GeenId AND RelationshipType = 'Irmão / Rivalidade')
    INSERT INTO dbo.CharacterRelationship (CharacterId, RelatedCharacterId, RelationshipType, Summary)
    VALUES (@JulianId, @GeenId, 'Irmão / Rivalidade', 'A perfeição de Geen amplifica a humilhação e a revolta que moldam Julian.');

IF NOT EXISTS (SELECT 1 FROM dbo.CharacterRelationship WHERE CharacterId = @JulianId AND RelatedCharacterId = @MinervaId AND RelationshipType = 'Aliada')
    INSERT INTO dbo.CharacterRelationship (CharacterId, RelatedCharacterId, RelationshipType, Summary)
    VALUES (@JulianId, @MinervaId, 'Aliada', 'Minerva fornece leitura e suporte tático cruciais à sobrevivência da matilha.');

IF NOT EXISTS (SELECT 1 FROM dbo.CharacterRelationship WHERE CharacterId = @JulianId AND RelatedCharacterId = @ReisId AND RelationshipType = 'Aliado')
    INSERT INTO dbo.CharacterRelationship (CharacterId, RelatedCharacterId, RelationshipType, Summary)
    VALUES (@JulianId, @ReisId, 'Aliado', 'Reis complementa a brutalidade de campo com disciplina estratégica.');

IF NOT EXISTS (SELECT 1 FROM dbo.CharacterRelationship WHERE CharacterId = @JulianId AND RelatedCharacterId = @AndreiId AND RelationshipType = 'Rivalidade / Respeito')
    INSERT INTO dbo.CharacterRelationship (CharacterId, RelatedCharacterId, RelationshipType, Summary)
    VALUES (@JulianId, @AndreiId, 'Rivalidade / Respeito', 'A tensão inicial evolui para reconhecimento mútuo forjado pela guerra.');

IF NOT EXISTS (SELECT 1 FROM dbo.CharacterRelationship WHERE CharacterId = @JulianId AND RelatedCharacterId = @FehrirId AND RelationshipType = 'Confiança')
    INSERT INTO dbo.CharacterRelationship (CharacterId, RelatedCharacterId, RelationshipType, Summary)
    VALUES (@JulianId, @FehrirId, 'Confiança', 'Fehrir representa abrigo humano, cuidado e força silenciosa no caos.');

IF NOT EXISTS (SELECT 1 FROM dbo.CharacterRelationship WHERE CharacterId = @ZeroId AND RelatedCharacterId = @JulianId AND RelationshipType = 'Pacto')
    INSERT INTO dbo.CharacterRelationship (CharacterId, RelatedCharacterId, RelationshipType, Summary)
    VALUES (@ZeroId, @JulianId, 'Pacto', 'Julian é o eixo humano pelo qual Zerodawn volta a tocar o mundo de forma íntima.');

UPDATE dbo.CharacterProfile
SET IsFeaturedOnHome = 1
WHERE Slug IN ('julian-derose', 'zerodawn-archworth', 'minerva-dandelion', 'reis-dandelion', 'andrei-wallen', 'fehrir-natalian');
GO
