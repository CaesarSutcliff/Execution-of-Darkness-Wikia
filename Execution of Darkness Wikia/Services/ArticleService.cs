using System;
using System.Data.Entity;
using System.Data.SqlClient;
using System.Linq;
using Execution_of_Darkness_Wikia.Data;
using Execution_of_Darkness_Wikia.Models;

namespace Execution_of_Darkness_Wikia.Services
{
    public class ArticleService
    {
        public WikiArticle GetArticle(int id)
        {
            try
            {
                using (var db = new WikiDbContext())
                {
                    return db.WikiArticles.Include("ArticleVersions").FirstOrDefault(a => a.Id == id);
                }
            }
            catch (SqlException)
            {
                // Banco não está atualizado - retornar null
                return null;
            }
        }

        public WikiArticle CreateArticle(string title, string summary, string content, string authorName, string changeSummary = null)
        {
            using (var db = new WikiDbContext())
            {
                var article = new WikiArticle
                {
                    Title = title,
                    Slug = GenerateSlug(title),
                    Summary = summary,
                    Content = content,
                    CreatedAt = DateTime.Now,
                    UpdatedAt = DateTime.Now
                };

                db.WikiArticles.Add(article);
                db.SaveChanges();

                // Criar versão inicial
                CreateVersion(article.Id, title, content, authorName, changeSummary ?? "Criação do artigo");

                return article;
            }
        }

        public void UpdateArticle(int id, string title, string summary, string content, string authorName, string changeSummary)
        {
            using (var db = new WikiDbContext())
            {
                var article = db.WikiArticles.Find(id);
                if (article == null) throw new Exception("Artigo não encontrado.");

                article.Title = title;
                article.Summary = summary;
                article.Content = content;
                article.UpdatedAt = DateTime.Now;

                db.SaveChanges();

                CreateVersion(id, title, content, authorName, changeSummary);
            }
        }

        private void CreateVersion(int articleId, string title, string content, string authorName, string changeSummary)
        {
            using (var db = new WikiDbContext())
            {
                var versionNumber = db.ArticleVersions.Where(v => v.ArticleId == articleId).Max(v => (int?)v.VersionNumber) ?? 0;
                versionNumber++;

                var version = new ArticleVersion
                {
                    ArticleId = articleId,
                    VersionNumber = versionNumber,
                    TitleSnapshot = title,
                    ContentSnapshot = content,
                    AuthorName = authorName,
                    ChangeSummary = changeSummary,
                    CreatedAt = DateTime.Now
                };

                db.ArticleVersions.Add(version);
                db.SaveChanges();
            }
        }

        private string GenerateSlug(string title)
        {
            return title.ToLower().Replace(" ", "-").Replace("ç", "c").Replace("ã", "a").Replace("õ", "o");
        }
    }
}