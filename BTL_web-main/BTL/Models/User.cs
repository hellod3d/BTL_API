using System;
using System.Collections.Generic;

namespace BTL.Models;

public partial class User
{
    public int UserId { get; set; }

    public string? Name { get; set; }

    public string? Username { get; set; }

    public string? Mobile { get; set; }

    public string? Email { get; set; }

    public string? Address { get; set; }

    public string? PostCode { get; set; }

    public string? Password { get; set; }

    public string? ImageUrl { get; set; }

    public DateTime? CreateDate { get; set; }

    public virtual ICollection<Review> Reviews { get; set; } = new List<Review>();
}
