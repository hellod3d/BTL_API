using BTL.Models;
using BTL.Repository;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);


builder.Services.AddHttpClient();
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAll", builder =>
    {
        builder.AllowAnyOrigin()
               .AllowAnyMethod()
               .AllowAnyHeader();
    });
});

builder.Services.AddHttpContextAccessor();
// Thêm Session
builder.Services.AddDistributedMemoryCache(); // L?u session trong b? nh?
builder.Services.AddSession(options =>
{
	options.IdleTimeout = TimeSpan.FromMinutes(30); // Th?i gian h?t h?n session
	options.Cookie.HttpOnly = true; // B?o m?t cookie
	options.Cookie.IsEssential = true; // B?t bu?c s? d?ng (GDPR)
});
// Add services to the container.
builder.Services.AddControllersWithViews();
var connectionString = builder.Configuration.GetConnectionString("FoodieContext");
builder.Services.AddDbContext<FoodieContext>(x => x.UseSqlServer(connectionString));
builder.Services.AddScoped<ILoaiRepository, LoaiRepository>();

var app = builder.Build();
app.UseCors("AllowAll");
app.UseStaticFiles();
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

app.UseAuthorization();

// Dùng Session
app.UseSession();

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");
app.Run();
