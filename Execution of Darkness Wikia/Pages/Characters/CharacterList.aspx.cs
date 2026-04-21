using System;
using System.Linq;
using System.Web.UI.WebControls;
using Execution_of_Darkness_Wikia.Services;

namespace Execution_of_Darkness_Wikia.Pages.Characters
{
    public partial class CharacterList : System.Web.UI.Page
    {
        private readonly CharacterService _service = new CharacterService();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindFilters();
                LoadFromQueryString();
                BindCharacters();
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            RedirectWithFilters();
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Pages/Characters/CharacterList.aspx");
        }

        private void BindFilters()
        {
            ddlStatus.Items.Clear();
            ddlStatus.Items.Add(new ListItem("Todos os status", ""));

            foreach (var item in _service.GetStatusOptions())
            {
                ddlStatus.Items.Add(new ListItem(item.Text, item.Value));
            }

            ddlFaction.Items.Clear();
            ddlFaction.Items.Add(new ListItem("Todas as facções", ""));

            foreach (var item in _service.GetFactionOptions())
            {
                ddlFaction.Items.Add(new ListItem(item.Text, item.Value));
            }
        }

        private void LoadFromQueryString()
        {
            txtQuery.Text = Request.QueryString["q"] ?? string.Empty;

            var status = Request.QueryString["status"];
            if (!string.IsNullOrWhiteSpace(status) && ddlStatus.Items.FindByValue(status) != null)
            {
                ddlStatus.SelectedValue = status;
            }

            var faction = Request.QueryString["factionId"];
            if (!string.IsNullOrWhiteSpace(faction) && ddlFaction.Items.FindByValue(faction) != null)
            {
                ddlFaction.SelectedValue = faction;
            }
        }

        private void BindCharacters()
        {
            int? factionId = null;
            if (int.TryParse(ddlFaction.SelectedValue, out var parsedFactionId))
            {
                factionId = parsedFactionId;
            }

            var characters = _service.SearchCharacters(
                txtQuery.Text?.Trim(),
                ddlStatus.SelectedValue,
                factionId);

            rptCharacters.DataSource = characters;
            rptCharacters.DataBind();

            pnlEmpty.Visible = !characters.Any();
        }

        private void RedirectWithFilters()
        {
            var query = Server.UrlEncode(txtQuery.Text?.Trim() ?? "");
            var status = Server.UrlEncode(ddlStatus.SelectedValue ?? "");
            var factionId = Server.UrlEncode(ddlFaction.SelectedValue ?? "");

            var url = string.Format(
                "~/Pages/Characters/CharacterList.aspx?q={0}&status={1}&factionId={2}",
                query,
                status,
                factionId);

            Response.Redirect(url);
        }
    }
}