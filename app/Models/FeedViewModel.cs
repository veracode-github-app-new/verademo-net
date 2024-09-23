using System.Collections.Generic;

namespace Verademo.Models
{
    public class FeedViewModel
    {
        public FeedViewModel()
        {
            BlabsByOthers = [];
            BlabsByMe = [];
        }
        public string CurrentUser { get; set; }
        public string Error { get; set; }
        public List<Blab> BlabsByOthers { get; set; }
        public List<Blab> BlabsByMe { get; set; }
    }
}