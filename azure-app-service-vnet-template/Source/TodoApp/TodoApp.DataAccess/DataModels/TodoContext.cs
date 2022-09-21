using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;

namespace TodoApp.DataAccess.DataModels
{
    public class TodoContext : DbContext
    {
        public TodoContext(DbContextOptions<TodoContext> options) : base(options) { }

        public DbSet<User> Users { get; set; }
        public DbSet<Todo> Todos { get; set; }

        public string Name => nameof(TodoContext);
        public string Provider => nameof(Microsoft.EntityFrameworkCore);

    }
}
