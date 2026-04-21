using System.ComponentModel.DataAnnotations;

namespace Execution_of_Darkness_Wikia.Models
{
    public class CharacterProfile : BaseEntity
    {
        [Required]
        [StringLength(150)]
        public string Name { get; set; }

        [Required]
        [StringLength(200)]
        public string Slug { get; set; }

        [StringLength(150)]
        public string Alias { get; set; }

        [StringLength(500)]
        public string Summary { get; set; }

        public string Biography { get; set; }

        [StringLength(50)]
        public string AgeText { get; set; }

        [StringLength(120)]
        public string Clan { get; set; }

        [StringLength(250)]
        public string Occupation { get; set; }

        [StringLength(100)]
        public string RankTitle { get; set; }

        [StringLength(80)]
        public string StatusText { get; set; }

        [StringLength(100)]
        public string FirstAppearance { get; set; }

        [StringLength(80)]
        public string Race { get; set; }

        [StringLength(40)]
        public string Gender { get; set; }

        [StringLength(80)]
        public string Alignment { get; set; }

        [StringLength(150)]
        public string BirthPlace { get; set; }

        [StringLength(150)]
        public string Residence { get; set; }

        public string Personality { get; set; }

        public string Appearance { get; set; }

        public string AbilitiesOverview { get; set; }

        [StringLength(500)]
        public string Quote { get; set; }

        [StringLength(300)]
        public string AvatarUrl { get; set; }

        [StringLength(300)]
        public string BannerUrl { get; set; }

        public bool IsFeaturedOnHome { get; set; }

        public int? FeaturedOrder { get; set; }

        public int? FactionId { get; set; }
        public int? LocationId { get; set; }

        public virtual Faction Faction { get; set; }
        public virtual Location Location { get; set; }
    }
}
