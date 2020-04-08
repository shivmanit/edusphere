using EduSpherePro.CoreServices;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.tool.xml;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EduSpherePro.EduSpherePro
{
    public partial class Students : System.Web.UI.Page
    {
        BindData BD = new BindData();
        //LoggedInUsers lnUser = new LoggedInUsers();
        IAnalytics MT = new Analytics();
        //Connect EC = new Connect();
        ISMSSender SMS = new SMSSender();
        IMailService MAIL = new MailService();
        PdfGenerator PG = new PdfGenerator();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                pnlEnroll.Visible = false;
                pnlPersonalDetails.Visible = false;
                pnlEditPhoto.Visible = false;
                pnlMemberSkuStatement.Visible = false;
                pnlMembers.Visible = true;
                pnlMemberSummary.Visible = true;
                //pnlViewEnquiries.Visible = false;
                pnlCompletedSku.Visible = false;
                pnlSkuReminders.Visible = false;
                pnlGreetings.Visible = false;
                pnlSentMessageHistory.Visible = false;
                //Get user role
                if (User.Identity.IsAuthenticated)
                {
                    string strID = User.Identity.Name;
                    //Changes with Identity
                    // string strRole  = lnUser.GetUserRole(strID);
                    //lblRole.Text = strRole;
                    if (User.IsInRole("Admin"))
                        lblRole.Text = "Admin";
                    if (User.IsInRole("Manager"))
                        lblRole.Text = "Manager";
                }

                //Display list of customers
                //Refresh Student List
                string strCmd = string.Format("SELECT TOP 10 MemberID, FullName, Gender,ProgramTitle FROM EduSphere.Members c JOIN EduSphere.Programs m ON c.ProgramID=m.ProgramID WHERE MembershipType='{0}' ORDER BY MemberID DESC","STUDENT");
                //Display Student Count
                DisplayStudentSummary();
                BD.DataBindToDataList(dlStudents, strCmd);
                //If creating an interview link from Organization Page.
                //Check the orgId in the query
                if (Request.QueryString["id"] != null)
                    lblDriveID.Text = Request.QueryString["id"].ToString();
                else
                    lblDriveID.Text = "0";

            }


        }

        //Display Students in datalist based on filter parameters
        protected void FilterStudent(Object sender, CommandEventArgs e)
        {
            lblMembersAction.Text = "Operations / Members / ViewStudents";
            string strCmdArg = e.CommandArgument.ToString();
            string strCmd;
            string strSearch = txtBoxSearch.Text;
            if (strCmdArg == "ALL")
                strCmd = string.Format("SELECT TOP 50 MemberID, FullName, Gender,ProgramTitle FROM EduSphere.Members c JOIN EduSphere.Programs m ON c.ProgramID=m.ProgramID WHERE MembershipType='{0}' ORDER BY MemberID DESC","STUDENT");
            else
                strCmd = string.Format("SELECT MemberID, FullName, Gender,ProgramTitle FROM EduSphere.Members c JOIN EduSphere.Programs m ON c.ProgramID=m.ProgramID WHERE MemberID like '%{0}%' OR FullName like '%{0}%' OR PhoneOne like '%{0}%' AND MembershipType='{1}'", strSearch,"STUDENT");

            pnlEnroll.Visible                       = false;
            pnlPersonalDetails.Visible              = false;
            pnlEditPhoto.Visible                    = false;
            pnlMemberSummary.Visible               = true;
            pnlMembers.Visible                     = true;
            pnlMemberSkuStatement.Visible           = false;
            //pnlViewEnquiries.Visible              = false;
            pnlSentMessageHistory.Visible           = false;
            pnlCompletedSku.Visible                = false;
            pnlSkuReminders.Visible                 = false;
            pnlGreetings.Visible                    = false;

            BD.DataBindToDataList(dlStudents, strCmd);
            //Display Student Count
            DisplayStudentSummary();
            //In case the logged in role is Admin then display delete button.
            if (lblRole.Text == "Admin")
            {
                foreach (DataListItem dlItem in dlStudents.Items)
                {
                    ImageButton btn = (ImageButton)dlItem.FindControl("btnDeleteStudent");
                    btn.Visible = true;
                }
            }
        }

        public void DisplayStudentSummary()
        {
            //Retrieve Count          
            int Count = MT.Count("spStudentsCount");
            lblCount.Text = Convert.ToString(Count);
            //End Count
        }

        //Display Personal Details of selected Student
        public void DisplayStudentData(object sender, CommandEventArgs e)
        {
            string cmdName, strKey, queryStudent = "";
            string queryString = "";
            cmdName = e.CommandName.ToString();
            strKey = e.CommandArgument.ToString();
            switch (cmdName)
            {
                case "PersonalDetails":
                    lblMembersAction.Text           = "Operations / View Members ->Personal Details";
                    pnlMembers.Visible             = false;
                    pnlMemberSummary.Visible       = false;
                    pnlPersonalDetails.Visible      = true;
                    pnlSendMsg.Visible              = true;
                    //pnlViewEnquiries.Visible        = false;
                    pnlSentMessageHistory.Visible   = false;
                    pnlCompletedSku.Visible        = false;
                    pnlSkuReminders.Visible         = false;
                    pnlGreetings.Visible            = false;
                    queryString = string.Format(@"SELECT * FROM EduSphere.Members n 
                                                           JOIN EduSphere.Programs p ON n.ProgramID=p.ProgramID
                                                           JOIN EduSphere.Organizations o ON n.OrganizationID=o.OrganizationID 
                                                           WHERE MemberID='{0}'", strKey);
                    BD.DataBindToDataList(dlPersonalDetails, queryString);
                    UpdateNotifyCheckBoxStatus();
                    break;

                case "StudentAccount":
                    lblMembersAction.Text = "Operations / Students ->Student Acoount Transactions";
                    PerformBilling(strKey);
                    break;
                case "AddToPlacementDrive":
                    AddStudentToPlacementDrive(Convert.ToInt32(lblDriveID.Text.ToString()), Convert.ToInt32(strKey));
                    break;

                case "DeleteStudent":
                    DeleteStudent(strKey);
                    //Refresh Student List
                    string strCmd = string.Format("SELECT MemberID, FullName, Gender from EduSphere.Members");
                    //Display Student Count
                    DisplayStudentSummary();
                    BD.DataBindToDataList(dlStudents, strCmd);
                    break;


                default:
                    break;
            }

        }

        private void PerformBilling(string strKey)
        {
            lblMembersAction.Text = "Academy / Student /Member Account Transactions";
            //Populate service for slection
            string strCmd = string.Format("SELECT SkuID, UPPER(Convert(varchar(10),SkuID) +'-'+ SkuTitle +'-'+ Convert(varchar(10),UnitRate)) AS DisplayText FROM EduSphere.Sku WHERE SkuID>=100 ORDER BY SkuTitle ASC");
            BD.DataBindToDropDownList(ddlSku, strCmd);//For adding service to bill
                                                           //BD.DataBindToDropDownList(ddlServiceMain, strCmd);//For adding service to enq
                                                           //BD.DataBindToDropDownList(ddlServiceOtherOne, strCmd);//For adding service to enq
                                                           //BD.DataBindToDropDownList(ddlServiceOtherTwo, strCmd);//For adding service to enq

            //Populate Employees for slecting consultant Name and ConsultantTwoID From while adding ServieItems to Bill (Debit)
            if (User.IsInRole("Admin") || User.IsInRole("Accounts"))
            {
                BD.DataBindToDropDownList(ddlTxLocation, string.Format("SELECT OrganizationName,OrganizationID FROM EduSphere.Organizations"));
                BD.DataBindToDropDownList(ddlPaymentLocation, string.Format("SELECT OrganizationName,OrganizationID FROM EduSphere.Organizations"));
            }
            else
            {
                BD.DataBindToDropDownList(ddlTxLocation, string.Format("SELECT OrganizationName,o.OrganizationID FROM EduSphere.Organizations o JOIN EduSphere.Staff e ON o.OrganizationID=e.OrganizationID WHERE Email='{0}'", User.Identity.Name));
                BD.DataBindToDropDownList(ddlPaymentLocation, string.Format("SELECT OrganizationName,o.OrganizationID FROM EduSphere.Organizations o JOIN EduSphere.Staff e ON o.OrganizationID=e.OrganizationID WHERE Email='{0}'", User.Identity.Name));

            }
            string strCmdEmployees = string.Format("SELECT EmployeeID,FullName,Gender FROM EduSphere.Staff WHERE EmploymentStatus='{0}' ORDER BY FullName ASC", "ACTIVE");
            BD.DataBindToDropDownList(ddlConsultantOneID, strCmdEmployees);
            BD.DataBindToDropDownList(ddlConsultantTwoID, strCmdEmployees);
            BD.DataBindToDropDownList(ddlConsultantThreeID, strCmdEmployees);

            string queryString = string.Format(@"SELECT TOP 5 * ,c.FullName as '{0}',a.TransactionID,s.SkuTitle,con.FullName as '{1}',ref.FullName as '{2}',a.TxDate,a.OfferedRate,a.DebitAmount,a.CreditAmount,a.PaymentMode,a.DigitalPaymentRefCode,a.BalanceAmount FROM EduSphere.Members c JOIN EduSphere.MemberAccount a ON c.MemberId=a.MemberId JOIN EduSphere.Sku s ON s.SkuID=a.SkuID JOIN EduSphere.Staff con ON con.EmployeeID=a.ConsultantOneID JOIN EduSphere.Staff ref ON ref.EmployeeID=a.ConsultantTwoID where c.MemberId='{3}'  order by a.TransactionID desc", "custName", "consName", "refName", strKey);
            //string queryMember = string.Format("SELECT * FROM EduSphere.Members c JOIN EduSphere.MembershipTypes m ON c.MembershipTypeId=m.MembershipTypeId WHERE MemberId='{0}'", strKey);
            string queryMember = string.Format("SELECT * FROM EduSphere.Members WHERE MemberId='{0}'", strKey);
            lblCustId.Text                  = strKey;
            pnlMembers.Visible              = false;
            pnlPersonalDetails.Visible      = false;
            pnlMemberSummary.Visible        = false;
            pnlMemberSkuStatement.Visible   = true;
            //pnlViewEnquiries.Visible      = false;
            pnlSentMessageHistory.Visible   = false;
            pnlCompletedSku.Visible         = false;
            pnlSkuReminders.Visible         = false;
            pnlMembershipReminders.Visible  = false;
            pnlGreetings.Visible            = false;
            lblMembersAction.Text           = "Academy / Student / Member Transactions";
            BD.DataBindToGridView(dgMemberSkuStatement, queryString, "NA");

            //Gather name, phone and email for sending sms & email
            BD.DataBindToDataList(dlMemberAccountTransaction, queryMember);
            //BD.DataBindToLabel(lblMembershipDiscount, string.Format("SELECT DiscountPercentage FROM EduSphere.MembershipTypes WHERE MembershipTypeId=(SELECT MembershipTypeId FROM EduSphere.Members WHERE MemberId={0})", strKey));
            //txtBoxDiscountPercentage.Text = lblMembershipDiscount.Text;
            txtBoxDiscountPercentage.Text = "0";
            //Display Member Todays Invoice
            //Query for Member Invoice Summary
            string strInvoiceQ = string.Format("SELECT TOP 1 * FROM EduSphere.TaxInvoices i JOIN EduSphere.Members c ON i.MemberId=c.MemberId WHERE i.MemberId={0} AND CAST(InvoiceDate AS DATE)=CAST(GETDATE() AS DATE) ORDER BY TaxInvoiceNumber DESC", strKey);
            BD.DataBindToDataList(dlMemberInvoice, strInvoiceQ);
            //Query for Member Invoice Details of Service
            string strInvoiceItems = string.Format(@"SELECT SkuTitle,DiscountAmount,CGSTAmount, SGSTAmount,DebitAmount,CreditAmount FROM EduSphere.MemberAccount a 
                                                                    JOIN EduSphere.Sku s ON a.SkuID=s.SkuID 
                                                                    WHERE MemberId={0}
                                                                    AND TaxInvoiceNumber=(SELECT Top 1 TaxInvoiceNumber FROM EduSphere.TaxInvoices WHERE MemberId={0} AND CAST(TxDate AS DATE)=CAST(GETDATE() AS DATE) ORDER BY TaxInvoiceNumber DESC)", strKey);
            BD.DataBindToGridView(gvInvoiceDetails, strInvoiceItems, "NA");
            //Query for Member Invoice Details of Product if any with latest Invoice Number
           // string strInvoiceItemsProduct = string.Format(@"SELECT ProductTitle,DiscountAmount,CGSTAmount, SGSTAmount,DebitAmount,CreditAmount FROM EduSphere.ProductSaleTransaction a JOIN EduSphere.Products s ON a.ProductId=s.ProductId WHERE MemberId={0} AND TaxInvoiceNumber=(SELECT Top 1 TaxInvoiceNumber FROM EduSphere.TaxInvoices WHERE MemberId={0} AND CAST(dtOfPurchase AS DATE)=CAST(GETDATE() AS DATE) ORDER BY TaxInvoiceNumber DESC)", strKey);
           // BD.DataBindToGridView(gvInvoiceDetailsProduct, strInvoiceItemsProduct, "NA");

            //Highlight the Account Balance for both Products & Service Account
            //string strServiceBalanceQuery = string.Format(@"SELECT SUM(CreditAmount)-SUM(DebitAmount) FROM EduSphere.MemberAccount WHERE MemberID={0}", strKey);
            string strBalanceQuery = string.Format(@"SELECT SUM(CreditAmount)-SUM(SubTotal) FROM EduSphere.TaxInvoices WHERE MemberID={0}", strKey);
            BD.DataBindToLabel(lblServiceBalance, strBalanceQuery);
            //string strProductBalanceQuery = string.Format(@"SELECT SUM(CreditAmount)-SUM(DebitAmount) FROM EduSphere.ProductSaleTransaction WHERE MemberID={0}", strKey);
            //BD.DataBindToLabel(lblProductBalance, strProductBalanceQuery);
            //Display Bonus Wallet Points
            //string strBWQ = string.Format(@"SELECT SUM(CreditPoints)-SUM(DebitPoints) FROM EduSphere.BonusWallet WHERE MemberID={0}", strKey);
            //BD.DataBindToLabel(lblBonusWalletPoints, strBWQ);

            //Grant Learning Tokens to Student
            string qLearningTokens = string.Format(@"SELECT * FROM EduSphere.LearningTokens t
                                                                JOIN EduSphere.Courses c ON t.CourseID=c.CourseID
                                                                WHERE MemberID={0}", Convert.ToInt32(lblCustId.Text));
            BD.DataBindToGridView(gvAssignCandidates, qLearningTokens, "NA");
        }


        //Manage Learning Tokens
        //Assign Candidates to Test
        //Higlight 
        protected void gvAssignCandidates_RowDataBound(object sender, GridViewRowEventArgs e)
        {
        //    if (e.Row.RowType == DataControlRowType.DataRow)
        //    {
        //        TableCell cell = e.Row.Cells[7];
        //        //int quantity = int.Parse(cell.Text);
        //        string AttendanceStatus = cell.Text;

        //        if (AttendanceStatus == "SUBSCRIBED")
        //        {
        //            cell.BackColor = Color.LightGreen;
        //            e.Row.BackColor = Color.LightGreen;
        //        }

        //    }


        }
        
        //LearningToken Assignment ---Add LearningTokens for All Courses of Program the Member is Enrolled for
        protected void ResetLearningTokens(object sender,CommandEventArgs e) 
        {
            int intMemberID         = Convert.ToInt32(lblCustId.Text);
            SqlCommand cmd          = new SqlCommand("spCreateLearningTokens", BD.ObjCn);
            cmd.CommandType         = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@MemberID", intMemberID);
            BD.UpdateParameters(cmd);
            string qLearningTokens  = string.Format(@"SELECT * FROM EduSphere.LearningTokens t
                                                                JOIN EduSphere.Courses c ON t.CourseID=c.CourseID
                                                                WHERE MemberID={0}", Convert.ToInt32(lblCustId.Text));
            BD.DataBindToGridView(gvAssignCandidates, qLearningTokens, "NA");
        }
        
        //Enable/Disable Learning token
        protected void gvAssignCandidates_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string strTokenStatus   = e.CommandName.ToString();
            int intTokenID          = Convert.ToInt32(e.CommandArgument.ToString());
            SqlCommand cmd          = new SqlCommand("spUpdateLearningToken", BD.ObjCn);
            cmd.CommandType         = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@TokenID", intTokenID);
            cmd.Parameters.AddWithValue("@TokenStatus", strTokenStatus);
            BD.UpdateParameters(cmd);
            //Refresh 
            string qLearningTokens = string.Format(@"SELECT * FROM EduSphere.LearningTokens t
                                                                JOIN EduSphere.Courses c ON t.CourseID=c.CourseID
                                                                WHERE MemberID={0}",Convert.ToInt32(lblCustId.Text));
            BD.DataBindToGridView(gvAssignCandidates, qLearningTokens, "NA");
        }


        //Add Student to Placement Drive
        private void AddStudentToPlacementDrive(int DriveID, int MemberID)
        {
            SqlCommand cmd = new SqlCommand("spAddStudentToDrive", BD.ObjCn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@DriveID", DriveID);
            cmd.Parameters.AddWithValue("@MemberID", MemberID);
            BD.UpdateParameters(cmd);
        }
        private void UpdateNotifyCheckBoxStatus()
        {
            //Update Notify check box based on Notify value
            //Label lblN = new Label();
            //CheckBox chkBoxN = new CheckBox();
            //foreach (DataListItem item in dlPersonalDetails.Items)
            //{
            //    chkBoxN = (CheckBox)item.FindControl("chkBoxNotify");
            //    lblN = (Label)item.FindControl("lblNotify");
            //}
            //if (lblN.Text == "YES")
            //    chkBoxN.Checked = true;
            //else
            //    chkBoxN.Checked = false;
        }

        public void DisplayMoreTransactions(object sender, CommandEventArgs e)
        {
            //Display number of transactions as metioned in CommandArgument, 
            string queryString = string.Format("SELECT TOP {0} * ,c.FullName as '{1}',a.TransactionID,s.SkuTitle,con.FullName as '{2}',a.TxDate,a.OfferedRate,a.DebitAmount,a.CreditAmount,a.PaymentMode,a.DigitalPaymentRefCode,a.BalanceAmount FROM EduSphere.Members c JOIN EduSphere.MemberAccount a ON c.MemberID=a.MemberID JOIN EduSphere.Sku s ON s.SkuId=a.SkuId JOIN EduSphere.Staff con ON con.EmployeeID=a.ConsultantOneID where c.MemberID='{3}'  order by a.TransactionID desc", e.CommandArgument.ToString(), "custName", "consName", lblCustId.Text);
            //string queryString = string.Format("SELECT TOP {0} c.FullName as {1},a.TransactionID,s.SkuTitle,con.FullName as '{2}',a.TxDate,a.OfferedRate,a.DebitAmount,a.CreditAmount,a.PaymentMode,a.DigitalPaymentRefCode,a.BalanceAmount FROM EduSphere.Members c JOIN EduSphere.MemberAccount a ON c.MemberID=a.MemberID JOIN EduSphere.Sku s ON s.SkuId=a.SkuId JOIN EduSphere.Staff con ON con.EmployeeID=a.ConsultantOneID where c.MemberID='{4}' order by a.TransactionID desc", e.CommandArgument.ToString(), "custName", "consName", lblCustId.Text);
            BD.DataBindToGridView(dgMemberSkuStatement, queryString, "NA");

        }

        //Update TaxCode and Taxe Rate upon change of service in the billing
        protected void SelectedSkuChanged(object sender, EventArgs e)
        {
            int intFeeId = Convert.ToInt32(ddlSku.SelectedValue.ToString());
            string strCmd = string.Format("SELECT s.TaxCode,s.UnitRate, CGSTPercentage,SGSTPercentage FROM EduSphere.Sku s JOIN EduSphere.TaxCodes c ON s.TaxCode=c.TaxCode WHERE s.SkuId={0}", intFeeId);
            BD.DataBindToDataList(dlTax, strCmd);
            Label lblUnitRate = new Label();
            foreach (DataListItem li in dlTax.Items)
            {
                lblUnitRate = (Label)li.FindControl("lblUnitRate");
            }
            txtBoxDebitAmount.Text = lblUnitRate.Text;
        }


        //service quantity number changed
        protected void txtBoxSkuQuantity_TextChanged(object sender, EventArgs e)
        {
            try
            {
                int qty = (Convert.ToInt32(txtBoxSkuQuantity.Text));
                Label lblUnitRate = new Label();
                foreach (DataListItem li in dlTax.Items)
                {
                    lblUnitRate = (Label)li.FindControl("lblUnitRate");
                }
                txtBoxDebitAmount.Text = (Convert.ToDecimal(lblUnitRate.Text) * qty).ToString();

            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Quantity must be number !!!')", true);

            }
            finally
            {
                //ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Qty must be number !!!')", true);

            }



        }

        //Customer Service Account View, on click to BookService or ReceivePayment
        public void PerformMemberAccountTransaction(object sender, CommandEventArgs e)
        {
            string strSMSmessage, strNotes, strName, strPhoneOne, strEmail, strDigitalPaymentRefCode = "";
            string[] cmdArgs = new string[3]; //Declare string array 
            string strPaymentMode = "";
            string strTransactionTrigger;
            string spName;
            SqlCommand ObjCmd;
            decimal decDebitAmount, decCreditAmount, decOfferedRate;
            int intServiceId;
            string strKey = lblCustId.Text;
            string cmdName = e.CommandName.ToString();

            Label lblName = new Label();
            Label lblPhoneOne = new Label();
            Label lblEmail = new Label();

            foreach (DataListItem li in dlMemberAccountTransaction.Items)
            {
                lblName = (Label)li.FindControl("lblFirstName");
                lblPhoneOne = (Label)li.FindControl("lblPhoneOne");
                lblEmail = (Label)li.FindControl("lblEmail");
            }
            //For SMS and Email
            strName = lblName.Text;
            strPhoneOne = lblPhoneOne.Text;
            strEmail = lblEmail.Text;

            //For Next Folloup Reminders
            int intNextFollowup = 0;
            string strNextFollowup = txtBoxNextFollowup.Text.ToString();
            if (strNextFollowup != "")
                intNextFollowup = Convert.ToInt32(strNextFollowup);
            //Connect EC = new Connect();



            strNotes = "";
            //string strNotes             = txtBoxServiceNotes.Text;

            string strConsultantOneID = ddlConsultantOneID.SelectedValue;
            if (strConsultantOneID == "Select")//In case user did not select any name
                strConsultantOneID = "90";

            string strConsultantTwoID = ddlConsultantTwoID.SelectedValue;
            if (strConsultantTwoID == "Select")//In case user did not select any name
                strConsultantTwoID = "90";

            string strConsultantThreeID = ddlConsultantThreeID.SelectedValue.ToString();
            if (strConsultantThreeID == "Select")//In case user did not select any name
                strConsultantThreeID = "90";

            string strTransactionStatus = "";
            if (cmdName == "BookEnquiry") //In case it Enquiry update EduSphere.MemberServiceEnquiry table
            {
                spName = "spMemberServiceEnquiryTransaction";
            }
            else
                spName = "spMemberAccountTransaction";

            ObjCmd = new SqlCommand(spName, BD.ObjCn);
            ObjCmd.CommandType = CommandType.StoredProcedure;
            ObjCmd.Parameters.AddWithValue("@MemberID", strKey);

            switch (cmdName)
            {
                case "BookEnquiry":

                    break;
                case "DebitAccount":
                    intServiceId = Convert.ToInt32(ddlSku.SelectedValue);
                    int intServiceQty = Convert.ToInt32(txtBoxSkuQuantity.Text);

                    decDebitAmount = Convert.ToDecimal(txtBoxDebitAmount.Text);

                    //decimal decDiscountAmount = (Convert.ToDecimal(txtBoxDiscountPercentage.Text) * decDebitAmount) / 100;
                    decimal decDiscountAmount = Convert.ToDecimal(txtBoxDiscountAmount.Text) + (Convert.ToDecimal(txtBoxDiscountPercentage.Text) * decDebitAmount) / 100;
                    //DebitAmount after discount
                    decDebitAmount -= decDiscountAmount;

                    decCreditAmount = 0;
                    strNotes = "ItemAdded";
                    strTransactionTrigger = "DEBIT-Sku";
                    string strServiceLocation = "100";
                    if (ddlTxLocation.SelectedValue.ToString() == "Select")
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Please Select Location !!!')", true);
                        return;
                    }
                    else
                    {
                        strServiceLocation = ddlTxLocation.SelectedValue.ToString();
                    }

                    ObjCmd.Parameters.AddWithValue("@SkuId", intServiceId);
                    ObjCmd.Parameters.AddWithValue("@DiscountAmount", decDiscountAmount);
                    ObjCmd.Parameters.AddWithValue("@DebitAmount", decDebitAmount);
                    ObjCmd.Parameters.AddWithValue("@CreditAmount", decCreditAmount);
                    ObjCmd.Parameters.AddWithValue("@TxDate", DateTime.Now);
                    //for single salon there should not be a need to select salon
                    ObjCmd.Parameters.AddWithValue("@TxLocation", strServiceLocation);//Multistore 
                    //ObjCmd.Parameters.AddWithValue("@ServiceLocation", "S01");//Single salon-the first salon is always named S01
                    ObjCmd.Parameters.AddWithValue("@OfferedRate", decDebitAmount);

                    ObjCmd.Parameters.AddWithValue("@ConsultantOneID", Convert.ToInt32(strConsultantOneID));
                    ObjCmd.Parameters.AddWithValue("@ConsultantOneEffortPercentage", Convert.ToInt32(txtBoxConsultantOneEffort.Text) * decDebitAmount / 100);
                    ObjCmd.Parameters.AddWithValue("@ConsultantTwoID", Convert.ToInt32(strConsultantTwoID));
                    ObjCmd.Parameters.AddWithValue("@ConsultantTwoEffortPercentage", Convert.ToInt32(txtBoxConsultantTwoEffort.Text) * decDebitAmount / 100);
                    ObjCmd.Parameters.AddWithValue("@ConsultantThreeID", Convert.ToInt32(strConsultantThreeID));
                    ObjCmd.Parameters.AddWithValue("@ConsultantThreeEffortPercentage", Convert.ToInt32(txtBoxConsultantThreeEffort.Text) * decDebitAmount / 100);
                    ObjCmd.Parameters.AddWithValue("@Notes", strNotes);
                    ObjCmd.Parameters.AddWithValue("@PaymentMode", strPaymentMode);
                    ObjCmd.Parameters.AddWithValue("@DigitalPaymentRefCode", strDigitalPaymentRefCode);
                    ObjCmd.Parameters.AddWithValue("@NextFollowup", intNextFollowup);
                    ObjCmd.Parameters.AddWithValue("@TransactionTrigger", strTransactionTrigger);

                    break;
                case "ReverseDebit":
                    cmdArgs = e.CommandArgument.ToString().Split(';');//split by ; andf copy into array
                    //intServiceId    = Convert.ToInt32(cmdArgs[0].ToString());
                    int intTransactionId = Convert.ToInt32(cmdArgs[0].ToString());
                    //intProductRate = Convert.ToInt32(cmdArgs[1].ToString());
                    decDebitAmount = -Convert.ToDecimal(cmdArgs[1].ToString());//make it -ve
                    //intServiceId  = Convert.ToInt32(ddlServices.SelectedValue);
                    //decDebitAmount = Convert.ToInt32(txtBoxDebitAmount.Text);
                    //make dicount -ve
                    decimal decDiscountAmountReverse = -Convert.ToDecimal(cmdArgs[2].ToString());//Cancel discount Amount
                    //DebitAmount after discount
                    // decDebitAmount -= decDiscountAmount;

                    decCreditAmount = 0;
                    strNotes = "ItemCancelled";
                    strTransactionTrigger = "REVERSAL";
                    //string strServiceLocationReverse = ddlServiceLocation.SelectedValue;
                    //Not required as location is found in stored procedure based on transactionID
                    string strServiceLocationReverse = "100";
                    //if (ddlServiceLocation.SelectedValue.ToString() == "Select")
                    //{
                    //    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Please Select Salon Location !!!')", true);
                    //    return;
                    //}
                    //else
                    //{
                    //    strServiceLocationReverse = ddlServiceLocation.SelectedValue.ToString();
                    //}
                    //Bug-while reversing the amount the consultant ids are not same at the transaction that is getting reveresed.
                    //In case of Reversal the SkuID parameter is carrying TransactionID.
                    //ObjCmd.Parameters.AddWithValue("@SkuID", intServiceId);
                    //Instead of creating a new parameter, a quick fix is done here. Service ID Carries TransactionID
                    ObjCmd.Parameters.AddWithValue("@SkuId", intTransactionId);
                    ObjCmd.Parameters.AddWithValue("@DiscountAmount", decDiscountAmountReverse);
                    ObjCmd.Parameters.AddWithValue("@DebitAmount", decDebitAmount);
                    ObjCmd.Parameters.AddWithValue("@CreditAmount", decCreditAmount);
                    ObjCmd.Parameters.AddWithValue("@TxDate", DateTime.Now);
                    //for a signle branch there should not be need to select service location
                    ObjCmd.Parameters.AddWithValue("@TxLocation", strServiceLocationReverse);
                    //ObjCmd.Parameters.AddWithValue("@ServiceLocation", "S01");
                    ObjCmd.Parameters.AddWithValue("@OfferedRate", decDebitAmount);

                    ObjCmd.Parameters.AddWithValue("@ConsultantOneID", Convert.ToDecimal(strConsultantOneID));
                    ObjCmd.Parameters.AddWithValue("@ConsultantOneEffortPercentage", Convert.ToDecimal(txtBoxConsultantOneEffort.Text) * decDebitAmount / 100);
                    ObjCmd.Parameters.AddWithValue("@ConsultantTwoID", Convert.ToInt32(strConsultantTwoID));
                    ObjCmd.Parameters.AddWithValue("@ConsultantTwoEffortPercentage", Convert.ToDecimal(txtBoxConsultantTwoEffort.Text) * decDebitAmount / 100);
                    ObjCmd.Parameters.AddWithValue("@ConsultantThreeID", Convert.ToInt32(strConsultantThreeID));
                    ObjCmd.Parameters.AddWithValue("@ConsultantThreeEffortPercentage", Convert.ToDecimal(txtBoxConsultantThreeEffort.Text) * decDebitAmount / 100);
                    ObjCmd.Parameters.AddWithValue("@Notes", strNotes);
                    ObjCmd.Parameters.AddWithValue("@PaymentMode", strPaymentMode);
                    ObjCmd.Parameters.AddWithValue("@DigitalPaymentRefCode", strDigitalPaymentRefCode);
                    ObjCmd.Parameters.AddWithValue("@NextFollowup", intNextFollowup);
                    ObjCmd.Parameters.AddWithValue("@TransactionTrigger", strTransactionTrigger);
                    break;

                case "CreditAccount":
                    decCreditAmount = Convert.ToDecimal(txtBoxCreditAmount.Text);
                    decDebitAmount = 0;
                    strPaymentMode = ddlModeOfPayment.SelectedValue;
                    //if (strPaymentMode == "BonusWallet")
                    //{
                    //    int result = ManageBonusWallet(Convert.ToInt32(strKey), "DebitWallet", decCreditAmount);
                    //    if (result != 0)
                    //    {
                    //        ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Transaction Failed !!!')", true);
                    //        return;
                    //    }
                    //}
                    //string strPaymentLocation   = ddlPaymentLocation.SelectedValue;
                    string strPaymentLocation = "100";
                    if (ddlPaymentLocation.SelectedValue.ToString() == "Select")
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Please Select  Location !!!')", true);
                        return;
                    }
                    else
                    {
                        strPaymentLocation = ddlPaymentLocation.SelectedValue.ToString();
                    }

                    strDigitalPaymentRefCode = txtBoxConfirmationCode.Text;
                    //strNotes                    = ddlServiceMain.SelectedItem + "," + ddlServiceOtherOne.SelectedItem + "," + ddlServiceOtherTwo.SelectedItem;
                    strTransactionTrigger = ddlPaymentFor.SelectedValue.ToString();
                    ObjCmd.Parameters.AddWithValue("@SkuId", 91);//PAYMENT-RECEIPT-Hidden Service ID
                    ObjCmd.Parameters.AddWithValue("@DiscountAmount", 0);
                    ObjCmd.Parameters.AddWithValue("@CreditAmount", decCreditAmount);
                    ObjCmd.Parameters.AddWithValue("@DebitAmount", decDebitAmount);

                    ObjCmd.Parameters.AddWithValue("@TxDate", DateTime.Now);
                    //for a signle branch there should not be need to select service location
                    ObjCmd.Parameters.AddWithValue("@TxLocation", strPaymentLocation);
                    //ObjCmd.Parameters.AddWithValue("@ServiceLocation", "S01");
                    ObjCmd.Parameters.AddWithValue("@Notes", "Received Payment");
                    ObjCmd.Parameters.AddWithValue("@ConsultantOneID", Convert.ToInt32(strConsultantOneID));
                    ObjCmd.Parameters.AddWithValue("@ConsultantOneEffortPercentage", 0);
                    ObjCmd.Parameters.AddWithValue("@ConsultantTwoID", Convert.ToInt32(strConsultantTwoID));
                    ObjCmd.Parameters.AddWithValue("@ConsultantTwoEffortPercentage", 0);
                    ObjCmd.Parameters.AddWithValue("@ConsultantThreeID", Convert.ToInt32(strConsultantThreeID));
                    ObjCmd.Parameters.AddWithValue("@ConsultantThreeEffortPercentage", 0);
                    ObjCmd.Parameters.AddWithValue("@OfferedRate", 0);
                    strTransactionStatus = string.Format("Received {0}", decCreditAmount);
                    ObjCmd.Parameters.AddWithValue("@PaymentMode", strPaymentMode);
                    ObjCmd.Parameters.AddWithValue("@DigitalPaymentRefCode", strDigitalPaymentRefCode);
                    ObjCmd.Parameters.AddWithValue("@NextFollowup", 0);
                    ObjCmd.Parameters.AddWithValue("@TransactionTrigger", strTransactionTrigger);
                    //send sms
                    //strSMSmessage = string.Format("Dear {0}, Received Rs {1} INR with Thanks, Salon Salon N Academy. Contact us at http://purplesalon.in/Home/Contact ", strName,decCreditAmount);
                    //EC.SendSMS(strPhoneOne, strSMSmessage);
                    //SentMsgLogger("SMS", strSMSmessage, strPhoneOne, strName);
                    break;
                case "OnlinePayment":
                    FtPost remotepost = new FtPost();
                    remotepost.Url = "https://www.ftcash.com/app/temp/verifymerchant2.php";

                    string amount = txtBoxCreditAmount.Text;
                    if (amount == "")
                    {
                        //Response.Write("<script>alert('Amount can not be blank !!!')</script>");
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Amount can't be blank !!!')", true);
                        return;
                    }
                    string orderid = "PO" + RandomOrder().ToString();
                    txtBoxorderID.Text = RandomOrder().ToString();

                    //string mid          = "257";                   
                    //string key          = "testNomismaAccount";
                    string mid = "71369";
                    string key = "904625EBA12D8EDF";

                    remotepost.Add("amount", amount);
                    remotepost.Add("orderid", orderid);
                    remotepost.Add("redirect_url", "http://poonamshuklainstitute.in/EduSphere/EduSpherePro/Academy/student");
                    remotepost.Add("mid", mid);

                    var msg = "'" + amount + "''" + orderid + "''" + mid + "'";
                    var hash = remotepost.ComputeHash(key, msg);
                    remotepost.Add("checksum", hash);
                    remotepost.Post();
                    break;
                case "CreditGiftVoucher":
                    //decDebitAmount          = 0;
                    //strConsultantTwoID        = strConsultantOneID;
                    strNotes = "SYSTEM";
                    if (txtBoxVoucherComments.Text != "")
                    {
                        strNotes = txtBoxVoucherComments.Text;
                    }

                    decCreditAmount = Convert.ToInt32(txtBoxGiftVoucherAmount.Text);
                    //Credit Bonus Wallet instead of Member Account
                   // ManageBonusWallet(Convert.ToInt32(strKey), "CreditWallet", decCreditAmount);
                    //strTransactionTrigger   = "VOUCHER-CREDIT";
                    //ObjCmd.Parameters.AddWithValue("@SkuID", 93);
                    //ObjCmd.Parameters.AddWithValue("@DiscountAmount", 0);
                    //ObjCmd.Parameters.AddWithValue("@DebitAmount", 0);
                    //ObjCmd.Parameters.AddWithValue("@CreditAmount", decCreditAmount);
                    //ObjCmd.Parameters.AddWithValue("@TxDate", DateTime.Now);
                    //ObjCmd.Parameters.AddWithValue("@ServiceLocation", "S01");

                    //ObjCmd.Parameters.AddWithValue("@OfferedRate", 0);

                    //ObjCmd.Parameters.AddWithValue("@ConsultantOneID", Convert.ToInt32(strConsultantOneID));
                    //ObjCmd.Parameters.AddWithValue("@ConsultantOneEffortPercentage", Convert.ToDecimal(txtBoxConsultantOneEffort.Text) * decDebitAmount / 100);
                    //ObjCmd.Parameters.AddWithValue("@ConsultantTwoID", Convert.ToInt32(strConsultantTwoID));
                    //ObjCmd.Parameters.AddWithValue("@ConsultantTwoEffortPercentage", Convert.ToDecimal(txtBoxConsultantTwoEffort.Text) * decDebitAmount / 100);
                    //ObjCmd.Parameters.AddWithValue("@ConsultantThreeID", Convert.ToInt32(strConsultantThreeID));
                    //ObjCmd.Parameters.AddWithValue("@ConsultantThreeEffortPercentage", Convert.ToDecimal(txtBoxConsultantThreeEffort.Text) * decDebitAmount / 100);


                    //ObjCmd.Parameters.AddWithValue("@Notes", strNotes);
                    //ObjCmd.Parameters.AddWithValue("@PaymentMode", strPaymentMode);
                    //ObjCmd.Parameters.AddWithValue("@DigitalPaymentRefCode", strDigitalPaymentRefCode);
                    //strTransactionStatus = string.Format("Added reward  {0}", decCreditAmount);
                    //ObjCmd.Parameters.AddWithValue("@NextFollowup", 0);
                    //ObjCmd.Parameters.AddWithValue("@TransactionTrigger", strTransactionTrigger);
                    //send SMS
                    //strSMSmessage = string.Format("Dear {0}, Your Salon Account is rewarded Rs{1}. Thanks, Salon Salon N Academy. Contact us at http://purplesalon.in/Home/Contact ", strName,decCreditAmount);
                    //EC.SendSMS(strPhoneOne, strSMSmessage);
                    //SentMsgLogger("SMS", strSMSmessage, strPhoneOne, strName);//send SMS
                    string strGiftedBy = strNotes;
                    string strMsg = string.Format("Congratulations!,Gift Voucher worth Rs.{0} credited to your Account by {1}", decCreditAmount, strGiftedBy);
                    //EC.SendSMS(strPhoneOne, strSMSmessage);
                    //SMS.SendSmsUsingProvider("SMSGATEWAYHUB",strPhoneOne.Remove(0, 3), strMsg);
                    SMS.SendSmsUsingProvider("KUTILITY", strPhoneOne.Remove(0, 3), strMsg);
                    //SentMsgLogger("SMS", strMsg, strPhoneOne, strName);
                    return;//do not exucute member acoount transaction procedure as its not done in customer account but in Bonus Wallet.
                           //break;
                case "ReceiveRating":
                    //Response.Redirect(string.Format("~/Rating.aspx?id={0}",strKey));
                    //Instead sms the link to customer
                    string strRateRequest = string.Format("How was your experience? Please rate us at http://www.poonamshuklainstitute.in/Rating.aspx?id={0}", strKey);
                    //SMS.SendSmsUsingProvider("SMSGATEWAYHUB", strPhoneOne.Remove(0, 3), strRateRequest);
                    SMS.SendSmsUsingProvider("KUTILITY", strPhoneOne.Remove(0, 3), strRateRequest);
                    return;
                case "AddToKart":
                    Response.Redirect(string.Format("Products.aspx?id={0}", strKey));
                    break;

                default:
                    ObjCmd.Parameters.AddWithValue("@CreditAmount", 0);
                    ObjCmd.Parameters.AddWithValue("@DebitAmount", 0);
                    break;
            }
            BD.UpdateParameters(ObjCmd);
            //Display updated statment with last 5 transactions in descending order, 
            string queryString = string.Format(@"SELECT TOP 5 c.FullName as '{0}',a.TransactionID,s.SkuID,s.SkuTitle,con.FullName as '{1}',a.Notes as '{2}',a.TxDate,a.OfferedRate,a.DiscountAmount,a.DebitAmount,a.CreditAmount,a.PaymentMode,a.DigitalPaymentRefCode,a.BalanceAmount FROM EduSphere.Members c JOIN EduSphere.MemberAccount a ON c.MemberID=a.MemberID JOIN EduSphere.Sku s ON s.SkuID=a.SkuID JOIN EduSphere.Staff con ON con.EmployeeID=a.ConsultantOneID JOIN EduSphere.Staff ref ON ref.EmployeeID=a.ConsultantTwoID where c.MemberID='{3}' order by a.TransactionID desc", "custName", "consName", "Notes", strKey);
            string queryCustomer = string.Format("SELECT * FROM EduSphere.Members WHERE MemberID='{0}'", strKey);

            BD.DataBindToGridView(dgMemberSkuStatement, queryString, "NA");

            //Query for Customer Invoice Summary
            string strInvoiceQ = string.Format(@"SELECT TOP 1 * FROM EduSphere.TaxInvoices i JOIN EduSphere.Members c ON i.MemberID=c.MemberID WHERE i.MemberID={0} AND CAST(InvoiceDate AS DATE)=CAST(GETDATE() AS DATE) ORDER BY TaxInvoiceNumber DESC", strKey);
            BD.DataBindToDataList(dlMemberInvoice, strInvoiceQ);
            //Query for Customer Invoice Details-Services
            string strInvoiceItems = string.Format(@"SELECT SkuTitle,DiscountAmount,CGSTAmount, SGSTAmount,DebitAmount,CreditAmount FROM EduSphere.MemberAccount a JOIN EduSphere.Sku s ON a.SkuID=s.SkuID WHERE MemberID={0}  AND TaxInvoiceNumber=(SELECT Top 1 TaxInvoiceNumber FROM EduSphere.TaxInvoices WHERE MemberID={0} AND CAST(TxDate AS DATE)=CAST(GETDATE() AS DATE) ORDER BY TaxInvoiceNumber DESC)", strKey);
            BD.DataBindToGridView(gvInvoiceDetails, strInvoiceItems, "NA");
            //Query for Customer Invoice Details-Products
            //string strInvoiceItemsProduct = string.Format("SELECT ProductTitle,DiscountAmount,CGSTAmount, SGSTAmount,DebitAmount,CreditAmount FROM EduSphere.ProductSaleTransaction a JOIN EduSphere.Products s ON a.ProductId=s.ProductId WHERE MemberID={0} AND TaxInvoiceNumber=(SELECT Top 1 TaxInvoiceNumber FROM EduSphere.TaxInvoices WHERE MemberID={0} AND CAST(dtOfPurchase AS DATE)=CAST(GETDATE() AS DATE) ORDER BY TaxInvoiceNumber DESC)", strKey);
            //BD.DataBindToGridView(gvInvoiceDetailsProduct, strInvoiceItemsProduct, "NA");

            //Highlight the Account Balance for both Products & Service Account
            string strBalanceQuery = string.Format(@"SELECT SUM(CreditAmount)-SUM(SubTotal) FROM EduSphere.TaxInvoices WHERE MemberID={0}", strKey);
            BD.DataBindToLabel(lblServiceBalance, strBalanceQuery);

            txtBoxDebitAmount.Text = "";
            txtBoxCreditAmount.Text = "";
            //txtBoxDiscountPercentage.Text = "0";

            //Response.Redirect(Request.Url.AbsoluteUri);   //to avoid duplicate POST upon refresh       
        }

        //Service Cancellation and Removal
        protected void dgMemberSkuStatement_RowDataBound(Object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // Hide the delete button when some condition is true
                // for example, deletion allwed for todays service only and for items added rows only
                string strRemarks = DataBinder.Eval(e.Row.DataItem, "Notes").ToString();
                LinkButton lnkBtn_CancelItem = (LinkButton)e.Row.FindControl("lnkBtn_CancelItem");
                DateTime servdt = Convert.ToDateTime(DataBinder.Eval(e.Row.DataItem, "TxDate").ToString());
                if ((strRemarks == "ItemAdded") && (servdt.ToShortDateString() == DateTime.Now.Date.ToShortDateString()))
                {
                    lnkBtn_CancelItem.Visible = true;
                }
                else
                    lnkBtn_CancelItem.Visible = false;

            }
        }


        //InvoiceHistory
        //protected void gvInvoiceHistory_RowCommand(object sender, GridViewCommandEventArgs e)
        //{
        //    //Determine the RowIndex of the Row whose Button was clicked.
        //    int index = Convert.ToInt32(e.CommandArgument);
        //    //Reference the GridView Row.
        //    GridViewRow row = gvInvoiceHistory.Rows[index];
        //    //Fetch value of fileds.
        //    var TaxInvoiceNumber = row.Cells[0].Text;
        //    var InvoiceDate = row.Cells[1].Text;
        //    //ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('InvoiceNumber: " + TaxInvoiceNumber + "\\nDate: " + InvoiceDate + "');", true);
        //    //Query for Student Invoice Summary
        //    string strInvoiceQ = string.Format("SELECT * FROM EduSphere.TaxInvoices i JOIN EduSphere.Members c ON i.MemberID=c.MemberID WHERE i.TaxInvoiceNumber={0}", Convert.ToInt32(TaxInvoiceNumber));
        //    BD.DataBindToDataList(dlStudentInvoice, strInvoiceQ);
        //    //Query for Student Invoice Details
        //    string strInvoiceItems = string.Format("SELECT SkuTitle,DiscountAmount,CGSTAmount, SGSTAmount,DebitAmount,CreditAmount FROM EduSphere.MemberAccount a JOIN EduSphere.Sku s ON a.SkuId=s.SkuId WHERE TaxInvoiceNumber={0}", Convert.ToInt32(TaxInvoiceNumber));
        //    BD.DataBindToGridView(gvInvoiceDetails, strInvoiceItems, "NA");
        //}
        //
        protected int RandomOrder()
        {
            Random random = new Random();
            return random.Next(1, 10000);
        }
        //Manage Panel Visibility
        protected void ManagePnlVisibility(object sender, CommandEventArgs e)
        {
            string strCmdName = e.CommandName.ToString();
            switch (strCmdName)
            {
                case "FromPnlEditPhotoToPnlPersonalDetails":
                    pnlEnroll.Visible = false;
                    pnlPersonalDetails.Visible = false;
                    pnlEditPhoto.Visible = false;
                    pnlMembers.Visible = true;
                    break;
                case "FromPnlPersonalDetailsToPnlStudents":
                    pnlMembers.Visible = true;
                    pnlMemberSummary.Visible = true;
                    pnlPersonalDetails.Visible = false;
                    pnlMemberSkuStatement.Visible = false;
                    break;
                case "FromPnlEnrollToPnlStudents":
                    pnlEnroll.Visible = false;
                    pnlMembers.Visible = true;
                    pnlMemberSummary.Visible = true;
                    pnlPersonalDetails.Visible = false;
                    pnlMemberSkuStatement.Visible = false;
                    pnlCompletedSku.Visible = false;
                    break;
                case "FromPnlMemberFeeStatementToPnlStudents":
                    pnlMembers.Visible = true;
                    pnlMemberSummary.Visible = true;
                    pnlEnroll.Visible = false;
                    pnlPersonalDetails.Visible = false;
                    pnlMemberSkuStatement.Visible = false;
                    pnlSentMessageHistory.Visible = false;
                    pnlCompletedSku.Visible = false;
                    break;
                case "FromPnlCompletedFeesToPnlStudents":
                    pnlMembers.Visible = true;
                    pnlMemberSummary.Visible = true;
                    pnlCompletedSku.Visible = false;
                    break;
            }

        }

        //Delete a Student record
        protected void DeleteStudent(string strKey)
        {
            string strKeyStudentId = strKey;
            SqlCommand ObjCmd = new SqlCommand("spDeleteStudent", BD.ObjCn);
            ObjCmd.CommandType = CommandType.StoredProcedure;
            ObjCmd.Parameters.AddWithValue("@MemberID", strKeyStudentId);
            BD.UpdateParameters(ObjCmd);
            //Refresh
        }

        //Fill New Student details
        protected void EnrolNewStudent(object sender, CommandEventArgs e)
        {
            pnlMemberSummary.Visible = false;
            pnlPersonalDetails.Visible = false;
            pnlMembers.Visible = false;
            pnlMemberSkuStatement.Visible = false;
            pnlEnroll.Visible = true;
            //pnlViewEnquiries.Visible = false;
            pnlSentMessageHistory.Visible = false;
            pnlCompletedSku.Visible = false;
            pnlSkuReminders.Visible = false;
            pnlGreetings.Visible = false;

            string strCmd = string.Format("SELECT ProgramId,ProgramTitle FROM EduSphere.Programs");
            BD.DataBindToDropDownList(ddlMembershipType, strCmd);
            // BD.DataBindToDropDownList(ddlFeeEnquiry2, strCmd);
            // BD.DataBindToDropDownList(ddlFeeEnquiry3, strCmd);            
            txtBoxFirstName.Text = "";
            txtBoxLastName.Text = "";
            txtBoxPhoneOne.Text = "";
            txtBoxPhoneTwo.Text = "";
            txtBoxEmail.Text = "";
            txtBoxDateOfBirth.Text = "dd/mm/yyyy";
            txtBoxAnniversary.Text = "dd/mm/yyyy";
            txtBoxAddress.Text = "";
            txtBoxRemarks.Text = "";
        }

        //Insert New Student Details
        protected void InsertStudentDetails(object sender, CommandEventArgs e)
        {
            DateTime dtDateOfBirth;
            DateTime dtAnniversary;

            string strFirstName = txtBoxFirstName.Text;
            string strLastName = txtBoxLastName.Text;
            string strPhoneOne = string.Format("+91" + txtBoxPhoneOne.Text);
            string strPhoneTwo = string.Format("+91" + txtBoxPhoneTwo.Text);
            string strEmail = txtBoxEmail.Text;
            string strAddress = txtBoxAddress.Text;
            if (chkBoxDateOfBirth.Checked)
            {
                dtDateOfBirth = DateTime.ParseExact("01/01/1900", "dd/MM/yyyy", CultureInfo.InvariantCulture);
            }
            else
            {
                dtDateOfBirth = DateTime.ParseExact(txtBoxDateOfBirth.Text.ToString(), "dd/MM/yyyy", CultureInfo.InvariantCulture);
            }
            if (chkBoxAnnivarsaryDate.Checked)
            {
                dtAnniversary = DateTime.ParseExact("01/01/1900", "dd/MM/yyyy", CultureInfo.InvariantCulture);
            }
            else
            {
                // Format your DateTime
                dtAnniversary = DateTime.ParseExact(txtBoxAnniversary.Text.ToString(), "dd/MM/yyyy", CultureInfo.InvariantCulture);

            }
            string strNotify = "NO";
            if (chkBoxNotify.Checked) strNotify = "YES";

            string strRemarks = txtBoxRemarks.Text;
            //string strRemarks = ddlFeeEnquiry1.SelectedItem + ","+ ddlFeeEnquiry2.SelectedItem + "," + ddlFeeEnquiry3.SelectedItem;
            SqlCommand ObjCmd = new SqlCommand("spInsertStudentDetails", BD.ObjCn);
            ObjCmd.CommandType = CommandType.StoredProcedure;

            ObjCmd.Parameters.AddWithValue("@FullName", strFirstName);
            ObjCmd.Parameters.AddWithValue("@Gender", strLastName);
            ObjCmd.Parameters.AddWithValue("@CurrentAcadStatus", ddlAcadStatus.SelectedValue.ToString());
            ObjCmd.Parameters.AddWithValue("@Section", ddlSection.SelectedValue.ToString());
            ObjCmd.Parameters.AddWithValue("@PhoneOne", strPhoneOne);
            ObjCmd.Parameters.AddWithValue("@PhoneTwo", strPhoneTwo);
            ObjCmd.Parameters.AddWithValue("@Email", strEmail);
            ObjCmd.Parameters.AddWithValue("@ResidenceAddress", strAddress);
            ObjCmd.Parameters.AddWithValue("@DateOfBirth", dtDateOfBirth);
            ObjCmd.Parameters.AddWithValue("@ProgramID", Convert.ToInt32(ddlMembershipType.SelectedValue.ToString()));
            ObjCmd.Parameters.AddWithValue("@MembershipExpiringDate", DateTime.ParseExact(txtBoxMemExpDate.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture));
            ObjCmd.Parameters.AddWithValue("@Anniversary", dtAnniversary);
            ObjCmd.Parameters.AddWithValue("@MemberPhoto", "~/Images/Member.jpg");
            ObjCmd.Parameters.AddWithValue("@SkuId", 90);//The proxy service ID for account creation
            ObjCmd.Parameters.AddWithValue("@Remarks", strRemarks);
            ObjCmd.Parameters.AddWithValue("@Notify", strNotify);
            BD.UpdateParameters(ObjCmd);

            lblMembersAction.Text = "Enrolled Successfully !!!";
            //send Welcome Message to Student
            Response.Redirect("Students.aspx");
            if (strNotify == "YES")
            {

                //SmsFee SMS = new SmsFee();
                //string strSMSmessage = string.Format("Dear '{0}, Thanks for visiting Our Operations !!!", strFirstName);
                //EC.SendSMS(strPhoneOne, strSMSmessage);
                //SMS.SendSms(strPhoneOne, strSMSmessage);
                //SentMsgLogger("SMS", strSMSmessage, strPhoneOne, strFirstName);
            }

        }

        //Not used in Operations instead dlPersonalDetailsUpdateHandler is used
        protected void UpdatePersonalDetails(string strStudentId, DataListCommandEventArgs e)
        {
            string spName, strMembershipType, strSection, strFullName, strGender, strFather, strMother, strGuardian, strCurrentAcadYear, strCurrentAcadSem;

            DateTime strYearOfAdmission, dtDateOfBirth;
            spName = "spUpdateStudentsDetails";
            DropDownList ddlEdiBatchID  = (DropDownList)e.Item.FindControl("ddlEdiBatchID");
            int intBatchID              = Convert.ToInt32(ddlEdiBatchID.SelectedValue.ToString());

            strMembershipType           = ((DropDownList)e.Item.FindControl("ddlEditMembershipType")).SelectedValue.ToString();
            //strYearOfAdmission           = DateTime.Parse(((TextBox)(e.Item.FindControl("txtBoxYearOfAdmission"))).Text);
            strFullName                 = ((TextBox)(e.Item.FindControl("txtBoxFullName"))).Text;
            strGender                   = ((TextBox)(e.Item.FindControl("txtBoxGender"))).Text;
            dtDateOfBirth               = DateTime.Parse(((TextBox)(e.Item.FindControl("txtBoxDateOfBirth"))).Text);

            //string dob      = dtDateOfBirth.ToString("mmm dd, yyyy");
            //dob                     = (DateTime.Parse(dob)).ToString("mm/dd/yyyy");   
            //strFather = ((TextBox)(e.Item.FindControl("txtBoxFather"))).Text;
            //strMother = ((TextBox)(e.Item.FindControl("txtBoxMother"))).Text;
            //strGuardian = ((TextBox)(e.Item.FindControl("txtBoxGuardian"))).Text;
            strCurrentAcadYear = ((DropDownList)e.Item.FindControl("ddlAcadYr")).SelectedValue;
            strCurrentAcadSem = ((DropDownList)e.Item.FindControl("ddlAcadSem")).SelectedValue;


            SqlCommand ObjCmd = new SqlCommand(spName, BD.ObjCn);

            ObjCmd.CommandType = CommandType.StoredProcedure;
            ObjCmd.Parameters.AddWithValue("@MemberID", strStudentId);
            ObjCmd.Parameters.AddWithValue("@BatchID", intBatchID);
            ObjCmd.Parameters.AddWithValue("@MembershipType", strMembershipType);
            //ObjCmd.Parameters.AddWithValue("@YearOfAdmission", strYearOfAdmission);
            ObjCmd.Parameters.AddWithValue("@FullName", strFullName);
            ObjCmd.Parameters.AddWithValue("@Gender", strGender);
            ObjCmd.Parameters.AddWithValue("@DateOfBirth", dtDateOfBirth);
            //ObjCmd.Parameters.AddWithValue("@Father", strFather);
            //ObjCmd.Parameters.AddWithValue("@Mother", strMother);
            //ObjCmd.Parameters.AddWithValue("@Guardian", strGuardian);
            //ObjCmd.Parameters.AddWithValue("@CurrentAcadYear", strCurrentAcadYear);
            //ObjCmd.Parameters.AddWithValue("@CurrentAcadSem", strCurrentAcadSem);
            BD.UpdateParameters(ObjCmd);

            pnlMemberSummary.Visible = true;
            pnlMembers.Visible = true;
        }

        //Insert dummy photos while enrolling new Student
        protected void AddDummyPhotos(string strStudentId)
        {
            SqlCommand ObjCmd = new SqlCommand("spInsertPhoto", BD.ObjCn);
            ObjCmd.CommandType = CommandType.StoredProcedure;
            ObjCmd.Parameters.AddWithValue("@MemberID", strStudentId);
            BD.UpdateParameters(ObjCmd);
        }

        //Insert dummy contacts while enrolling new Student
        protected void AddDummyContacts(string strStudentId)
        {
            SqlCommand ObjCmd = new SqlCommand("spInsertContacts", BD.ObjCn);
            ObjCmd.CommandType = CommandType.StoredProcedure;
            ObjCmd.Parameters.AddWithValue("@MemberID", strStudentId);
            BD.UpdateParameters(ObjCmd);
        }

        //Edit Personal Contacts
        protected void Edit_PersonalDetails(object sender, CommandEventArgs e)
        {
            string strStudentId = e.CommandArgument.ToString();
            string strPhotoName = e.CommandName.ToString();
            pnlEnroll.Visible = false;
            pnlPersonalDetails.Visible = false;
            pnlEditPhoto.Visible = true;
            pnlMembers.Visible = false;
            pnlSentMessageHistory.Visible = false;
            lblStudentId.Text = strStudentId;
            lblPhotoName.Text = strPhotoName;
        }

        //Edit Student Personal Details
        protected void dlPersonalDetailsEditHandler(object sender, DataListCommandEventArgs e)
        {
            //Hide Messaging Pannel
            pnlSendMsg.Visible = false; //Hide Message panel on edit

            dlPersonalDetails.EditItemIndex = e.Item.ItemIndex;
            string strStudentId = Convert.ToString(dlPersonalDetails.DataKeys[e.Item.ItemIndex]);
            string queryString = string.Format("SELECT * FROM EduSphere.Members WHERE MemberID='{0}'", strStudentId);

            BD.DataBindToDataList(dlPersonalDetails, queryString);
            UpdateNotifyCheckBoxStatus();
            //Diplay Membership types for editing
            DropDownList ddlEditProgram = new DropDownList();
            DropDownList ddlEditBatchCode = new DropDownList();
            DropDownList ddlEditEducationCentre = new DropDownList();
            foreach (DataListItem dlitem in dlPersonalDetails.Items)
            {
                ddlEditProgram = (DropDownList)dlitem.FindControl("ddlEditProgram");
                ddlEditBatchCode = (DropDownList)dlitem.FindControl("ddlEditBatchCode");
                ddlEditEducationCentre = (DropDownList)dlitem.FindControl("ddlEditEducationCentre");
            }
            BD.DataBindToDropDownList(ddlEditProgram, "SELECT ProgramTitle,ProgramID FROM EduSphere.Programs");
            BD.DataBindToDropDownList(ddlEditBatchCode, "SELECT BatchID,BatchCode FROM EduSphere.ProgramBatch");
            BD.DataBindToDropDownList(ddlEditEducationCentre, "SELECT OrganizationID,OrganizationName FROM EduSphere.Organizations WHERE OrganizationType='EDUCATION-CENTRE'");
        }

        //Cancel Editing Student personal editor
        protected void dlPersonalDetailsCancelHandler(object sender, DataListCommandEventArgs e)
        {
            pnlSendMsg.Visible = true; //display Message panel on edit cancel
            dlPersonalDetails.EditItemIndex = -1;
            string strStudentId = Convert.ToString(dlPersonalDetails.DataKeys[e.Item.ItemIndex]);
            string queryString = string.Format("SELECT * FROM EduSphere.Members c JOIN EduSphere.Programs m ON c.ProgramID=m.ProgramID WHERE MemberID='{0}'", strStudentId);
            BD.DataBindToDataList(dlPersonalDetails, queryString);

            //pnlEnroll.Visible           = false;
            pnlPersonalDetails.Visible = false;
            pnlMembers.Visible = true;

        }

        //Update Student Personal Details. It first updates contact and then updates personal details
        protected void dlPersonalDetailsUpdateHandler(object sender, DataListCommandEventArgs e)
        {
            //string strNotify;

            pnlSendMsg.Visible = true; //Hide Message panel while editing
            //Update contact details
            string strStudentId             = dlPersonalDetails.DataKeys[e.Item.ItemIndex].ToString();
            string strFullName              = ((TextBox)(e.Item.FindControl("txtBoxFullName"))).Text;
            string strGender                = ((TextBox)(e.Item.FindControl("txtBoxGender"))).Text;
            string strMembershipType        = ((DropDownList)e.Item.FindControl("ddlEditMembershipType")).SelectedValue.ToString();
            string strMaritalStatus         = ((DropDownList)e.Item.FindControl("ddlEditMaritalStatus")).SelectedValue.ToString();
            int intBatchID                  = Convert.ToInt32(((DropDownList)e.Item.FindControl("ddlEditBatchCode")).SelectedValue.ToString());
            int intOrgID                    = Convert.ToInt32(((DropDownList)e.Item.FindControl("ddlEditEducationCentre")).SelectedValue.ToString());
            string strPhoneOne              = ((TextBox)(e.Item.FindControl("txtBoxPhoneOne"))).Text;
            string strPhoneTwo              = ((TextBox)(e.Item.FindControl("txtBoxPhoneTwo"))).Text;
            string strEmail                 = ((TextBox)e.Item.FindControl("txtBoxEmail")).Text;
            
            string strDOB                   = ((TextBox)e.Item.FindControl("txtBoxDateOfBirth")).Text.ToString();
            string strAn                    = ((TextBox)e.Item.FindControl("txtBoxAnniversary")).Text.ToString();
            string strExpCompletion         = ((TextBox)e.Item.FindControl("txtBoxEditExpCompletion")).Text.ToString();
            DateTime dtDateOfBirth          = DateTime.ParseExact(strDOB, "dd/MM/yyyy", CultureInfo.InvariantCulture);
            DateTime dtAnniversary          = DateTime.ParseExact(strAn, "dd/MM/yyyy", CultureInfo.InvariantCulture);
            DateTime dtExpCompletion        = DateTime.ParseExact(strExpCompletion, "dd/MM/yyyy", CultureInfo.InvariantCulture);
            string strRemarks               = ((TextBox)(e.Item.FindControl("txtBoxRemarks"))).Text;
            int intProgramId                = Convert.ToInt32(((DropDownList)e.Item.FindControl("ddlEditProgram")).SelectedValue.ToString());
                       
            SqlCommand ObjCmd = new SqlCommand("spUpdateStudentDetails", BD.ObjCn);
            ObjCmd.CommandType = CommandType.StoredProcedure;
            ObjCmd.Parameters.AddWithValue("@MemberID", strStudentId);
            ObjCmd.Parameters.AddWithValue("@FullName", strFullName);
            ObjCmd.Parameters.AddWithValue("@Gender", strGender);
            ObjCmd.Parameters.AddWithValue("@MaritalStatus", strMaritalStatus);
            ObjCmd.Parameters.AddWithValue("@MembershipType", strMembershipType);
            ObjCmd.Parameters.AddWithValue("@OrganizationID", intOrgID);
            ObjCmd.Parameters.AddWithValue("@BatchID", intBatchID);
            ObjCmd.Parameters.AddWithValue("@PhoneOne", strPhoneOne);
            ObjCmd.Parameters.AddWithValue("@PhoneTwo", strPhoneTwo);
            ObjCmd.Parameters.AddWithValue("@Email", strEmail);
            //ObjCmd.Parameters.AddWithValue("@ResidenceAdress", strAdress);
            ObjCmd.Parameters.AddWithValue("@DateOfBirth", dtDateOfBirth);
            ObjCmd.Parameters.AddWithValue("@Anniversary", dtAnniversary);
            ObjCmd.Parameters.AddWithValue("@Remarks", strRemarks);
            //ObjCmd.Parameters.AddWithValue("@Notify", strNotify);
            ObjCmd.Parameters.AddWithValue("@ProgramID", intProgramId);
            ObjCmd.Parameters.AddWithValue("@MembershipExpiryDate", dtExpCompletion);
            BD.UpdateParameters(ObjCmd);
            //Bind the datalist with new values
            //string queryString = string.Format("SELECT * FROM EduSphere.Members WHERE MemberID='{0}'", strStudentId);
            //BD.DataBindToDataList(dlPersonalDetails, queryString);
            //UpdateNotifyCheckBoxStatus();//keep tick status as per Notify value(YES, NO)
            Response.Redirect("Students.aspx");
        }

        //Get path name
        protected void UploadPhoto(object sender, EventArgs e)
        {
            pnlEnroll.Visible = false;
            pnlPersonalDetails.Visible = false;
            pnlEditPhoto.Visible = true;
            pnlMembers.Visible = false;

            if (fileUpload.HasFile)
            {
                //Create a path to save the file
                string filename = Path.Combine(HttpContext.Current.Server.MapPath("~/Images"), fileUpload.FileName);

                //Display File path in text box for record insertion
                txtBoxPhotoPath.Text = string.Format("~/Images/" + fileUpload.FileName);
                //Save the file to our local path
                fileUpload.SaveAs(filename);
                //Response.Write(fileUpload.FileName + " - " + fileUpload.PostedFile.ContentLength + " Bytes. <br />");

            }
            //txtBoxPhotoPath.Text = string.Format("~/Images/" + fileUpload.FileName);

        }
        //Update table
        protected void DoneEditing(object sender, CommandEventArgs e)
        {
            string strPath = txtBoxPhotoPath.Text;
            string strStudentId = lblStudentId.Text;
            string strPhotoName = lblPhotoName.Text;

            string strSp;
            switch (strPhotoName)
            {
                case "Student":
                    strSp = "spUpdateStudentPhoto";
                    break;
                case "Father":
                    strSp = "spUpdateFatherPhoto";
                    break;
                case "Mother":
                    strSp = "spUpdateMotherPhoto";
                    break;
                case "Guardian":
                    strSp = "spUpdateGuardianPhoto";
                    break;
                default:
                    strSp = "";
                    break;

            }
            SqlCommand ObjCmd = new SqlCommand(strSp, BD.ObjCn);

            ObjCmd.CommandType = CommandType.StoredProcedure;
            ObjCmd.Parameters.AddWithValue("@MemberID", strStudentId);
            ObjCmd.Parameters.AddWithValue("@MemberPhoto", strPath);
            BD.UpdateParameters(ObjCmd);

        }

        //Accecpts sql query and return html table string
        private string QueryToHtmlTable(string query, string[] tblheader)
        {
            string salonName = "TIME MACHINE BEAUTY SOLUTIONS PRIVATE LIMITED";
            string address = "Bombay Annexe Building, Shop No.34-27, Sector-17, Vashi, Navi Mumbai";
            string GstNo = "27AAFCT7807E1Z9";
            string StateName = "Maharashtra";
            string Code = "27";
            string CIN = "U74999MH2016PTC282130";
            string phone = "+91 22";
            string Email = "admin@mmtimemachine.com";

            SqlCommand cmd = new SqlCommand(query, BD.ObjCn);
            DataTable dt = new DataTable();
            dt = BD.GetDataTable(cmd);
            using (StringWriter sw = new StringWriter())
            {
                using (HtmlTextWriter hw = new HtmlTextWriter(sw))
                {
                    StringBuilder sb = new StringBuilder();
                    //Generate Detailed Invoice (Bill) Header.
                    sb.Append("<table width='100%' class='table table - striped table - bordered'  cellspacing='0' cellpadding='2'>");
                    //sb.Append("<table width='100%' class='table  table-bordered table-hover'>");
                    sb.Append("<tr><td align='center' style='background-color: #18B5F0' colspan = '2'><b>INVOICE</b></td></tr>");
                    sb.Append("<tr><td colspan = '2'></td></tr>");
                    sb.Append("<tr><td><b>Invoice No: </b>");
                    sb.Append(tblheader[0].ToString());
                    sb.Append("</td><td align = 'right'><b>Date: </b>");
                    sb.Append(tblheader[1].ToString());
                    sb.Append(" </td></tr>");
                    sb.Append("<tr><td colspan = '2'><b>Centre : </b>");
                    sb.Append(salonName);
                    sb.Append("</td></tr>");
                    sb.Append("<tr><td colspan = '2'><b>Address : </b>");
                    sb.Append(address);
                    sb.Append("</td></tr>");

                    sb.Append("<tr><td colspan = '2'><b>GSTIN/UIN : </b>");
                    sb.Append(GstNo);
                    sb.Append("</td></tr>");
                    sb.Append("<tr><td colspan = '2'><b>StateName : </b>");
                    sb.Append(StateName);
                    sb.Append("</td></tr>");
                    sb.Append("<tr><td colspan = '2'><b>Code : </b>");
                    sb.Append(Code);
                    sb.Append("</td></tr>");
                    sb.Append("<tr><td colspan = '2'><b>CIN : </b>");
                    sb.Append(CIN);
                    sb.Append("</td></tr>");
                    sb.Append("<tr><td colspan = '2'><b>Email : </b>");
                    sb.Append(Email);
                    sb.Append("</td></tr>");

                    sb.Append("<tr><td colspan = '2'><b>Phone : </b>");
                    sb.Append(phone);
                    sb.Append("</td></tr>");
                    sb.Append("<tr><td><b>Student Name :</b>");
                    sb.Append(tblheader[2].ToString());
                    sb.Append("</td></tr>");
                    sb.Append("</table>");
                    sb.Append("<br />");
                    //sb.Append("<hr />");

                    //Generate Invoice (Bill) Items Grid.
                    sb.Append("<table border = '1'>");
                    sb.Append("<tr>");
                    foreach (DataColumn column in dt.Columns)
                    {
                        sb.Append("<th>");
                        sb.Append(column.ColumnName);
                        //sb.Append("<hr />");
                        sb.Append("</th>");
                    }
                    sb.Append("</tr>");
                    foreach (DataRow row in dt.Rows)
                    {
                        sb.Append("<tr>");
                        foreach (DataColumn column in dt.Columns)
                        {
                            sb.Append("<td>");
                            sb.Append(row[column]);
                            //sb.Append("<hr />");
                            sb.Append("</td>");
                        }
                        sb.Append("</tr>");
                    }

                    sb.Append("<tr><td align = 'right' colspan = '");
                    sb.Append(dt.Columns.Count - 1);
                    sb.Append("'>Total Savings :</td>");
                    sb.Append("<td>");
                    sb.Append(dt.Compute("sum(DISC)", ""));
                    sb.Append("</td>");
                    sb.Append("<td colspan='2'>");
                    sb.Append("Total Bill :</td>");
                    sb.Append("<td>");
                    sb.Append(dt.Compute("sum(BILL)", ""));
                    sb.Append("</td>");
                    sb.Append("</tr></table>");
                    return sb.ToString();
                }
            }
        }

        //Print Invoice Using Service
        protected void PrintInvoiceService(object sender, CommandEventArgs e)
        {
            string[] cmdArgs = new string[4];
            cmdArgs = e.CommandArgument.ToString().Split(';');
            int intTaxInvoiceNumber = Convert.ToInt32(cmdArgs[0].ToString());
            string InvoiceDate = cmdArgs[1].ToString();
            string Name = cmdArgs[2].ToString();
            PG.ProductInvoice(intTaxInvoiceNumber);

        }

        //Generates pdf file Invoice.
        protected void PrintInvoice(object sender, CommandEventArgs e)
        {
            //Header data for Invoice (Bill).
            string companyName = "TIME MACHINE BEAUTY SOLUTIONS PRIVATE LIMITED";
            string address = "Bombay Annexe Building, Shop No.34-27, Sector-17, Vashi, Navi Mumbai";
            string GstNo = "27AAFCT7807E1Z9";
            string StateName = "Maharashtra";
            string Code = "27";
            string CIN = "U74999MH2016PTC282130";
            string phone = "+91 22 2788 2020 / 0101 ";
            string Email = "admin@mmtimemachine.com";

            string[] cmdArgs = new string[4];
            cmdArgs = e.CommandArgument.ToString().Split(';');
            int intStudentTaxInvoiceNumber = Convert.ToInt32(cmdArgs[0].ToString());
            string InvoiceDate = cmdArgs[1].ToString();
            string Name = cmdArgs[2].ToString();
            string qInvoiceDetails = string.Format(@"SELECT SkuTitle AS Item,DiscountAmount AS DISC,CGSTAmount AS CGST, SGSTAmount AS SGST,DebitAmount AS BILL,CreditAmount AS PAID 
                                                           FROM EduSphere.MemberAccount a 
                                                           JOIN EduSphere.Sku s ON a.SkuId=s.SkuId 
                                                           JOIN EduSphere.Members c ON a.MemberID=c.MemberID
                                                           WHERE TaxInvoiceNumber ={0}", intStudentTaxInvoiceNumber);
            SqlCommand cmd = new SqlCommand(qInvoiceDetails, BD.ObjCn);
            int orderNo = intStudentTaxInvoiceNumber;
            DataTable dt = new DataTable();
            dt = BD.GetDataTable(cmd);
            using (StringWriter sw = new StringWriter())
            {
                using (HtmlTextWriter hw = new HtmlTextWriter(sw))
                {
                    StringBuilder sb = new StringBuilder();

                    //Generate Detailed Invoice (Bill) Header.
                    //sb.Append("<table width='100%' class='table table - striped table - bordered'  cellspacing='0' cellpadding='2'>");
                    sb.Append("<table width='100%' class='table  table-bordered table-hover'>");
                    sb.Append("<tr><td align='center' style='background-color: #18B5F0' colspan = '2'><b>INVOICE</b></td></tr>");
                    sb.Append("<tr><td colspan = '2'></td></tr>");
                    sb.Append("<tr><td><b>Invoice No: </b>");
                    sb.Append(intStudentTaxInvoiceNumber);
                    sb.Append("</td><td align = 'right'><b>Date: </b>");
                    sb.Append(InvoiceDate);
                    sb.Append(" </td></tr>");
                    sb.Append("<tr><td colspan = '2'><b>Centre : </b>");
                    sb.Append(companyName);
                    sb.Append("</td></tr>");
                    sb.Append("<tr><td colspan = '2'><b>Address : </b>");
                    sb.Append(address);
                    sb.Append("</td></tr>");

                    sb.Append("<tr><td colspan = '2'><b>GSTIN/UIN : </b>");
                    sb.Append(GstNo);
                    sb.Append("</td></tr>");
                    sb.Append("<tr><td colspan = '2'><b>StateName : </b>");
                    sb.Append(StateName);
                    sb.Append("</td></tr>");
                    sb.Append("<tr><td colspan = '2'><b>Code : </b>");
                    sb.Append(Code);
                    sb.Append("</td></tr>");
                    sb.Append("<tr><td colspan = '2'><b>CIN : </b>");
                    sb.Append(CIN);
                    sb.Append("</td></tr>");
                    sb.Append("<tr><td colspan = '2'><b>Email : </b>");
                    sb.Append(Email);
                    sb.Append("</td></tr>");


                    sb.Append("<tr><td colspan = '2'><b>Phone : </b>");
                    sb.Append(phone);
                    sb.Append("</td></tr>");
                    sb.Append("<tr><td><b>Student Name   :</b>");
                    sb.Append(Name);
                    sb.Append("</td></tr>");
                    sb.Append("</table>");
                    sb.Append("<br />");
                    //sb.Append("<hr />");

                    //Generate Invoice (Bill) Items Grid.
                    sb.Append("<table border = '1'>");
                    sb.Append("<tr>");
                    foreach (DataColumn column in dt.Columns)
                    {
                        sb.Append("<th>");
                        sb.Append(column.ColumnName);
                        sb.Append("<hr />");
                        sb.Append("</th>");
                    }
                    sb.Append("</tr>");
                    foreach (DataRow row in dt.Rows)
                    {
                        sb.Append("<tr>");
                        foreach (DataColumn column in dt.Columns)
                        {
                            sb.Append("<td>");
                            sb.Append(row[column]);
                            sb.Append("<hr />");
                            sb.Append("</td>");
                        }
                        sb.Append("</tr>");
                    }

                    sb.Append("<tr><td align = 'right' colspan = '");
                    sb.Append(dt.Columns.Count - 1);
                    sb.Append("'>Total Savings :</td>");
                    sb.Append("<td>");
                    sb.Append(dt.Compute("sum(DISC)", ""));
                    sb.Append("</td>");

                    sb.Append("<td colspan='2'>");
                    sb.Append("Total Bill :</td>");
                    sb.Append("<td>");
                    sb.Append(dt.Compute("sum(BILL)", ""));
                    sb.Append("</td>");
                    sb.Append("</tr></table>");

                    //Export HTML String as PDF.
                    StringReader sr = new StringReader(sb.ToString());
                    Document pdfDoc = new Document(PageSize.A4, 10f, 10f, 10f, 0f);
                    //HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
                    PdfWriter writer = PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
                    pdfDoc.Open();
                    //htmlparser.Parse(sr);
                    XMLWorkerHelper.GetInstance().ParseXHtml(writer, pdfDoc, sr);
                    pdfDoc.Close();
                    Response.ContentType = "application/pdf";
                    Response.AddHeader("content-disposition", "attachment;filename=Invoice_" + orderNo + ".pdf");
                    Response.Cache.SetCacheability(HttpCacheability.NoCache);
                    Response.Write(pdfDoc);
                    Response.End();
                }
            }
        }

        //Email the Invoice
        protected void EmailInvoice(object sender, CommandEventArgs e)
        {
            string[] cmdArgs = new string[4];
            cmdArgs = e.CommandArgument.ToString().Split(';');
            int intStudentTaxInvoiceNumber = Convert.ToInt32(cmdArgs[0].ToString());
            string InvoiceDate = cmdArgs[1].ToString();
            string Name = cmdArgs[2].ToString();
            string ToEmail = cmdArgs[3].ToString();
            string qInvItems = string.Format(@"SELECT SkuTitle AS Item,DiscountAmount AS DISC,CGSTAmount AS CGST, SGSTAmount AS SGST,DebitAmount AS BILL,CreditAmount AS PAID 
                                                           FROM EduSphere.MemberAccount a 
                                                           JOIN EduSphere.Sku s ON a.SkuId=s.SkuId 
                                                           JOIN EduSphere.Members c ON a.MemberID=c.MemberID
                                                           WHERE TaxInvoiceNumber ={0}", intStudentTaxInvoiceNumber);

            string strInvItems = QueryToHtmlTable(qInvItems, cmdArgs); //Get Querty Table converted to string
            MAIL.SendMailHtml("edusphere.alert@gmail.com", ToEmail, intStudentTaxInvoiceNumber.ToString(), strInvItems);
        }

        //SMSInvoice
        protected void SMSInvoice(object sender, CommandEventArgs e)
        {
            int intStudentTaxInvoiceNumber = Convert.ToInt32(e.CommandArgument.ToString());
            string queryInvoice = string.Format(@"SELECT a.MemberID,FullName,PhoneOne,Email,SUM(DiscountAmount) AS SAVINGS,SUM(DebitAmount) AS TotalBill,SUM(CGSTAmount) AS CGST,SUM(SGSTAmount) AS SGST,Sum(CreditAmount) AS PaidAmount
                                                        FROM EduSphere.MemberAccount a JOIN EduSphere.Members c ON a.MemberID = c.MemberID
                                                        WHERE TaxInvoiceNumber ={0} GROUP BY a.MemberID, FullName, PhoneOne, Email", intStudentTaxInvoiceNumber);
            SqlCommand cmd = new SqlCommand(queryInvoice, BD.ObjCn);
            DataTable inv = new DataTable();
            inv = BD.GetDataTable(cmd);
            string strFirstname = inv.Rows[0]["FullName"].ToString();

            string strPhoneOne = inv.Rows[0]["PhoneOne"].ToString();
            //take out +91 from Phone Number
            strPhoneOne = strPhoneOne.Remove(0, 3);

            string strSavings = inv.Rows[0]["Savings"].ToString();
            string strTotalBill = inv.Rows[0]["TotalBill"].ToString();
            string strCGST = inv.Rows[0]["CGST"].ToString();
            string strSGST = inv.Rows[0]["SGST"].ToString();
            string strPaidAmount = inv.Rows[0]["PaidAmount"].ToString();
            string strMsg = string.Format(@"NAME:{0} INV_NO:{1}, DISC:{2}, BILL:{3}, CGST:{4}, SGST:{5}, PAID :{6}", strFirstname, intStudentTaxInvoiceNumber, strSavings, strTotalBill, strCGST, strSGST, strPaidAmount);
            SMS.SendSmsUsingProvider("SMSGATEWAYHUB", strPhoneOne, strMsg);
        }

        //NewInvoice
        protected void GenerateNewInvoiceNumber(object sender, CommandEventArgs e)
        {
            int intMemberId = Convert.ToInt32(e.CommandArgument.ToString());

            SqlCommand ObjCmd = new SqlCommand("spGenerateNewInvoiceNumber", BD.ObjCn);
            ObjCmd.CommandType = CommandType.StoredProcedure;
            ObjCmd.Parameters.AddWithValue("@MemberId", intMemberId);
            ObjCmd.Parameters.AddWithValue("@ConsultantOneID", 90);
            ObjCmd.Parameters.AddWithValue("@LocationId", 90);
            BD.UpdateParameters(ObjCmd);
            //Refresh Invoice 
            PerformBilling(intMemberId.ToString());
        }

        //send SMS
        protected void SendSmsToStudent(object sender, CommandEventArgs e)
        {
            //SmsFee SMS = new SmsFee();
            //Extract two argument supplied in CommanfArguments
            string[] cmdArg = new string[3];
            cmdArg = e.CommandArgument.ToString().Split(';');

            string ToPhoneNumber, strSub, strBody, cmdName, FullName;
            //cmdArg            = e.CommandArgument.ToStriPurpleng();
            cmdName = e.CommandName.ToString();

            ToPhoneNumber = cmdArg[0].ToString();
            FullName = cmdArg[1].ToString();
            strSub = txtBoxSubject.Text;
            strBody = txtBoxBody.Text;

            switch (cmdName)
            {
                case "UnicastStudentSms":
                    //lblSentStatus.Text = SMS.SendSms(ToPhoneNumber, strSub + ":" + strBody + "Thanks, SJA", "T");
                    string strMsg = strSub + ":" + strBody;
                    SMS.SendSmsUsingProvider("SMSGATEWAYHUB", ToPhoneNumber, strMsg);
                    break;
                case "UnicastStudentFeedback":
                    int intBillNumber = Convert.ToInt32(cmdArg[2].ToString());
                    strBody = string.Format("Dear {0}, SJA requested a review of their work. Please use {1} as ID while filling submitting review. Please review at http://purplesalon.in/home/review", FullName, intBillNumber);
                    //SMS.SendSms(ToPhoneNumber, strBody, "T");
                    SMS.SendSmsUsingProvider("SMSGATEWAYHUB", ToPhoneNumber, strBody);
                    break;

                default:
                    break;
            }
            //SentMsgLogger("SMS", "Sub:" + strSub + "  Msg:" + strBody, ToPhoneNumber, FullName);

        }//end SendSmsToStudent

        //send email
        protected void SendEmailToStudent(object sender, CommandEventArgs e)
        {
            //MailFee MAIL = new MailFee();
            string strToEmail, strSub, strBody, cmdName, strFirstName;
            //extract two argument present in e.CommandAruments
            string[] cmdArg = new string[2];
            cmdArg = e.CommandArgument.ToString().Split(';');

            strToEmail = cmdArg[0].ToString();
            strFirstName = cmdArg[1].ToString();
            cmdName = e.CommandName.ToString();
            strSub = txtBoxSubject.Text;
            strBody = txtBoxBody.Text;
            switch (cmdName)
            {
                case "UnicastStudentEmail":
                    MAIL.SendMail("", strToEmail, strSub, strBody);

                    break;
                default:
                    break;
            }
            SentMsgLogger("MAIL", "Sub:" + strSub + "  Msg:" + strBody, strToEmail, strFirstName);
            lblSentStatus.Text = "Email Sent";

        }

        protected void SendGreetings(object sender, CommandEventArgs e)
        {
            string cmdName = e.CommandName.ToString();
            for (int i = 0; i < gvGreetings.Rows.Count; i++)
            {
                string strName, strPhone, strEmail, strDateOfBirth, strAnniversary, strMsg = "";
                int intStudentId;
                intStudentId = Convert.ToInt32(gvGreetings.Rows[i].Cells[0].Text);
                strName = gvGreetings.Rows[i].Cells[1].Text;
                strPhone = gvGreetings.Rows[i].Cells[2].Text;
                strEmail = gvGreetings.Rows[i].Cells[3].Text;
                strDateOfBirth = gvGreetings.Rows[i].Cells[4].Text;
                strAnniversary = gvGreetings.Rows[i].Cells[5].Text;
                //strBirthDayGreetingStatus       = gvGreetings.Rows[i].Cells[5].Text;
                //strAnniversaryGreetingStatus    = gvGreetings.Rows[i].Cells[6].Text;
                if (cmdName == "BIRTHDAY")
                    strMsg = string.Format("Dear {0}, SJA wishes you many many happy returns of the Day !!! Happy B'Day.", strName);

                MAIL.SendMail("", strEmail, "SJA wishes you many many happy returns of the Day !!! Happy B'Day !!!", strMsg);
                //SMS.SendSms(strPhone, strMsg, "T");
                SMS.SendSmsUsingProvider("SMSGATEWAYHUB", strPhone, strMsg);
            }
        }

        //Send Serice Reminders 
        protected void SendFeeReminders(Object sender, CommandEventArgs e)
        {
            for (int i = 0; i < gvFeeReminders.Rows.Count; i++)
            {
                string strFeeTitle, strName, strEmail, strPhone, strReminderStatus, strMsg;
                string FeeDueDate;
                int intReminderID;
                intReminderID = Convert.ToInt32(gvFeeReminders.Rows[i].Cells[0].Text);
                strFeeTitle = gvFeeReminders.Rows[i].Cells[1].Text;
                strName = gvFeeReminders.Rows[i].Cells[2].Text;
                strPhone = gvFeeReminders.Rows[i].Cells[3].Text;
                strEmail = gvFeeReminders.Rows[i].Cells[4].Text;
                FeeDueDate = gvFeeReminders.Rows[i].Cells[7].Text;
                strReminderStatus = gvFeeReminders.Rows[i].Cells[7].Text;
                if (strReminderStatus == "PLANNED")
                {
                    strMsg = string.Format("Dear {0} Your next service at Operations is due on '{1}'. Please get in touch.", strName, FeeDueDate);
                    MAIL.SendMail("", strEmail, "EduSphere-Fee Reminder", strMsg);
                    //SMS.SendSms(strPhone, "Operations" + strMsg, "T");
                    SMS.SendSmsUsingProvider("SMSGATEWAYHUB", strPhone, strMsg);
                    ReminderStatus(intReminderID);
                }

            }

        }

        //update status to "SENT" after sending reminders by email and sms
        protected void ReminderStatus(int reminderkey)
        {
            SqlCommand ObjCmd = new SqlCommand("spFeeRemindersStatus", BD.ObjCn);
            ObjCmd.CommandType = CommandType.StoredProcedure;
            ObjCmd.Parameters.AddWithValue("@FeeReminderID", reminderkey);
            ObjCmd.Parameters.AddWithValue("@ReminderStatus", "SENT");

            BD.UpdateParameters(ObjCmd);
        }

        protected void SentMsgLogger(string media, string msg, string to, string firstname)
        {
            string smsMsg, smsTo, mailMsg, mailTo, FullName;
            smsMsg = mailMsg = smsTo = mailTo = FullName = "";
            if (media == "SMS")
            {
                smsMsg = msg;
                smsTo = to;
                mailMsg = "NA";
                mailTo = "NA";

            }
            if (media == "MAIL")
            {
                smsMsg = "NA";
                smsTo = "NA";
                mailMsg = msg;
                mailTo = to;

            }
            FullName = firstname;
            SqlCommand ObjCmd = new SqlCommand("spInsertCommunicationLog", BD.ObjCn);
            ObjCmd.CommandType = CommandType.StoredProcedure;

            ObjCmd.Parameters.AddWithValue("@msgMedia", media);
            ObjCmd.Parameters.AddWithValue("@smsMsg", smsMsg);
            ObjCmd.Parameters.AddWithValue("@smsTo", smsTo);
            ObjCmd.Parameters.AddWithValue("@mailMsg", mailMsg);
            ObjCmd.Parameters.AddWithValue("@mailTo", mailTo);
            ObjCmd.Parameters.AddWithValue("@FullName", FullName);
            BD.UpdateParameters(ObjCmd);
        }

        //Display Enquiries
        protected void DisplayStudentsReport(object sender, CommandEventArgs e)
        {
            string cmdArg, cmdStr;
            cmdArg = e.CommandArgument.ToString();
            switch (cmdArg)
            {
                //case "ENQ":
                //    cmdStr = string.Format("SELECT * From EduSphere.MemberFeeEnquiry e JOIN EduSphere.Members c ON e.MemberID=c.MemberID JOIN EduSphere.Sku s ON e.SkuId=s.SkuId   order by e.PlannedFeeDate desc");
                //    BD.DataBindToDataGrid(dgEnquiries, cmdStr);
                //    pnlMemberSummary.Visible = false;
                //    pnlMembers.Visible = false;
                //    //pnlViewEnquiries.Visible = true;
                //    pnlEnroll.Visible = false;
                //    pnlPersonalDetails.Visible = false;
                //    pnlMemberSkuStatement.Visible = false;
                //    pnlCompletedSku.Visible = false;
                //    pnlSentMessageHistory.Visible = false;
                //    pnlSkuReminders.Visible = false;
                //    pnlGreetings.Visible = false;
                //    break;
                case "SERV":
                    //For Admin role disply all consultant, otherwise only the loggedin consultant
                    string filterQuery;
                    if (lblRole.Text == "Admin" || lblRole.Text == "Manager")
                        filterQuery = string.Format("SELECT FullName,EmployeeID FROM EduSphere.Staff");
                    else
                        filterQuery = string.Format("SELECT FullName,EmployeeID FROM EduSphere.Staff e JOIN EduSphere.EmpContacts c ON e.EmployeeID=c.EmployeeID  WHERE c.Email='{0}'", User.Identity.Name);

                    BD.DataBindToDropDownList(ddlConsultant, filterQuery);
                    //Diplay all completed services
                    //cmdStr   = string.Format("SELECT TOP 500 * FROM EduSphere.MemberAccount a JOIN EduSphere.Members c ON a.MemberID=c.MemberID JOIN EduSphere.Sku s ON a.SkuId=s.SkuId WHERE a.DebitAmount!={0} AND     order by a.TxDate desc",0);
                    //BD.DataBindToDataGrid(dgCompletedFees, cmdStr);
                    pnlMemberSummary.Visible = false;
                    pnlMembers.Visible = false;
                    //pnlViewEnquiries.Visible = false;
                    pnlCompletedSku.Visible = true;
                    pnlEnroll.Visible = false;
                    pnlPersonalDetails.Visible = false;
                    pnlMemberSkuStatement.Visible = false;
                    pnlSentMessageHistory.Visible = false;
                    pnlSkuReminders.Visible = false;
                    pnlGreetings.Visible = false;
                    break;
                case "FILTERSERV":
                    string strConsultantId = ddlConsultant.SelectedValue;
                    DateTime dtFrom = Convert.ToDateTime(txtBoxFromDate.Text);
                    string queryFrom = dtFrom.ToString("MM/dd/yyyy");
                    DateTime dtTo = Convert.ToDateTime(txtBoxToDate.Text);
                    string queryTo = dtTo.ToString("MM/dd/yyyy");
                    cmdStr = string.Format("SELECT * From EduSphere.MemberAccount a JOIN EduSphere.Members c ON a.MemberID=c.MemberID JOIN EduSphere.Sku s ON a.SkuId=s.SkuId WHERE a.DebitAmount!={0} AND a.ConsultantOneID='{1}' AND (a.TxDate between '{2}' AND '{3}')    order by a.TxDate desc", 0, strConsultantId, queryFrom, queryTo);
                    BD.DataBindToDataGrid(dgCompletedFees, cmdStr);
                    //Display total                            
                    int Total = MT.GetSum("spSumTotal", strConsultantId, dtFrom, dtTo);
                    lblTotal.Text = Convert.ToString(Total);
                    //End Count
                    break;
                case "SMS":
                    cmdStr = string.Format("SELECT TOP 100 smsTo,smsMsg, smsDate,FullName FROM EduSphere.CommunicationLog order by smsDate desc");
                    BD.DataBindToDataGrid(dgSmsMsgHistory, cmdStr);
                    dgMailMsgHistory.Visible = false;
                    dgSmsMsgHistory.Visible = true;
                    pnlSentMessageHistory.Visible = true;
                    pnlMemberSummary.Visible = false;
                    pnlMembers.Visible = false;
                    //pnlViewEnquiries.Visible = false;
                    pnlEnroll.Visible = false;
                    pnlPersonalDetails.Visible = false;
                    pnlCompletedSku.Visible = false;
                    pnlMemberSkuStatement.Visible = false;
                    pnlSkuReminders.Visible = false;
                    pnlGreetings.Visible = false;
                    break;
                case "MAIL":
                    cmdStr = string.Format("SELECT TOP 100 mailTo,mailMsg,mailDate,FullName FROM EduSphere.CommunicationLog order by mailDate desc");
                    BD.DataBindToDataGrid(dgMailMsgHistory, cmdStr);
                    dgMailMsgHistory.Visible = true;
                    dgSmsMsgHistory.Visible = false;
                    pnlSentMessageHistory.Visible = true;
                    pnlMemberSummary.Visible = false;
                    pnlMembers.Visible = false;
                    //pnlViewEnquiries.Visible = false;
                    pnlEnroll.Visible = false;
                    pnlPersonalDetails.Visible = false;
                    pnlCompletedSku.Visible = false;
                    pnlMemberSkuStatement.Visible = false;
                    pnlSkuReminders.Visible = false;
                    pnlGreetings.Visible = false;
                    break;
                case "GREETINGS":
                    pnlGreetings.Visible = true;
                    pnlSkuReminders.Visible = false;
                    dgMailMsgHistory.Visible = false;
                    dgSmsMsgHistory.Visible = false;
                    pnlSentMessageHistory.Visible = false;
                    pnlMemberSummary.Visible = false;
                    pnlMembers.Visible = false;
                    //pnlViewEnquiries.Visible = false;
                    pnlEnroll.Visible = false;
                    pnlCompletedSku.Visible = false;
                    pnlPersonalDetails.Visible = false;
                    pnlMemberSkuStatement.Visible = false;
                    cmdStr = string.Format("SELECT *  FROM EduSphere.Members WHERE DATEPART({0},DateOfBirth) = DATEPART({0},GETDATE()) AND DATEPART({1},DateOfBirth) = DATEPART({1},GETDATE()) ", "month", "day");
                    BD.DataBindToGridView(gvGreetings, cmdStr, "NA");
                    break;
                case "SERVICEREMINDERS":
                    cmdStr = string.Format("SELECT s.SkuTitle, c.FullName+'{0}'+c.Gender AS MemberName,c.PhoneOne,c.Email,r.FeeReminderID,r.PreviousFeeDate,r.FeeDueDate,r.ReminderStatus FROM EduSphere.FeeReminders r JOIN EduSphere.Sku s ON r.SkuId=s.SkuId JOIN EduSphere.Members c ON r.MemberID=c.MemberID WHERE FeeDueDate< DATEADD(day,2,GETDATE())", " ");
                    BD.DataBindToGridView(gvFeeReminders, cmdStr, "NA");
                    pnlSkuReminders.Visible = true;
                    pnlGreetings.Visible = false;
                    dgMailMsgHistory.Visible = false;
                    dgSmsMsgHistory.Visible = false;
                    pnlSentMessageHistory.Visible = false;
                    pnlCompletedSku.Visible = false;
                    pnlMemberSummary.Visible = false;
                    pnlMembers.Visible = false;
                    //pnlViewEnquiries.Visible = false;
                    pnlEnroll.Visible = false;
                    pnlPersonalDetails.Visible = false;
                    pnlMemberSkuStatement.Visible = false;
                    break;
                default:
                    break;
            }
        }

        ////Fee datagrid edit function
        //protected void dgEditEnquiries(object sender, DataGridCommandEventArgs e)
        //{
        //    //Make dgEnquiries datalist visible for editing
        //    dgEnquiries.EditItemIndex = e.Item.ItemIndex;
        //    string strKey = dgEnquiries.DataKeys[e.Item.ItemIndex].ToString();
        //    //GetSource();
        //    string strCmd = string.Format("SELECT * From EduSphere.MemberFeeEnquiry e JOIN EduSphere.Members c ON e.MemberID=c.MemberID JOIN EduSphere.Sku s ON e.SkuId=s.SkuId where e.EnquiryID='{0}'", strKey);
        //    BD.DataBindToDataGrid(dgEnquiries, strCmd);
        //}

        ////Cancel editing the Fee
        //protected void dgCancelEnquiries(object sender, DataGridCommandEventArgs e)
        //{
        //    dgEnquiries.EditItemIndex = -1;
        //    string strCmd = string.Format("SELECT * From EduSphere.MemberFeeEnquiry e JOIN EduSphere.Members c ON e.MemberID=c.MemberID JOIN EduSphere.Sku s ON e.SkuId=s.SkuId");
        //    BD.DataBindToDataGrid(dgEnquiries, strCmd);
        //}

        ////Delete Fee
        //protected void dgDeleteEnquiries(object sender, DataGridCommandEventArgs e)
        //{
        //    string strKey = dgEnquiries.DataKeys[e.Item.ItemIndex].ToString();
        //    SqlCommand ObjCmd = new SqlCommand("spDeleteFromTable", BD.ObjCn);
        //    ObjCmd.CommandType = CommandType.StoredProcedure;

        //    ObjCmd.Parameters.AddWithValue("@KeyID", strKey);
        //    ObjCmd.Parameters.AddWithValue("@SourceTable", "EduSphere.Sku");
        //    BD.UpdateParameters(ObjCmd);
        //    //GetSource();

        //}

        //Update Fee
        //protected void dgUpdateEnquiries(object sender, DataGridCommandEventArgs e)
        //{
        //    int intKeyEnquiryID;
        //    string strFollowUpDetails;

        //    intKeyEnquiryID = (int)dgEnquiries.DataKeys[e.Item.ItemIndex];
        //    //strFeeID      = string.Format(e.Item.Cells[2].Text);
        //    strFollowUpDetails = string.Format(((TextBox)e.Item.Cells[9].Controls[0]).Text);

        //    SqlCommand ObjCmd = new SqlCommand("spMemberFeeEnquiryUpdate", BD.ObjCn);
        //    ObjCmd.CommandType = CommandType.StoredProcedure;

        //    ObjCmd.Parameters.AddWithValue("@EnquiryID", intKeyEnquiryID);
        //    ObjCmd.Parameters.AddWithValue("@FollowUpDetails", strFollowUpDetails);
        //    BD.UpdateParameters(ObjCmd);
        //    dgEnquiries.EditItemIndex = -1;

        //    string strCmd = string.Format("SELECT * From EduSphere.MemberFeeEnquiry e JOIN EduSphere.Members c ON e.MemberID=c.MemberID JOIN EduSphere.Sku s ON e.SkuId=s.SkuId");
        //    BD.DataBindToDataGrid(dgEnquiries, strCmd);
        //}
    }
}