using System;
using System.Collections.Generic;

namespace BTL.Models;

public partial class Order
{
    public int OrderDetailsId { get; set; }

    public string? OrderNo { get; set; }

    public int? ProductId { get; set; }

    public int? Quantity { get; set; }

    public int? UserId { get; set; }

    public decimal? ToTalBill { get; set; }

    public string? Status { get; set; }

    public int? PaymentId { get; set; }

    public DateTime? OrderDate { get; set; }
}
