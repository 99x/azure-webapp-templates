using Microsoft.AspNetCore.Authentication.OpenIdConnect;
using Microsoft.Identity.Web;
using Microsoft.Identity.Web.UI;
using Microsoft.IdentityModel.Protocols.OpenIdConnect;
using TodoApp.Portal.Models;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddMicrosoftIdentityWebAppAuthentication(builder.Configuration, AppSettings.Identity);
builder.Services.Configure<OpenIdConnectOptions>(OpenIdConnectDefaults.AuthenticationScheme, options =>
{
    options.ResponseType = OpenIdConnectResponseType.Code;
    options.SignedOutRedirectUri = "/Home";
    options.Scope.Add(options.ClientId);

    // Workaround for Microsoft.Identity.Web not redirecting back to index after signout 
    // https://github.com/dotnet/aspnetcore/issues/18865
    options.Events.OnSignedOutCallbackRedirect = context =>
    {
        context.HttpContext.Response.Redirect(context.Options.SignedOutRedirectUri);
        context.HandleResponse();
        return Task.CompletedTask;
    };
});

// Add services to the container.
builder.Services.AddControllersWithViews();
builder.Services.AddRazorPages().AddMicrosoftIdentityUI();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();

app.UseRouting();
app.UseAuthentication();
app.UseAuthorization();

app.UseEndpoints(endpoints =>
{
    endpoints.MapControllerRoute(
        name: "default",
        pattern: "{controller=Home}/{action=Index}/{id?}");
    endpoints.MapRazorPages();
});

app.Run();
