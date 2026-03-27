using System;
using Execution_of_Darkness_Wikia.Services;

namespace Execution_of_Darkness_Wikia.Pages.Admin
{
    public partial class SchemaCompare : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindSchemaDiffs();
            }
        }

        private void BindSchemaDiffs()
        {
            var service = new SchemaCompareService();
            var result = service.Compare("EodWikiConnection");

            litExpectedTables.Text = result.ExpectedTableCount.ToString();
            litActualTables.Text = result.ActualTableCount.ToString();
            litDifferenceCount.Text = result.Differences.Count.ToString();

            pnlOk.Visible = result.Differences.Count == 0;
            pnlGrid.Visible = result.Differences.Count > 0;

            gvSchemaDiffs.DataSource = result.Differences;
            gvSchemaDiffs.DataBind();
        }
    }
}
