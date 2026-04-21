using System;
using System.Linq;
using Execution_of_Darkness_Wikia.Services;

namespace Execution_of_Darkness_Wikia.Pages.Characters
{
    public partial class CharacterDetails : System.Web.UI.Page
    {
        private readonly CharacterService _service = new CharacterService();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
                return;

            var slug = Request.QueryString["slug"];
            if (string.IsNullOrWhiteSpace(slug))
            {
                ShowNotFound();
                return;
            }

            var vm = _service.GetCharacterBySlug(slug);
            if (vm == null)
            {
                ShowNotFound();
                return;
            }

            pnlCharacter.Visible = true;
            pnlNotFound.Visible = false;
            Page.Title = vm.Name + " - Execution of Darkness Wikia";

            // Título e resumo
            litName.Text = Safe(vm.Name);
            litSummary.Text = Safe(vm.Summary);

            // Infobox
            litInfoboxName.Text = Safe(vm.Name);
            litFactName.Text = Safe(vm.Name);
            litFactAlias.Text = Safe(vm.Alias);
            litFactStatus.Text = Safe(vm.StatusText);
            litFactClan.Text = Safe(vm.Clan);
            litFactFaction.Text = Safe(vm.FactionName);
            litFactLocation.Text = Safe(vm.LocationName);
            litFactFirstAppearance.Text = Safe(vm.FirstAppearance);
            litFactRank.Text = Safe(vm.RankTitle);
            litFactRace.Text = Safe(vm.Race);
            litFactGender.Text = Safe(vm.Gender);
            litFactBirthPlace.Text = Safe(vm.BirthPlace);
            litFactResidence.Text = Safe(vm.Residence);

            // Citação
            if (!string.IsNullOrWhiteSpace(vm.Quote))
            {
                pnlQuote.Visible = true;
                litQuote.Text = Server.HtmlEncode(vm.Quote);
                litQuoteAuthor.Text = Safe(vm.Name);
            }
            else
            {
                pnlQuote.Visible = false;
            }

            // Seções de conteúdo (ocultar se vazio)
            SetSection(pnlBiography, litBiography, vm.Biography);
            SetSection(pnlPersonality, litPersonality, vm.Personality);
            SetSection(pnlAppearance, litAppearance, vm.Appearance);
            SetSection(pnlAbilities, litAbilities, vm.AbilitiesOverview);

            // Relacionamentos
            rptRelationships.DataSource = vm.Relationships;
            rptRelationships.DataBind();
            pnlNoRelationships.Visible = vm.Relationships == null || !vm.Relationships.Any();
        }

        private void SetSection(System.Web.UI.WebControls.Panel panel, System.Web.UI.WebControls.Literal literal, string value)
        {
            if (string.IsNullOrWhiteSpace(value))
            {
                panel.Visible = false;
            }
            else
            {
                panel.Visible = true;
                literal.Text = Server.HtmlEncode(value);
            }
        }

        private void ShowNotFound()
        {
            pnlCharacter.Visible = false;
            pnlNotFound.Visible = true;
            Response.StatusCode = 404;
        }

        private string Safe(string value)
        {
            return string.IsNullOrWhiteSpace(value) ? "—" : Server.HtmlEncode(value);
        }
    }
}
