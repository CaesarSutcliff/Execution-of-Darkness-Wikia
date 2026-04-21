using System;
using System.Linq;
using Execution_of_Darkness_Wikia.Data;

namespace Execution_of_Darkness_Wikia.Account
{
    public partial class Manage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!User.Identity.IsAuthenticated)
            {
                Response.Redirect("~/Account/Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadUserData();
            }
        }

        private void LoadUserData()
        {
            using (var db = new WikiDbContext())
            {
                var user = db.Users.FirstOrDefault(u => u.Username == User.Identity.Name);
                if (user == null)
                {
                    Response.Redirect("~/Account/Login.aspx");
                    return;
                }

                litUsername.Text = user.Username;
                litDisplayName.Text = user.DisplayName ?? user.Username;
                litEmail.Text = user.Email;
                litMemberSince.Text = user.CreatedAt.ToString("dd/MM/yyyy");
                litLastLogin.Text = user.LastLoginAt.HasValue ? user.LastLoginAt.Value.ToString("dd/MM/yyyy HH:mm") : "Primeiro acesso";
            }
        }
    }
}
