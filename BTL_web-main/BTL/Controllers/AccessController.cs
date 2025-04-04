using Microsoft.AspNetCore.Mvc;
using BTL.Models;
using Microsoft.EntityFrameworkCore;

namespace BTL.Controllers
{
    public class AccessController : Controller
    {
        FoodieContext db = new FoodieContext();
        [HttpGet]
        public IActionResult Login()
        {
            if (HttpContext.Session.GetString("Username") == null)
            {
                return View();
            }
            else
            {
                return RedirectToAction("Index", "Home");
            }
        }
        [HttpPost]
        public IActionResult Login(User user)
        {
            if (user.Username == "admin" && user.Password == "admin")
            {
                return RedirectToAction("Index", "Admin");
            }
            if (HttpContext.Session.GetString("Username") == null)
            {
                var u = db.Users.FirstOrDefault(x => x.Username == user.Username && x.Password == user.Password);
                if (u != null)
                {
                    HttpContext.Session.SetString("Username", u.Username);
                    HttpContext.Session.SetInt32("UserId", u.UserId);
                    return RedirectToAction("Index", "Home");
                }
            }
            ModelState.AddModelError("", "Tên đăng nhập hoặc mật khẩu không đúng");
            return View();
        }
        public IActionResult Logout()
        {
            HttpContext.Session.Clear();
            HttpContext.Session.Remove("Username");
            return RedirectToAction("Login", "Access");
        }
        // Đăng ký
        [HttpGet]
        public IActionResult Register()
        {
            return View();
        }
        // Xử lý dữ liệu đăng ký
        [HttpPost]
        public async Task<IActionResult> Register(User model, string ConfirmPassword)
        {
            if (model.Password != ConfirmPassword)
            {
                ModelState.AddModelError("ConfirmPassword", "Mật khẩu và mật khẩu xác nhận không khớp.");
            }
            if (ModelState.IsValid)
            {
                // Kiểm tra xem tên đăng nhập đã tồn tại chưa
                var existingUserByUsername = await db.Users.FirstOrDefaultAsync(u => u.Username == model.Username);
                if (existingUserByUsername != null)
                {
                    ModelState.AddModelError("Username", "Tên đăng nhập đã tồn tại.");
                    return View(model);
                }
                // Kiểm tra xem email đã tồn tại chưa
                var existingUserByEmail = await db.Users.FirstOrDefaultAsync(u => u.Email == model.Email);
                if (existingUserByEmail != null)
                {
                    ModelState.AddModelError("Email", "Email đã tồn tại.");
                    return View(model);
                }
                // Nếu email và tên đăng nhập đều chưa tồn tại, tiếp tục tạo tài khoản mới
                var user = new User
                {
                    Username = model.Username,
                    Password = model.Password, // Lưu ý: Nên mã hóa mật khẩu trước khi lưu
                    Email = model.Email
                };
                // Lưu người dùng mới vào cơ sở dữ liệu
                db.Users.Add(user);
                await db.SaveChangesAsync();
                // Chuyển hướng đến trang đăng nhập hoặc trang chính
                return RedirectToAction("Login", "Access");
            }
            return View(model);
        }
    }
}