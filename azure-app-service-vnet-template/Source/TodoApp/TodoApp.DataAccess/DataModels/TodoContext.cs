using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;

namespace TodoApp.DataAccess.DataModels
{
    public class TodoContext : DbContext
    {
        private string _connection_string;
        public TodoContext(IConfiguration configuration)
        {
            _connection_string = configuration.GetConnectionString("connection_string");
        }

        public DbSet<Todo> Todos { get; set; }

        public string Name => nameof(TodoContext);
        public string Provider => nameof(Microsoft.EntityFrameworkCore);


        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
            => optionsBuilder.UseSqlServer(_connection_string);
    }
}
