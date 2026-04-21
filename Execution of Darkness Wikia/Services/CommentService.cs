using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using Execution_of_Darkness_Wikia.Data;
using Execution_of_Darkness_Wikia.Models;

namespace Execution_of_Darkness_Wikia.Services
{
    public class CommentService
    {
        public List<Comment> GetCommentsForArticle(int articleId)
        {
            using (var db = new WikiDbContext())
            {
                return db.Comments
                    .Include("User")
                    .Where(c => c.ArticleId == articleId && !c.IsDeleted)
                    .OrderBy(c => c.CreatedAt)
                    .ToList();
            }
        }

        public Comment AddComment(int articleId, int userId, string content, int? parentCommentId = null)
        {
            using (var db = new WikiDbContext())
            {
                var comment = new Comment
                {
                    ArticleId = articleId,
                    UserId = userId,
                    Content = content,
                    ParentCommentId = parentCommentId,
                    CreatedAt = System.DateTime.Now,
                    UpdatedAt = System.DateTime.Now
                };

                db.Comments.Add(comment);
                db.SaveChanges();
                return comment;
            }
        }

        public void DeleteComment(int commentId, int userId)
        {
            using (var db = new WikiDbContext())
            {
                var comment = db.Comments.Find(commentId);
                if (comment != null && comment.UserId == userId)
                {
                    comment.IsDeleted = true;
                    comment.UpdatedAt = System.DateTime.Now;
                    db.SaveChanges();
                }
            }
        }
    }
}