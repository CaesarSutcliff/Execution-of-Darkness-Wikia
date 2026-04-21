using System;
using System.Linq;
using System.Web.UI.WebControls;
using Execution_of_Darkness_Wikia.Services;

namespace Execution_of_Darkness_Wikia.Pages.Locations
{
    public partial class LocationList : System.Web.UI.Page
    {
        private readonly LocationService _service = new LocationService();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindFilters();
                txtQuery.Text = Request.QueryString["q"] ?? string.Empty;
                var region = Request.QueryString["region"];
                if (!string.IsNullOrWhiteSpace(region) && ddlRegion.Items.FindByValue(region) != null)
                    ddlRegion.SelectedValue = region;
                BindLocations();
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            var query = Server.UrlEncode(txtQuery.Text?.Trim() ?? "");
            var region = Server.UrlEncode(ddlRegion.SelectedValue ?? "");
            Response.Redirect(string.Format("~/Pages/Locations/LocationList.aspx?q={0}&region={1}", query, region));
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Pages/Locations/LocationList.aspx");
        }

        private void BindFilters()
        {
            ddlRegion.Items.Clear();
            ddlRegion.Items.Add(new ListItem("Todas as regiões", ""));
            foreach (var region in _service.GetRegionOptions())
            {
                ddlRegion.Items.Add(new ListItem(region, region));
            }
        }

        private void BindLocations()
        {
            var locations = _service.GetAllLocations(txtQuery.Text?.Trim(), ddlRegion.SelectedValue);
            rptLocations.DataSource = locations;
            rptLocations.DataBind();
            pnlEmpty.Visible = !locations.Any();
        }
    }
}
