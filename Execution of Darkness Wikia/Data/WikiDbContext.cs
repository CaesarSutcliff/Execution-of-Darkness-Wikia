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
        }

        public DbSet<WikiArticle> WikiArticles { get; set; }
        public DbSet<CharacterProfile> CharacterProfiles { get; set; }
        public DbSet<Faction> Factions { get; set; }
        public DbSet<Location> Locations { get; set; }
        public DbSet<TimelineEvent> TimelineEvents { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Conventions.Remove<PluralizingTableNameConvention>();

            modelBuilder.Entity<WikiArticle>().ToTable("WikiArticle");
            modelBuilder.Entity<CharacterProfile>().ToTable("CharacterProfile");
            modelBuilder.Entity<Faction>().ToTable("Faction");
            modelBuilder.Entity<Location>().ToTable("Location");
            modelBuilder.Entity<TimelineEvent>().ToTable("TimelineEvent");

            modelBuilder.Entity<CharacterProfile>()
                .HasOptional(x => x.Faction)
                .WithMany(x => x.Characters)
                .HasForeignKey(x => x.FactionId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<CharacterProfile>()
                .HasOptional(x => x.Location)
                .WithMany(x => x.Residents)
                .HasForeignKey(x => x.LocationId)
                .WillCascadeOnDelete(false);

            base.OnModelCreating(modelBuilder);
        }
    }
}
