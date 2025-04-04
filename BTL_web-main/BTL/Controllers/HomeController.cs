using BTL.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.ViewComponents;
using Microsoft.EntityFrameworkCore;
using System.Diagnostics;

namespace BTL.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        FoodieContext db = new FoodieContext();
        public HomeController(ILogger<HomeController> logger)
        {
            _logger = logger;
        }

        public IActionResult Index()
        {
            return View();
        }
        public IActionResult About()
        {
            return View();
        }
        public IActionResult Privacy()
        {
            return View();
        }
        public IActionResult Menu()
        {
            return View();
        }
		[HttpGet]
		public IActionResult book()
		{
			return View();
		}
		[HttpPost]
		public IActionResult book(Booking book)
		{
			if (ModelState.IsValid)
			{
				// Lưu booking vào database
				db.Bookings.Add(book);
				db.SaveChanges();
				// Redirect hoặc thông báo thành công
				TempData["SuccessMessage"] = "Đặt bàn thành công!";
				return RedirectToAction("Index", "Home");
			}
			// Nếu model không hợp lệ, trả về view với thông báo lỗi
			return View(book);
		}
	
        public IActionResult ChiTietSanPham(int maSp)
        {
            var sanPham = db.Products.SingleOrDefault(x => x.ProductId == maSp);
            if (sanPham == null)
            {
                return NotFound("Sản phẩm không tồn tại.");
            }

            var userId = HttpContext.Session.GetInt32("UserId");
            ViewBag.HasPurchased = userId.HasValue && HasUserPurchasedProduct(userId.Value, maSp);
            
            if (userId.HasValue)
            {
                var user = db.Users.Find(userId.Value);
                ViewBag.UserName = user?.Name;
                ViewBag.UserImage = user?.ImageUrl ?? "default-avatar.jpg";
            }
            
            return View(sanPham);
        }
        [AuthenticationFilter]
        public IActionResult UserProfile()
        {
            var userId = HttpContext.Session.GetInt32("UserId");
            var user = db.Users.FirstOrDefault(u => u.UserId == userId);
            return View(user);
        }
        
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult UserProfile(User updatedUser)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    var user = db.Users.Find(updatedUser.UserId);
                    if (user == null)
                    {
                        return NotFound();
                    }

                    // Cập nhật thông tin user
                    user.Name = updatedUser.Name;
                    user.Email = updatedUser.Email;
                    user.Mobile = updatedUser.Mobile;
                    user.Address = updatedUser.Address;
                    user.PostCode = updatedUser.PostCode;
                    user.ImageUrl = updatedUser.ImageUrl;

                    db.SaveChanges();
                    TempData["SuccessMessage"] = "Cập nhật thông tin thành công!";
                    return RedirectToAction(nameof(UserProfile));
                }
                catch (Exception)
                {
                    ModelState.AddModelError("", "Có lỗi xảy ra khi cập nhật thông tin");
                }
            }
            return View(updatedUser);
        }
        [AuthenticationFilter]
        [HttpGet]
        public IActionResult Payment()
        {
            var userId = HttpContext.Session.GetInt32("UserId");
            
            // Kiểm tra xem có sản phẩm trong giỏ hàng không
            var hasCartItems = db.Carts.Any(c => c.UserId == userId);
            if (!hasCartItems)
            {
                TempData["ErrorMessage"] = "Giỏ hàng của bạn đang trống. Vui lòng thêm sản phẩm vào giỏ hàng.";
                return RedirectToAction("Menu");
            }
            
            // Lấy thông tin user
            User user = db.Users.FirstOrDefault(x => x.UserId == userId);
            
            // Lấy thông tin giỏ hàng và tính tổng
            var cartItems = db.Carts
                .Where(c => c.UserId == userId)
                .Join(db.Products,
                    cart => cart.ProductId,
                    product => product.ProductId,
                    (cart, product) => new {
                        ProductId = product.ProductId,
                        Name = product.Name,
                        Price = product.Price ?? 0m,
                        Quantity = cart.Quantity,
                        Subtotal = (product.Price ?? 0m) * cart.Quantity
                    })
                .ToList();

            // Tính tổng với null check
            decimal subtotal = cartItems.Sum(item => item.Subtotal ?? 0m);
            decimal shippingFee = 5.00m; // Phí ship cố định
            decimal total = subtotal + shippingFee;

            // Tạo payment model
            Payment pm = new Payment
            {
                UserId = (int)userId,
                Name = user?.Name ?? "",
                Address = user?.Address ?? "",
                ToTalBill = total,
                PaymentMode = "Online"
            };

            // Lưu thông tin vào ViewBag
            ViewBag.CartItems = cartItems;
            ViewBag.Subtotal = subtotal.ToString("0.00");
            ViewBag.ShippingFee = shippingFee.ToString("0.00");
            ViewBag.TotalAmount = total.ToString("0.00");

            return View(pm);
        }
        [HttpPost]
        [AuthenticationFilter]
        [ValidateAntiForgeryToken]
        public IActionResult Payment(Payment payment)
        {
            if (ModelState.IsValid)
            {
                using (var transaction = db.Database.BeginTransaction())
                {
                    try
                    {
                        // Lưu thông tin payment
                        db.Add(payment);
                        db.SaveChanges();

                        var userId = HttpContext.Session.GetInt32("UserId");
                        
                        // Lấy thông tin giỏ hàng
                        var cartItems = db.Carts
                            .Where(c => c.UserId == userId)
                            .Join(db.Products,
                                cart => cart.ProductId,
                                product => product.ProductId,
                                (cart, product) => new {
                                    ProductId = product.ProductId,
                                    Quantity = cart.Quantity ?? 0,
                                    Price = product.Price ?? 0m
                                })
                            .ToList();

                        // Tạo orders cho từng sản phẩm
                        foreach (var item in cartItems)
                        {
                            var order = new Order
                            {
                                UserId = userId.Value,
                                ProductId = item.ProductId,
                                Quantity = item.Quantity,
                                OrderDate = DateTime.Now,
                                Status = "Pending",
                                ToTalBill = item.Price * item.Quantity
                            };
                            db.Orders.Add(order);
                        }

                        // Xóa giỏ hàng sau khi đặt hàng
                        var userCart = db.Carts.Where(c => c.UserId == userId);
                        db.Carts.RemoveRange(userCart);

                        db.SaveChanges();
                        transaction.Commit();

                        return Json(new { 
                            success = true, 
                            message = "Đặt hàng thành công!",
                            title = "Xác nhận đơn hàng",
                            text = "Cảm ơn bạn đã đặt hàng! Đơn hàng của bạn đã được xác nhận.",
                            icon = "success",
                            confirmButtonText = "Tiếp tục mua sắm",
                            redirectUrl = "/Home/Menu"
                        });
                    }
                    catch (Exception ex)
                    {
                        transaction.Rollback();
                        return Json(new { 
                            success = false, 
                            title = "Lỗi",
                            text = "Có lỗi xảy ra khi xử lý đơn hàng: " + ex.Message,
                            icon = "error",
                            confirmButtonText = "Đóng"
                        });
                    }
                }
            }
            
            // Nếu có lỗi, load lại dữ liệu cho view
            var cartItemsForView = db.Carts
                .Where(c => c.UserId == payment.UserId)
                .Join(db.Products,
                    cart => cart.ProductId,
                    product => product.ProductId,
                    (cart, product) => new {
                        ProductId = product.ProductId,
                        Name = product.Name,
                        Price = product.Price ?? 0m,
                        Quantity = cart.Quantity,
                        Subtotal = (product.Price ?? 0m) * cart.Quantity
                    })
                .ToList();

            decimal subtotal = cartItemsForView.Sum(item => item.Subtotal ?? 0m);
            decimal shippingFee = 5.00m;
            decimal total = subtotal + shippingFee;

            ViewBag.CartItems = cartItemsForView;
            ViewBag.Subtotal = subtotal.ToString("0.00");
            ViewBag.ShippingFee = shippingFee.ToString("0.00");
            ViewBag.TotalAmount = total.ToString("0.00");

            return View(payment);
        }
        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }

        public string GetImageUrl(string imageUrl)
        {
            return Url.Content($"~/Anh/AnhMonAn/{imageUrl}");
        }
        [AuthenticationFilter]
        public IActionResult Cart()
        {
            // Người dùng đã đăng nhập mới có thể truy cập giỏ hàng
            return View();
        }

    

        // Thêm action đ kiểm tra trạng thái đăng nhập
        [HttpPost]
        public IActionResult CheckAuthAndAddToCart(int productId)
        {
            if (HttpContext.Session.GetString("Username") == null)
            {
                return Json(new { 
                    requireLogin = true, 
                    loginUrl = Url.Action("Login", "Access"),
                    message = "Vui lòng đăng nhập để thêm món ăn vào giỏ hàng"
                });
            }

            return Json(new { 
                success = true,
                message = "Đã sẵn sàng thêm vào giỏ hàng"
            });
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        [AuthenticationFilter]
        public IActionResult ChangePassword(string currentPassword, string newPassword, string confirmPassword)
        {
            var userId = HttpContext.Session.GetInt32("UserId");
            var user = db.Users.FirstOrDefault(u => u.UserId == userId);

            if (user == null)
            {
                TempData["PasswordMessage"] = "Không tìm thấy thông tin người dùng";
                TempData["AlertType"] = "error";
                return RedirectToAction("UserProfile");
            }

            if (user.Password != currentPassword)
            {
                TempData["PasswordMessage"] = "Mật khẩu hiện tại không đúng";
                TempData["AlertType"] = "error";
                return RedirectToAction("UserProfile");
            }

            if (newPassword != confirmPassword)
            {
                TempData["PasswordMessage"] = "Mật khẩu mới và mật khẩu xác nhận không khớp";
                TempData["AlertType"] = "error";
                return RedirectToAction("UserProfile");
            }

            if (newPassword.Length < 6)
            {
                TempData["PasswordMessage"] = "Mật khẩu mới phải có ít nhất 6 ký tự";
                TempData["AlertType"] = "error";
                return RedirectToAction("UserProfile");
            }

            try
            {
                user.Password = newPassword;
                db.SaveChanges();
                TempData["PasswordMessage"] = "Đổi mật khẩu thành công";
                TempData["AlertType"] = "success";
                return RedirectToAction("UserProfile");
            }
            catch (Exception)
            {
                TempData["PasswordMessage"] = "Có lỗi xảy ra khi đổi mật khẩu";
                TempData["AlertType"] = "error";
                return RedirectToAction("UserProfile");
            }
        }

        [HttpPost]
        public IActionResult AddToCart(int productId, int quantity)
        {
            try
            {
                var userId = HttpContext.Session.GetInt32("UserId");
                if (userId == null)
                {
                    return Json(new { 
                        requireLogin = true, 
                        loginUrl = Url.Action("Login", "Access"),
                        message = "Vui lòng đăng nhập để thêm món ăn vào giỏ hàng"
                    });
                }

                var product = db.Products.Find(productId);
                if (product == null)
                {
                    return Json(new { 
                        success = false, 
                        message = "Không tìm thấy món ăn này" 
                    });
                }

                // Kiểm tra xem sản phẩm đã có trong giỏ hàng chưa
                var existingCartItem = db.Carts.FirstOrDefault(c => 
                    c.UserId == userId && c.ProductId == productId);

                if (existingCartItem != null)
                {
                    // Nếu đã có, cập nhật số lượng
                    existingCartItem.Quantity += quantity;
                }
                else
                {
                    // Nếu chưa có, tạo mới cart item
                    var cartItem = new Cart
                    {
                        UserId = userId.Value,
                        ProductId = productId,
                        Quantity = quantity
                    };
                    db.Carts.Add(cartItem);
                }

                db.SaveChanges();
                return Json(new { 
                    success = true,
                    message = "Thêm vào giỏ hàng thành công"
                });
            }
            catch (Exception ex)
            {
                return Json(new { 
                    success = false, 
                    message = "Đã xảy ra lỗi: " + ex.Message 
                });
            }
        }

        [HttpGet]
        public IActionResult GetCartItems()
        {
            var userId = HttpContext.Session.GetInt32("UserId");
            if (userId == null)
            {
                return Json(new { 
                    requireLogin = true, 
                    loginUrl = Url.Action("Login", "Access"),
                    message = "Vui lòng đăng nhập để xem giỏ hàng"
                });
            }

            var cartItems = db.Carts
                .Where(c => c.UserId == userId)
                .Join(db.Products,
                    cart => cart.ProductId,
                    product => product.ProductId,
                    (cart, product) => new
                    {
                        ProductId = product.ProductId,
                        Name = product.Name,
                        Price = product.Price,
                        Quantity = cart.Quantity,
                        ImageUrl = product.ImageUrl
                    })
                .ToList();

            return Json(cartItems);
        }

        [HttpPost]
        public IActionResult RemoveFromCart(int productId)
        {
            try
            {
                var userId = HttpContext.Session.GetInt32("UserId");
                if (userId == null)
                {
                    return Json(new { 
                        requireLogin = true, 
                        loginUrl = Url.Action("Login", "Access"),
                        message = "Vui lòng đăng nhập để thực hiện thao tác này"
                    });
                }

                var cartItem = db.Carts.FirstOrDefault(c => 
                    c.UserId == userId && c.ProductId == productId);

                if (cartItem != null)
                {
                    db.Carts.Remove(cartItem);
                    db.SaveChanges();
                    return Json(new { 
                        success = true,
                        message = "Đã xóa món ăn khỏi giỏ hàng"
                    });
                }

                return Json(new { 
                    success = false, 
                    message = "Không tìm thấy món ăn trong giỏ hàng" 
                });
            }
            catch (Exception ex)
            {
                return Json(new { 
                    success = false, 
                    message = "Đã xảy ra lỗi: " + ex.Message 
                });
            }
        }

        [HttpGet]
        public IActionResult GetCartTotal()
        {
            var userId = HttpContext.Session.GetInt32("UserId");
            if (userId == null)
            {
                return Json(new { 
                    success = false, 
                    message = "Vui lòng đăng nhập để xem giỏ hàng" 
                });
            }

            var cartItems = db.Carts
                .Where(c => c.UserId == userId)
                .Join(db.Products,
                    cart => cart.ProductId,
                    product => product.ProductId,
                    (cart, product) => new
                    {
                        Subtotal = (product.Price ?? 0m) * (cart.Quantity ?? 0)
                    })
                .ToList();

            decimal subtotal = cartItems.Sum(item => item.Subtotal);
            decimal shippingFee = 5.00m;
            decimal total = subtotal + shippingFee;

            return Json(new
            {
                success = true,
                subtotal = subtotal.ToString("0.00"),
                shipping = shippingFee.ToString("0.00"),
                total = total.ToString("0.00"),
                message = "Tính toán thành công"
            });
        }

        // Thêm phơng thức mới
        private bool HasUserPurchasedProduct(int userId, int productId)
        {
            return db.Orders.Any(o => 
                o.UserId == userId && 
                o.ProductId == productId
            );
        }
		[HttpPost]
		public IActionResult Logout()
		{
			// Xóa tất cả dữ liệu trong session
			HttpContext.Session.Clear();
			// Chuyển hướng về trang login hoặc trang chủ
			return RedirectToAction("Index", "Home");
		}
		[HttpPost]
		public IActionResult ContactForm(Contact model)
		{
			if (ModelState.IsValid)
			{
				// Lưu thông tin vào cơ sở dữ liệu
				db.Contacts.Add(model);
				db.SaveChanges();

				// Gửi thông báo thành công
				TempData["SuccessMessage"] = "Your message has been sent successfully!";
				return RedirectToAction("Index", "Home");
			}
			// Lấy tên action hiện tại
			var currentView = ControllerContext.RouteData.Values["action"].ToString();
			return RedirectToAction("Index", "Home");
		}
	}
}
