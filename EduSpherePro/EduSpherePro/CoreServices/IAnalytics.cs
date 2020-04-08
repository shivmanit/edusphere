using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EduSpherePro.CoreServices
{
    interface IAnalytics
    {
        List<int> GetAge(string FromDate, string sp);
        int CountEmp(string table, string sp, int DepartmentID, string EmploymentStatus);
        int Count(string sp);
        int GetSum(string sp, string id, DateTime dtFrom, DateTime dtTo);
    }
}
