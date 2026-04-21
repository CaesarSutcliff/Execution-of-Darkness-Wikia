using System;
using Execution_of_Darkness_Wikia.Services;

namespace Execution_of_Darkness_Wikia
{
    public partial class _Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
                return;

            var service = new HomePageService();
            var vm = service.Get();

            litTitle.Text = vm.Title;
            litSubtitle.Text = vm.Subtitle;

            rptFactions.DataSource = vm.Factions;
            rptFactions.DataBind();

            rptCharacters.DataSource = vm.FeaturedCharacters;
            rptCharacters.DataBind();

            rptLocations.DataSource = vm.Locations;
            rptLocations.DataBind();

            rptSystems.DataSource = vm.Systems;
            rptSystems.DataBind();

            rptTimeline.DataSource = vm.Timeline;
            rptTimeline.DataBind();
        }
    }
}