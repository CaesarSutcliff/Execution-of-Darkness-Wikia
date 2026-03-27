using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace Execution_of_Darkness_Wikia.Models
{
    public class Location : BaseEntity
    {
        public Location()
        {
            Residents = new HashSet<CharacterProfile>();
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

        [StringLength(100)]
        public string Region { get; set; }

        [StringLength(100)]
        public string DangerLevel { get; set; }

        [StringLength(300)]
        public string ImageUrl { get; set; }

        public virtual ICollection<CharacterProfile> Residents { get; set; }
    }
}
