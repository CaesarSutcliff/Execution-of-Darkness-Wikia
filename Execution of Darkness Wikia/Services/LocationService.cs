using System.Collections.Generic;
using System.Data.Entity;
using System.Data.SqlClient;
using System.Linq;
using Execution_of_Darkness_Wikia.Data;
using Execution_of_Darkness_Wikia.ViewModels;

namespace Execution_of_Darkness_Wikia.Services
{
    public class LocationService
    {
        public List<LocationCardViewModel> GetAllLocations(string query = null, string region = null)
        {
            try
            {
                using (var db = new WikiDbContext())
                {
                    var data = db.Locations.Where(l => l.IsActive);

                    if (!string.IsNullOrWhiteSpace(query))
                    {
                        data = data.Where(l =>
                            l.Name.Contains(query) ||
                            l.Summary.Contains(query) ||
                            l.Region.Contains(query));
                    }

                    if (!string.IsNullOrWhiteSpace(region))
                    {
                        data = data.Where(l => l.Region == region);
                    }

                    return data
                        .OrderBy(l => l.Name)
                        .Select(l => new LocationCardViewModel
                        {
                            Id = l.Id,
                            Name = l.Name,
                            Slug = l.Slug,
                            Summary = l.Summary,
                            Region = l.Region,
                            DangerLevel = l.DangerLevel,
                            ImageUrl = l.ImageUrl,
                            ResidentCount = db.CharacterProfiles.Count(c => c.LocationId == l.Id && c.IsActive)
                        })
                        .ToList();
                }
            }
            catch (SqlException)
            {
                return new List<LocationCardViewModel>();
            }
        }

        public LocationDetailsViewModel GetLocationBySlug(string slug)
        {
            using (var db = new WikiDbContext())
            {
                var location = db.Locations.FirstOrDefault(l => l.IsActive && l.Slug == slug);
                if (location == null) return null;

                var residents = db.CharacterProfiles
                    .Where(c => c.LocationId == location.Id && c.IsActive)
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

                return new LocationDetailsViewModel
                {
                    Id = location.Id,
                    Name = location.Name,
                    Slug = location.Slug,
                    Summary = location.Summary,
                    Description = location.Description,
                    Region = location.Region,
                    DangerLevel = location.DangerLevel,
                    ImageUrl = location.ImageUrl,
                    Residents = residents
                };
            }
        }

        public List<string> GetRegionOptions()
        {
            try
            {
                using (var db = new WikiDbContext())
                {
                    return db.Locations
                        .Where(l => l.IsActive && l.Region != null && l.Region != "")
                        .Select(l => l.Region)
                        .Distinct()
                        .OrderBy(r => r)
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
