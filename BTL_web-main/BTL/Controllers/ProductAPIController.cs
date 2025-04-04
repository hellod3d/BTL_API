using BTL.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace BTL.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProductAPIController : ControllerBase
    {
        FoodieContext db = new FoodieContext();
        public IEnumerable<Product> GetAllProducts()
        {
            var sanPham = (from c in db.Categories
                           join p in db.Products on c.CategoryId equals p.CategoryId
                           select new Product
                           {
                               ProductId = p.ProductId, // Đảm bảo rằng ProductId được lấy từ cơ sở dữ liệu
                               CategoryId = c.CategoryId,
                               Name = p.Name,
                               Price = p.Price,
                               ImageUrl = p.ImageUrl,


                           }).ToList();
            return sanPham;
        }
        [HttpGet("{categoryid}")]
        public IEnumerable<Product> GetProductByCategory(int categoryId) // Sửa tên tham số cho nhất quán
        {
            var sanPham = (from c in db.Categories
                           join p in db.Products on c.CategoryId equals p.CategoryId
                           where c.CategoryId == categoryId // Thêm điều kiện lọc theo categoryId
                           select new Product
                           {
                               ProductId = p.ProductId,
                               CategoryId = c.CategoryId,
                               Name = p.Name,
                               Price = p.Price,
                               ImageUrl = p.ImageUrl,
                           }).ToList();
            return sanPham;
        }
        //tìm kiếm ajax
        [HttpGet("search")]
        public IActionResult SearchProductByName(string name)
        {
            var products = db.Products
                .Where(p => p.Name.Contains(name))
                .Select(p => new Product
                {
                    ProductId = p.ProductId,
                    Name = p.Name,
                    Price = p.Price,
                    ImageUrl = p.ImageUrl
                })
                .ToList();

            if (!products.Any())
            {
                return NotFound("Không tìm thấy sản phẩm nào với tên này.");
            }

            return Ok(products);
        }

        //lọc sp ajax
        [HttpGet("filter")]
        public IActionResult FilterProductsByPrice(decimal? minPrice, decimal? maxPrice)
        {
            var products = db.Products.AsQueryable();

            if (minPrice.HasValue)
            {
                products = products.Where(p => p.Price >= minPrice.Value);
            }

            if (maxPrice.HasValue)
            {
                products = products.Where(p => p.Price <= maxPrice.Value);
            }

            var result = products.Select(p => new Product
            {
                ProductId = p.ProductId,
                Name = p.Name,
                Price = p.Price,
                ImageUrl = p.ImageUrl
            }).ToList();

            if (!result.Any())
            {
                return NotFound("No products found in the given price range.");
            }

            return Ok(result);
        }

        //lưu trữ review
        // ... existing code ...
        [HttpPost("add-review/{productId}")]
        public IActionResult AddReview(int productId, [FromBody] ReviewDto reviewDto)
        {
            try
            {
                var userId = HttpContext.Session.GetInt32("UserId");
                if (!userId.HasValue)
                {
                    return Unauthorized("Bạn cần đăng nhập để thêm đánh giá.");
                }

                var product = db.Products.Find(productId);
                if (product == null)
                {
                    return NotFound("Không tìm thấy sản phẩm.");
                }

                // Create new review
                var review = new Review
                {
                    ProductId = productId,
                    UserId = userId.Value,
                    Rating = reviewDto.Rating,
                    Comment = reviewDto.Content,
                    CreatedDate = DateTime.Now
                };

                db.Reviews.Add(review);
                db.SaveChanges();

                // Update product's average rating
                var averageRating = db.Reviews
                    .Where(r => r.ProductId == productId)
                    .Average(r => r.Rating);
                
                product.Rating = (int)Math.Round(averageRating);
                product.IdReview = db.Reviews.Count(r => r.ProductId == productId);
                
                db.SaveChanges();

                return Ok(new { success = true, message = "Thêm đánh giá thành công." });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { success = false, message = "Đã xảy ra lỗi: " + ex.Message });
            }
        }

        // DTO cho đánh giá
        public class ReviewDto
        {
            public string Content { get; set; }
            public int Rating { get; set; }
        }

        [HttpGet("reviews/{productId}")]
        public IActionResult GetReviews(int productId)
        {
            try
            {
                var reviews = db.Reviews
                    .Where(r => r.ProductId == productId)
                    .Join(db.Users,
                        review => review.UserId,
                        user => user.UserId,
                        (review, user) => new
                        {
                            UserName = user.Name,
                            UserImage = user.ImageUrl ?? "default-avatar.jpg",
                            review.Rating,
                            review.Comment,
                            review.CreatedDate
                        })
                    .OrderByDescending(r => r.CreatedDate)
                    .ToList();

                return Ok(reviews);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { success = false, message = ex.Message });
            }
        }

        [HttpPost("add-to-cart/{productId}")]
        public IActionResult AddToCart(int productId, [FromBody] CartDto cartDto)
        {
            try
            {
                var userId = HttpContext.Session.GetInt32("UserId");
                if (!userId.HasValue)
                {
                    return Ok(new { 
                        requireLogin = true, 
                        loginUrl = Url.Action("Login", "Access"),
                        message = "Vui lòng đăng nhập để thêm sản phẩm vào giỏ hàng."
                    });
                }

                var product = db.Products.Find(productId);
                if (product == null)
                {
                    return NotFound(new { success = false, message = "Sản phẩm không tồn tại." });
                }

                // Kiểm tra xem sản phẩm đã có trong giỏ hàng chưa
                var existingCartItem = db.Carts.FirstOrDefault(c => 
                    c.UserId == userId && c.ProductId == productId);

                if (existingCartItem != null)
                {
                    // Cập nhật số lượng nếu đã có trong giỏ
                    existingCartItem.Quantity += cartDto.Quantity;
                }
                else
                {
                    // Thêm mới vào giỏ hàng
                    var cartItem = new Cart
                    {
                        UserId = userId.Value,
                        ProductId = productId,
                        Quantity = cartDto.Quantity
                    };
                    db.Carts.Add(cartItem);
                }

                db.SaveChanges();
                return Ok(new { success = true, message = "Thêm vào giỏ hàng thành công." });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { success = false, message = "Đã xảy ra lỗi: " + ex.Message });
            }
        }

        public class CartDto
        {
            public int Quantity { get; set; }
        }

        [HttpPut("update-cart/{productId}")]
        public IActionResult UpdateCartQuantity(int productId, [FromBody] CartDto cartDto)
        {
            try
            {
                var userId = HttpContext.Session.GetInt32("UserId");
                if (!userId.HasValue)
                {
                    return Ok(new { 
                        requireLogin = true, 
                        loginUrl = Url.Action("Login", "Access"),
                        message = "Vui lòng đăng nhập để cập nhật giỏ hàng."
                    });
                }

                var cartItem = db.Carts.FirstOrDefault(c => 
                    c.UserId == userId && c.ProductId == productId);

                if (cartItem == null)
                {
                    return NotFound(new { success = false, message = "Sản phẩm không tồn tại trong giỏ hàng." });
                }

                cartItem.Quantity = cartDto.Quantity;
                db.SaveChanges();

                return Ok(new { success = true, message = "Cập nhật giỏ hàng thành công." });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { success = false, message = "Đã xảy ra lỗi: " + ex.Message });
            }
        }
    }
}
