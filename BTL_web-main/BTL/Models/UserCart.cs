using System;
using System.Collections.Generic;

namespace BTL.Models;

public partial class UserCart
{
    public int ProductId { get; set; }

    public int UserId { get; set; }

    public int Amount { get; set; }

    public virtual Product Product { get; set; } = null!;

    public virtual User User { get; set; } = null!;
}
