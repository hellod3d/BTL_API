using BTL.Models;

namespace BTL.Repository
{
    public class LoaiRepository : ILoaiRepository
    {
        private readonly FoodieContext _context;
        public LoaiRepository(FoodieContext context)
        {
            _context = context;
        }

        public Category Add(Category loaiSanPham)
        {
            _context.Categories.Add(loaiSanPham);
            _context.SaveChanges();
            return loaiSanPham;
        }

        public Category Delete(string maSanPham)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<Category> GetAllLoaiSanPham()
        {
            return _context.Categories;
        }

        public Category GetloaiSach(string maSanPham)
        {
            return _context.Categories.Find(maSanPham);
        }


        public Category Update(Category loaiSanPham)
        {
            _context.Update(loaiSanPham);
            _context.SaveChanges();
            return loaiSanPham;
        }
    }
}
