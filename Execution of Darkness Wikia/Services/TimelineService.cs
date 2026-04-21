using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using Execution_of_Darkness_Wikia.Data;
using Execution_of_Darkness_Wikia.ViewModels;

namespace Execution_of_Darkness_Wikia.Services
{
    public class TimelineService
    {
        public List<TimelineEventViewModel> GetAllEvents(string query = null, string era = null, string importance = null)
        {
            try
            {
                using (var db = new WikiDbContext())
                {
                    var data = db.TimelineEvents.AsQueryable();

                    if (!string.IsNullOrWhiteSpace(query))
                    {
                        data = data.Where(t =>
                            t.Title.Contains(query) ||
                            t.Summary.Contains(query));
                    }

                    if (!string.IsNullOrWhiteSpace(era))
                    {
                        data = data.Where(t => t.Era == era);
                    }

                    if (!string.IsNullOrWhiteSpace(importance))
                    {
                        data = data.Where(t => t.ImportanceLevel == importance);
                    }

                    return data
                        .OrderBy(t => t.Era)
                        .ThenBy(t => t.Title)
                        .Select(t => new TimelineEventViewModel
                        {
                            Id = t.Id,
                            Title = t.Title,
                            Slug = t.Slug,
                            Summary = t.Summary,
                            Description = t.Description,
                            Era = t.Era,
                            ImportanceLevel = t.ImportanceLevel
                        })
                        .ToList();
                }
            }
            catch (SqlException)
            {
                return new List<TimelineEventViewModel>();
            }
        }

        public List<string> GetEraOptions()
        {
            try
            {
                using (var db = new WikiDbContext())
                {
                    return db.TimelineEvents
                        .Where(t => t.Era != null && t.Era != "")
                        .Select(t => t.Era)
                        .Distinct()
                        .OrderBy(e => e)
                        .ToList();
                }
            }
            catch (SqlException)
            {
                return new List<string>();
            }
        }

        public List<string> GetImportanceOptions()
        {
            try
            {
                using (var db = new WikiDbContext())
                {
                    return db.TimelineEvents
                        .Where(t => t.ImportanceLevel != null && t.ImportanceLevel != "")
                        .Select(t => t.ImportanceLevel)
                        .Distinct()
                        .OrderBy(i => i)
                        .ToList();
                }
            }
            catch (SqlException)
            {
                return new List<string>();
            }
        }
    }
}
