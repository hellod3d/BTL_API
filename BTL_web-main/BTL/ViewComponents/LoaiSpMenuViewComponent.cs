using BTL.Models;
using BTL.Repository;
using Microsoft.AspNetCore.Mvc;

namespace BTL.ViewComponents
{
    public class LoaiSpMenuViewComponent : ViewComponent
    {
        private readonly ILoaiRepository _loaiSpRepository;

        public LoaiSpMenuViewComponent(ILoaiRepository loaiSpRepository)
        {
            _loaiSpRepository = loaiSpRepository;
        }

        public IViewComponentResult Invoke()
        {
            var loaisach = _loaiSpRepository.GetAllLoaiSanPham().OrderBy(x => x.CategoryId).Take(7);
            return View(loaisach);
        }
    }
}