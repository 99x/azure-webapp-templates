using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace TodoApp.DataAccess.Migrations
{
    public partial class addForeignKeys : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateIndex(
                name: "IX_Todo_CreatedUser",
                table: "Todo",
                column: "CreatedUser");

            migrationBuilder.AddForeignKey(
                name: "FK_Todo_User_CreatedUser",
                table: "Todo",
                column: "CreatedUser",
                principalTable: "User",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Todo_User_CreatedUser",
                table: "Todo");

            migrationBuilder.DropIndex(
                name: "IX_Todo_CreatedUser",
                table: "Todo");
        }
    }
}
