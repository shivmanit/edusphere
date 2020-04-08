using System;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EduSpherePro.CoreServices
{
    public interface IBlobStorage
    {
        Task<string> SaveLearnArt(string name, Stream content);
    }
}
