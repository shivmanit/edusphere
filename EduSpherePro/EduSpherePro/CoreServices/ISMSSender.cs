using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EduSpherePro.CoreServices
{
    interface ISMSSender
    {
        string SendSms(string To, string Msg);
        string SendSmsUsingProvider(string provider, string To, string Msg);
    }
}
