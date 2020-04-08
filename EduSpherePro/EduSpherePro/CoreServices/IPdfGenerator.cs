using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EduSpherePro.CoreServices
{
    interface IPdfGenerator
    {
        void ServiceInvoice(int intInvoiceID);
        void EnrolmentCertificate(int intMemberID);
        void CourseInvoice(int intInvoiceID);
        void GeneratePdfFromPdfTemplate(string strPdfTemplateFile, int intMemberID);
    }
}
