using System.Collections.Generic;

namespace Verademo.Models
{
    public class BlabViewModel
    {
        public BlabViewModel()
        {
            Comments = [];
        }
        public string BlabName { get; set; }

        public string Content { get; set; }
        public string Error { get; set; }
        public int BlabId { get; set; }
        public List<Comment> Comments { get; set; }
    }
}