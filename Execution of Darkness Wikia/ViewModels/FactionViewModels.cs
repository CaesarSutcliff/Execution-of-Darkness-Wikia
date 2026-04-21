using System.Collections.Generic;

namespace Execution_of_Darkness_Wikia.ViewModels
{
    public class FactionCardViewModel
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Slug { get; set; }
        public string Summary { get; set; }
        public string FactionType { get; set; }
        public string Alignment { get; set; }
        public string Motto { get; set; }
        public string CrestUrl { get; set; }
        public int MemberCount { get; set; }
        public string DetailUrl => "/Pages/Factions/FactionDetails.aspx?slug=" + Slug;
    }

    public class FactionDetailsViewModel
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Slug { get; set; }
        public string Summary { get; set; }
        public string Description { get; set; }
        public string FactionType { get; set; }
        public string Alignment { get; set; }
        public string Motto { get; set; }
        public string CrestUrl { get; set; }
        public List<CharacterCardViewModel> Members { get; set; } = new List<CharacterCardViewModel>();
    }
}
