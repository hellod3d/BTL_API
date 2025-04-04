using BTL.Controllers;
using BTL.Models;
using BTL.Models.Authentication;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.CodeAnalysis;
using Microsoft.EntityFrameworkCore;
using X.PagedList;
namespace BTL.Areas.Admin.Controllers
{
    [Area("admin")]
    [Route("admin")]
    public class AdminController : Controller
    {   FoodieContext db = new FoodieContext();
        [Route("")]
        [Route("index")]
        public IActionResult Index()
        {
            ViewData["TongDon"] = db.Orders.Count(i => i.OrderNo != null);
            ViewData["TongDangKy"] = db.Users.Count(i => i.UserId != null);
			ViewData["TongThu"] = db.Orders.Where(i => i.ToTalBill != null).Sum(i => i.ToTalBill);
			ViewData["SoMon"] = db.Products.Count(i => i.ProductId != null);
            return View();
        }
        //bắt đầu Loại sản phẩm 
        [Route("loaisanpham")]
        public IActionResult LoaiSanPham(int? page)
		{
			int pageSize = 8;
			int pageNumber = page == null || page < 0 ? 1 : page.Value;
			var lstSanPham = db.Categories.AsNoTracking().OrderBy(x => x.Name);
			PagedList<Category> lst = new PagedList<Category>(lstSanPham, pageNumber, pageSize);
			return View(lst);
		}
        [Route("ThemLoaiSanPhamMoi")]
        [HttpGet]
        public IActionResult ThemLoaiSanPhamMoi()
        {
            return View();
        }
        [Route("themloaisanphammoi")]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult ThemLoaiSanPhamMoi(Category maSanPham)
        {
            if (ModelState.IsValid)
            {
                db.Categories.Add(maSanPham);
                db.SaveChanges();
                return RedirectToAction("LoaiSanPham");
            }
            return View(maSanPham);
        }
        [Route("sualoaisanpham")]
        [HttpGet]
        public IActionResult SuaLoaiSanPham(int loaiSanPham)
        {
            var sanPham = db.Categories.Find(loaiSanPham);
            return View(sanPham);
        }
        [Route("sualoaisanpham")]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult SuaLoaiSanPham(Category maLoaiSanPham)
        {
            if (ModelState.IsValid)
            {
                db.Update(maLoaiSanPham);
                db.SaveChanges();
                return RedirectToAction("LoaiSanPham", "Admin");
            }
            return View(maLoaiSanPham);
        }
        [Route("xoaloaisanpham")]
		[HttpGet]
		public IActionResult XoaLoaiSanPham(int maLoaiSanPham)
		{
			TempData["Message"] = "";
			var chiTietSanPham = db.Products.Where(x => x.CategoryId == maLoaiSanPham).ToList();
			if (chiTietSanPham.Count > 0)
			{
				TempData["Message"] = "Không xoá được loại sản phẩm này.";
				return RedirectToAction("LoaiSanPham", "Admin");
			}
			db.Remove(db.Categories.Find(maLoaiSanPham));
			db.SaveChanges();
			TempData["Message"] = "Loại sản phẩm đã được xoá.";
			return RedirectToAction("LoaiSanPham", "Admin");
		}
		// kết thúc Loại sản phẩm
		// Bắt đầu danh mục sản phẩm
		[Route("danhmucsanpham")]
        public IActionResult DanhMucSanPham(int? page)
        {
            int pageSize = 8;
            int pageNumber = page == null || page < 0 ? 1 : page.Value;
            var lstSanPham = db.Products.AsNoTracking().OrderBy(x=>x.Name);
            PagedList<Product> lst = new PagedList<Product>(lstSanPham, pageNumber, pageSize);
            return View(lst);
        }
        [Route("ThemSanPhamMoi")]
        [HttpGet]
        public IActionResult ThemSanPhamMoi()
        {
            ViewBag.CategoryId = new SelectList(db.Categories.ToList(), "CategoryId", "Name");
            return View(); 
        }
        [Route("ThemSanPhamMoi")]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult ThemSanPhamMoi(Product sanPham)
        {
            if(ModelState.IsValid)
            {
                db.Products.Add(sanPham);
                db.SaveChanges();
                return RedirectToAction("DanhMucSanPham");
            }    
            return View(sanPham);
        }
        [Route("SuaSanPham")]
        [HttpGet]
        public IActionResult SuaSanPham(int maSanPham)
        {
            ViewBag.CategoryId = new SelectList(db.Categories.ToList(), "CategoryId", "Name");
            var sanPham = db.Products.Find(maSanPham);
            return View(sanPham);
        }
        [Route("SuaSanPham")]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult SuaSanPham(Product sanPham)
        {
            if (ModelState.IsValid)
            {
                db.Update(sanPham);
                db.SaveChanges();
                return RedirectToAction("DanhMucSanPham", "Admin");
            }
            return View(sanPham);
        }
        [Route("XoaSanPham")]
        [HttpGet]
        public IActionResult XoaSanPham(int maSanPham)
        {
            TempData["Message"] = "";
            var chiTietSanPham = db.Orders.Where(x => x.ProductId==maSanPham).ToList();
            if (chiTietSanPham.Count>0)
            {
                TempData["Message"] = "Không xoá được sản phẩm này.";
                return RedirectToAction("DanhMucSanPham", "Admin");
            }
            db.Remove(db.Products.Find(maSanPham)); 
            db.SaveChanges();
            TempData["Message"] = "Sản phẩm đã được xoá.";
            return RedirectToAction("DanhMucSanPham", "Admin");
        }
        // kết thúc danh mục sản phẩm
        //bắt đầu user
        [Route("quanlytaikhoan")]
        public IActionResult QuanLyTaiKhoan(int? page)
        {
            int pageSize = 10;
            int pageNumber = page == null || page < 0 ? 1 : page.Value;
            var lstSanPham = db.Users.AsNoTracking().OrderBy(x => x.Name);
            PagedList<User> lst = new PagedList<User>(lstSanPham, pageNumber, pageSize);
            return View(lst);
        }
        [Route("removeuser")]
        [HttpGet]
        public IActionResult removeuser(int userid)
        {
            TempData["Message"] = "";
            var chiTietSanPham = db.Orders.Where(x => x.UserId == userid).ToList();
            if (chiTietSanPham.Count > 0)
            {
                TempData["Message"] = "Không xoá được account này.";
                return RedirectToAction("quanlytaikhoan", "Admin");
            }
            db.Remove(db.Users.Find(userid));
            db.SaveChanges();
            TempData["Message"] = "Tài khoản đã được xoá.";
            return RedirectToAction("quanlytaikhoan", "Admin");
        }
        // kết thúc user

