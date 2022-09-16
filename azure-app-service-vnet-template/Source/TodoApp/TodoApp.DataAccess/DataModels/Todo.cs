
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace TodoApp.DataAccess.DataModels
{
    [Table("Todo")]
    public class Todo
    {
        public long Id { get; set; }
        [Required]
        public string Name { get; set; }
        public string? Description { get; set; }
        public bool IsCompleted { get; set; }
        [Required]
        public DateTime CreatedTime { get; set; }
        public DateTime? CompletedTime { get; set; }
        [Required]
        public string CreatedUser { get; set; }
    }
}
