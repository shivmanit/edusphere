using EduSpherePro.CoreServices;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EduSpherePro.EduSpherePro
{
    public partial class Attendance : System.Web.UI.Page
    {
        IBindData BD = new BindData();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblStaffAction.Text         = "Enter your Attendance for the day";
                pnlViewStaff.Visible        = true;
                pnlViewStaffProfile.Visible = false;

                //Create attendatce for the day if didn't exist.
                SqlCommand cmd          = new SqlCommand("spCreateAttendanceDay", BD.ConStr);
                cmd.CommandType         = CommandType.StoredProcedure;
                BD.UpdateParameters(cmd);

                //Display Today Attendace Register
                DateTime AttendanceDate = DateTime.Now;
                string strAttendanceDate = AttendanceDate.ToString("yyyy-MM-dd");
                string strCmd = string.Format("SELECT  *,a.EmployeeId,s.FullName,s.PhoneOne,s.Email FROM EduSphere.StaffAttendance a JOIN EduSphere.Staff s ON a.EmployeeId=s.EmployeeId WHERE AttendanceDate='{0}'  ORDER BY s.FullName ASC", strAttendanceDate);
                BD.DataBindToDataList(dlStaff, strCmd);
            }
        }

        //Manage Staff Panel Displays
        protected void ManageStaffAttendance(object sender, CommandEventArgs e)
        {
            string cmdName, strCmd = "";
            cmdName = e.CommandName.ToString();
            switch (cmdName)
            {
                case "SearchStaff":
                    lblStaffAction.Text = "Staff Attendace";
                    pnlViewStaff.Visible = true;
                    pnlViewStaffProfile.Visible = false;
                    int intSearchParam = Convert.ToInt32(txtBoxSearchStaff.Text);
                    DateTime AttendanceDate = DateTime.Now;
                    string strAttendanceDate = AttendanceDate.ToString("yyyy-MM-dd");
                    strCmd = string.Format("SELECT *,a.EmployeeId,s.FullName,s.PhoneOne,s.Email FROM EduSphere.StaffAttendance a JOIN EduSphere.Staff s ON a.EmployeeId=s.EmployeeId WHERE a.EmployeeId LIKE'%{0}%'AND a.AttendanceDate='{1}'", intSearchParam, strAttendanceDate);
                    BD.DataBindToDataList(dlStaff, strCmd);
                    break;
                case "ViewProfile":
                    lblStaffAction.Text = "Staff Details";
                    pnlViewStaff.Visible = false;
                    pnlViewStaffProfile.Visible = true;
                    int intEmployeeId = Convert.ToInt32(e.CommandArgument.ToString());
                    strCmd = string.Format("SELECT * FROM EduSphere.Staff WHERE EmployeeId='{0}'", intEmployeeId);
                    BD.DataBindToDataList(dlStaffDetails, strCmd);
                    break;
                case "ReturnToViewStaff":
                    Response.Redirect("Attendance.aspx");
                    break;
                default:
                    break;
            }
        }

        //IN and Out button clicks handler
        protected void UpdateStaffAttendance(object sender, DataListCommandEventArgs e)
        {
            double DaysPresentFor = 0.0;
            string DayStatus = "ABSENT";
            string[] cmdArgs = new string[3];
            cmdArgs = e.CommandArgument.ToString().Split(';');
            string cmdArgAttendance = cmdArgs[1].ToString();
            int intEmployeeId = Convert.ToInt32(dlStaff.DataKeys[e.Item.ItemIndex]);
            lblStaffAction.Text = "Enter your Attendace for the day";
            switch (cmdArgAttendance)
            {
                case "IN":
                    SqlCommand cmdIn = new SqlCommand("spUpdateStaffInTime", BD.ConStr);
                    cmdIn.CommandType = CommandType.StoredProcedure;
                    cmdIn.Parameters.AddWithValue("@SwipeId", ((Label)e.Item.FindControl("lblSwipeId")).Text);
                    cmdIn.Parameters.AddWithValue("@EmployeeId", intEmployeeId);
                    cmdIn.Parameters.AddWithValue("@SwipeInById", Context.User.Identity.Name);
                    cmdIn.Parameters.AddWithValue("@SwipeInStatus", "DISABLED");
                    cmdIn.Parameters.AddWithValue("@SwipeInDateTime", DateTime.Now);
                    cmdIn.Parameters.AddWithValue("@Remarks", ((TextBox)e.Item.FindControl("txtBoxAttendanceRemarks")).Text);
                    BD.UpdateParameters(cmdIn);
                    break;
                case "OUT":
                    DateTime dtSwipeInDateTime = DateTime.Parse(cmdArgs[0].ToString());
                    SqlCommand cmdOut = new SqlCommand("spUpdateStaffOutTime", BD.ConStr);
                    cmdOut.CommandType = CommandType.StoredProcedure;
                    cmdOut.Parameters.AddWithValue("@SwipeId", ((Label)e.Item.FindControl("lblSwipeId")).Text);
                    cmdOut.Parameters.AddWithValue("@EmployeeId", intEmployeeId);
                    cmdOut.Parameters.AddWithValue("@SwipeOutById", Context.User.Identity.Name);
                    cmdOut.Parameters.AddWithValue("@SwipeOutStatus", "DISABLED");
                    cmdOut.Parameters.AddWithValue("@SwipeOutDateTime", DateTime.Now);
                    double HoursPresentFor = DateTime.Now.Subtract(dtSwipeInDateTime).TotalHours;
                    if (HoursPresentFor >= 9)
                    {
                        DaysPresentFor = 1;
                        DayStatus = "PRESENT";
                    }
                    if (HoursPresentFor < 9 && HoursPresentFor > 5)
                    {
                        DaysPresentFor = 0.5;
                        DayStatus = "HALFDAY";
                    }
                    cmdOut.Parameters.AddWithValue("@HoursPresentFor", HoursPresentFor);
                    cmdOut.Parameters.AddWithValue("@DaysPresentFor", DaysPresentFor);
                    cmdOut.Parameters.AddWithValue("@DayStatus", DayStatus);
                    cmdOut.Parameters.AddWithValue("@Remarks", ((TextBox)e.Item.FindControl("txtBoxAttendanceRemarks")).Text);
                    BD.UpdateParameters(cmdOut);
                    break;
            }
            Response.Redirect("Attendance.aspx");
        }

    }
}