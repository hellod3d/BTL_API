using Microsoft.AspNetCore.Mvc;
using System;

namespace YourNamespace.Controllers
{
    public class CartController : Controller
    {
        [HttpPost]
        public IActionResult AddToCart(int productId)
        {
            try
            {
                var userId = HttpContext.Session.GetInt32("UserId");
                if (!userId.HasValue)
                {
                    return Json(new { success = false, message = "Chưa đăng nhập" });
                }

                // Thêm sản phẩm vào giỏ hàng và lấy số lượng
                var cartCount = 1; // Thay bằng số lượng thực tế

                return Json(new { success = true, cartCount = cartCount });
            }
            catch
            {
                return Json(new { success = false });
            }
        }

        [HttpGet]
        public IActionResult CheckLoginStatus()
        {
            var isLoggedIn = HttpContext.Session.GetString("Username") != null;
            return Json(new { isLoggedIn = isLoggedIn });
        }

        //[AuthenticationFilter]
        public IActionResult Checkout()
        {
            // Redirect to payment page
            return RedirectToAction("Payment", "Home");
        }
    }
} 