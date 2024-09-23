using System.Collections.Generic;

namespace Verademo.Models
{
    public class BlabbersViewModel
    {
        public BlabbersViewModel()
        {
            Blabbers = [];
        }

        public string Error { get; set; }
        public List<Blabber> Blabbers { get; set; }
    }
}