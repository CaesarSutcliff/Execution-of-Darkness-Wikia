using System;
using System.Linq;
using Execution_of_Darkness_Wikia.Services;

namespace Execution_of_Darkness_Wikia.Pages.Factions
{
    public partial class FactionList : System.Web.UI.Page
    {
        private readonly FactionService _service = new FactionService();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                txtQuery.Text = Request.QueryString["q"] ?? string.Empty;
                BindFactions();
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            var query = Server.UrlEncode(txtQuery.Text?.Trim() ?? "");
            Response.Redirect(string.Format("~/Pages/Factions/FactionList.aspx?q={0}", query));
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Pages/Factions/FactionList.aspx");
        }

        private void BindFactions()
        {
            var factions = _service.GetAllFactions(txtQuery.Text?.Trim());
            rptFactions.DataSource = factions;
            rptFactions.DataBind();
            pnlEmpty.Visible = !factions.Any();
        }
    }
}
