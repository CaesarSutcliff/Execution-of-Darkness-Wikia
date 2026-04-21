using System.Collections.Generic;
using System.Data.Entity;
using System.Data.SqlClient;
using System.Linq;
using Execution_of_Darkness_Wikia.Data;
using Execution_of_Darkness_Wikia.ViewModels;

namespace Execution_of_Darkness_Wikia.Services
{
    public class FactionService
    {
        public List<FactionCardViewModel> GetAllFactions(string query = null, string factionType = null)
        {
            try
            {
                using (var db = new WikiDbContext())
                {
                    var data = db.Factions.Where(f => f.IsActive);

                    if (!string.IsNullOrWhiteSpace(query))
                    {
                        data = data.Where(f =>
                            f.Name.Contains(query) ||
                            f.Summary.Contains(query) ||
                            f.Motto.Contains(query));
                    }

                    return data
                        .OrderBy(f => f.Name)
                        .Select(f => new FactionCardViewModel
                        {
                            Id = f.Id,
                            Name = f.Name,
                            Slug = f.Slug,
                            Summary = f.Summary,
                            Alignment = f.Alignment,
                            Motto = f.Motto,
                            CrestUrl = f.CrestUrl,
                            MemberCount = db.CharacterProfiles.Count(c => c.FactionId == f.Id && c.IsActive)
                        })
                        .ToList();
                }
            }
            catch (SqlException)
            {
                return new List<FactionCardViewModel>();
            }
        }

        public FactionDetailsViewModel GetFactionBySlug(string slug)
        {
            using (var db = new WikiDbContext())
            {
                var faction = db.Factions.FirstOrDefault(f => f.IsActive && f.Slug == slug);
                if (faction == null) return null;

                var members = db.CharacterProfiles
                    .Where(c => c.FactionId == faction.Id && c.IsActive)
                    .OrderBy(c => c.Name)
                    .Select(c => new CharacterCardViewModel
                    {
                        Id = c.Id,
                        Name = c.Name,
                        Slug = c.Slug,
                        Alias = c.Alias,
                        Summary = c.Summary,
                        StatusText = c.StatusText,
                        RankTitle = c.RankTitle,
                        Clan = c.Clan,
                        AvatarUrl = c.AvatarUrl
                    })
                    .ToList();

                return new FactionDetailsViewModel
                {
                    Id = faction.Id,
                    Name = faction.Name,
                    Slug = faction.Slug,
                    Summary = faction.Summary,
                    Description = faction.Description,
                    Alignment = faction.Alignment,
                    Motto = faction.Motto,
                    CrestUrl = faction.CrestUrl,
                    Members = members
                };
            }
        }
    }
}
