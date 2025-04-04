
using System.ComponentModel.DataAnnotations;
public partial class ChangePasswordViewModel
{
    public int UserId { get; set; }

    [Required]
    public string Password { get; set; } // Current password

    [Required]
    public string NewPassword { get; set; }

    [Required]
    [Compare("NewPassword", ErrorMessage = "Mật khẩu xác nhận không khớp.")]
    public string RepeatNewPassword { get; set; }
}