using System;
using System.Collections.Generic;
using System.Linq;
using Execution_of_Darkness_Wikia.Data;
using Execution_of_Darkness_Wikia.Services;
using Execution_of_Darkness_Wikia.Models;

namespace Execution_of_Darkness_Wikia.Pages.Articles
{
    public partial class ArticleView : System.Web.UI.Page
    {
        private CommentService _commentService = new CommentService();
        private int ArticleId => int.TryParse(Request.QueryString["id"], out var id) ? id : 0;
        private int? ReplyToCommentId
        {
            get => ViewState[nameof(ReplyToCommentId)] as int?;
            set => ViewState[nameof(ReplyToCommentId)] = value;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            LoadArticle();

            if (!Page.IsPostBack)
            {
                LoadComments();
            }
        }

        private void LoadArticle()
        {
            using (var db = new WikiDbContext())
            {
                var article = db.WikiArticles.Find(ArticleId);
                if (article == null)
                {
                    Response.Redirect("ArticleList.aspx");
                    return;
                }

                litArticleTitle.Text = article.Title;
                litArticleSummary.Text = article.Summary;
                litArticleContent.Text = article.Content?.Replace("\n", "<br />");
                litArticleMeta.Text = $"Publicado em {article.CreatedAt:dd/MM/yyyy}, atualizado em {article.UpdatedAt:dd/MM/yyyy HH:mm}.";
                litInfoTitle.Text = article.Title;
                litInfoUpdated.Text = article.UpdatedAt.ToString("dd/MM/yyyy HH:mm");
                litInfoVersions.Text = db.ArticleVersions.Count(v => v.ArticleId == article.Id).ToString();

                litCategoryBadge.Text = string.IsNullOrWhiteSpace(article.Category)
                    ? string.Empty
                    : "<span class='eod-chip'>" + Server.HtmlEncode(article.Category) + "</span>";

                btnShowCommentForm.Visible = User.Identity.IsAuthenticated;
                if (User.Identity.IsAuthenticated)
                {
                    var editUrl = $"ArticleEdit.aspx?id={ArticleId}";
                    hlEditArticle.NavigateUrl = editUrl;
                    hlEditSideLink.NavigateUrl = editUrl;
                }
            }
        }

        private void LoadComments()
        {
            var comments = _commentService.GetCommentsForArticle(ArticleId);
            var structured = BuildCommentTree(comments);
            rptComments.DataSource = structured;
            rptComments.DataBind();
        }

        private List<CommentViewModel> BuildCommentTree(List<Comment> comments)
        {
            var commentLookup = comments.ToLookup(c => c.ParentCommentId);
            var list = new List<CommentViewModel>();

            void AddComments(int? parentId, int depth)
            {
                foreach (var comment in commentLookup[parentId])
                {
                    list.Add(new CommentViewModel
                    {
                        Id = comment.Id,
                        UserName = comment.User?.DisplayName ?? comment.User?.Username ?? "Usuário",
                        Content = comment.Content,
                        CreatedAt = comment.CreatedAt,
                        Indent = depth * 20
                    });
                    AddComments(comment.Id, depth + 1);
                }
            }

            AddComments(null, 0);
            return list;
        }

        protected void btnShowCommentForm_Click(object sender, EventArgs e)
        {
            pnlCommentForm.Visible = true;
        }

        protected void btnSaveComment_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtComment.Text))
            {
                lblCommentError.Text = "O comentário não pode ficar vazio.";
                lblCommentError.Visible = true;
                return;
            }

            var userId = GetCurrentUserId();
            if (!userId.HasValue)
            {
                Response.Redirect($"~/Account/Login.aspx?ReturnUrl={Server.UrlEncode(Request.RawUrl)}");
                return;
            }

            _commentService.AddComment(ArticleId, userId.Value, txtComment.Text.Trim(), ReplyToCommentId);
            txtComment.Text = string.Empty;
            ReplyToCommentId = null;
            pnlCommentForm.Visible = false;
            LoadComments();
        }

        protected void CommentCommand(object sender, System.Web.UI.WebControls.CommandEventArgs e)
        {
            if (e.CommandName == "Reply" && int.TryParse(e.CommandArgument.ToString(), out var commentId))
            {
                ReplyToCommentId = commentId;
                pnlCommentForm.Visible = true;
            }
        }

        private int? GetCurrentUserId()
        {
            using (var db = new WikiDbContext())
            {
                var user = db.Users.FirstOrDefault(u => u.Username == User.Identity.Name);
                return user?.Id;
            }
        }

        protected class CommentViewModel
        {
            public int Id { get; set; }
            public string UserName { get; set; }
            public string Content { get; set; }
            public DateTime CreatedAt { get; set; }
            public int Indent { get; set; }
        }
    }
}
