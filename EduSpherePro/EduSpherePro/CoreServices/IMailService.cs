using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EduSpherePro.CoreServices
{
    interface IMailService
    {
        bool SendMail(string from, string to, string subject, string body);
        bool SendMailHtml(string from, string to, string subject, string body);
        Task SendAsync(string from, string to, string subject, string body);
    }
}
