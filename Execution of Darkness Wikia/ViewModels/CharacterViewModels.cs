using System.Collections.Generic;

namespace Execution_of_Darkness_Wikia.ViewModels
{
    public class CharacterCardViewModel
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Slug { get; set; }
        public string Alias { get; set; }
        public string Summary { get; set; }
        public string StatusText { get; set; }
        public string RankTitle { get; set; }
        public string Clan { get; set; }
        public string FactionName { get; set; }
        public string LocationName { get; set; }
        public string AvatarUrl { get; set; }
        public bool IsFeaturedOnHome { get; set; }
        public int? FeaturedOrder { get; set; }
        public string DetailUrl => "/Pages/Characters/CharacterDetails.aspx?slug=" + Slug;
    }

    public class CharacterRelationshipViewModel
    {
        public string RelatedCharacterName { get; set; }
        public string RelatedCharacterSlug { get; set; }
        public string RelationshipType { get; set; }
        public string Summary { get; set; }
        public string DetailUrl => "/Pages/Characters/CharacterDetails.aspx?slug=" + RelatedCharacterSlug;
    }

    public class CharacterDetailsViewModel
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Slug { get; set; }
        public string Alias { get; set; }
        public string Summary { get; set; }
        public string Biography { get; set; }
        public string AgeText { get; set; }
        public string Clan { get; set; }
        public string Occupation { get; set; }
        public string RankTitle { get; set; }
        public string StatusText { get; set; }
        public string FirstAppearance { get; set; }
        public string Race { get; set; }
        public string Gender { get; set; }
        public string Alignment { get; set; }
        public string BirthPlace { get; set; }
        public string Residence { get; set; }
        public string Personality { get; set; }
        public string Appearance { get; set; }
        public string AbilitiesOverview { get; set; }
        public string Quote { get; set; }
        public string AvatarUrl { get; set; }
        public string BannerUrl { get; set; }
        public string FactionName { get; set; }
        public string LocationName { get; set; }
        public List<CharacterRelationshipViewModel> Relationships { get; set; } = new List<CharacterRelationshipViewModel>();
    }

    public class CharacterFilterOptionViewModel
    {
        public string Text { get; set; }
        public string Value { get; set; }
    }
}
