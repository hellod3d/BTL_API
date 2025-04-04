using Microsoft.AspNetCore.Mvc;
using System.Net.Http;
using System.Text.Json;
using System.Threading.Tasks;

[Route("api/location")]
[ApiController]
public class LocationController : ControllerBase
{
    private readonly HttpClient _httpClient;

    public LocationController(HttpClient httpClient)
    {
        _httpClient = httpClient;
    }

    [HttpGet("reverse-geocode")]
    public async Task<IActionResult> ReverseGeocode(double lat, double lon)
    {
        string url = $"https://nominatim.openstreetmap.org/reverse?format=json&lat={lat}&lon={lon}";

        try
        {
            // Tạo yêu cầu HTTP với tiêu đề User-Agent
            var request = new HttpRequestMessage(HttpMethod.Get, url);
            request.Headers.Add("User-Agent", "localweb/1.0 (wangtaocaibong@email.com)");

            var response = await _httpClient.SendAsync(request);

            if (!response.IsSuccessStatusCode)
            {
                return StatusCode((int)response.StatusCode, new { message = "Lỗi khi gọi API: " + response.StatusCode });
            }

            var responseString = await response.Content.ReadAsStringAsync();
            var jsonData = JsonSerializer.Deserialize<JsonElement>(responseString);

            if (jsonData.TryGetProperty("display_name", out var address))
            {
                return Ok(new { address = address.GetString() });
            }
            else
            {
                return StatusCode(500, new { message = "Không tìm thấy địa chỉ trong phản hồi từ API." });
            }
        }
        catch (Exception ex)
        {
            // Log chi tiết lỗi
            Console.WriteLine("Exception: " + ex.Message);
            return StatusCode(500, new { message = "Không thể lấy địa chỉ: " + ex.Message });
        }
    }


}
