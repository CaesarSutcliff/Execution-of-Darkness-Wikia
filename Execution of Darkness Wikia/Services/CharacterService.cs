using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.SqlClient;
using System.Linq;
using Execution_of_Darkness_Wikia.Data;
using Execution_of_Darkness_Wikia.Models;
using Execution_of_Darkness_Wikia.ViewModels;

namespace Execution_of_Darkness_Wikia.Services
{
    public class CharacterService
    {
        public List<CharacterCardViewModel> GetFeaturedCharacters(int take = 6)
        {
            try
            {
                using (var db = new WikiDbContext())
                {
                    return db.CharacterProfiles
                        .Include(x => x.Faction)
                        .Include(x => x.Location)
                        .Where(x => x.IsActive && x.IsFeaturedOnHome)
                        .OrderBy(x => x.FeaturedOrder)
                        .ThenBy(x => x.Name)
                        .Take(take)
                        .Select(x => new CharacterCardViewModel
                        {
                            Id = x.Id,
                            Name = x.Name,
                            Slug = x.Slug,
                            Alias = x.Alias,
                            Summary = x.Summary,
                            StatusText = x.StatusText,
                            RankTitle = x.RankTitle,
                            Clan = x.Clan,
                            FactionName = x.Faction != null ? x.Faction.Name : null,
                            LocationName = x.Location != null ? x.Location.Name : null,
                            AvatarUrl = x.AvatarUrl,
                            IsFeaturedOnHome = x.IsFeaturedOnHome,
                            FeaturedOrder = x.FeaturedOrder
                        })
                        .ToList();
                }
            }
            catch (SqlException)
            {
                // Banco não está atualizado - retornar lista vazia
                return new List<CharacterCardViewModel>();
            }
        }

        public List<CharacterCardViewModel> SearchCharacters(string query, string status, int? factionId)
        {
            using (var db = new WikiDbContext())
            {
                var data = db.CharacterProfiles
                    .Include(x => x.Faction)
                    .Include(x => x.Location)
                    .Where(x => x.IsActive);

                if (!string.IsNullOrWhiteSpace(query))
                {
                    data = data.Where(x =>
                        x.Name.Contains(query) ||
                        x.Alias.Contains(query) ||
                        x.Clan.Contains(query) ||
                        x.Summary.Contains(query) ||
                        x.RankTitle.Contains(query) ||
                        x.Occupation.Contains(query));
                }

                if (!string.IsNullOrWhiteSpace(status))
                {
                    data = data.Where(x => x.StatusText == status);
                }

                if (factionId.HasValue)
                {
                    data = data.Where(x => x.FactionId == factionId.Value);
                }

                return data
                    .OrderByDescending(x => x.IsFeaturedOnHome)
                    .ThenBy(x => x.FeaturedOrder)
                    .ThenBy(x => x.Name)
                    .Select(x => new CharacterCardViewModel
                    {
                        Id = x.Id,
                        Name = x.Name,
                        Slug = x.Slug,
                        Alias = x.Alias,
                        Summary = x.Summary,
                        StatusText = x.StatusText,
                        RankTitle = x.RankTitle,
                        Clan = x.Clan,
                        FactionName = x.Faction != null ? x.Faction.Name : null,
                        LocationName = x.Location != null ? x.Location.Name : null,
                        AvatarUrl = x.AvatarUrl,
                        IsFeaturedOnHome = x.IsFeaturedOnHome,
                        FeaturedOrder = x.FeaturedOrder
                    })
                    .ToList();
            }
        }

        public CharacterDetailsViewModel GetCharacterBySlug(string slug)
        {
            using (var db = new WikiDbContext())
            {
                var character = db.CharacterProfiles
                    .Include(x => x.Faction)
                    .Include(x => x.Location)
                    .FirstOrDefault(x => x.IsActive && x.Slug == slug);

                if (character == null)
                    return null;

                var relationships = db.CharacterRelationships
                    .Include(x => x.RelatedCharacter)
                    .Where(x => x.CharacterId == character.Id)
                    .OrderBy(x => x.RelationshipType)
                    .ThenBy(x => x.RelatedCharacter.Name)
                    .Select(x => new CharacterRelationshipViewModel
                    {
                        RelatedCharacterName = x.RelatedCharacter.Name,
                        RelatedCharacterSlug = x.RelatedCharacter.Slug,
                        RelationshipType = x.RelationshipType,
                        Summary = x.Summary
                    })
                    .ToList();

                return new CharacterDetailsViewModel
                {
                    Id = character.Id,
                    Name = character.Name,
                    Slug = character.Slug,
                    Alias = character.Alias,
                    Summary = character.Summary,
                    Biography = character.Biography,
                    AgeText = character.AgeText,
                    Clan = character.Clan,
                    Occupation = character.Occupation,
                    RankTitle = character.RankTitle,
                    StatusText = character.StatusText,
                    FirstAppearance = character.FirstAppearance,
                    Race = character.Race,
                    Gender = character.Gender,
                    Alignment = character.Alignment,
                    BirthPlace = character.BirthPlace,
                    Residence = character.Residence,
                    Personality = character.Personality,
                    Appearance = character.Appearance,
                    AbilitiesOverview = character.AbilitiesOverview,
                    Quote = character.Quote,
                    AvatarUrl = character.AvatarUrl,
                    BannerUrl = character.BannerUrl,
                    FactionName = character.Faction != null ? character.Faction.Name : null,
                    LocationName = character.Location != null ? character.Location.Name : null,
                    Relationships = relationships
                };
            }
        }

        public List<CharacterFilterOptionViewModel> GetFactionOptions()
        {
            using (var db = new WikiDbContext())
            {
                return db.Factions
                    .Where(x => x.IsActive)
                    .OrderBy(x => x.Name)
                    .Select(x => new CharacterFilterOptionViewModel
                    {
                        Text = x.Name,
                        Value = x.Id.ToString()
                    })
                    .ToList();
            }
        }

        public List<CharacterFilterOptionViewModel> GetStatusOptions()
        {
            try
            {
                using (var db = new WikiDbContext())
                {
                    return db.CharacterProfiles
                        .Where(x => x.IsActive && x.StatusText != null && x.StatusText != "")
                        .Select(x => x.StatusText)
                        .Distinct()
                        .OrderBy(x => x)
                        .ToList()
                        .Select(x => new CharacterFilterOptionViewModel
                        {
                            Text = x,
                            Value = x
                        })
                        .ToList();
                }
            }
            catch (SqlException)
            {
                // Banco não está atualizado - retornar lista vazia
                return new List<CharacterFilterOptionViewModel>();
            }
        }

        public List<FeaturedCardViewModel> GetFeaturedCardsForHome(int take = 6)
        {
            return GetFeaturedCharacters(take)
                .Select(x => new FeaturedCardViewModel
                {
                    Title = x.Name,
                    Badge = string.IsNullOrWhiteSpace(x.RankTitle) ? "Personagem" : x.RankTitle,
                    Description = x.Summary,
                    Keywords = string.Join(" ", new [] { x.Name, x.Alias, x.Clan, x.FactionName, x.LocationName, x.StatusText }),
                    Url = x.DetailUrl
                })
                .ToList();
        }
    }
}
