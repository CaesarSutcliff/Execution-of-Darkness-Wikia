using System;
using System.ComponentModel.DataAnnotations;

namespace Execution_of_Darkness_Wikia.Models
{
    public class ArticleVersion : BaseEntity
    {
        [Required]
        public int ArticleId { get; set; }

        [Required]
        public int VersionNumber { get; set; }

        [Required]
        [StringLength(200)]
        public string TitleSnapshot { get; set; }

        public string ContentSnapshot { get; set; }

        public string AuthorName { get; set; }

        [StringLength(500)]
        public string ChangeSummary { get; set; }

        public virtual WikiArticle Article { get; set; }
    }
}
