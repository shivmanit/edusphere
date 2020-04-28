using EduSpherePro.CoreServices;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EduSpherePro.EduSpherePro
{
    public partial class Programs : System.Web.UI.Page
    {
        IBindData BD        = new BindData();
       // LoggedInUsers lnUser = new LoggedInUsers("PURPLESALON");
        DataSet ObjDS       = new DataSet();
        DataView ObjDV      = new DataView();
        BlobStorage BS      = new BlobStorage();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                pnlPrograms.Visible         = false;
                pnlCourses.Visible          = false;
                pnlCourseDocs.Visible       = false;
                pnlObjQ.Visible             = false;
                pnlAddDoc.Visible           = false;
                pnlCOPOMap.Visible          = false;
                pnlCo.Visible               = false;
                pnlProgramBatches.Visible   = false;
                pnlAssessments.Visible      = false;
                pnlStudentAttendance.Visible = false;
                BD.DataBindToDropDownList(ddlProgramsFilter, "SELECT * FROM EduSphere.Programs WHERE ProgramID >=100 ORDER BY ProgramID DESC");
                //Get user role
                if (User.Identity.IsAuthenticated)
                {
                    string strID = User.Identity.Name;
                    //string strRole          = lnUser.GetUserRole(strID);
                    if (User.IsInRole("Admin"))
                        lblRole.Text = "Admin";
                    if (User.IsInRole("Manager"))
                        lblRole.Text = "Manager";
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

        //Manage Panel Visibilty for Programs
        protected void ManageVisibility(object sender,CommandEventArgs e)
        {
            
            string cmdName = e.CommandName.ToString();
            switch(cmdName)
            {
                case "ViewPrograms":
                    lblProgramAction.Text = "Operations / Programs /View Programs";
                    pnlPrograms.Visible     = true;
                    pnlCourses.Visible      = false;
                    pnlCourseDocs.Visible   = false;
                    pnlObjQ.Visible         = false;
                    pnlAddDoc.Visible       = false;
                    pnlCOPOMap.Visible      = false;
                    pnlCo.Visible           = false;
                    pnlProgramBatches.Visible = false;
                    pnlAssessments.Visible = false;
                    pnlStudentAttendance.Visible = false;
                    BD.DataBindToGridView(gvPrograms, "SELECT * FROM EduSphere.Programs WHERE ProgramID >= 100 ORDER BY ProgramID DESC", "NA");
                    break;
                case "ViewCourses":
                    lblProgramAction.Text           = "Operations / Programs /View Courses";
                    
                    pnlPrograms.Visible             = false;
                    pnlCourses.Visible              = true;
                    pnlCourseDocs.Visible           = false;
                    pnlObjQ.Visible                 = false;
                    pnlAddDoc.Visible               = false;
                    pnlCOPOMap.Visible              = false;
                    pnlCo.Visible                   = false;
                    pnlProgramBatches.Visible       = false;
                    pnlAssessments.Visible          = false;
                    pnlStudentAttendance.Visible    = false;
                    //int intProgramID = Convert.ToInt32(ddlProgramsFilter.SelectedValue);
                    //Find lblProgramID in DataList and assign the text to Branch
                    lblProgramID.Text = ddlProgramsFilter.SelectedValue.ToString();
                    //FilterCourses(sender, e);
                    BD.DataBindToDropDownList(ddlProgramAddCourse, "SELECT ProgramID,ProgramTitle  FROM EduSphere.Programs WHERE ProgramID >=100");
                    break;
                case "FilterCourses":
                    lblProgramAction.Text = "Operations /Programs /View Courses of Selected Program";
                    pnlPrograms.Visible     = false;
                    pnlCourses.Visible      = true;
                    pnlCourseDocs.Visible   = false;
                    pnlObjQ.Visible         = false;
                    pnlAddDoc.Visible       = false;
                    pnlCOPOMap.Visible      = false;
                    pnlCo.Visible           = false;
                    pnlProgramBatches.Visible = false;
                    pnlAssessments.Visible = false;
                    pnlStudentAttendance.Visible = false;
                    lblProgramID.Text = ddlProgramsFilter.SelectedValue.ToString();
                    string strCmd;
                    string strProgromID = ddlProgramsFilter.SelectedValue.ToString();
                    if (strProgromID != "Select")
                    {
                        int intProgramID = Convert.ToInt32(strProgromID);
                        strCmd = string.Format("SELECT * from EduSphere.Courses where ProgramID='{0}'", intProgramID);
                    }
                    else
                    {
                        strCmd = string.Format("SELECT * from EduSphere.Courses");
                    }
                    if ((lblRole.Text == "Admin") || (lblRole.Text == "Manager"))
                        BD.DataBindToGridView(dgCourses, strCmd, "NA");
                    else
                        BD.DataBindToGridView(dgCoursesView, strCmd, "NA");
                    break;

                case "AddLearning":
                    lblProgramAction.Text = "Operations /Programs /Add Learning";
                    pnlPrograms.Visible         = false;
                    pnlCourses.Visible          = false;
                    pnlCourseDocs.Visible       = false;
                    pnlObjQ.Visible             = false;
                    pnlAddDoc.Visible           = true;
                    pnlCOPOMap.Visible          = false;
                    pnlCo.Visible               = false;
                    pnlProgramBatches.Visible   = false;
                    pnlAssessments.Visible      = false;
                    pnlStudentAttendance.Visible = false;
                    BD.DataBindToDropDownList(ddlArtifactCourse, "SELECT * FROM EduSphere.Courses");
                    BD.DataBindToDropDownList(ddlDocProgram, "SELECT * FROM EduSphere.Programs WHERE ProgramID >=100");
                    break;
                case "AddCourse":
                    lblProgramAction.Text = "Operations /Programs /Add New Course";
                    break;
                case "AddBatch":
                    pnlPrograms.Visible         = false;
                    pnlCourses.Visible          = false;
                    pnlCourseDocs.Visible       = false;
                    pnlObjQ.Visible             = false;
                    pnlAddDoc.Visible           = false;
                    pnlCOPOMap.Visible          = false;
                    pnlCo.Visible               = false;
                    pnlProgramBatches.Visible   = true;
                    pnlAssessments.Visible      = false;
                    pnlStudentAttendance.Visible = false;
                    lblProgramAction.Text = "Operations /Programs /Create New Program Batch";
                    //Diplay All Existing Batches
                    BD.DataBindToGridView(gvProgramBatches, "SELECT * FROM EduSphere.ProgramBatch b JOIN Edusphere.Programs p ON b.ProgramID=p.ProgramID", "NA");
                    BD.DataBindToDropDownList(ddlProgramID, "SELECT ProgramTitle,ProgramID FROM EduSphere.Programs WHERE ProgramID >=100");
                    break;
                case "ViewAssessments":
                    pnlPrograms.Visible         = false;
                    pnlCourses.Visible          = false;
                    pnlCourseDocs.Visible       = false;
                    pnlObjQ.Visible             = false;
                    pnlAddDoc.Visible           = false;
                    pnlCOPOMap.Visible          = false;
                    pnlCo.Visible               = false;
                    pnlProgramBatches.Visible   = false;
                    pnlAssessments.Visible      = true;
                    pnlStudentAttendance.Visible = false;
                    lblProgramAction.Text = "Operations /Programs /Assessments";
                    //Diplay All Existing Batches
                    BD.DataBindToDropDownList(ddlAssessmentBatchFilter, "SELECT BatchID,BatchCode FROM EduSphere.ProgramBatch ORDER BY BatchCode DESC");
                    BD.DataBindToGridView(gvAssessments, "SELECT * FROM EduSphere.Assessments a JOIN Edusphere.Courses c ON a.CourseID=c.CourseID JOIN EduSphere.ProgramBatch b ON a.BatchID=b.BatchID", "NA");
                    //For Creating new Assessment
                    BD.DataBindToDropDownList(ddlAssessmentCourse, "SELECT CourseTitle,CourseID FROM EduSphere.Courses");
                    BD.DataBindToDropDownList(ddlAssessmentBatch, "SELECT BatchCode,BatchID FROM EduSphere.ProgramBatch");
                    break;
                case "StudentAttendance":
                    pnlPrograms.Visible             = false;
                    pnlCourses.Visible              = false;
                    pnlCourseDocs.Visible           = false;
                    pnlObjQ.Visible                 = false;
                    pnlAddDoc.Visible               = false;
                    pnlCOPOMap.Visible              = false;
                    pnlCo.Visible                   = false;
                    pnlProgramBatches.Visible       = false;
                    pnlAssessments.Visible          = false;
                    pnlStudentAttendance.Visible    = true;
                    lblProgramAction.Text           = "Operations /Programs /Student Attendance";
                    lblAttendanceTakebByID.Text     = User.Identity.Name.ToString();
                    string strASheetsCmd            = string.Format("SELECT * FROM EduSphere.AttendanceSheets a JOIN EduSphere.Courses c ON a.CourseID=c.CourseID");
                    BD.DataBindToGridView(gvAttendanceSheets, strASheetsCmd, "NA");
                    //For Creating new Attendance Sheet
                    BD.DataBindToDropDownList(ddlAttendanceSheetCourse, "SELECT CourseTitle,CourseID FROM EduSphere.Courses");
                    BD.DataBindToDropDownList(ddlAttendanceSheetBatch, "SELECT BatchCode,BatchID FROM EduSphere.ProgramBatch");
                    break;
                case "ReturnToPrograms":
                    Response.Redirect("Programs.aspx");
                    break;
                default:
                    break;
            }

        }

        //Display Course Details of selected student
        public void DisplayCourseDetails(object sender, CommandEventArgs e)
        {
            string cmdName, strKey;
            string queryString = "";
            cmdName = e.CommandName.ToString();
            strKey = e.CommandArgument.ToString();
            lblCourseID.Text = strKey;
            switch (cmdName)
            {
                case "CourseOutcomes":
                    pnlCourses.Visible = false;
                    pnlCo.Visible = true;
                    pnlCourseDocs.Visible = false;
                    pnlCourseDocs.Visible = false;
                    queryString = string.Format("SELECT * FROM CO co JOIN EduSphere.Courses c  ON co.CourseID=c.CourseID WHERE co.CourseID='{0}'", strKey);
                    BD.DataBindToDataList(dlCo, queryString);
                    break;
                case "CourseMaterial":
                    lblSelectedCourseID.Text = strKey;
                    string strCourseVideos = string.Format(@"SELECT * FROM EduSphere.CourseVideos v
                                                              JOIN EduSphere.Courses c ON v.CourseID=c.CourseID
                                                              WHERE c.CourseID='{0}'", strKey);
                    BD.DataBindToGridView(gvCourseVideos, strCourseVideos, "NA");
                    //List of Documents for Chosen Program
                    string strCourseDocs = string.Format(@"SELECT * FROM EduSphere.CourseDocs v
                                                              JOIN EduSphere.Courses c ON v.CourseID=c.CourseID
                                                              WHERE c.CourseID='{0}'", strKey);
                    BD.DataBindToGridView(gvCourseDocs, strCourseDocs, "NA");

                    pnlCourses.Visible      = false;
                    pnlCo.Visible           = false;
                    pnlCourseDocs.Visible   = true;
                    pnlObjQ.Visible         = false;
                    break;
                case "QuestionBank":
                    lblCID.Text             = strKey;
                    pnlCourses.Visible      = false;
                    pnlCo.Visible           = false;
                    pnlCourseDocs.Visible   = false;
                    pnlObjQ.Visible         = true;
                    queryString             = string.Format("SELECT * FROM Evaluations.ObjQuestions Q join Evaluations.ObjAnswers A on Q.QuestionID=A.QuestionID where Q.CourseID='{0}'", strKey);
                    BD.DataBindToDataList(dlObjQ, queryString);
                    break;
                default:
                    break;
            }

        }

        //To return back to main panel
        protected void ReturnToPanel(object sender, CommandEventArgs e)
        {
            string cmdName = e.CommandName.ToString();
            switch (cmdName)
            {
                case "ToPnlCourses":
                    pnlPrograms.Visible = false;
                    pnlCourses.Visible = false;
                    pnlAddDoc.Visible = false;
                    pnlCourseDocs.Visible = false;
                    pnlObjQ.Visible = false;
                    pnlCo.Visible = false;
                    pnlCourseDocs.Visible = false;
                    pnlCOPOMap.Visible = false;
                    break;
                case "FromPnlObjQToPnlCourses":
                    pnlObjQ.Visible = false;
                    pnlCourses.Visible = true;
                    break;
                case "FromPnlCoToPnlCourses":
                    pnlCo.Visible = false;
                    pnlCourses.Visible = true;
                    break;
                case "FromPnlCourseDocsToPnlCourses":
                    pnlCourseDocs.Visible = false;
                    pnlCourses.Visible = true;
                    break;
                case "FromPnlCOPOMapToPnlCo":
                    pnlCOPOMap.Visible = false;
                    pnlCo.Visible = true;
                    break;
                default:
                    break;
            }
        }

        //Edit the CourseOutcomes of selected course in dlCo datalist
        protected void dlCoEditHandler(object sender, DataListCommandEventArgs e)
        {
            dlCo.EditItemIndex = e.Item.ItemIndex;
            //int intCoID             = Convert.ToInt32(dlCo.DataKeys[e.Item.ItemIndex]);
            string strCourseID = lblCourseID.Text;
            string queryString = string.Format("SELECT * FROM CO co JOIN EduSphere.Courses c  ON co.CourseID=c.CourseID WHERE co.CourseID='{0}'", strCourseID);
            BD.DataBindToDataList(dlCo, queryString);
        }

        //Add New Course Outcome
        protected void AddNewCourseOutcome(object sender, EventArgs e)
        {
            string strCourseID = lblCourseID.Text;
            SqlCommand ObjCmd = new SqlCommand("spInsertCO", BD.ConStr);
            ObjCmd.CommandType = CommandType.StoredProcedure;
            ObjCmd.Parameters.AddWithValue("@CourseID", strCourseID);
            BD.UpdateParameters(ObjCmd);
            string queryString = string.Format("SELECT * FROM CO co JOIN EduSphere.Courses c  ON co.CourseID=c.CourseID WHERE co.CourseID='{0}'", strCourseID);
            BD.DataBindToDataList(dlCo, queryString);
        }

        //Cancel Editing Course Objectives
        protected void dlCoCancelHandler(object sender, DataListCommandEventArgs e)
        {
            dlCo.EditItemIndex = -1;
            string strCourseID = lblCourseID.Text;
            //string strHallTicketNumber = Convert.ToString(dlCo.DataKeys[e.Item.ItemIndex]);
            string queryString = string.Format("SELECT * FROM CO co JOIN EduSphere.Courses c  ON co.CourseID=c.CourseID WHERE co.CourseID='{0}'", strCourseID);
            BD.DataBindToDataList(dlCo, queryString);
        }

        //Update Course Objective
        protected void dlCoUpdateHandler(object sender, DataListCommandEventArgs e)
        {
            int intCoID = (int)dlCo.DataKeys[e.Item.ItemIndex];
            string strCourseOutcome = (((TextBox)e.Item.FindControl("txtBoxCo")).Text).ToString();
            string strCourseOutcomeDescription = (((TextBox)e.Item.FindControl("txtBoxCoDescription")).Text).ToString();

            SqlCommand ObjCmd = new SqlCommand("spUpdateCO", BD.ConStr);
            ObjCmd.CommandType = CommandType.StoredProcedure;
            ObjCmd.Parameters.AddWithValue("@CoID", intCoID);
            ObjCmd.Parameters.AddWithValue("@CourseOutcome", strCourseOutcome);
            ObjCmd.Parameters.AddWithValue("@CourseOutcomeDescription", strCourseOutcomeDescription);
            //Update Course Outcome       
            BD.UpdateParameters(ObjCmd);
            //Revert back from EditItemTemplate
            dlCo.EditItemIndex = -1;
            //Bind the datalist with updated values
            string strCourseID = lblCID.Text;
            string queryString = string.Format("SELECT * FROM CO co JOIN EduSphere.Courses c  ON co.CourseID=c.CourseID WHERE co.CourseID='{0}'", strCourseID);
            BD.DataBindToDataList(dlCo, queryString);
        }

        //Supporting function to display updated COPOMap table for selected CO and Program
        private void RefreshCOPOMapping(int intProgramID, int intCoID)
        {
            string queryString = string.Format("SELECT * FROM COPOMap m JOIN PO p ON m.POID=p.POID WHERE m.ProgramID={0} AND m.CoID={1}", intProgramID, intCoID);
            BD.DataBindToDataGridDC(dgCOPOMap, queryString, "COPOMap");
            pnlCOPOMap.Visible = true;
            pnlCo.Visible = false;
        }
        //Diplay existing COPOMap for selected CO and Program
        protected void DisplayCOPOMapping(object sender, CommandEventArgs e)
        {
            lblCOID.Text = e.CommandArgument.ToString();//source CoID for further reference
            lblCoDescription.Text = e.CommandName.ToString();

            //Populate Filter Parameters
            string CmdString = string.Format("SELECT * FROM Programs WHERE ProgramID >=100");
            BD.DataBindToDropDownList(ddlPrograms, CmdString);

            int intProgramID = Convert.ToInt32(ddlPrograms.SelectedValue.ToString());
            int intCoID = Convert.ToInt32(lblCOID.Text);
            //Populate Filter Parameters
            string queryPO = string.Format("SELECT * FROM PO WHERE ProgramID='{0}'", intProgramID);
            BD.DataBindToDropDownList(ddlPO, queryPO);

            //User chosen filter parameters to display COPOMap table
            RefreshCOPOMapping(intProgramID, intCoID);

        }

        //Incase the programe slection is changed redraw it
        protected void SelectedProgramIndexChanged(object sender, EventArgs e)
        {
            int intProgramID = Convert.ToInt32(ddlPrograms.SelectedValue.ToString());
            int intCoID = Convert.ToInt32(lblCOID.Text);
            //Populate Filter Parameters
            string queryPO = string.Format("SELECT * FROM PO WHERE ProgramID='{0}'", intProgramID);
            BD.DataBindToDropDownList(ddlPO, queryPO);

            //User chosen filter parameters to display COPOMap table
            RefreshCOPOMapping(intProgramID, intCoID);
        }

        //Insert new PO to COPOMap for selected CO and Program
        protected void InsertPOtoCOPOMap(object sender, CommandEventArgs e)
        {
            int intCoID = Convert.ToInt32(lblCOID.Text);
            int intProgramID = Convert.ToInt32(ddlPrograms.SelectedValue.ToString());
            int intPOID = Convert.ToInt32(ddlPO.SelectedValue.ToString());
            int intCOPOMapValue = Convert.ToInt32(e.CommandArgument.ToString());

            SqlCommand ObjCmd = new SqlCommand("spManageCOPOMap", BD.ConStr);
            ObjCmd.CommandType = CommandType.StoredProcedure;

            ObjCmd.Parameters.AddWithValue("@ManageCOPOMapCmd", "InsertCOPOMap");
            ObjCmd.Parameters.AddWithValue("@CoID", intCoID);
            ObjCmd.Parameters.AddWithValue("@POID", intPOID);
            ObjCmd.Parameters.AddWithValue("@ProgramID", intProgramID);
            ObjCmd.Parameters.AddWithValue("@COPOMapValue", intCOPOMapValue);
            //The follwoing param is not used. Supplied to meet procedure req
            ObjCmd.Parameters.AddWithValue("@COPOMapID", -1);

            BD.UpdateParameters(ObjCmd);
            //Refresh the view
            RefreshCOPOMapping(intProgramID, intCoID);
        }

        //Edit, Update and delete even handler for dgClassMarks
        protected void dgEditMapValue(object sender, DataGridCommandEventArgs e)
        {
            dgCOPOMap.EditItemIndex = e.Item.ItemIndex;

            //Refresh the view
            int intProgramID = Convert.ToInt32(ddlPrograms.SelectedValue.ToString());
            int intCoID = Convert.ToInt32(lblCOID.Text);
            RefreshCOPOMapping(intProgramID, intCoID);

        }

        //Update CO Contribution
        protected void dgUpdateMapValue(object sender, DataGridCommandEventArgs e)
        {
            int intCOPOMapID, intCOPOMapValue;
            int intProgramID = Convert.ToInt32(ddlPrograms.SelectedValue.ToString());
            int intCoID = Convert.ToInt32(lblCOID.Text);
            intCOPOMapID = (int)dgCOPOMap.DataKeys[e.Item.ItemIndex];
            intCOPOMapValue = Convert.ToInt32(((TextBox)e.Item.Cells[5].Controls[0]).Text);

            SqlCommand ObjCmd = new SqlCommand("spManageCOPOMap", BD.ConStr);
            ObjCmd.CommandType = CommandType.StoredProcedure;

            ObjCmd.Parameters.AddWithValue("@ManageCOPOMapCmd", "UpdateCOPOMapValue");
            ObjCmd.Parameters.AddWithValue("@COPOMapID", intCOPOMapID);
            ObjCmd.Parameters.AddWithValue("@ProgramID", intProgramID);
            ObjCmd.Parameters.AddWithValue("@COPOMapValue", intCOPOMapValue);

            //The follwoing param is not used. Supplied to meet procedure req
            ObjCmd.Parameters.AddWithValue("@CoID", intCoID);
            ObjCmd.Parameters.AddWithValue("@POID", -1);
            BD.UpdateParameters(ObjCmd);
            dgCOPOMap.EditItemIndex = -1;

            //Refresh the view
            RefreshCOPOMapping(intProgramID, intCoID);
        }

        protected void dgCancelMapValue(object sender, DataGridCommandEventArgs e)
        {
            dgCOPOMap.EditItemIndex = -1;
            int intProgramID = Convert.ToInt32(ddlPrograms.SelectedValue.ToString());
            int intCoID = Convert.ToInt32(lblCOID.Text);
            //Refresh the view
            RefreshCOPOMapping(intProgramID, intCoID);
            //string queryString  = string.Format("SELECT * FROM COPOMap m JOIN PO p ON m.POID=p.POID WHERE m.ProgramID={0} AND m.CoID={1}", intProgramID, intCoID);
            //BD.DataBindToDataGridDC(dgCOPOMap, queryString, "COPOMap");
        }

        //Delete PO from COPO Map
        protected void dgDeleteCOPOMap(object sender, CommandEventArgs e)
        {
            int intProgramID = Convert.ToInt32(ddlPrograms.SelectedValue.ToString());
            int intCoID = Convert.ToInt32(lblCOID.Text);
            //int intCOPOMapID        = (int)dgCOPOMap.DataKeys[e.Item.ItemIndex];
            int intCOPOMapID = Convert.ToInt32(e.CommandArgument.ToString());

            SqlCommand ObjCmd = new SqlCommand("spManageCOPOMap", BD.ConStr);
            ObjCmd.CommandType = CommandType.StoredProcedure;

            ObjCmd.Parameters.AddWithValue("@ManageCOPOMapCmd", "DeleteCOPOMap");
            ObjCmd.Parameters.AddWithValue("@COPOMapID", intCOPOMapID);

            //The following param is not used. Supplied to meet procedure req
            ObjCmd.Parameters.AddWithValue("@CoID", -1);
            ObjCmd.Parameters.AddWithValue("@POID", -1);
            ObjCmd.Parameters.AddWithValue("@ProgramID", intProgramID);
            ObjCmd.Parameters.AddWithValue("@COPOMapValue", -1);

            BD.UpdateParameters(ObjCmd);
            //Refresh the view
            RefreshCOPOMapping(intProgramID, intCoID);
        }

        //Add new objective type question, edit, update and cancel
        //Edit the Objective Question  of selected course in dlObjQ datalist
        protected void dlQEditHandler(object sender, DataListCommandEventArgs e)
        {
            dlObjQ.EditItemIndex = e.Item.ItemIndex;
            int intQuestionID = Convert.ToInt32(dlObjQ.DataKeys[e.Item.ItemIndex]);
            string strCourseID = lblCID.Text;
            string queryString = string.Format("SELECT * FROM Evaluations.ObjQuestions Q JOIN Evaluations.ObjAnswers A  ON Q.QuestionID=A.QuestionID WHERE Q.QuestionID='{0}'", intQuestionID);
            BD.DataBindToDataList(dlObjQ, queryString);
            
        }

        //Add New Objective Type Question for selected Course
        protected void AddNewObjQ(object sender, EventArgs e)
        {
            string strCourseID = lblCID.Text;
            string strManageCmd = "AddNewQ";

            SqlCommand ObjCmd = new SqlCommand("spManageObjQuestions", BD.ConStr);
            ObjCmd.CommandType = CommandType.StoredProcedure;

            ObjCmd.Parameters.AddWithValue("@CourseID", strCourseID);
            ObjCmd.Parameters.AddWithValue("@ManageCmd", strManageCmd);
            ObjCmd.Parameters.AddWithValue("@SessionID", 1);
            ObjCmd.Parameters.AddWithValue("@QuestionID", 1);
            ObjCmd.Parameters.AddWithValue("@Question", txtBoxNewQuestion.Text);
            ObjCmd.Parameters.AddWithValue("@CorrectAnswer", txtBoxNewCorrectAnswer.Text);
            ObjCmd.Parameters.AddWithValue("@OptionA", txtBoxNewOptionA.Text);
            ObjCmd.Parameters.AddWithValue("@OptionB", txtBoxNewOptionB.Text);
            ObjCmd.Parameters.AddWithValue("@OptionC", txtBoxNewOptionC.Text);
            ObjCmd.Parameters.AddWithValue("@OptionD", txtBoxNewOptionD.Text);


            BD.UpdateParameters(ObjCmd);
            //Display all the Questions for the selected Course
            //string queryString = string.Format("SELECT * FROM Evaluations.ObjQuestions Q join Evaluations.ObjAnswers A on Q.QuestionID=A.QuestionID where Q.CourseID='{0}'", strCourseID);
            string queryString = string.Format("SELECT TOP 1 * FROM Evaluations.ObjQuestions Q join Evaluations.ObjAnswers A on Q.QuestionID=A.QuestionID ORDER BY Q.QuestionID DESC");
            BD.DataBindToDataList(dlObjQ, queryString);

            txtBoxNewQuestion.Text      = "";
            txtBoxNewCorrectAnswer.Text = "";
            txtBoxNewOptionA.Text       = "";
            txtBoxNewOptionB.Text       = "";
            txtBoxNewOptionC.Text       = "";
            txtBoxNewOptionD.Text       = "";

        }

        //Cancel Editing Objective Question
        protected void dlQCancelHandler(object sender, DataListCommandEventArgs e)
        {
            dlObjQ.EditItemIndex = -1;
            string strCourseID = lblCID.Text;
            int intQuestionID = Convert.ToInt32(dlObjQ.DataKeys[e.Item.ItemIndex]);

            string queryString = string.Format("SELECT * FROM Evaluations.ObjQuestions Q join Evaluations.ObjAnswers A on Q.QuestionID=A.QuestionID where Q.CourseID='{0}'", strCourseID);
            BD.DataBindToDataList(dlObjQ, queryString);
        }

        //Update Objective Question
        protected void dlQUpdateHandler(object sender, DataListCommandEventArgs e)
        {
            int intQuestionID = (int)dlObjQ.DataKeys[e.Item.ItemIndex];
            string strCourseID = lblCID.Text;
            string strQuestion = (((TextBox)e.Item.FindControl("txtBoxQuestion")).Text).ToString();
            string strCorrectAnswer = (((TextBox)e.Item.FindControl("txtBoxCorrectAnswer")).Text).ToString();
            string strOptionA = (((TextBox)e.Item.FindControl("txtBoxOptionA")).Text).ToString();
            string strOptionB = (((TextBox)e.Item.FindControl("txtBoxOptionB")).Text).ToString();
            string strOptionC = (((TextBox)e.Item.FindControl("txtBoxOptionC")).Text).ToString();
            string strOptionD = (((TextBox)e.Item.FindControl("txtBoxOptionD")).Text).ToString();

            SqlCommand ObjCmd = new SqlCommand("spManageObjQuestions", BD.ConStr);
            ObjCmd.CommandType = CommandType.StoredProcedure;
            ObjCmd.Parameters.AddWithValue("@ManageCmd", "UpdateQ");
            ObjCmd.Parameters.AddWithValue("@SessionID", 1);
            ObjCmd.Parameters.AddWithValue("@CourseID", strCourseID);
            ObjCmd.Parameters.AddWithValue("@QuestionID", intQuestionID);
            ObjCmd.Parameters.AddWithValue("@Question", strQuestion);
            ObjCmd.Parameters.AddWithValue("@CorrectAnswer", strCorrectAnswer);
            ObjCmd.Parameters.AddWithValue("@OptionA", strOptionA);
            ObjCmd.Parameters.AddWithValue("@OptionB", strOptionB);
            ObjCmd.Parameters.AddWithValue("@OptionC", strOptionC);
            ObjCmd.Parameters.AddWithValue("@OptionD", strOptionD);
            //Update Course Outcome       
            BD.UpdateParameters(ObjCmd);
            //Revert back from EditItemTemplate
            dlObjQ.EditItemIndex = -1;
            //Bind the datalist with updated values
            string queryString = string.Format("SELECT * FROM Evaluations.ObjQuestions Q join Evaluations.ObjAnswers A on Q.QuestionID=A.QuestionID where Q.CourseID='{0}'", strCourseID);
            BD.DataBindToDataList(dlObjQ, queryString);
        }


        

        //Delete Course
        protected void dgCourses_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            
        }
        //Edit Course
        protected void dgCourses_RowEditing(object sender, GridViewEditEventArgs e)
        {
            dgCourses.EditIndex = e.NewEditIndex;
            BD.DataBindToGridView(dgCourses, "SELECT * from EduSphere.Courses", "NA");
        }
       

        //Cancel Coure Editing
        protected void dgCourses_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            dgCourses.EditIndex = -1;
            BD.DataBindToGridView(dgCourses, "SELECT * from EduSphere.Courses", "NA");
        }
        

        //Delete Course
        protected void dgDeleteCourse(object sender, DataGridCommandEventArgs e)
        {
            string strKey = dgCourses.DataKeys[e.Item.ItemIndex].ToString();
            SqlCommand ObjCmd = new SqlCommand("spDeleteFromTable", BD.ConStr);
            ObjCmd.CommandType = CommandType.StoredProcedure;

            ObjCmd.Parameters.AddWithValue("@KeyID", strKey);
            ObjCmd.Parameters.AddWithValue("@SourceTable", "EduSphere.Courses");
            BD.UpdateParameters(ObjCmd);
            GetSource();
            //BD.DeleteSelectedRecord(dgCourses, key, "Courses");
        }


        protected void dgCourses_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int intKeyCID, intCredits;
            string strCourseTitle, strCourseDescription;

            intKeyCID               = Convert.ToInt32(dgCourses.DataKeys[e.RowIndex].Value.ToString());
            GridViewRow row         = dgCourses.Rows[e.RowIndex];
            strCourseTitle          = ((TextBox)row.Cells[3].Controls[0]).Text;
            strCourseDescription    = ((TextBox)row.Cells[4].Controls[0]).Text;
            intCredits              = Convert.ToInt32(((TextBox)row.Cells[5].Controls[0]).Text);

            SqlCommand ObjCmd = new SqlCommand("spUpdateCourse", BD.ConStr);
            ObjCmd.CommandType = CommandType.StoredProcedure;

            
            ObjCmd.Parameters.AddWithValue("@CourseID", intKeyCID);
            ObjCmd.Parameters.AddWithValue("@CourseTitle", strCourseTitle);
            ObjCmd.Parameters.AddWithValue("@CourseDescription", strCourseDescription);
            ObjCmd.Parameters.AddWithValue("@Credits", intCredits);
            BD.UpdateParameters(ObjCmd);

            dgCourses.EditIndex = -1;
            BD.DataBindToGridView(dgCourses, "SELECT * from EduSphere.Courses", "NA");
        }
        

        //Get Datasource
        protected void GetSource()
        {
            SqlCommand ObjCmd = new SqlCommand("spSelectCourses", BD.ConStr);
            ObjCmd.CommandType = CommandType.StoredProcedure;

            //DataSet ObjDS = new DataSet();
            SqlDataAdapter ObjDA = new SqlDataAdapter(ObjCmd);
            ObjDA.Fill(ObjDS, "EduSphere.Courses");

            //ObjDS = BD.GetDataSet(ObjCmd);
            //dgCourses.DataSource = ObjDS;
            dgCourses.DataSource = ObjDA.Fill(ObjDS);
            dgCourses.DataBind();

        }
        //Page Index Changed
        protected void dgCourses_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            dgCourses.PageIndex = e.NewPageIndex;
            BD.DataBindToGridView(dgCourses, "SELECT * from EduSphere.Courses", "NA");
        }

        public void DgItemDisplay(object sender, DataGridCommandEventArgs e)
        {

            string cmdName = ((LinkButton)e.CommandSource).CommandName;
            string cmdArg = ((LinkButton)e.CommandSource).CommandArgument;
            switch (cmdName)
            {
                case "ViewCoursePlanner":
                    DisplayArtifact(cmdArg);

                    break;
            }


        }

        public void DisplayArtifact(string fileName)
        {
            //Get the path details
            string path = Server.MapPath(fileName);
            //Get file name
            string name = Path.GetFileName(path);
            //get file extension
            string ext = Path.GetExtension(path);

            string type = "";
            //set known types based on extension
            switch (ext)
            {
                case ".pdf":
                    type = "Application/pdf";
                    break;
                case ".docx":
                    type = "Application/msword";
                    break;

            }
            //Set the appropriate ContentType.
            Response.ContentType = type;
            Response.AppendHeader("Content-Disposition", "attachment; filename=name");
            //Response.TransmitFile(Server.MapPath("~/docs/test.doc"));
            Response.WriteFile(Server.MapPath(fileName));
            Response.End();

        }

        //BulletedListDisplayMode Panel to add new course
        protected void DisplayPnlAddProgram(object sender, CommandEventArgs e)
        {
            BD.DataBindToGridView(gvPrograms, "SELECT * FROM EduSphere.Programs WHERE ProgramID >=100 ORDER BY ProgramID DESC", "NA");
            pnlCourses.Visible = false;
            pnlAddDoc.Visible = false;

            pnlPrograms.Visible = true;
        }

        //Inserts a new programme 
        protected void AddProgram(object sender, EventArgs e)
        {
            SqlCommand ObjCmd = new SqlCommand("spInsertPrograms", BD.ConStr);
            ObjCmd.CommandType = CommandType.StoredProcedure;
            ObjCmd.Parameters.AddWithValue("@ProgramTitle", txtBoxProgTitle.Text);
            ObjCmd.Parameters.AddWithValue("@ProgramDescription", txtBoxProgDescription.Text);
            ObjCmd.Parameters.AddWithValue("@ProgramVision", txtBoxProgVision.Text);
            ObjCmd.Parameters.AddWithValue("@ProgramMission", txtBoxProgMission.Text);
            BD.UpdateParameters(ObjCmd);
            txtBoxProgDescription.Text = "";
            txtBoxProgTitle.Text = "";
            txtBoxProgVision.Text = "";
            txtBoxProgMission.Text = "";
        }

        //Rowcommand on gridview
        protected void gvPrograms_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if(e.CommandName=="ViewCourses")
            {
                int intProgramID = Convert.ToInt32(e.CommandArgument.ToString());
                BD.DataBindToGridView(gvProgramCourses, string.Format("SELECT * FROM Edusphere.Courses WHERE ProgramID={0}", intProgramID),"NA");
            }
        }

        //Program Batch Row Command
        protected void gvProgramBatches_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string strCmd = e.CommandName.ToString();
            int intBatchID = Convert.ToInt32(e.CommandArgument.ToString());
            lblBatchID.Text = intBatchID.ToString();
            if(strCmd== "BatchSchedule")
            {
                gvStudentsList.Visible = false;
                gvBatchSchedule.Visible = true;
                BD.DataBindToGridView(gvBatchSchedule, string.Format("SELECT * FROM EduSphere.BatchSchedule s JOIN EduSphere.Courses c ON s.CourseID=c.CourseID WHERE BatchID={0}", intBatchID),"NA" );
            }
            if (strCmd == "StudentList")
            {
                gvStudentsList.Visible = true;
                gvBatchSchedule.Visible = false;
                BD.DataBindToGridView(gvStudentsList, string.Format("SELECT * FROM EduSphere.Members WHERE BatchID={0}", intBatchID), "NA");
            }
        }

        //Batch Schedule Row Command
        protected void gvBatchSchedule_RowCommand(object sender,GridViewCommandEventArgs e)
        {

        }

        protected void gvBatchSchedule_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow && gvBatchSchedule.EditIndex == e.Row.RowIndex)
            {
                DropDownList ddlEditCourseID = (DropDownList)e.Row.FindControl("ddlEditCourseID");
                if(ddlEditCourseID!=null)
                {
                    BD.DataBindToDropDownList(ddlEditCourseID, "SELECT CourseID,CourseTitle FROM EduSphere.Courses");
                    //ddlEditCourseID.Items.FindByValue((e.Row.FindControl("lblCourseTitle") as Label).Text).Selected = true;
                }

            }
        }
        //Edit Batch Schedule
        public void gvEditBatchSchedule(object sender, GridViewEditEventArgs e)
        {
            gvBatchSchedule.EditIndex       = e.NewEditIndex;
            int intDayID = Convert.ToInt32(gvBatchSchedule.DataKeys[e.NewEditIndex].Value.ToString());
            //DropDownList ddl = (DropDownList)e.Row.FindControl("ddldesignation");
            
            //string strStore = ddlStore.SelectedValue.ToString();
            //string strQuery                 = string.Format("SELECT inventoryID,DateOfInventoryChange,inventoryChange, i.productID,productManufacturer,productTitle,productDescription,productPartNumber,i.storeID,inStockQuantity,inStockQuantity*productRate as Value FROM PurpleSalon.Products p JOIN PurpleSalon.ProductInventory i ON p.ProductID= i.productID WHERE productGroup='{0}' AND storeID='{1}' ORDER BY Value DESC", strInventoryProductGroup, strStore);
            string strQuery = string.Format(@"SELECT * FROM EduSphere.BatchSchedule s JOIN EduSphere.Courses c ON s.CourseID=c.CourseID WHERE DayID={0}", intDayID);
            BD.DataBindToGridView(gvBatchSchedule, strQuery, "NA");

        }
        //Cancel Batch Schedule
        public void gvCancelBatchSchedule(object sender, GridViewCancelEditEventArgs e)
        {
            gvBatchSchedule.EditIndex = -1;
            //string strInventoryProductGroup = ddlInventoryProductGroup.SelectedValue.ToString();
            //string strStore = ddlStore.SelectedValue.ToString();
            string strQuery = string.Format("SELECT * FROM EduSphere.BatchSchedule s JOIN EduSphere.Courses c ON s.CourseID=c.CourseID WHERE BatchID={0}", Convert.ToInt32(lblBatchID.Text));
            BD.DataBindToGridView(gvBatchSchedule, strQuery,"NA");
        }

        //Update Btch Schedule
        public void gvUpdateBatchSchedule(object sender, GridViewUpdateEventArgs e)
        {
            int intDayID        = (int)gvBatchSchedule.DataKeys[e.RowIndex].Value;
            GridViewRow row     = gvBatchSchedule.Rows[e.RowIndex];
           
            string strTime      = ((TextBox)row.Cells[3].Controls[0]).Text;
            int CourseID        = Convert.ToInt32((row.FindControl("ddlEditCourseID") as DropDownList).SelectedItem.Value);
            string strTopic     = ((TextBox)row.Cells[5].Controls[0]).Text;
            string strDetails   = ((TextBox)row.Cells[6].Controls[0]).Text;

            SqlCommand ObjCmd = new SqlCommand("spUpdateBatchSchedule", BD.ConStr);
            ObjCmd.CommandType = CommandType.StoredProcedure;
            ObjCmd.Parameters.AddWithValue("@DayID", intDayID);
            ObjCmd.Parameters.AddWithValue("@SessionTime", strTime);
            ObjCmd.Parameters.AddWithValue("@CourseID", CourseID);
            ObjCmd.Parameters.AddWithValue("@SessionTitle", strTopic);
            ObjCmd.Parameters.AddWithValue("@SessionDetails", strDetails);
            BD.UpdateParameters(ObjCmd);
            gvBatchSchedule.EditIndex = -1;
            
            string strQuery = string.Format("SELECT * FROM EduSphere.BatchSchedule s JOIN EduSphere.Courses c ON s.CourseID=c.CourseID WHERE BatchID={0}", Convert.ToInt32(lblBatchID.Text));
            BD.DataBindToGridView(gvBatchSchedule, strQuery, "NA");

        }
        //StudentsList of Batch Row Command
        protected void gvStudentsList_RowCommand(object sender, GridViewCommandEventArgs e)
        {

        }

        //Button Command clicks-gvAssessments
        protected void gvAssessments_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string strCmd           = e.CommandName.ToString();
            string[] args           = new string[4];
            args                    = e.CommandArgument.ToString().Split(';');
            int intAssessmentID     = Convert.ToInt32(args[0]);
            int intTotalMarks       = Convert.ToInt32(args[1]);
            int intPassingMarks     = Convert.ToInt32(args[2]);
            lblAssessmentID.Text    = intAssessmentID.ToString();
            lblTotalMarks.Text      = intTotalMarks.ToString();
            lblPassingMarks.Text    = intPassingMarks.ToString();
            if (strCmd == "StudentAssessment")
            {
                gvStudentAssessment.Visible = true;
                //gvBatchSchedule.Visible = true;
                BD.DataBindToGridView(gvStudentAssessment, string.Format("SELECT * FROM EduSphere.StudentAssessments a JOIN EduSphere.Members s ON a.MemberID=s.MemberID WHERE AssessmentID={0}", intAssessmentID), "NA");
            }
        }
        //View Assements for selected Batch
        protected void AssessmentBatchFilter_IndexChanged(object sender,EventArgs e)
        {
            string strCmd;
            string strBatchID = ddlAssessmentBatchFilter.SelectedValue.ToString();
            if(strBatchID!="Select")
            {
                int intBatchID = Convert.ToInt32(ddlAssessmentBatchFilter.SelectedValue.ToString());
                strCmd = string.Format("SELECT * FROM  EduSphere.Assessments a JOIN Edusphere.Courses c ON a.CourseID=c.CourseID JOIN EduSphere.ProgramBatch b ON a.BatchID=b.BatchID WHERE a.BatchID={0}", intBatchID);
            }
            else
            {
                strCmd = string.Format("SELECT * FROM  EduSphere.Assessments a JOIN Edusphere.Courses c ON a.CourseID=c.CourseID JOIN EduSphere.ProgramBatch b ON a.BatchID=b.BatchID ");
            }
            BD.DataBindToGridView(gvAssessments, strCmd, "NA");
            //Hide Results of prviously selected Assessment ID 
            gvStudentAssessment.Visible = false;
        }

        //StudentAssessment Row Command
        protected void gvStudentAssessment_RowCommand(object sender, GridViewCommandEventArgs e)
        {

        }
        //Edit gvStudentAssessment-MarksObtained
        public void gvEditStudentAssessment(object sender, GridViewEditEventArgs e)
        {
            gvStudentAssessment.EditIndex = e.NewEditIndex;
            string strStudentAssessmentID = gvStudentAssessment.DataKeys[e.NewEditIndex].Value.ToString();
           
            string strQuery = string.Format(@"SELECT * FROM EduSphere.StudentAssessments a JOIN EduSphere.Members s ON a.MemberID=s.MemberID WHERE StudentAssessmentID='{0}'", strStudentAssessmentID);
            BD.DataBindToGridView(gvStudentAssessment, strQuery, "NA");

        }
        //Cancel Editing gvStudentAssessment
        public void gvCancelStudentAssessment(object sender, GridViewCancelEditEventArgs e)
        {
            gvStudentAssessment.EditIndex = -1;
            string strQuery = string.Format("SELECT * FROM EduSphere.StudentAssessments a JOIN EduSphere.Members s ON a.MemberID=s.MemberID WHERE AssessmentID={0}", Convert.ToInt32(lblAssessmentID.Text));
            BD.DataBindToGridView(gvStudentAssessment, strQuery, "NA");
        }

        //Update Btch Schedule
        public void gvUpdateStudentAssessment(object sender, GridViewUpdateEventArgs e)
        {
            string strStudentAssessmentID = gvStudentAssessment.DataKeys[e.RowIndex].Value.ToString();
            GridViewRow row = gvStudentAssessment.Rows[e.RowIndex];
            string strPassStatus="DETAINED";
            int intMarksObtained        = Convert.ToInt32(((TextBox)row.Cells[2].Controls[0]).Text);
            int intTotalMarks           = Convert.ToInt32(lblTotalMarks.Text);
            int intPassingMarks         = Convert.ToInt32(lblPassingMarks.Text);
            int intMarksPercentage      = 100*intMarksObtained/intTotalMarks;
            if(intMarksObtained >= intPassingMarks)
            {
                strPassStatus = "PASS";
            }
            string strComments  = ((TextBox)row.Cells[5].Controls[0]).Text;
            SqlCommand ObjCmd   = new SqlCommand("spUpdateStudentAssessments", BD.ConStr);
            ObjCmd.CommandType  = CommandType.StoredProcedure;
            ObjCmd.Parameters.AddWithValue("@StudentAssessmentID", strStudentAssessmentID);
            ObjCmd.Parameters.AddWithValue("@MarksObtained", intMarksObtained);
            ObjCmd.Parameters.AddWithValue("@MarksPercentage", intMarksPercentage);
            ObjCmd.Parameters.AddWithValue("@PassStatus", strPassStatus);
            ObjCmd.Parameters.AddWithValue("@Comments", strComments);

            BD.UpdateParameters(ObjCmd);
            gvStudentAssessment.EditIndex = -1;

            string strQuery = string.Format("SELECT * FROM EduSphere.StudentAssessments a JOIN EduSphere.Members s ON a.MemberID=s.MemberID WHERE AssessmentID={0}", Convert.ToInt32(lblAssessmentID.Text));
            BD.DataBindToGridView(gvStudentAssessment, strQuery, "NA");

        }

        //
        //Student Attendance
        //
        //Button Command clicks-gvAttendanceSheet=>Display Attendace Sheet
        protected void gvAttendanceSheets_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string strCmd               = e.CommandName.ToString();
            int intAttendanceSheetID    = Convert.ToInt32(e.CommandArgument.ToString());
            lblAttendanceSheetID.Text   = intAttendanceSheetID.ToString();
            if (strCmd == "ViewAttendanceSheet")
            { 
                BD.DataBindToGridView(gvStudentAttendance, string.Format("SELECT * FROM EduSphere.StudentAttendance a JOIN EduSphere.Members s ON a.StudentID=s.MemberID WHERE AttendanceSheetID={0}", intAttendanceSheetID), "NA");
            }
        }
        //Button Command clicks-gvStudentAttendance --Update P or A
        protected void gvStudentAttendance_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int intAttendaceStatus   = Convert.ToInt32(e.CommandName.ToString());
            string strStudentSwipID     = e.CommandArgument.ToString();
            SqlCommand CmdObj               = new SqlCommand("spUpdateStudentAttendance", BD.ConStr);
            CmdObj.CommandType              = CommandType.StoredProcedure;
            CmdObj.Parameters.AddWithValue("@StudentSwipeID", strStudentSwipID);
            CmdObj.Parameters.AddWithValue("@AttendanceStatus", intAttendaceStatus);
            BD.UpdateParameters(CmdObj);
            BD.DataBindToGridView(gvStudentAttendance, string.Format("SELECT * FROM EduSphere.StudentAttendance a JOIN EduSphere.Members s ON a.StudentID=s.MemberID WHERE AttendanceSheetID={0}", Convert.ToInt32(lblAttendanceSheetID.Text)), "NA");
        }

        //Upload new file to ~/Doc folder
        protected void UploadFile(object sender, EventArgs e)
        {
            if (flUpload.HasFile)//Check to ensure a file is selected
            {
                txtBoxArtifactName.Text = flUpload.FileName;
                //Create a path to save the file
                string filename = Path.Combine(HttpContext.Current.Server.MapPath("~/Artifacts/Docs"), flUpload.FileName);
                //Display File path in text box for record insertion
                txtBoxArtifactPath.Text = string.Format("/Artifacts/Docs/" + flUpload.FileName);
                //Save the file to our local path
                flUpload.SaveAs(filename);
            }
        }

        //Save file to BlobStorage on Azure
        protected async void UploadToBlobStorage(object sender, EventArgs e)
        {
            string path = "";      
            if (flUpload.HasFile)//Check to ensure a file is selected
            {
                txtBoxArtifactName.Text = flUpload.FileName;
                //Create a path to save the file
                string filename = Path.Combine(HttpContext.Current.Server.MapPath("~/Artifacts/Docs"), flUpload.FileName);
                //BlobStorage BS = new BlobStorage();
                //Display File path in text box for record insertion
                //txtBoxArtifactPath.Text = string.Format("~/Artifacts/Docs/" + flUpload.FileName);
                Stream content          =   System.IO.File.OpenRead(filename);
                
                path = await BS.SaveLearnArt(flUpload.FileName, content);
                txtBoxArtifactPath.Text = path;
                
                //Save the file to our local path
                //flUpload.SaveAs(filename);
            }
            //return $"{path}";

        }

        //Inserts a new course for selected ProgramID
        protected void AddCourse(object sender, EventArgs e)
        {
            string strProgramID = ddlProgramAddCourse.SelectedValue.ToString();
            int intProgramID    = Convert.ToInt32(strProgramID);
            SqlCommand ObjCmd   = new SqlCommand("spAddCourse", BD.ConStr);
            ObjCmd.CommandType  = CommandType.StoredProcedure;

            ObjCmd.Parameters.AddWithValue("@CourseTitle", txtBoxCourseTitle.Text);
            ObjCmd.Parameters.AddWithValue("@Credits", Convert.ToInt32(txtBoxCredits.Text));
            ObjCmd.Parameters.AddWithValue("@ProgramID", intProgramID);
            ObjCmd.Parameters.AddWithValue("@LectureHours", Convert.ToInt32(txtBoxLectureHours.Text));
            ObjCmd.Parameters.AddWithValue("@TPDHours", Convert.ToInt32(txtBoxPractcalHours.Text));
            BD.UpdateParameters(ObjCmd);
            txtBoxCourseTitle.Text      = "";
            txtBoxCredits.Text          = "";
            txtBoxLectureHours.Text     = "";
            txtBoxPractcalHours.Text    = "";
        }

        //Inserts a new course for selected ProgramID
        protected void CreateNewBatch(object sender, EventArgs e)
        {
            //string strProgramID = ddlProgramsFilter.SelectedValue.ToString();
            //int intProgramID = Convert.ToInt32(strProgramID);
            SqlCommand ObjCmd = new SqlCommand("spAddBatch", BD.ConStr);
            ObjCmd.CommandType = CommandType.StoredProcedure;

            ObjCmd.Parameters.AddWithValue("@BatchCode", txtBoxBatchCode.Text);
            ObjCmd.Parameters.AddWithValue("@ProgramID", Convert.ToInt32(ddlProgramID.SelectedValue.ToString()));
            ObjCmd.Parameters.AddWithValue("@StartDate", DateTime.Parse(txtBoxBatchStartDate.Text));
            ObjCmd.Parameters.AddWithValue("@EndDate", DateTime.Parse(txtBoxBatchEndDate.Text));
           
            BD.UpdateParameters(ObjCmd);
            txtBoxBatchCode.Text = "";
            
        }

        //Inserts a new assessment for selected CourseID and BatchID
        protected void CreateNewAssessment(object sender, EventArgs e)
        {
            SqlCommand ObjCmd = new SqlCommand("spCreateAssessment", BD.ConStr);
            ObjCmd.CommandType = CommandType.StoredProcedure;

            ObjCmd.Parameters.AddWithValue("@CourseID", Convert.ToInt32(ddlAssessmentCourse.SelectedValue.ToString()));
            ObjCmd.Parameters.AddWithValue("@BatchID", Convert.ToInt32(ddlAssessmentBatch.SelectedValue.ToString()));
            ObjCmd.Parameters.AddWithValue("@AssessmentCode", txtBoxAssessmentCode.Text);
            ObjCmd.Parameters.AddWithValue("@AssessmentTitle", txtBoxAssessmentTitle.Text);
            ObjCmd.Parameters.AddWithValue("@AssessmentDescription", txtBoxAssessmentDescription.Text);
            ObjCmd.Parameters.AddWithValue("@AssessmentDate", DateTime.Parse(txtBoxAssessmentDate.Text));
            ObjCmd.Parameters.AddWithValue("@AssessmentDuration", txtBoxAssessmentDuration.Text);
            ObjCmd.Parameters.AddWithValue("@TotalMarks", txtBoxTotalMarks.Text);
            ObjCmd.Parameters.AddWithValue("@PassingMarks", txtBoxPassingMarks.Text);
            BD.UpdateParameters(ObjCmd);
            txtBoxAssessmentCode.Text           = "";
            txtBoxAssessmentTitle.Text          = "";
            txtBoxAssessmentDescription.Text    = "";
            txtBoxAssessmentDuration.Text       = "";
        }

        //Inserts a new Attendance sheet for selected CourseID and BatchID
        protected void CreateNewAttendanceSheet(object sender, EventArgs e)
        {
            SqlCommand ObjCmd = new SqlCommand("spCreateAttendanceSheet", BD.ConStr);
            ObjCmd.CommandType = CommandType.StoredProcedure;
            ObjCmd.Parameters.AddWithValue("@CourseID", Convert.ToInt32(ddlAttendanceSheetCourse.SelectedValue.ToString()));
            ObjCmd.Parameters.AddWithValue("@BatchID", Convert.ToInt32(ddlAttendanceSheetBatch.SelectedValue.ToString()));
            ObjCmd.Parameters.AddWithValue("@Topic", txtBoxTopic.Text);
            ObjCmd.Parameters.AddWithValue("@ClassLocation", txtBoxClassLocation.Text);
            ObjCmd.Parameters.AddWithValue("@AttendanceDate", DateTime.Parse(txtBoxAttendanceDate.Text));
            ObjCmd.Parameters.AddWithValue("@AttendanceTakenByID", User.Identity.Name.ToString());
            BD.UpdateParameters(ObjCmd);
            txtBoxTopic.Text = "";
            txtBoxClassLocation.Text = "";
        }

        //Inserts new record in Course Table
        protected void InsertRecord(object sender, EventArgs e)
        {
            int intProgramID = 90;
            string strCourseID = ddlArtifactCourse.SelectedValue.ToString();
            if(strCourseID!="Select")
            {
                intProgramID = Convert.ToInt32(strCourseID);
            }
            string strArtifactType = ddlArtifactType.Text;
            string strArtifactPath = txtBoxArtifactPath.Text;
            string strArtifactName = txtBoxArtifactName.Text;
            if (strArtifactType != "VideoLecture")
            {
                SqlCommand ObjCmd = new SqlCommand("spInsertNewDocument", BD.ConStr);
                ObjCmd.CommandType = CommandType.StoredProcedure;

                ObjCmd.Parameters.AddWithValue("@CourseID", strCourseID);
                ObjCmd.Parameters.AddWithValue("@ProgramID", intProgramID);
                ObjCmd.Parameters.AddWithValue("@ArtifactType", strArtifactType);
                ObjCmd.Parameters.AddWithValue("@ArtifactPath", strArtifactPath);
                ObjCmd.Parameters.AddWithValue("@ArtifactName", strArtifactName);
                BD.UpdateParameters(ObjCmd);

            }
            if(strArtifactType == "VideoLecture")
            {
                SqlCommand ObjCmd = new SqlCommand("spAddCourseVideo", BD.ConStr);
                ObjCmd.CommandType = CommandType.StoredProcedure;

                ObjCmd.Parameters.AddWithValue("@CourseID", strCourseID);
                ObjCmd.Parameters.AddWithValue("@ProgramID", intProgramID);
                ObjCmd.Parameters.AddWithValue("@VideoTitle", txtBoxArtifactTitle.Text);
                ObjCmd.Parameters.AddWithValue("@VideoDescription", txtBoxDescription.Text);
                //ObjCmd.Parameters.AddWithValue("@VideoPath", "/Artifacts/Docs/"+strArtifactName);
                ObjCmd.Parameters.AddWithValue("@VideoPath", strArtifactPath);
                BD.UpdateParameters(ObjCmd);
            }
            pnlAddDoc.Visible = false;
        }//End function

        protected void gvCourseVideos_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int intKey                  = Convert.ToInt32(gvCourseVideos.DataKeys[e.RowIndex].Values[0].ToString());
            string intVideoID           =   gvCourseVideos.Rows[e.RowIndex].Cells[1].Text;
            string strVideoPath         =   gvCourseVideos.Rows[e.RowIndex].Cells[2].Text;
            SqlCommand delCmd           = new SqlCommand("spDeleteVideo", BD.ConStr);
            delCmd.CommandType          = CommandType.StoredProcedure;
            delCmd.Parameters.AddWithValue("@VideoID", intVideoID);
            BD.UpdateParameters(delCmd);
            //Delete Actual VideoFile from ~/Artifacts/Docs folder
            string FileToDelete = Server.MapPath(strVideoPath);
            File.Delete(FileToDelete);
            //Refresh Screen
            string strCourseVideos = string.Format(@"SELECT * FROM EduSphere.CourseVideos v
                                                              JOIN EduSphere.Courses c ON v.CourseID=c.CourseID
                                                              WHERE c.CourseID='{0}'", lblSelectedCourseID.Text);
            BD.DataBindToGridView(gvCourseVideos, strCourseVideos, "NA");
            

        }

        protected void gvCourseDocs_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int intKey              = Convert.ToInt32(gvCourseDocs.DataKeys[e.RowIndex].Values[0].ToString());//key not used
            string intDocID         = gvCourseDocs.Rows[e.RowIndex].Cells[1].Text;
            string strArtifactPath  = gvCourseDocs.Rows[e.RowIndex].Cells[2].Text;
            SqlCommand delCmd       = new SqlCommand("spDeleteDoc", BD.ConStr);
            delCmd.CommandType      = CommandType.StoredProcedure;
            delCmd.Parameters.AddWithValue("@DocID", intDocID);
            //Delete DB Reference
            BD.UpdateParameters(delCmd);
            //Delete Actual Doc File from ~/Artifacts/Docs folder
            string FileToDelete     = Server.MapPath(strArtifactPath);
            File.Delete(FileToDelete);
            //Refresh Screen
            //List of Documents for Chosen Program
            string strCourseDocs = string.Format(@"SELECT * FROM EduSphere.CourseDocs d
                                                              JOIN EduSphere.Courses c ON d.CourseID=c.CourseID
                                                              WHERE c.CourseID='{0}'", lblSelectedCourseID.Text);
            BD.DataBindToGridView(gvCourseDocs, strCourseDocs, "NA");


        }
    }
}