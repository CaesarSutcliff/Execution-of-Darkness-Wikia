using System.Collections.Generic;

namespace Execution_of_Darkness_Wikia.ViewModels
{
    public class HomePageViewModel
    {
        public string Title { get; set; }
        public string Subtitle { get; set; }
        public List<FeaturedCardViewModel> FeaturedCharacters { get; set; } = new List<FeaturedCardViewModel>();
        public List<FeaturedCardViewModel> Factions { get; set; } = new List<FeaturedCardViewModel>();
        public List<FeaturedCardViewModel> Locations { get; set; } = new List<FeaturedCardViewModel>();
        public List<FeaturedCardViewModel> Systems { get; set; } = new List<FeaturedCardViewModel>();
        public List<TimelineCardViewModel> Timeline { get; set; } = new List<TimelineCardViewModel>();
    }

    public class FeaturedCardViewModel
    {
        public string Title { get; set; }
        public string Badge { get; set; }
        public string Description { get; set; }
        public string Keywords { get; set; }
        public string Url { get; set; }
    }

    public class TimelineCardViewModel
    {
        public string Title { get; set; }
        public string Description { get; set; }
    }
}
