using System;
using Execution_of_Darkness_Wikia.Services;

namespace Execution_of_Darkness_Wikia.Account
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (User.Identity.IsAuthenticated)
            {
                Response.Redirect("~/");
            }
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            if (txtPassword.Text != txtConfirmPassword.Text)
            {
                lblError.Text = "As senhas não coincidem.";
                lblError.Visible = true;
                return;
            }

            try
            {
                var service = new UserService();
                var user = service.Register(
                    txtUsername.Text.Trim(),
                    txtEmail.Text.Trim(),
                    txtPassword.Text,
                    string.IsNullOrWhiteSpace(txtDisplayName.Text) ? null : txtDisplayName.Text.Trim()
                );

                // Auto-login após registro
                System.Web.Security.FormsAuthentication.SetAuthCookie(user.Username, false);
                var returnUrl = Request.QueryString["ReturnUrl"];
                if (!string.IsNullOrWhiteSpace(returnUrl) && returnUrl.StartsWith("/") && !returnUrl.StartsWith("//") && !returnUrl.Contains("://"))
                {
                    Response.Redirect(returnUrl);
                }
                else
                {
                    Response.Redirect("~/");
                }
            }
            catch (Exception ex)
            {
                lblError.Text = ex.Message;
                lblError.Visible = true;
            }
        }
    }
}