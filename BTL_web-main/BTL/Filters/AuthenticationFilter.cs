using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;

public class AuthenticationFilter : ActionFilterAttribute
{
    public override void OnActionExecuting(ActionExecutingContext context)
    {
        if (context.HttpContext.Session.GetString("Username") == null)
        {
            context.HttpContext.Session.SetString("ReturnUrl", context.HttpContext.Request.Path);
            context.Result = new RedirectToActionResult("Login", "Access", null);
        }
        base.OnActionExecuting(context);
    }
} 