using System;
using System.ComponentModel.DataAnnotations;

namespace Execution_of_Darkness_Wikia.Models
{
    public class TimelineEvent : BaseEntity
    {
        [Required]
        [StringLength(200)]
        public string Title { get; set; }

        [Required]
        [StringLength(200)]
        public string Slug { get; set; }

        [StringLength(500)]
        public string Summary { get; set; }

        public string Description { get; set; }

        public DateTime? EventDate { get; set; }

        [StringLength(100)]
        public string Era { get; set; }

        [StringLength(50)]
        public string ImportanceLevel { get; set; }
    }
}
