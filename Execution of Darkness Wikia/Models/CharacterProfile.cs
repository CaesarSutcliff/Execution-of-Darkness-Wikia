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

        [StringLength(100)]
        public string Rank { get; set; }

        [StringLength(100)]
        public string Status { get; set; }

        [StringLength(100)]
        public string FirstAppearance { get; set; }

        [StringLength(300)]
        public string AvatarUrl { get; set; }

        public int? FactionId { get; set; }
        public int? LocationId { get; set; }

        public virtual Faction Faction { get; set; }
        public virtual Location Location { get; set; }
    }
}
