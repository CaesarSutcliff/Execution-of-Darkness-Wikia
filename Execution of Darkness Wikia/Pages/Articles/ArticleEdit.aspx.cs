using System;
using System.Web.UI;
using System.Linq;
using Execution_of_Darkness_Wikia.Services;
using Execution_of_Darkness_Wikia.Models;

namespace Execution_of_Darkness_Wikia.Pages.Articles
{
    public partial class ArticleEdit : System.Web.UI.Page
    {
        private ArticleService _articleService = new ArticleService();
        private int? ArticleId => string.IsNullOrEmpty(Request.QueryString["id"]) ? (int?)null : int.Parse(Request.QueryString["id"]);

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!User.Identity.IsAuthenticated)
            {
                Response.Redirect($"~/Account/Login.aspx?ReturnUrl={Server.UrlEncode(Request.RawUrl)}");
                return;
            }

            if (!Page.IsPostBack)
            {
                if (ArticleId.HasValue)
                {
                    LoadArticle(ArticleId.Value);
                }
                else
                {
                    litTitle.Text = "Criar Novo Artigo";
                }
            }
        }

        private void LoadArticle(int id)
        {
            var article = _articleService.GetArticle(id);
            if (article == null)
            {
                Response.Redirect("ArticleList.aspx");
                return;
            }

            litTitle.Text = "Editar Artigo";
            txtArticleTitle.Text = article.Title;
            txtSummary.Text = article.Summary;
            txtContent.Text = article.Content;

            // Carregar histórico
            pnlHistory.Visible = true;
            rptVersions.DataSource = article.ArticleVersions.OrderByDescending(v => v.VersionNumber);
            rptVersions.DataBind();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                string authorName = User.Identity.Name ?? "Anônimo";

                if (ArticleId.HasValue)
                {
                    _articleService.UpdateArticle(
                        ArticleId.Value,
                        txtArticleTitle.Text.Trim(),
                        txtSummary.Text.Trim(),
                        txtContent.Text,
                        authorName,
                        txtChangeSummary.Text.Trim()
                    );
                }
                else
                {
                    _articleService.CreateArticle(
                        txtArticleTitle.Text.Trim(),
                        txtSummary.Text.Trim(),
                        txtContent.Text,
                        authorName,
                        txtChangeSummary.Text.Trim()
                    );
                }

                Response.Redirect("ArticleList.aspx");
            }
            catch (Exception ex)
            {
                lblError.Text = ex.Message;
                lblError.Visible = true;
            }
        }

        protected void btnPreview_Click(object sender, EventArgs e)
        {
            pnlEdit.Visible = false;
            pnlPreview.Visible = true;

            litPreviewTitle.Text = txtArticleTitle.Text;
            litPreviewSummary.Text = txtSummary.Text;
            litPreviewContent.Text = txtContent.Text.Replace("\n", "<br/>"); // Simples preview
        }

        protected void btnBackToEdit_Click(object sender, EventArgs e)
        {
            pnlPreview.Visible = false;
            pnlEdit.Visible = true;
        }
    }
}