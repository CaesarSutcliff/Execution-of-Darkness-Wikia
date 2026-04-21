using System;
using System.Linq;
using Execution_of_Darkness_Wikia.Services;

namespace Execution_of_Darkness_Wikia.Pages.Locations
{
    public partial class LocationDetails : System.Web.UI.Page
    {
        private readonly LocationService _service = new LocationService();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;

            var slug = Request.QueryString["slug"];
            if (string.IsNullOrWhiteSpace(slug))
            {
                ShowNotFound();
                return;
            }

            var vm = _service.GetLocationBySlug(slug);
            if (vm == null)
            {
                ShowNotFound();
                return;
            }

            pnlLocation.Visible = true;
            pnlNotFound.Visible = false;
            Page.Title = vm.Name;

            litName.Text = Server.HtmlEncode(vm.Name);
            litRegion.Text = string.IsNullOrWhiteSpace(vm.Region) ? "Região desconhecida" : Server.HtmlEncode(vm.Region);
            litSummary.Text = string.IsNullOrWhiteSpace(vm.Summary) ? "-" : Server.HtmlEncode(vm.Summary);
            litDescription.Text = string.IsNullOrWhiteSpace(vm.Description) ? "-" : Server.HtmlEncode(vm.Description);
            litFactRegion.Text = string.IsNullOrWhiteSpace(vm.Region) ? "-" : Server.HtmlEncode(vm.Region);
            litFactDanger.Text = string.IsNullOrWhiteSpace(vm.DangerLevel) ? "-" : Server.HtmlEncode(vm.DangerLevel);

            litDangerBadge.Text = string.IsNullOrWhiteSpace(vm.DangerLevel)
                ? string.Empty
                : "<span class='eod-badge'>" + Server.HtmlEncode(vm.DangerLevel) + "</span>";

            rptResidents.DataSource = vm.Residents;
            rptResidents.DataBind();
            pnlNoResidents.Visible = vm.Residents == null || !vm.Residents.Any();
        }

        private void ShowNotFound()
        {
            pnlLocation.Visible = false;
            pnlNotFound.Visible = true;
            Response.StatusCode = 404;
        }
    }
}
