using System;
using System.Linq;
using Execution_of_Darkness_Wikia.Data;

namespace Execution_of_Darkness_Wikia.Pages.Articles
{
    public partial class ArticleList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                txtSearch.Text = Request.QueryString["q"] ?? string.Empty;
                LoadArticles();
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            var query = Server.UrlEncode(txtSearch.Text?.Trim() ?? "");
            Response.Redirect(string.Format("~/Pages/Articles/ArticleList.aspx?q={0}", query));
        }

        private void LoadArticles()
        {
            using (var db = new WikiDbContext())
            {
                var query = txtSearch.Text?.Trim();
                var data = db.WikiArticles.AsQueryable();

                if (!string.IsNullOrWhiteSpace(query))
                {
                    data = data.Where(a => a.Title.Contains(query) || a.Summary.Contains(query) || a.Content.Contains(query));
                }

                var articles = data.OrderByDescending(a => a.UpdatedAt).ToList();
                rptArticles.DataSource = articles;
                rptArticles.DataBind();
                pnlEmpty.Visible = articles.Count == 0;
            }
        }
    }
}
