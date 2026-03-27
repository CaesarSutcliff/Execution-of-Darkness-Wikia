using System;
using System.ComponentModel.DataAnnotations;

namespace Execution_of_Darkness_Wikia.Models
{
    public class WikiArticle : BaseEntity
    {
        [Required]
        [StringLength(200)]
        public string Title { get; set; }

        [Required]
        [StringLength(200)]
        public string Slug { get; set; }

        [StringLength(500)]
        public string Summary { get; set; }

        public string Content { get; set; }

        [StringLength(100)]
        public string Category { get; set; }

        public bool IsPublished { get; set; }

        public DateTime? PublishedAt { get; set; }

        [StringLength(300)]
        public string CoverImageUrl { get; set; }
    }
}
