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
    public partial class Placements : System.Web.UI.Page
    {
        IBindData BD = new BindData();
        // LoggedInUsers lnUser = new LoggedInUsers("PURPLESALON");
        DataSet ObjDS = new DataSet();
        DataView ObjDV = new DataView();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                pnlPlacementDrives.Visible = false;
                
                //BD.DataBindToDropDownList(ddlPlacementsFilter, "SELECT * FROM EduSphere.Placements ORDER BY PlacementID DESC");
                //Get user role
                if (User.Identity.IsAuthenticated)
                {
                    string strID = User.Identity.Name;
                    //string strRole          = lnUser.GetUserRole(strID);
                    //if (User.IsInRole("Admin"))
                    //    lblRole.Text = "Admin";
                }

                //In case the logged in role is Admin then display delete button.
                if (User.IsInRole("Admin"))
                {
                    //BD.DataBindToDataGridDC(dgCourses, "SELECT * FROM Courses where ProgName='CSE'", "Courses");
                }
                else
                {
                    //BD.DataBindToDataGridDC(dgCoursesView, "SELECT * FROM Courses  where ProgName='CSE'", "Courses");
                }
            }
        }

        //Manage Panel Visibilty for Placements
        protected void ManageVisibility(object sender, CommandEventArgs e)
        {

            string cmdName = e.CommandName.ToString();
            switch (cmdName)
            {
                case "ViewPlacementDrives":
                    lblPlacementAction.Text     = "Placements /Drives";
                    pnlPlacementDrives.Visible = true;
                    string drivCmd = string.Format(@"SELECT * FROM EduSphere.PlacementDrives d 
                                                              JOIN EduSphere.Organizations o ON d.EmployerID=o.OrganizationID JOIN EduSphere.Staff s ON d.CoordinatorID=s.EmployeeID 
                                                              ORDER BY DriveDate DESC");
                    BD.DataBindToGridView(gvPlacementDrives, drivCmd,"NA");
                    BD.DataBindToDropDownList(ddlEmployerID, string.Format("SELECT OrganizationID,OrganizationName FROM EduSphere.Organizations WHERE OrganizationType='{0}'", "EMPLOYER"));
                    BD.DataBindToDropDownList(ddlCoordinatorID, string.Format("SELECT EmployeeID,FullName FROM EduSphere.Staff"));
                    break;
                
                case "ReturnToPlacements":
                    Response.Redirect("Placements.aspx");
                    break;
                default:
                    break;
            }

        }

        //Inserts a new course for selected PlacementID
        protected void CreateNewDrive(object sender, EventArgs e)
        {
            SqlCommand ObjCmd = new SqlCommand("spAddDrive", BD.ConStr);
            ObjCmd.CommandType = CommandType.StoredProcedure;
            ObjCmd.Parameters.AddWithValue("@DriveTitle", txtBoxDriveTitle.Text);
            ObjCmd.Parameters.AddWithValue("@EmployerID", Convert.ToInt32(ddlEmployerID.SelectedValue.ToString()));
            ObjCmd.Parameters.AddWithValue("@JobDescription", txtBoxJobDescription.Text);
            ObjCmd.Parameters.AddWithValue("@DriveDate", DateTime.Parse(txtBoxDriveDate.Text));
            ObjCmd.Parameters.AddWithValue("@CoordinatorID", Convert.ToInt32(ddlCoordinatorID.SelectedValue.ToString()));
            BD.UpdateParameters(ObjCmd);
            BD.DataBindToGridView(gvPlacementDrives, "SELECT * FROM EduSphere.PlacementDrives d JOIN EduSphere.Organizations o ON d.EmployerID=o.OrgnizationID JOIN EduSphere.Staff s ON d.CoordinatorID=s.EmployeeID", "NA");
            txtBoxDriveTitle.Text       = "";
            txtBoxJobDescription.Text   = "";
        }

        //Placement Drive Row Command
        protected void gvPlacementDrives_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string strCmd = e.CommandName.ToString();
            int intDriveID = Convert.ToInt32(e.CommandArgument.ToString());
            lblDriveID.Text = intDriveID.ToString();
            if (strCmd == "AddStudentsToDrive")
            {
                Response.Redirect(string.Format("Students.aspx?id={0}", intDriveID));
                //BD.DataBindToGridView(gvDriveSchedule, string.Format("SELECT * FROM EduSphere.DriveSchedule s JOIN EduSphere.Courses c ON s.CourseID=c.CourseID WHERE DriveID={0}", intDriveID), "NA");
            }
            if (strCmd == "ViewDriveStatus")
            { 
                BD.DataBindToGridView(gvDriveStatus, string.Format("SELECT * FROM EduSphere.StudentsPlacementDrives d JOIN EduSphere.Students s ON d.StudentID=s.StudentID WHERE DriveID={0}", intDriveID), "NA");
            }
        }

        //Batch Schedule Row Command
        protected void gvDriveStatus_RowCommand(object sender, GridViewCommandEventArgs e)
        {

        }

        protected void gvDriveStatus_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            //if (e.Row.RowType == DataControlRowType.DataRow && gvDriveStatus.EditIndex == e.Row.RowIndex)
            //{
            //    DropDownList ddlEditCourseID = (DropDownList)e.Row.FindControl("ddlEditCourseID");
            //    if (ddlEditCourseID != null)
            //    {
            //        BD.DataBindToDropDownList(ddlEditCourseID, "SELECT CourseID,CourseTitle FROM EduSphere.Courses");
            //        //ddlEditCourseID.Items.FindByValue((e.Row.FindControl("lblCourseTitle") as Label).Text).Selected = true;
            //    }

            //}
        }
        //Edit Students Placement Status
        public void gvEditDriveStatus(object sender, GridViewEditEventArgs e)
        {
            gvDriveStatus.EditIndex           = e.NewEditIndex;
            string strStudentsPlacementDriveID = gvDriveStatus.DataKeys[e.NewEditIndex].Value.ToString();
            
            string strQuery = string.Format(@"SELECT * FROM EduSphere.StudentsPlacementDrives d JOIN EduSphere.Students s ON d.StudentID=s.StudentID WHERE StudentsPlacementDriveID='{0}'", strStudentsPlacementDriveID);
            BD.DataBindToGridView(gvDriveStatus, strQuery, "NA");

        }
        //Cancel Editing Students Placement Status
        public void gvCancelDriveStatus(object sender, GridViewCancelEditEventArgs e)
        {
            gvDriveStatus.EditIndex = -1;
            string strQuery = string.Format(@"SELECT * FROM EduSphere.StudentsPlacementDrives d JOIN EduSphere.Students s ON d.StudentID=s.StudentID WHERE DriveID={0}", Convert.ToInt32(lblDriveID.Text.ToString()));
            BD.DataBindToGridView(gvDriveStatus, strQuery, "NA");
        }

        //Update Students Placement Status
        public void gvUpdateDriveStatus(object sender, GridViewUpdateEventArgs e)
        {
            string strStudentsPlacementDriveID = gvDriveStatus.DataKeys[e.RowIndex].Value.ToString();
            GridViewRow row    = gvDriveStatus.Rows[e.RowIndex];
            string strStudentsDriveStatus = (row.FindControl("ddlEditStudentStatus") as DropDownList).SelectedItem.Value.ToString();
           
            SqlCommand ObjCmd = new SqlCommand("spUpdateStudentsDriveStatus", BD.ConStr);
            ObjCmd.CommandType = CommandType.StoredProcedure;
            ObjCmd.Parameters.AddWithValue("@StudentsPlacementDriveID", strStudentsPlacementDriveID);
            ObjCmd.Parameters.AddWithValue("@StudentsDriveStatus", strStudentsDriveStatus);
            
            BD.UpdateParameters(ObjCmd);
            gvDriveStatus.EditIndex = -1;
            string strQuery = string.Format("SELECT * FROM EduSphere.StudentsPlacementDrives d JOIN EduSphere.Students s ON d.StudentID=s.StudentID WHERE DriveID={0}", Convert.ToInt32(lblDriveID.Text));
            BD.DataBindToGridView(gvDriveStatus, strQuery, "NA");

        }
        
    }
}