using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using System.Reflection.Metadata;

namespace TodoApp.DataAccess.DataModels
{
    public class TodoContext : DbContext
    {
        public TodoContext(DbContextOptions<TodoContext> options) : base(options) { }

        public DbSet<User> Users { get; set; }
        public DbSet<Todo> Todos { get; set; }

        public string Name => nameof(TodoContext);
        public string Provider => nameof(Microsoft.EntityFrameworkCore);

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<User>()
                        .HasData(
                         new User { Id = 1, FirstName = "Admin", LastName = "Admin", Email = "indunilw@99x.io" });
        }

    }
}
