using System;
using System.ComponentModel.DataAnnotations;

namespace Execution_of_Darkness_Wikia.Models
{
    public class User : BaseEntity
    {
        [Required]
        [StringLength(100)]
        public string Username { get; set; }

        [Required]
        [EmailAddress]
        [StringLength(200)]
        public string Email { get; set; }

        [Required]
        [StringLength(256)]
        public string PasswordHash { get; set; }

        [Required]
        [StringLength(128)]
        public string Salt { get; set; }

        [StringLength(150)]
        public string DisplayName { get; set; }

        public bool IsAdmin { get; set; } = false;

        public DateTime? LastLoginAt { get; set; }
    }
}