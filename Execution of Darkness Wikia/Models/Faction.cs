using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace Execution_of_Darkness_Wikia.Models
{
    public class Faction : BaseEntity
    {
        public Faction()
        {
            Characters = new HashSet<CharacterProfile>();
        }

        [Required]
        [StringLength(150)]
        public string Name { get; set; }

        [Required]
        [StringLength(200)]
        public string Slug { get; set; }

        [StringLength(500)]
        public string Summary { get; set; }

        public string Description { get; set; }

        [StringLength(80)]
        public string FactionType { get; set; }

        [StringLength(150)]
        public string Motto { get; set; }

        [StringLength(100)]
        public string Alignment { get; set; }

        [StringLength(300)]
        public string EmblemUrl { get; set; }

        [StringLength(300)]
        public string CrestUrl { get; set; }

        public virtual ICollection<CharacterProfile> Characters { get; set; }
    }
}
