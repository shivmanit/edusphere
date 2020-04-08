using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace EduSpherePro.CoreServices
{
    public class Analytics :IAnalytics
    {
        //
        IBindData BD = new BindData();
        public List<int> GetAge(string FromDate, string sp)
        {
            List<int> list = new List<int>();
            SqlCommand cmd = new SqlCommand(sp, BD.ConStr);
            cmd.CommandType = CommandType.StoredProcedure;

            //Add Output parameters
            cmd.Parameters.AddWithValue("@FromDate", DateTime.Parse(FromDate));
            SqlParameter AgeYears = new SqlParameter("@AgeYears", SqlDbType.Int);
            AgeYears.Direction = ParameterDirection.Output;
            cmd.Parameters.Add(AgeYears);
            SqlParameter AgeMonths = new SqlParameter("@AgeMonths", SqlDbType.Int);
            AgeMonths.Direction = ParameterDirection.Output;
            cmd.Parameters.Add(AgeMonths);
            SqlParameter AgeDays = new SqlParameter("@AgeDays", SqlDbType.Int);
            AgeDays.Direction = ParameterDirection.Output;
            cmd.Parameters.Add(AgeDays);
            BD.UpdateParameters(cmd);

            list.Add((int)cmd.Parameters["@AgeYears"].Value);
            list.Add((int)cmd.Parameters["@AgeMonths"].Value);
            list.Add((int)cmd.Parameters["@AgeDays"].Value);
            return list;
        }


        public int CountEmp(string table, string sp, int DepartmentID, string EmploymentStatus)
        {
            //BindData BD                 = new BindData();
            int intDepartmentID = DepartmentID;
            string strEmloymentStatus = EmploymentStatus;
            //Retrieve Summary
            SqlCommand cmd = new SqlCommand("spEmpSummary", BD.ConStr);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlParameter intCountTeachingStaff = new SqlParameter("@CountTeachingStaff", SqlDbType.Int);
            intCountTeachingStaff.Direction = ParameterDirection.Output;
            cmd.Parameters.Add(intCountTeachingStaff);

            cmd.Parameters.AddWithValue("@DepartmentID", intDepartmentID);
            cmd.Parameters.AddWithValue("@EmploymentStatus", strEmloymentStatus);
            BD.UpdateParameters(cmd);

            int number = Convert.ToInt32(intCountTeachingStaff.Value);
            return number;
        }

        //Count Using sp
        public int Count(string sp)
        {
            SqlCommand cmd = new SqlCommand(sp, BD.ConStr);
            cmd.CommandType = CommandType.StoredProcedure;
            //Add output parameters
            SqlParameter intCount = new SqlParameter("@Count", SqlDbType.Int);
            intCount.Direction = ParameterDirection.Output;
            cmd.Parameters.Add(intCount);
            BD.UpdateParameters(cmd);
            return (Convert.ToInt32(intCount.Value));
        }

        public int GetSum(string sp, string id, DateTime dtFrom, DateTime dtTo)
        {
            //Retrieve Summary
            SqlCommand cmd = new SqlCommand(sp, BD.ConStr);
            cmd.CommandType = CommandType.StoredProcedure;
            //Add output parameters
            SqlParameter intSum = new SqlParameter("@intSum", SqlDbType.Int);
            intSum.Direction = ParameterDirection.Output;
            cmd.Parameters.Add(intSum);

            cmd.Parameters.AddWithValue("@id", id);
            cmd.Parameters.AddWithValue("@dtFrom", dtFrom);
            cmd.Parameters.AddWithValue("@dtTo", dtTo);
            BD.UpdateParameters(cmd);

            int total = Convert.ToInt32(intSum.Value);
            return total;

        }
    }
}