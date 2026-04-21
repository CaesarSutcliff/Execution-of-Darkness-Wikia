using System;
using System.Linq;
using Execution_of_Darkness_Wikia.Data;

namespace Execution_of_Darkness_Wikia
{
    public partial class SiteMaster : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                liSchemaCompare.Visible = IsCurrentUserAdmin();
            }
        }

        private bool IsCurrentUserAdmin()
        {
            try
            {
                if (!Context.User.Identity.IsAuthenticated)
                    return false;

                using (var db = new WikiDbContext())
                {
                    var user = db.Users.FirstOrDefault(u => u.Username == Context.User.Identity.Name && u.IsActive);
                    return user != null && user.IsAdmin;
                }
            }
            catch
            {
                return false;
            }
        }

        protected void Unnamed_LoggingOut(object sender, System.Web.UI.WebControls.LoginCancelEventArgs e)
        {
        }
    }
}
