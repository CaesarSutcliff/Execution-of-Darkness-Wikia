using System;
using System.Linq;
using Execution_of_Darkness_Wikia.Services;

namespace Execution_of_Darkness_Wikia.Pages.Factions
{
    public partial class FactionDetails : System.Web.UI.Page
    {
        private readonly FactionService _service = new FactionService();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;

            var slug = Request.QueryString["slug"];
            if (string.IsNullOrWhiteSpace(slug))
            {
                ShowNotFound();
                return;
            }

            var vm = _service.GetFactionBySlug(slug);
            if (vm == null)
            {
                ShowNotFound();
                return;
            }

            pnlFaction.Visible = true;
            pnlNotFound.Visible = false;
            Page.Title = vm.Name;

            litName.Text = Server.HtmlEncode(vm.Name);
            litMotto.Text = string.IsNullOrWhiteSpace(vm.Motto) ? "Sem lema registrado" : Server.HtmlEncode(vm.Motto);
            litSummary.Text = string.IsNullOrWhiteSpace(vm.Summary) ? "-" : Server.HtmlEncode(vm.Summary);
            litDescription.Text = string.IsNullOrWhiteSpace(vm.Description) ? "-" : Server.HtmlEncode(vm.Description);
            litFactAlignment.Text = string.IsNullOrWhiteSpace(vm.Alignment) ? "-" : Server.HtmlEncode(vm.Alignment);
            litFactMotto.Text = string.IsNullOrWhiteSpace(vm.Motto) ? "-" : Server.HtmlEncode(vm.Motto);

            litAlignmentBadge.Text = string.IsNullOrWhiteSpace(vm.Alignment)
                ? string.Empty
                : "<span class='eod-badge'>" + Server.HtmlEncode(vm.Alignment) + "</span>";

            rptMembers.DataSource = vm.Members;
            rptMembers.DataBind();
            pnlNoMembers.Visible = vm.Members == null || !vm.Members.Any();
        }

        private void ShowNotFound()
        {
            pnlFaction.Visible = false;
            pnlNotFound.Visible = true;
            Response.StatusCode = 404;
        }
    }
}
