using System;
using System.ComponentModel.DataAnnotations;

namespace Execution_of_Darkness_Wikia.Models
{
    public class Comment : BaseEntity
    {
        [Required]
        public int ArticleId { get; set; }

        [Required]
        public int UserId { get; set; }

        public int? ParentCommentId { get; set; }

        [Required]
        public string Content { get; set; }

        public bool IsDeleted { get; set; } = false;

        // Navigation properties
        public virtual WikiArticle Article { get; set; }
        public virtual User User { get; set; }
        public virtual Comment ParentComment { get; set; }
    }
}