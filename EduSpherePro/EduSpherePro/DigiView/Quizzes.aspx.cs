using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
//
using EduSpherePro.CoreServices;
using System.Data;
using System.Data.SqlClient;
using System.Collections;
using System.Drawing;
using System.Threading.Tasks;

namespace EduSpherePro.DigiView
{
    public partial class Quizzes : System.Web.UI.Page
    {
        BindData BD = new BindData();
        ITranslateText TT = new TranslateText();
        //For getting role
        //LoggedInUsers lnUser = new LoggedInUsers();

        int startid             = 1;//Here specify your starting id of Questions table. So that it will display questions from id starting from this value
        int endid               = 50;//Here specify your ending id of Questions table. So that it will display questions which has id below this value
        int maxqid              = 0; //Max Question ID in Question Paper
        //test configuration parameters
        int totalnoofquestions  = 25;//Here change the number of questions you want to display.
        int testDuration        = 90;
        int quizid              = 0;
        DateTime testDate,testClosureDate;
      
        protected string PostBackStr;
        DateTime start;
        public Quizzes()
        {
            if(!IsPostBack)
            {
                CheckTestConfigParameters();
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            //Get the Test start time only first time. 
            if (!this.IsPostBack)
            {
                //Get user role
                if (User.Identity.IsAuthenticated)
                {
                    string strID = User.Identity.Name;
                    if (User.IsInRole("Admin"))
                        lblRole.Text = "Admin";
                    if (User.IsInRole("Manager"))
                        lblRole.Text = "Manager";
                }


                PostBackStr = Page.ClientScript.GetPostBackEventReference(this, "time");
               
                lblTestStartTime.Text = DateTime.Now.ToString();
                start = Convert.ToDateTime(lblTestStartTime.Text.ToString());
                string eventArg = Request["__EVENTARGUMENT"];
                if (eventArg == "time")
                {
                    getNextQuestion();
                }

                //Test code for timer
                if (!SM1.IsInAsyncPostBack)
                    Session["timeout"] = DateTime.Now.AddMinutes(testDuration).ToString();
                //End Test code for timer
                
                pnlCandidate.Visible        = false;
                pnlTest.Visible             = false;                             
                pnlResult.Visible           = false;
              
            }
        }

        //Check Test Parameters
        void CheckTestConfigParameters()
        {
            DataTable dt        = new DataTable();
            SqlCommand ObjCmd   = new SqlCommand("SELECT TOP 1 * FROM Evaluations.TestConfigParameters ORDER BY TestID DESC ", BD.ConStr);
            dt                  = BD.GetDataTable(ObjCmd);
            quizid              = Convert.ToInt32(dt.Rows[0]["TestID"].ToString());
            testDuration        = Convert.ToInt32(dt.Rows[0]["TestDuration"].ToString());
            totalnoofquestions  = Convert.ToInt32(dt.Rows[0]["QCount"].ToString());
            endid               = Convert.ToInt32(dt.Rows[0]["QCount"].ToString());
            maxqid              = Convert.ToInt32(dt.Rows[0]["MaxQID"].ToString());

            testDate = Convert.ToDateTime(dt.Rows[0]["TestDate"].ToString());
            testClosureDate     = Convert.ToDateTime(dt.Rows[0]["TestClosureDate"].ToString());
        }
        //Display panel to choose subject and call function to create test paper
        protected void ManageTestPanelVisibility(object sender, CommandEventArgs e)
        {
            string cmdName          = e.CommandName.ToString();
            switch (cmdName)
            {
               
                case "pnlTest":
                    pnlCandidate.Visible    = true;
                    pnlTest.Visible         = false; //made visible to candidate SUBSCRIBED for test
                    pnlQuestions.Visible    = false;//is made visible after start click                                      
                    pnlResult.Visible       = false;
                    //Extract test ID
                    //int quizid = Convert.ToInt32(lblTestID.Text.ToString());
                    DataTable dtTestStatus              = new DataTable();
                    //select candidate details based on Email and latest TestID
                    string queryStatus                  = string.Format(@"SELECT FullName,MemberID,AttendanceStatus  FROM EduSphere.Members n
                                                                                                JOIN Evaluations.CandidateTestAttendance a ON n.MemberID=a.CandidateID
                                                                                                WHERE n.Email='{0}' AND a.TestID={1}", User.Identity.Name.ToString(),quizid);
                    SqlCommand cmd          = new SqlCommand(queryStatus, BD.ObjCn);
                    dtTestStatus = BD.GetDataTable(cmd);
                    if((dtTestStatus.Rows[0]["AttendanceStatus"].ToString()=="SUBSCRIBED") && testDate<=DateTime.Now && DateTime.Now <= testClosureDate)
                    {
                        pnlTest.Visible     = true;
                        lblCandidateID.Text = dtTestStatus.Rows[0]["MemberID"].ToString();
                        lblCandidateName.Text = dtTestStatus.Rows[0]["FullName"].ToString();
                        //BD.DataBindToTable(lblCandidateID, string.Format(@"SELECT MemberID FROM EduSphere.Members WHERE Email='{0}'", User.Identity.Name.ToString()));
                        //string query = string.Format("SELECT TOP * FROM Evaluations.ObjTestPaper qp JOIN EduSphere.Courses cs ON qp.CourseID=cs.CourseID");

                        string query = string.Format(@"SELECT TOP 1 * FROM Evaluations.ObjTestPaper p 
                                                        JOIN Evaluations.TestConfigParameters c ON p.TestID=c.TestID");
                        SqlDataAdapter da = new SqlDataAdapter(query, BD.ObjCn);
                        DataSet ds = new DataSet();
                        da.Fill(ds, "Question");

                        //Display Test ID
                        DataRow dr          = ds.Tables[0].Rows[0];
                        lblTestID.Text      = dr["TestID"].ToString();
                        lblTestTitle.Text   = dr["TestTitle"].ToString();
                        //CREATE Answer sheet for candidate
                        SqlCommand ObjCmd   = new SqlCommand("spOnlineTestTransaction",BD.ObjCn);
                        ObjCmd.CommandType  = CommandType.StoredProcedure;
                        ObjCmd.Parameters.AddWithValue("@CandidateID", Convert.ToInt32(lblCandidateID.Text));
                        ObjCmd.Parameters.AddWithValue("@TestID", Convert.ToInt32(lblTestID.Text));
                        BD.UpdateParameters(ObjCmd);

                        //Allow to start the test
                        btnStartExam.Visible = true;

                    }

                    else
                    {
                       
                        lblTestTitle.Text = "No Test Scheduled";
                        btnStartExam.Visible = false;
                        pnlTest.Visible = false;
                    }
                    
                    //lblCandidateName.Text        = User.Identity.Name;
                    break;
                case "pnlResult":
                    pnlCandidate.Visible    = false;
                    pnlTest.Visible         = false;
                    pnlQuestions.Visible    = false;
                    pnlResult.Visible       = true;

                    //Fetch details of candidate, exam
                    DataTable dtTestCandidate       = new DataTable();
                    string queryCandidate           = string.Format(@"SELECT TOP 1 FullName,MemberID,AttendanceStatus,p.TestID,p.TestTitle,CandidateID FROM Evaluations.CandidateTestAttendance a 
                                                                    JOIN Evaluations.ObjTestPaper p ON a.TestID=p.TestID
                                                                    JOIN EduSphere.Members n ON a.CandidateID=n.MemberID
                                                                    WHERE n.Email='{0}'", User.Identity.Name.ToString());
                    SqlCommand cmdCandidate         = new SqlCommand(queryCandidate, BD.ObjCn);
                    dtTestCandidate                 = BD.GetDataTable(cmdCandidate);
                    lblResultTestID.Text            = dtTestCandidate.Rows[0]["TestID"].ToString();
                    lblResultTestTitle.Text         = dtTestCandidate.Rows[0]["TestTitle"].ToString();
                    lblResultCandidateName.Text     = dtTestCandidate.Rows[0]["FullName"].ToString();
                    lblResultCandidateID.Text       = dtTestCandidate.Rows[0]["MemberID"].ToString();
                    lblAttendanceStatus.Text        = dtTestCandidate.Rows[0]["AttendanceStatus"].ToString();
                    //display result if candidate APPEARED for EXAM
                    if (dtTestCandidate.Rows[0]["AttendanceStatus"].ToString()=="APPEARED")
                    {
                        string qResult = string.Format(@"SELECT * FROM Evaluations.OnlineTestTransaction
                                                                WHERE CandidateID={0} AND TestID={1} AND EvaluationStatus!='{2}'",
                                                                Convert.ToInt32(dtTestCandidate.Rows[0]["CandidateID"].ToString()), Convert.ToInt32(dtTestCandidate.Rows[0]["TestID"].ToString()),"SKIPPED");
                        BD.DataBindToGridView(gvResult, qResult, "NA");

                    }
                    
                    break;
                default:
                    break;
            }

        }

        //Assign Candidates to Test
        //Higlight Enquiry Status
        protected void gvResult_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                TableCell cell = e.Row.Cells[8];
                //int quantity = int.Parse(cell.Text);
                string EvaluationStatus = cell.Text;

                if (EvaluationStatus == "INCORRECT")
                {
                    cell.ForeColor = Color.Red;
                    //e.Row.BackColor = Color.Red;
                }
                if (EvaluationStatus == "CORRECT")
                {
                    //cell.BorderColor = Color.Green;
                    cell.ForeColor = Color.Green;
                    //e.Row.BackColor = Color.Red;
                }

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
                CompleteAndExit();
                Response.Redirect("~/Default.aspx");
            }
        }
        //End test code for timer

        //Start the test
        protected void StartTest(object sender, EventArgs e)
        {
            lblCandidateName.Visible        = true;
            btnStartExam.Visible            = false;
            pnlTest.Visible                 = true;
            pnlQuestions.Visible            = true;           
            //start = DateTime.Now;
            //Check morning, afternoon, evening
            int Hr = Convert.ToInt32(DateTime.Now.Hour.ToString());
            if (Hr < 12)
                lblName.Text = "Good Morning !   " + lblCandidateName.Text;
            //if Afternoon
            else
            {
                //
                Hr -= 12;
                if (Hr < 6)
                    lblName.Text = "Good Afternoon !     " + lblCandidateName.Text;
                else
                    lblName.Text = "Good Evening !     " + lblCandidateName.Text;
            }
            //
            int score = Convert.ToInt32(txtScore.Text);
            lblScore.Text = "Score : " + Convert.ToString(score);

            //Counter to count the number of question
            Session["counter"] = "1";
            Random rnd = new Random();
            //int i = rnd.Next(startid, endid + 1);//genereates from ID 1 to scheduled question count. Same question in random order are asked to all the students. 
            int i = rnd.Next(startid, maxqid + 1);//generates from ID 1 to Max Question ID in whole question paper. The same questions may not be asked to all the students.
            //Display 1st question
            getQuestion(i);
            ArrayList al = new ArrayList();
            al.Add(i.ToString());
            Session["ids"] = al;
        }

        //Display question and options, Save correct answer in session variable
        public void getQuestion(int no)
        {
            //string strCmdQ = "SELECT * from Evaluations.ObjTestPaper where QuestionID=" + no + "";
            string strCmdQ          = string.Format(@"SELECT * from Evaluations.OnlineTestTransaction where QuestionID={0} AND TestID={1} AND CandidateID={2}", no,Convert.ToInt32(lblTestID.Text), Convert.ToInt32(lblCandidateID.Text));
            //string strCmdQ = string.Format("select * from Evaluations.ObjQuestions where QuestionID={0}   OR CourseID='{1}'", no, strCourseID) ;
            SqlDataAdapter ObjDAq   = new SqlDataAdapter(strCmdQ, BD.ObjCn);
            DataSet ObjDS           = new DataSet();
            ObjDAq.Fill(ObjDS, "Question");

            //Display Test ID
            DataRow dr      = ObjDS.Tables[0].Rows[0];
            lblTestID.Text  = dr["TestID"].ToString();
            //lblTestTitle.Text = dr["CourseTitle"].ToString();

            if (ObjDS.Tables[0].Rows.Count > 0)
            {
                DataRow dtrQ;
                int i = 0;
                while (i < ObjDS.Tables[0].Rows.Count)
                {
                    dtrQ = ObjDS.Tables[0].Rows[i];
                    Session["TransactionID"] = dtrQ["TransactionID"].ToString();//TransactionID from Users Answer Sheet
                    Session["Answer"]        = dtrQ["CorrectAnswer"].ToString();
                    //Display Question
                    lblQuestion.Text         = "Q" + Session["counter"].ToString() + "." +" "+ dtrQ["Question"].ToString();
                    //Display options
                    RblOption.ClearSelection();
                    RblOption.Items.Clear();
                    RblOption.Items.Add(dtrQ["OptionA"].ToString());
                    RblOption.Items.Add(dtrQ["OptionB"].ToString());
                    RblOption.Items.Add(dtrQ["OptionC"].ToString());
                    RblOption.Items.Add(dtrQ["OptionD"].ToString());

                    i++;
                }
            }
            //Commented following as there is no need to make trip again-Shivmani 06/06/2019
            //DisplayOptions(no);
        }

        //Display Options
        public void DisplayOptions(int no)
        {
        //    string strCmdA = "select * from Evaluations.ObjTestPaper where QuestionID=" + no + "";
            string strCmdA = string.Format(@"SELECT * from Evaluations.OnlineTestTransaction where QuestionID={0} AND TestID={1} AND CandidateID={2}", no, Convert.ToInt32(lblTestID.Text), Convert.ToInt32(lblCandidateID.Text));
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
                //Next Question
                Random rnd = new Random();
                //int i = rnd.Next(startid, endid);//Same questions are asked in random order. The id are from 1 to QCount
                int i = rnd.Next(startid,  maxqid);//same question may not be asked to all the students. The id is from 1 to MaxQuestion ID in paper.
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

        private void UpdateCandidateAnswerSheet()
        {
            //store the previous answer to users answer sheet
            string strCandidateSelection = "";
            string strEvaluationStatus="SKIPPED";//Default status in case candidate doesnt select any answer and clicks Next
            if (RblOption.SelectedIndex >= 0)
            {
                //if (Session["Answer"].ToString() == RblOption.SelectedIndex.ToString())
                if (Session["Answer"].ToString() == RblOption.SelectedItem.Value.ToString())
                {
                    int score = Convert.ToInt32(txtScore.Text) + 1;// 1 for mark for each question
                                                                   //int score       = 5;
                    txtScore.Text = score.ToString();
                    lblScore.Text = "Score : " + Convert.ToString(score);
                    strEvaluationStatus = "CORRECT";
                    strCandidateSelection = RblOption.SelectedItem.Value.ToString();
                }
                else
                {
                    strEvaluationStatus = "INCORRECT";
                    strCandidateSelection = RblOption.SelectedItem.Value.ToString();
                }                
            }
            //Candidate did not selectio andy option. Mark it NA
            else
            {
                strEvaluationStatus = "NA";
                strCandidateSelection = "";

            }
            //Update user answer in AnswerSheet
            // Answer sheet for candidate
            SqlCommand ObjCmd = new SqlCommand("spUpdateOnlineTestTransaction", BD.ObjCn);
            ObjCmd.CommandType = CommandType.StoredProcedure;
            ObjCmd.Parameters.AddWithValue("@TransactionID", Convert.ToInt32(Session["TransactionID"].ToString()));           
            ObjCmd.Parameters.AddWithValue("@CandidateSelection", strCandidateSelection);
            ObjCmd.Parameters.AddWithValue("@EvaluationStatus", strEvaluationStatus);
            BD.UpdateParameters(ObjCmd);
        }

        //Button Next is clicked
        public void DisplayNextQuestion(object sender, EventArgs e)
        {
            UpdateCandidateAnswerSheet();
            getNextQuestion();
        }

        //Finish Test
        protected void Finish_Click(object sender, EventArgs e)
        {
            //if (Session["Answer"].ToString() == RblOption.SelectedIndex.ToString())
            //{
            //    int score = Convert.ToInt32(txtScore.Text) + 1;// 1 for mark for each question
            //    txtScore.Text = score.ToString();
            //    lblScore.Text = "Score : " + Convert.ToString(score);
            //}
            CompleteAndExit();
            //pnlTest.FindControl("pnlTimer").Visible = false;
        }

        private void CompleteAndExit()
        {
            UpdateCandidateAnswerSheet();
            lblResult.Text = "Thank you for taking the Test. Your Score is : " + txtScore.Text;

            //Store the score in Evaluations.OnlineTestResults
            int intCandidateID  = Convert.ToInt32(lblCandidateID.Text);
            int intTestID       = Convert.ToInt32(lblTestID.Text);
            int intScore        = Convert.ToInt32(txtScore.Text);
            int intMaxmarks     = totalnoofquestions;

            DateTime dtTestDate = DateTime.Now;

            StoreOnlineTestScore(intCandidateID, intScore, intMaxmarks, intTestID, dtTestDate);
            
            lblResult.Visible = true;
            pnlQuestions.Visible = false;
        }

        //Insert the score in Evaluations.OnlineTestResults
        protected void StoreOnlineTestScore(int intCandidateID, int intScore, int intMaxMarks, int intTestID, DateTime dtTestDate)
        {
            //compute time take for completion
            //DateTime start      = DateTime.ParseExact(lblTestStartTime.Text, "dd-mm-yyyy HH:mm:ss", System.Globalization.CultureInfo.InvariantCulture);
            start = Convert.ToDateTime(lblTestStartTime.Text.ToString());
            DateTime end        = DateTime.Now;
            TimeSpan span       = end.Subtract(start);
            int minutesTaken    = Convert.ToInt32(span.Minutes);

            SqlCommand ObjCmd = new SqlCommand("spInsertOnlineTR", BD.ObjCn);
            ObjCmd.CommandType = CommandType.StoredProcedure;

            ObjCmd.Parameters.AddWithValue("@CandidateID", intCandidateID);
            ObjCmd.Parameters.AddWithValue("@Score", intScore);
            ObjCmd.Parameters.AddWithValue("@MaxMarks", intMaxMarks);
            ObjCmd.Parameters.AddWithValue("@PercentageMarks", 100 * intScore / intMaxMarks);
            ObjCmd.Parameters.AddWithValue("@TestID", intTestID);
            ObjCmd.Parameters.AddWithValue("@TestDate", dtTestDate);
            ObjCmd.Parameters.AddWithValue("@TimeTaken", minutesTaken);
            BD.UpdateParameters(ObjCmd);
        }

        //language translation
        //Translate
        protected async void Translate(object sender, CommandEventArgs e)
        {
            string cmdName = e.CommandName.ToString();
            //string uri = "https://api.cognitive.microsofttranslator.com/translate?api-version=3.0&to=hi";
            string to = cmdName;
            await Task.Run(() => { 
            lblQuestion.Text = (TT.TranslateTextRequest(to,lblQuestion.Text)).ToString();
            });
        }
    }
}