        //bắt đầu dashboard
        [Route("dashboard")]
        [HttpGet]
        public IActionResult DashBoard()
        {
          ViewData["TongDon"] = db.Orders.Count(i=>i.OrderNo!=null);
          ViewData["TongDangKy"] = db.Users.Count(i => i.UserId != null);
		  ViewData["TongThu"] = db.Orders.Where(i => i.ToTalBill != null).Sum(i => i.ToTalBill);
		  ViewData["SoMon"] = db.Products.Count(i=>i.ProductId!=null);
          var lst = db.Orders.ToList();
          return View(lst);
        }
        // bắt đầu phần quản lý đơn hàng
        [Route("quanlydon")]
        [HttpGet]
        public IActionResult QuanLyDon()
        {
            var lst = db.Orders.ToList();
            return View(lst);
        }
        [Route("suaquanlydon")]
        [HttpGet]
        public IActionResult SuaQuanLyDon(int Orderid)
        {
            // Tìm đơn hàng theo Orderid
            var order = db.Orders.Find(Orderid);
            order.Status = "Đã hoàn thành";
            db.SaveChanges();
            return RedirectToAction("quanlydon", "admin");
        }
        [Route("xoaquanlydon")]
        [HttpGet]
        public IActionResult XoaQuanLyDon(int Orderid)
        {
            TempData["Message"] = "";
            db.Remove(db.Orders.Find(Orderid));
            db.SaveChanges();
            TempData["Message"] = "Đơn hàng đã được xoá.";
            return RedirectToAction("quanlydon", "Admin");
        }
        // bắt đầu phần quản lý tin nhắn
        [Route("quanlytinnhan")]
        [HttpGet]
        public IActionResult QuanLyTinNhan()
        {
            var lst = db.Contacts.ToList();
            return View(lst);
        }
        [Route("XoaTinNhan")]
        [HttpGet]
        public IActionResult XoaTinNhan(int contactid)
        {
            TempData["Message"] = "";
            db.Remove(db.Contacts.Find(contactid));
            db.SaveChanges();
            TempData["Message"] = "Liên hệ đã được xoá.";
            return RedirectToAction("quanlytinnhan", "Admin");
        }
		//bắt đầu user
		[Route("DatBan")]
		[HttpGet]
		public IActionResult DatBan(int? page)
		{
			int pageSize = 10;
			int pageNumber = page == null || page < 0 ? 1 : page.Value;
			var lstSanPham = db.Bookings.AsNoTracking().OrderBy(x => x.Email);
			PagedList<Booking> lst = new PagedList<Booking>(lstSanPham, pageNumber, pageSize);
			return View(lst);
		}
		[Route("XoaDatBan")]
		[HttpGet]
		public IActionResult XoaDatBan(int BookingId)
		{
			TempData["Message"] = "";
			db.Remove(db.Bookings.Find(BookingId));
			db.SaveChanges();
			TempData["Message"] = "Liên hệ đã được xoá.";
			return RedirectToAction("DatBan", "Admin");
		}
		// kết thúc user
	}
}
