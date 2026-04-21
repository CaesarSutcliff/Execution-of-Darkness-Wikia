using System;
using System.Data.Entity;
using System.Linq;
using Execution_of_Darkness_Wikia.Models;

namespace Execution_of_Darkness_Wikia.Data
{
    public class WikiDbInitializer : CreateDatabaseIfNotExists<WikiDbContext>
    {
        protected override void Seed(WikiDbContext context)
        {
            if (!context.Factions.Any())
            {
                var executores = new Faction
                {
                    Name = "Executores",
                    Slug = "executores",
                    Summary = "Ordem central ligada ao combate contra as trevas.",
                    Description = "Base inicial para a wiki. Ajuste a lore conforme a sua cronologia oficial.",
                    Motto = "Luz contra a escuridão.",
                    Alignment = "Ordem"
                };

                var mansao = new Location
                {
                    Name = "Mansão DeRose",
                    Slug = "mansao-derose",
                    Summary = "Um dos locais centrais do universo inicial.",
                    Description = "Ponto de partida para personagens e conflitos familiares.",
                    Region = "Domínio DeRose",
                    DangerLevel = "Moderado"
                };

                var julian = new CharacterProfile
                {
                    Name = "Julian DeRose",
                    Slug = "julian-derose",
                    Alias = "Julian",
                    Summary = "Protagonista em conflito com seu próprio legado.",
                    Biography = "Entrada inicial para dar vida ao seed da wiki.",
                    RankTitle = "Aprendiz",
                    StatusText = "Vivo",
                    FirstAppearance = "Volume 1",
                    Faction = executores,
                    Location = mansao,
                    IsFeaturedOnHome = true,
                    FeaturedOrder = 1
                };

                var artigo = new WikiArticle
                {
                    Title = "Execution of Darkness",
                    Slug = "execution-of-darkness",
                    Summary = "Artigo central da wiki com visão geral do universo.",
                    Content = "Use este artigo como portal principal do universo.",
                    Category = "Lore",
                    IsPublished = true,
                    PublishedAt = DateTime.UtcNow
                };

                var evento = new TimelineEvent
                {
                    Title = "Princípio de Tudo",
                    Slug = "principio-de-tudo",
                    Summary = "Marco inicial para organizar a linha temporal.",
                    Description = "Evento seed para validar a estrutura da timeline.",
                    Era = "Era Atual",
                    ImportanceLevel = "Alta"
                };

                context.Factions.Add(executores);
                context.Locations.Add(mansao);
                context.CharacterProfiles.Add(julian);
                context.WikiArticles.Add(artigo);
                context.TimelineEvents.Add(evento);
            }

            base.Seed(context);
        }
    }
}