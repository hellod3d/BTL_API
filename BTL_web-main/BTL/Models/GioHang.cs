using System;
using System.Collections.Generic;

namespace BTL.Models;

public partial class GioHang
{
    public int GioHangId { get; set; }

    public int UserId { get; set; }

    public int ProductId { get; set; }

    public int SoLuong { get; set; }

    public DateTime NgayTao { get; set; }
}
