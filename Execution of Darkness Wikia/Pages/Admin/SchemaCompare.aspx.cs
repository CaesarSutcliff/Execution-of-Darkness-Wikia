using System;
using System.Web.UI.WebControls;
using Execution_of_Darkness_Wikia.Services;
using Execution_of_Darkness_Wikia.Data;
using System.Linq;

namespace Execution_of_Darkness_Wikia.Pages.Admin
{
    public partial class SchemaCompare : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Verificar acesso: permitir se não há admins no banco (setup inicial)
            // ou se o usuário logado é admin
            if (!IsAdminOrFirstSetup())
            {
                Response.Redirect("~/Account/Login.aspx?ReturnUrl=" + Server.UrlEncode(Request.RawUrl));
                return;
            }

            if (!IsPostBack)
            {
                BindSchemaDiffs();
                BindScripts();
            }
        }

        private bool IsAdminOrFirstSetup()
        {
            try
            {
                using (var db = new WikiDbContext())
                {
                    // Se não há nenhum admin no banco, permitir acesso (setup inicial)
                    var hasAnyAdmin = db.Users.Any(u => u.IsAdmin && u.IsActive);
                    if (!hasAnyAdmin)
                        return true;

                    // Se há admins, verificar se o usuário logado é admin
                    if (!User.Identity.IsAuthenticated)
                        return false;

                    var currentUser = db.Users.FirstOrDefault(u => u.Username == User.Identity.Name && u.IsActive);
                    return currentUser != null && currentUser.IsAdmin;
                }
            }
            catch
            {
                // Se o banco não existe ou a tabela User não existe, permitir acesso (setup)
                return true;
            }
        }

        private void BindSchemaDiffs()
        {
            try
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
            catch (Exception ex)
            {
                litExpectedTables.Text = "Erro";
                litActualTables.Text = "Erro";
                litDifferenceCount.Text = "Erro";

                pnlOk.Visible = false;
                pnlGrid.Visible = true;

                gvSchemaDiffs.DataSource = new[] { new { Type = "Error", TableName = "Database", ColumnName = "-", Expected = "-", Actual = "-", Details = ex.Message } };
                gvSchemaDiffs.DataBind();
            }
        }

        private void BindScripts()
        {
            var service = new SchemaCompareService();
            var scripts = service.GetAvailableScripts();

            ddlScripts.Items.Clear();
            ddlScripts.Items.Add(new ListItem("Selecione um script...", ""));
            foreach (var script in scripts)
            {
                ddlScripts.Items.Add(new ListItem(script, script));
            }
        }

        protected void btnFullSync_Click(object sender, EventArgs e)
        {
            var service = new SchemaCompareService();
            var result = service.ApplyFullSync("EodWikiConnection");
            ShowResult(result);
            BindSchemaDiffs();
        }

        protected void btnApplyUpgrade_Click(object sender, EventArgs e)
        {
            var service = new SchemaCompareService();
            var result = service.ApplyUpgrade("EodWikiConnection");
            ShowResult(result);
            BindSchemaDiffs();
        }

        protected void btnCreateDatabase_Click(object sender, EventArgs e)
        {
            var service = new SchemaCompareService();
            var result = service.CreateDatabase("EodWikiConnection");
            ShowResult(result);
            BindSchemaDiffs();
        }

        protected void btnGenerateScript_Click(object sender, EventArgs e)
        {
            var service = new SchemaCompareService();
            var script = service.GenerateUpgradeScript("EodWikiConnection");
            litGeneratedScript.Text = Server.HtmlEncode(script);
            pnlGeneratedScript.Visible = true;
        }

        protected void btnRunScript_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(ddlScripts.SelectedValue))
            {
                ShowResult("Selecione um script para executar.");
                return;
            }

            var service = new SchemaCompareService();
            var result = service.ApplyScript("EodWikiConnection", ddlScripts.SelectedValue);
            ShowResult(result);
            BindSchemaDiffs();
        }

        protected void btnCreateAdmin_Click(object sender, EventArgs e)
        {
            var service = new SchemaCompareService();
            var result = service.SeedAdminUser("EodWikiConnection", txtAdminUsername.Text.Trim(), txtAdminPassword.Text);

            lblAdminResult.Text = result;
            lblAdminResult.Visible = true;
            lblAdminResult.Style["color"] = result.Contains("Erro") ? "#ff6b6b" : "#7ddf7d";

            txtAdminPassword.Text = string.Empty;
        }

        private void ShowResult(string message)
        {
            lblUpgradeResult.Text = message;
            pnlResult.Visible = true;
            lblUpgradeResult.Style["color"] = message.Contains("Erro") || message.Contains("ERRO") ? "#ff6b6b" : "#7ddf7d";
        }
    }
}
