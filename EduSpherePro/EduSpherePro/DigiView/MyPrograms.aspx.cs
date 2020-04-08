using EduSpherePro.CoreServices;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EduSpherePro.DigiView
{
    public partial class MyPrograms : System.Web.UI.Page
    {
        BindData BD = new BindData();
        int startid = 1;//Here specify your starting id of Questions table. So that it will display questions from id starting from this value
        int endid = 10;//Here specify your ending id of Questions table. So that it will display questions which has id below this value
        int totalnoofquestions = 25;//Here change the number of questions you want to display.
        protected string PostBackStr;

        protected void Page_Load(object sender, EventArgs e)
        {
            //do not call this if its PostBack due to SelectedIndexChanged
            if (!IsPostBack)
            {
                pnlLearningContent.Visible = true;
                pnlTakeQuiz.Visible = false;

                string strEnrolledProgram = string.Format(@"SELECT p.ProgramID,p.ProgramTitle FROM EduSphere.Programs p 
                                                                                       JOIN EduSphere.ProgramBatch b ON p.ProgramID=b.ProgramID
                                                                                       JOIN EduSphere.Members s ON s.BatchID=b.BatchID
                                                                                       WHERE Email='{0}'", User.Identity.Name.ToString());
                BD.DataBindToDropDownList(ddlMyPrograms, strEnrolledProgram);

                PostBackStr = Page.ClientScript.GetPostBackEventReference(this, "time");
                lblTestStartTime.Text = DateTime.Now.ToLongTimeString();
                string eventArg = Request["__EVENTARGUMENT"];
                if (eventArg == "time")
                {
                    getNextQuestion();
                }

                //Test code for timer
                if (!SM1.IsInAsyncPostBack)
                    Session["timeout"] = DateTime.Now.AddMinutes(30).ToString();
                //End Test code for timer
            }

        }

        protected void ddlMyPrograms_SelectedIndexChanged(object sender, EventArgs e)
        {
            int intProgramID = -99;
            if (ddlMyPrograms.SelectedValue.ToString() != "Select")
            {
                intProgramID = Convert.ToInt32(ddlMyPrograms.SelectedValue.ToString());
            }
            //List of Videos for Chosen Program
            //string strCourseVideos = string.Format(@"SELECT * FROM EduSphere.CourseVideos WHERE ProgramID={0}", intProgramID);
            string strCourseVideos = string.Format(@"SELECT * FROM EduSphere.CourseVideos v
                                                              JOIN EduSphere.Courses c ON v.CourseID=c.CourseID
                                                              JOIN EduSphere.LearningTokens t ON v.CourseID=t.CourseID 
                                                              WHERE t.TokenStatus='YES' AND t.MemberID=(SELECT MemberID FROM EduSphere.Members WHERE Email='{0}')", User.Identity.Name.ToString());
            BD.DataBindToGridView(gvCourseVideos, strCourseVideos, "NA");
            //List of Documents for Chosen Program
            string strCourseDocs = string.Format(@"SELECT * FROM EduSphere.CourseDocs v
                                                              JOIN EduSphere.Courses c ON v.CourseID=c.CourseID
                                                              JOIN EduSphere.LearningTokens t ON v.CourseID=t.CourseID 
                                                              WHERE t.TokenStatus='YES' AND t.MemberID=(SELECT MemberID FROM EduSphere.Members WHERE Email='{0}')", User.Identity.Name.ToString());
            BD.DataBindToGridView(gvCourseDocs, strCourseDocs, "NA");
        }

        //ManagePanelVisibility
        public void ManageVisibility(object sender, CommandEventArgs e)
        {
            string cmdName = e.CommandName.ToString();
            switch (cmdName)
            {
                case "ViewContents":
                    pnlLearningContent.Visible = true;
                    pnlTakeQuiz.Visible = false;
                    pnlCandidate.Visible = false;
                    break;
                case "TakeQuiz":
                    pnlLearningContent.Visible = false;
                    pnlTakeQuiz.Visible = true;
                    pnlCandidate.Visible = true;
                    string query = string.Format("select qp.CourseID,CourseTitle FROM Evaluations.ObjTestPaper qp JOIN EduSphere.Courses cs ON qp.CourseID=cs.CourseID ");
                    SqlDataAdapter da = new SqlDataAdapter(query, BD.ObjCn);
                    DataSet ds = new DataSet();
                    da.Fill(ds, "Question");

                    //Display course ID
                    DataRow dr = ds.Tables[0].Rows[0];
                    lblCourseName.Text = dr["CourseID"].ToString();
                    lblCourseTitle.Text = dr["CourseTitle"].ToString();
                    txtName.Text = User.Identity.Name;
                    //txtName.Text            = dr["FullName"].ToString();
                    break;
                default:
                    break;

            }
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
                Response.Redirect("MyPrograms.aspx");
            }
        }
        //End test code for timer

        //Start the test
        protected void StartTest(object sender, EventArgs e)
        {
            txtName.Visible = false;
            btnStartExam.Visible = false;
            pnlTakeQuiz.Visible = true;
            //pnlCreateTest.Visible = false;
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
            Session["counter"] = "0";
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
            pnlTakeQuiz.FindControl("pnlTimer").Visible = false;
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