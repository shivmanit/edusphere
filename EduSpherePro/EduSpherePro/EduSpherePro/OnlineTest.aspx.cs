
using EduSpherePro.CoreServices;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EduSpherePro.EduSpherePro
{
    public partial class OnlineTest : System.Web.UI.Page
    {
        BindData BD = new BindData();
        FileService FS = new FileService();//for exporting to excel, uploading, downloading files
        //For getting role
      

        int startid = 1;//Here specify your starting id of Questions table. So that it will display questions from id starting from this value
        int endid = 50;//Here specify your ending id of Questions table. So that it will display questions which has id below this value
        
        //Test Parameters
        int testDuration            = 90;//minutes
        int totalnoofquestions      = 25;//Here change the number of questions you want to display.

        protected string PostBackStr;

        protected void Page_Load(object sender, EventArgs e)
        {
            //Get the Test start time only first time. 
            if (!this.IsPostBack)
            {
                pnlCreateTest.Visible           = false;
                pnlAssignCandidates.Visible     = false;
                pnlCandidate.Visible            = false;
                pnlViewTestResults.Visible       = false;
                //Get user role
                if (User.Identity.IsAuthenticated)
                {
                    string strID = User.Identity.Name;
                    if (User.IsInRole("Admin"))
                        lblRole.Text = "Admin";
                    if (User.IsInRole("Manager"))
                        lblRole.Text = "Manager";
                }
                //Allow only manager to create test
                if (lblRole.Text == "Manager")
                    lnkBtnCreateTest.Visible = true;

                //Bind the ddlTestSubject to list the subject
                int intProgramID        = 100;
                //string strQuery           = string.Format("SELECT CourseID,CourseTitle from EduSphere.Courses where ProgramID='{0}'", intProgramID);
                string strQuery             = string.Format("SELECT CourseID,CourseTitle from EduSphere.Courses");
                BD.DataBindToDropDownList(ddlTestSubjectOne, strQuery);
                BD.DataBindToDropDownList(ddlTestSubjectTwo, strQuery);
                BD.DataBindToDropDownList(ddlTestSubjectThree, strQuery);
                BD.DataBindToDropDownList(ddlTestSubjectFour, strQuery);
                //SqlCommand ObjCmdProg       = new SqlCommand(strQuery, BD.ObjCn);
                //DataSet ObjDS               = BD.GetDataSet(ObjCmdProg);
                //ddlTestSubjectOne.DataSource   = ObjDS;
                //ddlTestSubjectOne.DataBind();

                PostBackStr = Page.ClientScript.GetPostBackEventReference(this, "time");
                lblTestStartTime.Text = DateTime.Now.ToLongTimeString();
                string eventArg = Request["__EVENTARGUMENT"];
                if (eventArg == "time")
                {
                    getNextQuestion();
                }

                //Test code for timer
                if (!SM1.IsInAsyncPostBack)
                    Session["timeout"] = DateTime.Now.AddMinutes(testDuration).ToString();
                //End Test code for timer
            }
        }

        //Display panel to choose subject and call function to create test paper
        protected void ManageTestPanelVisibility(object sender, CommandEventArgs e)
        {
            string cmdName = e.CommandName.ToString();
            pnlCreateTest.Visible = false;
            pnlTest.Visible = false;
            pnlCandidate.Visible = false;
            switch (cmdName)
            {
                case "pnlCreateTest":
                    pnlCreateTest.Visible       = true;
                    pnlAssignCandidates.Visible = false;
                    pnlCandidate.Visible        = false;
                    pnlViewTestResults.Visible = false;
                    break;
                case "pnlAssignCandidates":
                    pnlCreateTest.Visible       = false;
                    pnlAssignCandidates.Visible = true;
                    pnlCandidate.Visible        = false;
                    pnlViewTestResults.Visible = false;
                    //Test Details
                    string qTest = string.Format(@"SELECT TOP 1 * FROM Evaluations.TestConfigParameters c 
                                                                    JOIN Evaluations.ObjTestPaper p ON c.TestID=p.TestID  ORDER BY c.TestID DESC");
                    DataTable dtTest    =   new DataTable();
                    SqlCommand cmd      = new SqlCommand(qTest, BD.ObjCn);
                    dtTest              =   BD.GetDataTable(cmd);
                    lblTestTitle.Text   =   dtTest.Rows[0]["TestTitle"].ToString();
                    lblTestID.Text      =   dtTest.Rows[0]["TestID"].ToString();
                    //Candidates
                    string q = "";
                    if(e.CommandArgument.ToString()=="SearchCandidate")
                    {
                        q = string.Format(@"SELECT * FROM Evaluations.CandidateTestAttendance a
                                                        JOIN EduSphere.Members n ON a.CandidateID=n.MemberID
                                                        WHERE a.TestID={0} AND n.FullName LIKE '%{1}%'", Convert.ToInt32(lblTestID.Text), txtBoxSearch.Text);

                    }
                    else
                    {
                       q = string.Format(@"SELECT * FROM Evaluations.CandidateTestAttendance a
                                                        JOIN EduSphere.Members n ON a.CandidateID=n.MemberID
                                                        WHERE a.TestID={0}", Convert.ToInt32(lblTestID.Text));

                    }
                    
                    BD.DataBindToGridView(gvAssignCandidates,q, "NA");
                    break;
                case "pnlTest":
                    pnlCreateTest.Visible       = false;
                    pnlCandidate.Visible        = true;
                    pnlAssignCandidates.Visible = false;
                    pnlViewTestResults.Visible       = false;
                    string query = string.Format(@"select * from Evaluations.ObjTestPaper qp JOIN EduSphere.Courses cs ON qp.CourseID=cs.CourseID");
                    SqlDataAdapter da = new SqlDataAdapter(query, BD.ObjCn);
                    DataSet ds = new DataSet();
                    da.Fill(ds, "Question");

                    //Display course ID
                    DataRow dr = ds.Tables[0].Rows[0];
                    lblCourseName.Text = dr["CourseID"].ToString();
                    lblCourseTitle.Text = dr["CourseTitle"].ToString();
                    txtName.Text = User.Identity.Name;
                    break;
                case "pnlViewTestResults":
                    pnlCreateTest.Visible               = false;
                    pnlCandidate.Visible                = false;
                    pnlAssignCandidates.Visible         = false;
                    pnlViewTestResults.Visible          = true;
                    //Filter option for selecting TestID
                    BD.DataBindToDropDownList(ddlTestList,string.Format(@"SELECT r.TestID, TestTitle FROM Evaluations.OnlineTestResults r
                                                                          JOIN Evaluations.TestConfigParameters c ON r.TestID=c.TestID GROUP BY r.TestID,TestTitle"));
                    //Display Results--Do not display by default. Deisplay after the test iD is selected
                    //string qresults = string.Format(@"SELECT * FROM Evaluations.OnlineTestResults r JOIN EduSphere.Members n ON r.CandidateID=n.MemberID");
                    //BD.DataBindToGridView(gvTestResults, qresults, "NA");
                    break;

                default:
                    break;
            }

        }

        //
        protected void ddlTestList_SelectedIndexChanged(object sender, EventArgs e)
        {
            string qresults = string.Format(@"SELECT * FROM Evaluations.OnlineTestResults r JOIN EduSphere.Members n ON r.CandidateID=n.MemberID WHERE TestID={0}",Convert.ToUInt32(ddlTestList.SelectedValue.ToString()));
            BD.DataBindToGridView(gvTestResults, qresults, "NA");

        }
        //Fill the table with Questions of selected course
        protected void CreateTestPaper(object sender, CommandEventArgs e)
        {
            string strTestType = e.CommandArgument.ToString();
            string strCourseID1="90", strCourseID2="90", strCourseID3="90", strCourseID4="90";
            if(ddlTestSubjectOne.SelectedValue.ToString()!="Select")
                strCourseID1 = ddlTestSubjectOne.SelectedValue.ToString();
            if (ddlTestSubjectTwo.SelectedValue.ToString() != "Select")
                strCourseID2 = ddlTestSubjectTwo.SelectedValue.ToString();
            if (ddlTestSubjectThree.SelectedValue.ToString() != "Select")
                strCourseID3 = ddlTestSubjectThree.SelectedValue.ToString();
            if (ddlTestSubjectFour.SelectedValue.ToString() != "Select")
                strCourseID4 = ddlTestSubjectFour.SelectedValue.ToString();

            lblCourseName.Text = strCourseID1+"+"+ strCourseID2+"+"+strCourseID3+"+"+strCourseID4;

            switch (strTestType)
            {
                case "ObjTest":
                    DateTime ExamDateTime           = DateTime.Parse(txtBoxExamDateTime.Text.ToString());
                    DateTime ExamClosureDateTime    = DateTime.Parse(txtBoxExamClosureDateTime.Text.ToString());
                    if(ExamDateTime >= ExamClosureDateTime)
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Closure DateTime Must be Later to Start DateTime')", true);
                        return;
                    }
                    //Create Question Paper for selecte Course
                    SqlCommand ObjCmd       = new SqlCommand("spCreateTest", BD.ObjCn);
                    ObjCmd.CommandType      = CommandType.StoredProcedure;
                    ObjCmd.Parameters.AddWithValue("@CourseID1", Convert.ToInt32(strCourseID1));
                    ObjCmd.Parameters.AddWithValue("@CourseID2", Convert.ToInt32(strCourseID2));
                    ObjCmd.Parameters.AddWithValue("@CourseID3", Convert.ToInt32(strCourseID3));
                    ObjCmd.Parameters.AddWithValue("@CourseID4", Convert.ToInt32(strCourseID4));
                    ObjCmd.Parameters.AddWithValue("@TestTitle", txtBoxTestTitle.Text);
                    ObjCmd.Parameters.AddWithValue("@TestDate", ExamDateTime);
                    ObjCmd.Parameters.AddWithValue("@TestClosureDate", ExamClosureDateTime);
                    ObjCmd.Parameters.AddWithValue("@TestDuration", Convert.ToInt32(txtBoxDuration.Text.ToString()));
                    ObjCmd.Parameters.AddWithValue("@QCount", Convert.ToInt32(txtBoxNumberOfQuestions.Text.ToString()));
                    BD.UpdateParameters(ObjCmd);
                    //SqlDataAdapter da = new SqlDataAdapter(ObjCmd);
                    //DataSet ds = new DataSet();
                    //da.Fill(ds);
                    //DataSet StudentDS = BD.GetDataSet(ObjCmd);
                    //dlObjTestPaper.DataSource = ds;
                    //dlObjTestPaper.DataBind();
                    break;

                default:
                    break;

            }

        }

        //Assign Candidates to Test
        //Higlight 
        protected void gvAssignCandidates_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                TableCell cell = e.Row.Cells[7];
                //int quantity = int.Parse(cell.Text);
                string AttendanceStatus = cell.Text;
                
                if (AttendanceStatus == "SUBSCRIBED")
                {
                    cell.BackColor = Color.LightGreen;
                    e.Row.BackColor= Color.LightGreen;
                }
                
            }


        }
        //Buttone Clicks on list of leads ViewDetails,Edit,ViewEditHistory
        protected void gvAssignCandidates_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string cmdName = e.CommandName.ToString();
            string updateCmd="";
            int intRecordID =   Convert.ToInt32(e.CommandArgument.ToString());
            switch (cmdName)
            {
                case "SUBSCRIBE":                   

                    break;
                case "UNSUBSCRIBE":
                    
                    break;
                

                default:
                    break;

            }
            updateCmd = string.Format(@"UPDATE Evaluations.CandidateTestAttendance SET AttendanceStatus='{0}' WHERE RecordID={1}",cmdName,intRecordID );
            SqlCommand cmd = new SqlCommand(updateCmd, BD.ObjCn);
            BD.UpdateParameters(cmd);
            //Display Updated list
            string q = string.Format(@"SELECT * FROM Evaluations.CandidateTestAttendance a
                                                        JOIN EduSphere.Members n ON a.CandidateID=n.MemberID
                                                        WHERE a.TestID={0} ORDER BY AttendanceStatus", Convert.ToInt32(lblTestID.Text));
            BD.DataBindToGridView(gvAssignCandidates, q, "NA");
        }

        //Test Results
        //Higlight 
        protected void gvTestResults_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            //if (e.Row.RowType == DataControlRowType.DataRow)
            //{
            //    TableCell cell = e.Row.Cells[7];
            //    //int quantity = int.Parse(cell.Text);
            //    string AttendanceStatus = cell.Text;

            //    if (AttendanceStatus == "SUBSCRIBED")
            //    {
            //        cell.BackColor = Color.LightGreen;
            //        e.Row.BackColor = Color.LightGreen;
            //    }

            //}


        }
        
        //Button Clicks on list of Test Results
        protected void gvTestResults_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            //string cmdName = e.CommandName.ToString();
            //string updateCmd = "";
            //int intRecordID = Convert.ToInt32(e.CommandArgument.ToString());
            //switch (cmdName)
            //{
            //    case "SUBSCRIBE":

            //        break;
            //    case "UNSUBSCRIBE":

            //        break;


            //    default:
            //        break;

            //}
            //updateCmd = string.Format(@"UPDATE Evaluations.CandidateTestAttendance SET AttendanceStatus='{0}' WHERE RecordID={1}", cmdName, intRecordID);
            //SqlCommand cmd = new SqlCommand(updateCmd, BD.ObjCn);
            //BD.UpdateParameters(cmd);
        }


        //Download Test Results
        protected void DownloadTestResults(object sender, CommandEventArgs e)
        {
            FS.ExportToExcel(gvTestResults);
        }
        //a must for above code
        public override void VerifyRenderingInServerForm(Control control)
        {
            /* Verifies that the control is rendered */
        }
        //Test code for timer
        protected void timer1_tick(object sender, EventArgs e)
        {
            if (0 > DateTime.Compare(DateTime.Now, DateTime.Parse(Session["timeout"].ToString())))
            {
                lblTimer.Text = string.Format("Time Left: 00:{0}:{1}", ((Int32)DateTime.Parse(Session["timeout"].ToString()).Subtract(DateTime.Now).TotalMinutes).ToString(), ((Int32)DateTime.Parse(Session["timeout"].ToString()).Subtract(DateTime.Now).Seconds).ToString());
            }
            else
            {
                timer1.Enabled = true;
                Response.Redirect("~/Default.aspx");
            }
        }
        //End test code for timer

        //Start the test
        protected void StartTest(object sender, EventArgs e)
        {
            txtName.Visible = false;
            btnStartExam.Visible = false;
            pnlTest.Visible = true;
            pnlCreateTest.Visible = false;
            //Check morning, afternoon, evening
            int Hr = Convert.ToInt32(DateTime.Now.Hour.ToString());
            if (Hr < 12)
                lblName.Text = "Good Morning !   " + txtName.Text;
            //if Afternoon
            else
            {
                //
                Hr -= 12;
                if (Hr < 6)
                    lblName.Text = "Good Afternoon !     " + txtName.Text;
                else
                    lblName.Text = "Good Evening !     " + txtName.Text;
            }
            //
            int score = Convert.ToInt32(txtScore.Text);
            lblScore.Text = "Score : " + Convert.ToString(score);

            //Counter to count the number of question
            Session["counter"] = "1";
            Random rnd = new Random();
            int i = rnd.Next(startid, endid + 1);
            getQuestion(i);
            ArrayList al = new ArrayList();
            al.Add(i.ToString());
            Session["ids"] = al;
        }

        //Display question
        public void getQuestion(int no)
        {
            string strCmdQ = "select * from Evaluations.ObjTestPaper where QuestionID=" + no + "";
            //string strCmdQ = string.Format("select * from Evaluations.ObjQuestions where QuestionID={0}   OR CourseID='{1}'", no, strCourseID) ;
            SqlDataAdapter ObjDAq = new SqlDataAdapter(strCmdQ, BD.ObjCn);
            DataSet ObjDS = new DataSet();
            ObjDAq.Fill(ObjDS, "Question");

            //Display course ID
            DataRow dr = ObjDS.Tables[0].Rows[0];
            lblCourseName.Text = dr["CourseID"].ToString();
            //lblCourseTitle.Text = dr["CourseTitle"].ToString();

            if (ObjDS.Tables[0].Rows.Count > 0)
            {
                DataRow dtrQ;
                int i = 0;
                while (i < ObjDS.Tables[0].Rows.Count)
                {
                    dtrQ = ObjDS.Tables[0].Rows[i];
                    Session["Answer"] = dtrQ["CorrectAnswer"].ToString();
                    lblQuestion.Text = "Q." + Session["counter"].ToString() + "  " + dtrQ["Question"].ToString();
                    i++;
                }
            }
            DisplayOptions(no);
        }

        //Display Options
        public void DisplayOptions(int no)
        {
            string strCmdA = "select * from Evaluations.ObjTestPaper where QuestionID=" + no + "";
            SqlDataAdapter ObjDAa = new SqlDataAdapter(strCmdA, BD.ObjCn);
            DataSet ObjDS = new DataSet();
            ObjDAa.Fill(ObjDS, "Answers");
            if (ObjDS.Tables[0].Rows.Count > 0)
            {
                DataRow dtrA;
                int i = 0;
                while (i < ObjDS.Tables[0].Rows.Count)
                {
                    dtrA = ObjDS.Tables[0].Rows[i];
                    RblOption.ClearSelection();
                    RblOption.Items.Clear();
                    RblOption.Items.Add(dtrA["OptionA"].ToString());
                    RblOption.Items.Add(dtrA["OptionB"].ToString());
                    RblOption.Items.Add(dtrA["OptionC"].ToString());
                    RblOption.Items.Add(dtrA["OptionD"].ToString());
                    i++;
                }
            }
        }//End Function getOptions()


        //Increment the score based on previous answer.  
        public void getNextQuestion()
        {
            //Get questions till the planned total number of questions are displayed
            if (Convert.ToInt32(Session["counter"].ToString()) <= totalnoofquestions)
            {
                if (RblOption.SelectedIndex >= 0)
                {

                    //if (Session["Answer"].ToString() == RblOption.SelectedIndex.ToString())
                    if (Session["Answer"].ToString() == RblOption.SelectedItem.Value.ToString())
                    {
                        int score = Convert.ToInt32(txtScore.Text) + 1;// 1 for mark for each question
                        //int score       = 5;
                        txtScore.Text = score.ToString();
                        lblScore.Text = "Score : " + Convert.ToString(score);
                    }

                }
                Random rnd = new Random();
                int i = rnd.Next(startid, endid);
                ArrayList al = (ArrayList)Session["ids"];
                if (!al.Contains(i.ToString()))
                {
                    al.Add(i.ToString());
                }
                else
                {
                    while (al.Contains(i.ToString()))
                    {
                        i = rnd.Next(startid, endid + 1);

                        if (al.Count == totalnoofquestions - 1 && !al.Contains(i.ToString()))
                        {
                            btnNextQ.Visible = false;
                            Finish.Visible = true;
                            break;
                        }
                        else if (al.Count > endid + 1)
                        {
                            break;
                        }

                    }
                    if (!al.Contains(i.ToString()))
                    {
                        al.Add(i.ToString());
                    }
                }
                if (al.Count == totalnoofquestions)
                {
                    btnNextQ.Visible = false;
                    Finish.Visible = true;
                }
                Session["ids"] = al;
                Session["counter"] = Convert.ToString(Convert.ToInt32(Session["counter"].ToString()) + 1);
                getQuestion(i);
            }
            else
            {
                pnlQuestions.Visible = false;
                //code for displaying after completting the exam, if you want to show the result then you can code here.
            }

        }//End getNextQuestion()

        //Button Next is clicked
        public void DisplayNextQuestion(object sender, EventArgs e)
        {
            getNextQuestion();
        }

        //Finish Test
        protected void Finish_Click(object sender, EventArgs e)
        {
            if (Session["Answer"].ToString() == RblOption.SelectedIndex.ToString())
            {
                int score = Convert.ToInt32(txtScore.Text) + 1;// 1 for mark for each question
                txtScore.Text = score.ToString();
                lblScore.Text = "Score : " + Convert.ToString(score);
            }
            lblResult.Text = "Thank you for taking the Test. Your Score is : " + txtScore.Text;

            //Store the score in Evaluations.OnlineTestResults
            string strHallTicketNumber = txtName.Text;
            string strCourseID = lblCourseName.Text;
            int intScore = Convert.ToInt32(txtScore.Text);
            int intMaxmarks = totalnoofquestions;

            DateTime dtTestDate = DateTime.Now;
            StoreOnlineTestScore(strHallTicketNumber, intScore, intMaxmarks, strCourseID, dtTestDate);

            lblResult.Visible = true;
            pnlQuestions.Visible = false;
            pnlTest.FindControl("pnlTimer").Visible = false;
        }

        //Insert the score in Evaluations.OnlineTestResults
        protected void StoreOnlineTestScore(string strHallTicketNumber, int intScore, int intMaxMarks, string strCourseID, DateTime dtTestDate)
        {
            SqlCommand ObjCmd = new SqlCommand("spInsertOnlineTR", BD.ObjCn);
            ObjCmd.CommandType = CommandType.StoredProcedure;

            ObjCmd.Parameters.AddWithValue("@HallTicketNumber", strHallTicketNumber);
            ObjCmd.Parameters.AddWithValue("@Score", intScore);
            ObjCmd.Parameters.AddWithValue("@MaxMarks", intMaxMarks);
            ObjCmd.Parameters.AddWithValue("@PercentageMarks", 100 * intScore / intMaxMarks);
            ObjCmd.Parameters.AddWithValue("@CourseID", strCourseID);
            ObjCmd.Parameters.AddWithValue("@TestDate", dtTestDate);
            BD.UpdateParameters(ObjCmd);
        }

        
    }
}