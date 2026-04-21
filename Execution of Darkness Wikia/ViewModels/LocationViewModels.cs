using System.Collections.Generic;

namespace Execution_of_Darkness_Wikia.ViewModels
{
    public class LocationCardViewModel
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Slug { get; set; }
        public string Summary { get; set; }
        public string Region { get; set; }
        public string DangerLevel { get; set; }
        public string LocationType { get; set; }
        public string ImageUrl { get; set; }
        public int ResidentCount { get; set; }
        public string DetailUrl => "/Pages/Locations/LocationDetails.aspx?slug=" + Slug;
    }

    public class LocationDetailsViewModel
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Slug { get; set; }
        public string Summary { get; set; }
        public string Description { get; set; }
        public string Region { get; set; }
        public string DangerLevel { get; set; }
        public string LocationType { get; set; }
        public string ImageUrl { get; set; }
        public List<CharacterCardViewModel> Residents { get; set; } = new List<CharacterCardViewModel>();
    }
}
