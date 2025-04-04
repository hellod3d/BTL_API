using BTL.Models;
namespace BTL.Models.ProductModels
{
    public class Product
    {
        public int ProductId { get; set; }

        public string? Name { get; set; }

        public string? Description { get; set; }

        public decimal? Price { get; set; }

        public int? Quantity { get; set; }

        public string? ImageUrl { get; set; }

        public int? CategoryId { get; set; }

        public bool? IsActive { get; set; }
        public DateTime? CreateDate { get; set; }

        public string? Review { get; set; }

        public int? IdReview { get; set; }

        public double? Rating { get; set; }

        public string? UserReview { get; set; }

        public DateTime? DateReview { get; set; }
    }
}
