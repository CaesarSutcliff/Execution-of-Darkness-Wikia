using System;
using System.Linq;
using System.Web.UI.WebControls;
using Execution_of_Darkness_Wikia.Services;

namespace Execution_of_Darkness_Wikia.Pages.Timeline
{
    public partial class TimelineList : System.Web.UI.Page
    {
        private readonly TimelineService _service = new TimelineService();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindFilters();
                txtQuery.Text = Request.QueryString["q"] ?? string.Empty;

                var era = Request.QueryString["era"];
                if (!string.IsNullOrWhiteSpace(era) && ddlEra.Items.FindByValue(era) != null)
                    ddlEra.SelectedValue = era;

                var importance = Request.QueryString["importance"];
                if (!string.IsNullOrWhiteSpace(importance) && ddlImportance.Items.FindByValue(importance) != null)
                    ddlImportance.SelectedValue = importance;

                BindEvents();
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            var query = Server.UrlEncode(txtQuery.Text?.Trim() ?? "");
            var era = Server.UrlEncode(ddlEra.SelectedValue ?? "");
            var importance = Server.UrlEncode(ddlImportance.SelectedValue ?? "");
            Response.Redirect(string.Format("~/Pages/Timeline/TimelineList.aspx?q={0}&era={1}&importance={2}", query, era, importance));
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Pages/Timeline/TimelineList.aspx");
        }

        private void BindFilters()
        {
            ddlEra.Items.Clear();
            ddlEra.Items.Add(new ListItem("Todas as eras", ""));
            foreach (var era in _service.GetEraOptions())
            {
                ddlEra.Items.Add(new ListItem(era, era));
            }

            ddlImportance.Items.Clear();
            ddlImportance.Items.Add(new ListItem("Todas as importâncias", ""));
            foreach (var imp in _service.GetImportanceOptions())
            {
                ddlImportance.Items.Add(new ListItem(imp, imp));
            }
        }

        private void BindEvents()
        {
            var events = _service.GetAllEvents(txtQuery.Text?.Trim(), ddlEra.SelectedValue, ddlImportance.SelectedValue);
            rptEvents.DataSource = events;
            rptEvents.DataBind();
            pnlEmpty.Visible = !events.Any();
        }
    }
}
