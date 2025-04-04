using System;
using System.Collections.Generic;

namespace BTL.Models;

public partial class Booking
{
    public int BookingId { get; set; }

    public string UserName { get; set; } = null!;

    public DateTime Date { get; set; }

    public int Number { get; set; }

    public string? PhoneNumber { get; set; }

    public string? Email { get; set; }
}
