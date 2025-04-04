using System;
using System.Collections.Generic;

namespace BTL.Models;

public partial class Product
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

    public virtual ICollection<Review> Reviews { get; set; } = new List<Review>();
}
