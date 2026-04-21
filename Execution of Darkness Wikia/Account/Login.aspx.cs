using System;
using System.Web.Security;
using Execution_of_Darkness_Wikia.Services;

namespace Execution_of_Darkness_Wikia.Account
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (User.Identity.IsAuthenticated)
            {
                Response.Redirect("~/");
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            var service = new UserService();
            var user = service.Authenticate(txtUsername.Text.Trim(), txtPassword.Text);

            if (user != null)
            {
                FormsAuthentication.SetAuthCookie(user.Username, false);
                Response.Redirect(FormsAuthentication.GetRedirectUrl(user.Username, false));
            }
            else
            {
                lblError.Text = "Usuário ou senha inválidos.";
                lblError.Visible = true;
            }
        }
    }
}