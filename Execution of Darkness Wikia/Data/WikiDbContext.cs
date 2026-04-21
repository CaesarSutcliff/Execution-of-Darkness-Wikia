using System.Data.Entity;
using System.Data.Entity.ModelConfiguration.Conventions;
using Execution_of_Darkness_Wikia.Models;

namespace Execution_of_Darkness_Wikia.Data
{
    public class WikiDbContext : DbContext
    {
        public WikiDbContext() : base("name=EodWikiConnection")
        {
            Configuration.LazyLoadingEnabled = false;
            Configuration.ProxyCreationEnabled = false;
            // Desabilitar validação automática do modelo
            Database.SetInitializer<WikiDbContext>(null);
        }

        public DbSet<WikiArticle> WikiArticles { get; set; }
        public DbSet<ArticleVersion> ArticleVersions { get; set; }
        public DbSet<CharacterProfile> CharacterProfiles { get; set; }
        public DbSet<CharacterRelationship> CharacterRelationships { get; set; }
        public DbSet<Faction> Factions { get; set; }
        public DbSet<Location> Locations { get; set; }
        public DbSet<TimelineEvent> TimelineEvents { get; set; }
        public DbSet<User> Users { get; set; }
        public DbSet<Comment> Comments { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Conventions.Remove<PluralizingTableNameConvention>();

            modelBuilder.Entity<WikiArticle>().ToTable("WikiArticle");
            modelBuilder.Entity<CharacterProfile>().ToTable("CharacterProfile");
            modelBuilder.Entity<CharacterRelationship>().ToTable("CharacterRelationship");
            modelBuilder.Entity<Faction>().ToTable("Faction");
            modelBuilder.Entity<Location>().ToTable("Location");
            modelBuilder.Entity<TimelineEvent>().ToTable("TimelineEvent");

            modelBuilder.Entity<CharacterProfile>()
                .HasOptional(x => x.Faction)
                .WithMany(f => f.Characters)
                .HasForeignKey(x => x.FactionId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<CharacterProfile>()
                .HasOptional(x => x.Location)
                .WithMany(l => l.Residents)
                .HasForeignKey(x => x.LocationId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<CharacterRelationship>()
                .HasRequired(x => x.Character)
                .WithMany()
                .HasForeignKey(x => x.CharacterId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<CharacterRelationship>()
                .HasRequired(x => x.RelatedCharacter)
                .WithMany()
                .HasForeignKey(x => x.RelatedCharacterId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<User>().ToTable("User");
            modelBuilder.Entity<Comment>().ToTable("Comment");

            modelBuilder.Entity<Comment>()
                .HasRequired(x => x.Article)
                .WithMany()
                .HasForeignKey(x => x.ArticleId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Comment>()
                .HasRequired(x => x.User)
                .WithMany()
                .HasForeignKey(x => x.UserId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Comment>()
                .HasOptional(x => x.ParentComment)
                .WithMany()
                .HasForeignKey(x => x.ParentCommentId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<WikiArticle>()
                .HasMany(x => x.ArticleVersions)
                .WithRequired(x => x.Article)
                .HasForeignKey(x => x.ArticleId)
                .WillCascadeOnDelete(true);

            modelBuilder.Entity<WikiArticle>()
                .HasMany(x => x.Comments)
                .WithRequired(x => x.Article)
                .HasForeignKey(x => x.ArticleId)
                .WillCascadeOnDelete(false);

            base.OnModelCreating(modelBuilder);
        }
    }
}
