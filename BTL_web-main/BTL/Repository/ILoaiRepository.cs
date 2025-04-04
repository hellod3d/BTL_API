using BTL.Models;
namespace BTL.Repository
{
    public interface ILoaiRepository
    {
        Category Add(Category loaiSanPham);
        Category Update(Category loaiSanPham);
        Category Delete(String maSanPham);
        Category GetloaiSach(String maSanPham);
        IEnumerable<Category> GetAllLoaiSanPham();
    }
}
