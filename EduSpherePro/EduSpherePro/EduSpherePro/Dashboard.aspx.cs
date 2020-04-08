using EduSpherePro.CoreServices;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EduSpherePro.EduSpherePro
{
    public partial class Dashboard : System.Web.UI.Page
    {
        IBindData BD = new BindData();
        IFileService FS = new FileService();
        //LoggedInUsers lnUser = new LoggedInUsers();
        DataSet ObjDS = new DataSet();
        DataView ObjDV = new DataView();
        string strRole = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                pnlServicesDashboard.Visible = false;
                pnlIndicatorsDashboard.Visible = false;
                pnlAttendanceDashboard.Visible = false;
                pnlStudentAttendanceDashboard.Visible = false;
                pnlStudentAcademicsDashboard.Visible = false;
                pnlCustomerDashoard.Visible = false;
                pnlExpensesDashboard.Visible = false;
                //Get user role
                if (User.Identity.IsAuthenticated)
                {
                    string strID = User.Identity.Name;
                    //string strRole  = lnUser.GetUserRole(strID);
                    if (User.IsInRole("Admin"))
                        strRole = "Admin";
                    if (User.IsInRole("Manager"))
                        strRole = "Manager";
                }
            }

        }

        public void ManageDashboardPanels(object sender, CommandEventArgs e)
        {
            string strCmd;
            strCmd = e.CommandName.ToString();
            switch (strCmd)
            {
                case "pnlServicesDashboard":
                    pnlServicesDashboard.Visible    = true;
                    pnlIndicatorsDashboard.Visible  = false;
                    pnlAttendanceDashboard.Visible  = false;
                    pnlStudentAttendanceDashboard.Visible = false;
                    pnlStudentAcademicsDashboard.Visible = false;
                    pnlCustomerDashoard.Visible     = false;
                    pnlExpensesDashboard.Visible    = false;
                    lblDashboardAction.Text = "Service Revenue";
                    SetSalonVisibility( ddlSalon, ddlConsultant);
                    break;
                case "pnlIndicatorsDashboard":
                    pnlServicesDashboard.Visible    = false;
                    pnlIndicatorsDashboard.Visible  = true;
                    pnlAttendanceDashboard.Visible  = false;
                    pnlStudentAttendanceDashboard.Visible = false;
                    pnlStudentAcademicsDashboard.Visible = false;
                    pnlCustomerDashoard.Visible     = false;
                    pnlExpensesDashboard.Visible    = false;
                    string cmdArgument = e.CommandArgument.ToString();
                    DateTime dtIndicatorDate = DateTime.Now.Date;
                    int intOrganizationID = 101;
                    if (cmdArgument == "today")
                    {
                        dtIndicatorDate = DateTime.Now.Date;
                        txtBoxIndicatorDate.Text = "dd/MM/yyyy";
                        BD.DataBindToDropDownList(ddlSalonSite, string.Format("SELECT OrganizationID,OrganizationName FROM EduSphere.Organizations"));
                    }

                    if (cmdArgument == "specificDate")
                    {
                        dtIndicatorDate = DateTime.ParseExact(txtBoxIndicatorDate.Text.ToString(), "dd/MM/yyyy", CultureInfo.InvariantCulture);
                        intOrganizationID = Convert.ToInt32(ddlSalonSite.SelectedValue.ToString());
                    }
                    List<int> list = ShowIndicatorsDashboard(dtIndicatorDate, intOrganizationID);
                    lblTodaysServiceBills.Text = list[0].ToString();
                    lblTodaysExpenseBills.Text = list[1].ToString();
                    lblTodaysServiceReceipts.Text = list[2].ToString();
                    lblMonthlyServiceBills.Text = list[3].ToString();
                    lblMonthlyExpenseBills.Text = list[4].ToString();
                    lblMonthlyServiceReceipts.Text = list[5].ToString();

                    //SetSalonVisibility(strRole, User.Identity.Name, ddlStoreLocation, ddlSeller);
                    //Payment Modes
                    string strDayServicePaymentMode = string.Format(@"SELECT SUM(CreditAmount) AS ReceivedAmount, PaymentMode AS ModeOfReceipt 
                                                                FROM EduSphere.MemberAccount  
                                                                WHERE CAST(TxDate AS DATE)=CAST('{1}' AS DATE) AND TxLocation='{2}'   
                                                                GROUP BY PaymentMode 
                                                                ORDER BY PaymentMode DESC", " ", dtIndicatorDate.ToString("MM/dd/yyyy"), intOrganizationID);
                    BD.DataBindToGridView(gvServicePaymentMode, strDayServicePaymentMode, "NA");
                    

                    //Dispaly staff Level Day Indicators for service & Product
                    string strDayServiceIndicatorCmd = string.Format(@"SELECT SUM(DebitAmount) AS BillAmount,a.ConsultantOneID AS EmployeeID,e.FullName  AS Name 
                                                                FROM EduSphere.MemberAccount a  JOIN EduSphere.Staff e ON a.ConsultantOneID=e.EmployeeID 
                                                                WHERE CAST(a.TxDate AS DATE)=CAST('{1}' AS DATE) AND TxLocation='{2}'  
                                                                GROUP BY a.ConsultantOneID,e.FullName 
                                                                ORDER BY SUM(DebitAmount) DESC", " ", dtIndicatorDate.ToString("MM/dd/yyyy"), intOrganizationID);
                    BD.DataBindToGridView(gvStaffDayServiceIndicators, strDayServiceIndicatorCmd, "NA");
                    



                    //Display staff Level Month Indicators for service & products
                    string strMonthServiceIndicatorCmd = string.Format(@"SELECT SUM(DebitAmount) AS BillAmount, a.ConsultantOneID AS EmployeeID,year(a.TxDate),month(a.TxDate), e.FullName AS Name 
                                                                  FROM EduSphere.MemberAccount a JOIN EduSphere.Staff e ON a.ConsultantOneID=e.EmployeeID
                                                                  WHERE month(a.TxDate)=month('{1}') AND TxLocation='{2}'  
                                                                  GROUP BY a.ConsultantOneID,e.FullName,year(a.TxDate),month(a.TxDate) 
                                                                  ORDER BY SUM(DebitAmount) DESC", " ", dtIndicatorDate.ToString("MM/dd/yyyy"), intOrganizationID);
                    BD.DataBindToGridView(gvStaffMonthServiceIndicators, strMonthServiceIndicatorCmd, "NA");

                  

                    break;
                case "pnlAttendanceDashboard":
                    lblDashboardAction.Text         = "Staff Attendance";
                    pnlServicesDashboard.Visible    = false;
                    pnlIndicatorsDashboard.Visible  = false;
                    pnlAttendanceDashboard.Visible  = true;
                    pnlStudentAttendanceDashboard.Visible = false;
                    pnlStudentAcademicsDashboard.Visible = false;
                    pnlCustomerDashoard.Visible     = false;
                    pnlExpensesDashboard.Visible    = false;
                  
                    BD.DataBindToDropDownList(ddlStaff, string.Format("SELECT FullName,EmployeeID FROM EduSphere.Staff WHERE EmploymentStatus='{0}'", "ACTIVE"));
                    lblDate.Text = DateTime.Today.ToString("yyyy-MMM");
                    //hide staff attendace details grid while displying all staff attendance summary
                    gvStaffAttendanceDetails.Visible = false;
                    string strCmdMonthAttendance = string.Format("SELECT  s.FullName AS Name, SUM(DaysPresentFor) AS Number FROM EduSphere.StaffAttendance a JOIN EduSphere.Staff s ON a.EmployeeID=s.EmployeeID WHERE DATEPART(MM,AttendanceDate)=DATEPART(MM,GETDATE()) AND DATEPART(YYYY,AttendanceDate)=DATEPART(YYYY,GETDATE()) GROUP BY s.FullName ORDER BY s.FullName");
                    BD.DataBindToGridView(gvAttendanceDashboard, strCmdMonthAttendance, "NA");
                    //Day Count
                    //string strMonthAttendance = string.Format("SELECT  s.FullName, DaysPresentFor, AttendanceDate, Remarks FROM EduSphere.StaffAttendance a JOIN EduSphere.Staff s ON a.EmployeeID=s.EmployeeID WHERE DATEPART(MM,AttendanceDate)=DATEPART(MM,GETDATE()) AND DATEPART(YYYY,AttendanceDate)=DATEPART(YYYY,GETDATE())  ORDER BY s.FullName, AttendanceDate ASC");
                    //BD.DataBindToGridView(gvMonthAttendance, strMonthAttendance, "NA");
                    //PIVOT Table
                    GenerateMonthlyAttendaceReportPvt(DateTime.Today.ToString("MM/dd/yyyy"));
                    break;
                case "pnlStudentAttendanceDashboard":
                    lblDashboardAction.Text                 = "Student Attendance";
                    pnlServicesDashboard.Visible            = false;
                    pnlIndicatorsDashboard.Visible          = false;
                    pnlAttendanceDashboard.Visible          = false;
                    pnlStudentAttendanceDashboard.Visible   = true;
                    pnlStudentAcademicsDashboard.Visible    = false;
                    pnlCustomerDashoard.Visible             = false;
                    pnlExpensesDashboard.Visible            = false;

                    BD.DataBindToDropDownList(ddlAttendanceBatchFilter, string.Format("SELECT BatchCode,BatchID FROM EduSphere.ProgramBatch"));
                    
                    lblDate.Text = DateTime.Today.ToString("yyyy-MMM");
                    
                    //PIVOT Table
                    GenerateBatchAttendanceReportPvt(101);//testing
                    break;
                case "pnlStudentAcademicsDashboard":
                    lblDashboardAction.Text                 = "Student Academics";
                    pnlServicesDashboard.Visible            = false;
                    pnlIndicatorsDashboard.Visible          = false;
                    pnlAttendanceDashboard.Visible          = false;
                    pnlStudentAttendanceDashboard.Visible   = false;
                    pnlStudentAcademicsDashboard.Visible    = true;
                    pnlCustomerDashoard.Visible             = false;
                    pnlExpensesDashboard.Visible            = false;

                    BD.DataBindToDropDownList(ddlAcademicsBatchFilter, string.Format("SELECT BatchCode,BatchID FROM EduSphere.ProgramBatch"));
                   

                    //PIVOT Table
                    GenerateBatchAcademicsReportPvt(101);//testing
                    break;
                case "pnlCustomerDashboard":
                    lblDashboardAction.Text                 = "Student Outstandings";
                    pnlServicesDashboard.Visible            = false;
                    pnlIndicatorsDashboard.Visible          = false;
                    pnlAttendanceDashboard.Visible          = false;
                    pnlStudentAttendanceDashboard.Visible   = false;
                    pnlStudentAcademicsDashboard.Visible    = false;
                    pnlCustomerDashoard.Visible             = true;
                    pnlExpensesDashboard.Visible            = false;
                   
                    BD.DataBindToDropDownList(ddlLocation, string.Format("SELECT OrganizationName,OrganizationID FROM EduSphere.Organizations WHERE OrganizationID>={0} AND OrganizationType='{1}'", 100,"EDUCATION-CENTRE"));
                    break;
                case "pnlExpensesDashboard":
                    lblDashboardAction.Text         = "Expenses";
                    pnlServicesDashboard.Visible    = false;
                    pnlIndicatorsDashboard.Visible  = false;
                    pnlAttendanceDashboard.Visible  = false;
                    pnlStudentAttendanceDashboard.Visible = false;
                    pnlStudentAcademicsDashboard.Visible = false;
                    pnlCustomerDashoard.Visible     = false;
                    pnlExpensesDashboard.Visible    = true;
                    //string spender = string.Format("SELECT FullName+'{0}'+Gender as FullName,EmployeeID  FROM EduSphere.Staff", " ");
                    //BD.DataBindToDropDownList(ddlSpender, spender);
                    //Make all stores visible only to admin. The manager can see only his/her store
                    SetSalonVisibility(ddlSite, ddlSpender);
                    break;
                case "FromPnlServicesRevenueToNoPanel":
                    pnlServicesDashboard.Visible            = false;
                    pnlIndicatorsDashboard.Visible          = false;
                    pnlAttendanceDashboard.Visible          = false;
                    pnlStudentAttendanceDashboard.Visible   = false;
                    pnlStudentAcademicsDashboard.Visible    = false;
                    pnlCustomerDashoard.Visible             = false;
                    pnlExpensesDashboard.Visible            = false;
                    break;
                default:
                    break;
            }
        }

        public void ManageFileExport(object sender, CommandEventArgs e)
        {
            string fileSourceName = e.CommandName.ToString();
            string fileExportType = e.CommandArgument.ToString();
            switch (fileSourceName)
            {
                case "gvMonthlyAttendancePvt":
                    if (fileExportType == "ToExcel")
                        FS.ExportToExcel(gvMonthlyAttendancePvt);
                    break;
                case "gvBatchAttendance":
                    if (fileExportType == "ToExcel")
                        FS.ExportToExcel(gvBatchAttendance);
                    break;
                case "gvBatchAssessments":
                    if (fileExportType == "ToExcel")
                        FS.ExportToExcel(gvBatchAssessments);
                    break;
                default:
                    break;
            }
        }
        //

        private void SetSalonVisibility(DropDownList ddlOrg, DropDownList ddlStaff)
        {
            if ((User.IsInRole("Admin") || User.IsInRole("Manager")))
            {
                BD.DataBindToDropDownList(ddlStaff, string.Format("SELECT FullName,EmployeeID FROM EduSphere.Staff"));
                //Allow manager to choose only his organization
                if (strRole == "Manager")
                {
                    //string strOrg = lnUser.GetUserLogInOrg(User.Identity.Name);
                    //BD.DataBindToDropDownList(ddlOrg, string.Format("SELECT OrganizationID,OrganizationName FROM EduSphere.Organizations WHERE OrganizationID='{0}'", strOrg));
                    BD.DataBindToDropDownList(ddlOrg, string.Format("SELECT OrganizationID,OrganizationName FROM EduSphere.Organizations WHERE Email='{0}'", User.Identity.Name.ToString()));
                }
                else
                    BD.DataBindToDropDownList(ddlOrg, "SELECT OrganizationID,OrganizationName FROM EduSphere.Organizations");
            }
            else
            {
                BD.DataBindToDropDownList(ddlStaff, string.Format("SELECT FullName,EmployeeID FROM EduSphere.Staff WHERE Email='{0}'", User.Identity.Name));
            }
        }

        //Services Revenue based on filters
        public void GetServicesRevenueReport(object sender, CommandEventArgs e)
        {
            string queryStr, strCmd, strArg, querydtFrom, querydtTo;
            strCmd = e.CommandName.ToString();
            strArg = e.CommandArgument.ToString();

            //string format = "yyyy-mm-dd hh:mm:ss"; Coverts to mm/dd/yyyy format for valid dates.In case of invalid date returns 1st date of month as From and current date To 
            DateTime dtFrom, dtTo;
            if (DateTime.TryParseExact(txtBoxFromDate.Text, "yyyy-mm-dd", new CultureInfo("en-US"), DateTimeStyles.None, out dtFrom))
                querydtFrom = dtFrom.ToString("mm/dd/yyyy");
            else
            {
                DateTime now = DateTime.Today;
                DateTime firstOfMonth = new DateTime(now.Year, now.Month, 1);
                querydtFrom = firstOfMonth.ToString("MM/dd/yyyy");
                txtBoxFromDate.Text = firstOfMonth.ToString();
            }

            if (DateTime.TryParseExact(txtBoxToDate.Text, "yyyy-mm-dd", new CultureInfo("en-US"), DateTimeStyles.None, out dtTo))
                querydtTo = dtTo.ToString("mm/dd/yyyy");
            else
            {
                DateTime today = DateTime.Today;
                querydtTo = DateTime.Now.ToString("MM/dd/yyyy");
            }

            string strSalon;
            //if(strRole=="Admin")
            strSalon = ddlSalon.SelectedValue.ToString();
            switch (strCmd)
            {
                case "AllByDate":
                    string strPayMode = ddlPaymentMode.SelectedValue.ToString();
                    if (strPayMode == "All")
                        queryStr = string.Format("SELECT  a.TxDate,c.FullName  AS MemberName,c.PhoneOne,s.SkuType,s.SkuTitle,e.FullName AS ConsultantOneID,a.DebitAmount,a.CreditAmount,a.PaymentMode,a.DigitalPaymentRefCode,a.TxLocation FROM EduSphere.MemberAccount a JOIN EduSphere.Sku s ON a.SkuID=s.SkuID JOIN EduSphere.Members c ON a.MemberID=c.MemberID JOIN EduSphere.Staff e ON a.ConsultantOneID=e.EmployeeID WHERE a.TxLocation='{0}' AND (a.TxDate BETWEEN '{1}' AND '{2}')   ORDER BY a.TxDate DESC", strSalon, querydtFrom, querydtTo);
                    else
                        queryStr = string.Format("SELECT  a.TxDate,c.FullName AS MemberName,c.PhoneOne,s.SkuType,s.SkuTitle,e.FullName AS ConsultantOneID,a.DebitAmount,a.CreditAmount,a.PaymentMode,a.DigitalPaymentRefCode,a.TxLocation FROM EduSphere.MemberAccount a JOIN EduSphere.Sku s ON a.SkuID=s.SkuID JOIN EduSphere.Members c ON a.MemberID=c.MemberID JOIN EduSphere.Staff e ON a.ConsultantOneID=e.EmployeeID WHERE a.TxLocation='{0}' AND (a.TxDate BETWEEN '{1}' AND '{2}') AND a.PaymentMode='{3}'   ORDER BY a.TxDate DESC", strSalon, querydtFrom, querydtTo, strPayMode);

                    if (strArg == "exportToExcel")
                    {
                        gvServicesDashboard.AllowPaging = false;
                    }
                    BD.DataBindToGridView(gvServicesDashboard, queryStr, "NA");
                    break;

                case "ByDateByGroupByConsultant":
                    string ConsultantOneID = ddlConsultant.SelectedValue.ToString();
                    queryStr = string.Format("SELECT  a.TxDate,c.FullName  AS MemberName,c.PhoneOne,s.SkuType,s.SkuTitle,e.FullName AS ConsultantOneID,a.DebitAmount,a.CreditAmount,a.PaymentMode,a.DigitalPaymentRefCode,a.TxLocation FROM EduSphere.MemberAccount a JOIN EduSphere.Sku s ON a.SkuID=s.SkuID JOIN EduSphere.Members c ON a.MemberID=c.MemberID JOIN EduSphere.Staff e ON a.ConsultantOneID=e.EmployeeID WHERE  a.TxLocation='{0}' AND a.ConsultantOneID='{1}' AND (a.TxDate BETWEEN '{2}' AND '{3}')   ORDER BY a.TxDate DESC", strSalon, ConsultantOneID, querydtFrom, querydtTo);
                    if (strArg == "exportToExcel")
                    {
                        gvServicesDashboard.AllowPaging = false;
                    }
                    BD.DataBindToGridView(gvServicesDashboard, queryStr, "NA");


                    break;
                default:
                    break;
            }
            lblTotalBill.Text = GetColumnTotalDec(gvServicesDashboard, 6);
            lblTotalReceipt.Text = GetColumnTotalDec(gvServicesDashboard, 7);
            
            //check if export to excel requested
            if (strArg == "exportToExcel")
            {
                ExportToExcel(gvServicesDashboard);
            }
        }

        private string GetColumnTotalDec(GridView gv, int intColumn)
        {
            //Get Coulmn Total for GridView

            decimal decSum = 0;
            for (int i = 0; i < gv.Rows.Count; i++)
            {
                decSum += decimal.Parse(gv.Rows[i].Cells[intColumn].Text);
            }
            return decSum.ToString("0.00");
        }


        private string GetColumnTotal(GridView gv, int intColumn)
        {
            //Get Coulmn Total for GridView

            int intSum = 0;
            for (int i = 0; i < gv.Rows.Count; i++)
            {
                intSum += int.Parse(gv.Rows[i].Cells[intColumn].Text);
            }
            return intSum.ToString();
        }

        //
        protected void OnServiceRevenuePageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvServicesDashboard.PageIndex = e.NewPageIndex;
            string queryStr = string.Format("SELECT  a.TxDate,c.FullName,c.PhoneOne,s.SkuType,s.SkuTitle,a.DebitAmount,a.CreditAmount,a.PaymentMode,a.DigitalPaymentRefCode,a.TxLocation FROM EduSphere.MemberAccount a JOIN EduSphere.Sku s ON a.SkuID=s.SkuID JOIN EduSphere.Members c ON a.MemberID=c.MemberID WHERE a.DebitAmount !={0} OR a.CreditAmount!={1}  ORDER BY a.TxDate DESC", 0, 0);
            BD.DataBindToGridView(gvServicesDashboard, queryStr, "NA");
        }


        private void ExportToExcel(GridView gv)
        {
            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=GridViewExport.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.ms-excel";
            using (StringWriter sw = new StringWriter())
            {
                HtmlTextWriter hw = new HtmlTextWriter(sw);

                //To Export all pages
                gv.AllowPaging = false;
                //DateTime dtFrom, dtTo;
                //DateTime.TryParseExact(txtBoxFromDate.Text, "yyyy-mm-dd", new CultureInfo("en-US"), DateTimeStyles.None, out dtFrom);
                //DateTime.TryParseExact(txtBoxToDate.Text, "yyyy-mm-dd", new CultureInfo("en-US"), DateTimeStyles.None, out dtTo);

                //string querydtFrom = dtFrom.ToString("mm/dd/yyyy");
                //string querydtTo = dtTo.ToString("mm/dd/yyyy");
                ///string ConsultantOneID = ddlConsultant.SelectedValue.ToString();
                //string queryStr = string.Format("SELECT  c.FullName,s.SkuType,s.SkuTitle,a.DebitAmount,a.TxDate FROM EduSphere.MemberAccount a JOIN EduSphere.Sku s ON a.SkuID=s.SkuID JOIN EduSphere.Members c ON a.MemberID=c.MemberID WHERE a.DebitAmount !={0} AND a.ConsultantOneID='{1}' AND (a.TxDate BETWEEN '{2}' AND '{3}') ORDER BY a.TxDate DESC", 0, ConsultantOneID, querydtFrom, querydtTo);
                //BD.DataBindToGridView(gv, queryStr, "NA");

                gv.HeaderRow.BackColor = Color.White;
                foreach (TableCell cell in gv.HeaderRow.Cells)
                {
                    cell.BackColor = gv.HeaderStyle.BackColor;
                }
                foreach (GridViewRow row in gv.Rows)
                {
                    row.BackColor = Color.White;
                    foreach (TableCell cell in row.Cells)
                    {
                        if (row.RowIndex % 2 == 0)
                        {
                            cell.BackColor = gv.AlternatingRowStyle.BackColor;
                        }
                        else
                        {
                            cell.BackColor = gv.RowStyle.BackColor;
                        }
                        cell.CssClass = "textmode";
                    }
                }

                gv.RenderControl(hw);

                //style to format numbers to string
                string style = @"<style> .textmode { } </style>";
                Response.Write(style);
                Response.Output.Write(sw.ToString());
                Response.Flush();
                Response.End();
            }
        }

        //a must for above code
        public override void VerifyRenderingInServerForm(Control control)
        {
            /* Verifies that the control is rendered */
        }

        

        //Indicators
        public List<int> ShowIndicatorsDashboard(DateTime IndicatorDate, int intOrganizationID)
        {
            List<int> list = new List<int>();//list to contain all output parametrs returned values
            SqlCommand ObjCmd = new SqlCommand("spIndicators", BD.ConStr);
            ObjCmd.CommandType = CommandType.StoredProcedure;

            ObjCmd.Parameters.AddWithValue("@IndicatorDate", IndicatorDate);
            ObjCmd.Parameters.AddWithValue("@OrganizationID", intOrganizationID);
            SqlParameter TodaysServiceBills = new SqlParameter("@TodaysServiceBills", SqlDbType.Int);
            TodaysServiceBills.Direction = ParameterDirection.Output;
            ObjCmd.Parameters.Add(TodaysServiceBills);
            SqlParameter TodaysExpenseBills = new SqlParameter("@TodaysExpenseBills", SqlDbType.Int);
            TodaysExpenseBills.Direction = ParameterDirection.Output;
            ObjCmd.Parameters.Add(TodaysExpenseBills);
            SqlParameter TodaysServiceReceipts = new SqlParameter("@TodaysServiceReceipts", SqlDbType.Int);
            TodaysServiceReceipts.Direction = ParameterDirection.Output;
            ObjCmd.Parameters.Add(TodaysServiceReceipts);
            SqlParameter MonthlyServiceBills = new SqlParameter("@MonthlyServiceBills", SqlDbType.Int);
            MonthlyServiceBills.Direction = ParameterDirection.Output;
            ObjCmd.Parameters.Add(MonthlyServiceBills);
            SqlParameter MonthlyExpenseBills = new SqlParameter("@MonthlyExpenseBills", SqlDbType.Int);
            MonthlyExpenseBills.Direction = ParameterDirection.Output;
            ObjCmd.Parameters.Add(MonthlyExpenseBills);
            SqlParameter MonthlyServiceReceipts = new SqlParameter("@MonthlyServiceReceipts", SqlDbType.Int);
            MonthlyServiceReceipts.Direction = ParameterDirection.Output;
            ObjCmd.Parameters.Add(MonthlyServiceReceipts);
            BD.UpdateParameters(ObjCmd);

            list.Add((int)ObjCmd.Parameters["@TodaysServiceBills"].Value);
            list.Add((int)ObjCmd.Parameters["@TodaysExpenseBills"].Value);
            list.Add((int)ObjCmd.Parameters["@TodaysServiceReceipts"].Value);
            list.Add((int)ObjCmd.Parameters["@MonthlyServiceBills"].Value);
            list.Add((int)ObjCmd.Parameters["@MonthlyExpenseBills"].Value);
            list.Add((int)ObjCmd.Parameters["@MonthlyServiceReceipts"].Value);
          
            return list;
        }

        protected void staffAttendaceCalendar_SelectionChanged(object sender, EventArgs e)
        {
            //Disply details grid which is hidden while displying All Staff Attendance Summary
            gvStaffAttendanceDetails.Visible = true;
            //Display Selected Staff Summary and Details
            lblSelectedDate.Text = staffAttendanceCalendar.SelectedDate.ToString("yyyy/MMM");
            string dtMonthYear = staffAttendanceCalendar.SelectedDate.ToString("MM/dd/yyyy");
            string selectEmp = ddlStaff.SelectedValue.ToString();
            string strCmdStaff = "";
            string strCmdStaffAttendanceDetails = "";
            lblDate.Text = lblSelectedDate.Text;
            if (selectEmp != "Select")
            {
                string strEmployeeID = ddlStaff.SelectedValue.ToString();
                //Attendance total for selected employee
                strCmdStaff = string.Format("SELECT  s.FullName AS Name, SUM(DaysPresentFor) AS Number FROM EduSphere.StaffAttendance a JOIN EduSphere.Staff s ON a.EmployeeID=s.EmployeeID WHERE DATEPART(MM,AttendanceDate)=DATEPART(MM,'{0}') AND DATEPART(YYYY,AttendanceDate)=DATEPART(YYYY,'{0}') AND s.EmployeeID='{1}' GROUP BY s.FullName  ORDER BY s.FullName", dtMonthYear, strEmployeeID);
                gvStaffAttendanceDetails.Visible = true;
                //Attendance Details for chosen employee
                strCmdStaffAttendanceDetails = string.Format("SELECT s.FullName AS Name,AttendanceDate,SwipeInDateTime,SwipeOutDateTime,CAST(HoursPresentFor AS NUMERIC(18,2)) AS HoursPresentFor, DayStatus,Remarks FROM EduSphere.StaffAttendance a JOIN EduSphere.Staff s ON a.EmployeeID=s.EmployeeID WHERE DATEPART(MM,AttendanceDate)=DATEPART(MM,'{0}') AND DATEPART(YYYY,AttendanceDate)=DATEPART(YYYY,'{0}') AND a.EmployeeID='{1}' ORDER BY AttendanceDate", dtMonthYear, strEmployeeID);
                BD.DataBindToGridView(gvStaffAttendanceDetails, strCmdStaffAttendanceDetails, "NA");
            }
            else
            {
                //Disable details report of single staff
                gvStaffAttendanceDetails.Visible = false;
                //Attendance total for all employees
                strCmdStaff = string.Format("SELECT  s.FullName AS Name, SUM(DaysPresentFor) AS Number FROM EduSphere.StaffAttendance a JOIN EduSphere.Staff s ON a.EmployeeID=s.EmployeeID WHERE DATEPART(MM,AttendanceDate)=DATEPART(MM,'{0}') AND DATEPART(YYYY,AttendanceDate)=DATEPART(YYYY,'{0}') GROUP BY s.FullName ORDER BY s.FullName", dtMonthYear);
            }
            //Display Attendance Total
            BD.DataBindToGridView(gvAttendanceDashboard, strCmdStaff, "NA");
            //Pivot Table for all employees
            GenerateMonthlyAttendaceReportPvt(dtMonthYear);
        }

        //PIVOT Staff Attendance Report
        protected void GenerateMonthlyAttendaceReportPvt(string selectedDate)
        {
            
            SqlCommand cmd = new SqlCommand("spGetMonthDates", BD.ConStr);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlParameter outcols = new SqlParameter("@cols", SqlDbType.NVarChar, 4000);
            outcols.Direction = ParameterDirection.Output;
            cmd.Parameters.AddWithValue("@selectedDate", selectedDate);
            cmd.Parameters.Add(outcols);

            BD.UpdateParameters(cmd);

            string strCols = outcols.Value.ToString();
            if (strCols != "")
            {
                string pvtQuery = string.Format(@"SELECT FullName, {0} FROM
                                           (SELECT FullName, AttendanceDate, DaysPresentFor
                                           FROM EduSphere.StaffAttendance a JOIN EduSphere.Staff e ON a.EmployeeID=e.EmployeeID WHERE DATEPART(month,AttendanceDate)=DATEPART(month,'{1}'))p
                                           PIVOT(MAX(DaysPresentFor) FOR AttendanceDate IN({0})) AS Pvt
                                           ", strCols, selectedDate);
                BD.DataBindToGridView(gvMonthlyAttendancePvt, pvtQuery, "NA");
            }
            else
            {
                lblAttendanceError.Text = "No Staff Ateendace record found !!!";
            }
        }

        //Display Attendace for selected Batch
        protected void ddlAttendanceBatchFilter_IndexChanged(object sender, EventArgs e)
        {
            string strBatchID = ddlAttendanceBatchFilter.SelectedValue.ToString();
            if(strBatchID!="Select")
            {
                int intBatchID = Convert.ToInt32(strBatchID);
                GenerateBatchAttendanceReportPvt(intBatchID);
                //List all students fo the batch, so as to select and view the detailed attendace of a particular student
                BD.DataBindToDropDownList(ddlAttendanceStudentFilter, string.Format("SELECT StudentID,FullName FROM EduSphere.Students WHERE BatchID={0}",intBatchID));
            }
            
        }
        //Batch Attendance
        protected void GenerateBatchAttendanceReportPvt(int intBatchID)
        {
            SqlCommand cmd = new SqlCommand("spGetBatchCourses", BD.ConStr);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlParameter outcols = new SqlParameter("@cols", SqlDbType.NVarChar, 4000);
            outcols.Direction = ParameterDirection.Output;
            cmd.Parameters.AddWithValue("@BatchID", intBatchID);
            cmd.Parameters.Add(outcols);
            BD.UpdateParameters(cmd);
            
            string strCols = outcols.Value.ToString();
            if (strCols != "")
            {
                string pvtQuery = string.Format(@"SELECT FullName,{0} FROM
	                        (SELECT  s.StudentID,CourseTitle,FullName,SUM(s.AttendanceStatus) AS PresentCount
	                            FROM EduSphere.AttendanceSheets a 
	                            JOIN EduSphere.StudentAttendance s ON a.AttendanceSheetID=s.AttendanceSheetID
	                            JOIN EduSphere.Courses c ON a.CourseID=c.CourseID
	                            JOIN Edusphere.Students sn ON s.StudentID=sn.StudentID
	                            WHERE a.BatchID='{1}' 
	                            GROUP BY s.StudentID,FullName,CourseTitle
	                            ) AS SRC_TBL
	                        PIVOT
	                        (
	                            MAX(PresentCount)
	                            FOR CourseTitle IN ({0})
	                            )AS PIVOT_TABLE", strCols, intBatchID);
                BD.DataBindToGridView(gvBatchAttendance, pvtQuery, "NA");
            }
            else
            {
                lblStudentAttendanceError.Text = "No Attendance Record found !!!";

            }
        }
        
        //Selected Student Attendance details
        protected void ddlAttendanceFilter_Changed(object sender,EventArgs e)
        {
            string strStudentID = ddlAttendanceStudentFilter.SelectedValue.ToString();
            if(strStudentID !="Select")
            {
                int intStudentID = Convert.ToInt32(strStudentID);
                string studentCmd = string.Format(@"SELECT CourseTitle,CAST(AttendanceDate AS DATE) AS AttendanceDate,FullName,AttendanceStatus FROM EduSphere.StudentAttendance sa 
	                                                           JOIN EduSphere.AttendanceSheets sh ON sh.AttendanceSheetID=sa.AttendanceSheetID
			                                                   JOIN EduSphere.Students s ON sa.StudentID=s.StudentID
															   JOIN EduSphere.Courses c ON sh.CourseID=c.CourseID
			                                                WHERE sa.StudentID='{0}' ORDER BY sh.CourseID", intStudentID);
                BD.DataBindToGridView(gvStudentAttendanceDetails, studentCmd, "NA");
            }

        }
        //Display Academics for selected Batch
        protected void ddlAcademicsBatchFilter_IndexChanged(object sender, EventArgs e)
        {
            string strBatchID = ddlAcademicsBatchFilter.SelectedValue.ToString();
            if (strBatchID != "Select")
            {
                int intBatchID = Convert.ToInt32(strBatchID);
                GenerateBatchAcademicsReportPvt(intBatchID);
            }

        }
        //Batch Academics
        protected void GenerateBatchAcademicsReportPvt(int intBatchID)
        {
            SqlCommand cmd          = new SqlCommand("spGetBatchAssessments", BD.ConStr);
            cmd.CommandType         = CommandType.StoredProcedure;
            SqlParameter outcols    = new SqlParameter("@cols", SqlDbType.NVarChar, 4000);
            outcols.Direction   = ParameterDirection.Output;
            cmd.Parameters.AddWithValue("@BatchID", intBatchID);
            cmd.Parameters.Add(outcols);
            BD.UpdateParameters(cmd);

            string strCols = outcols.Value.ToString();
            if(strCols!="")
            {
            string pvtQuery = string.Format(@"SELECT FullName,{0} FROM
	                        (SELECT FullName,AssessmentCode,MarksObtained,MarksPercentage
	                         FROM EduSphere.Assessments a 
	                         JOIN  EduSphere.StudentAssessments sa ON a.AssessmentID=sa.AssessmentID
	                         JOIN Edusphere.Students st ON sa.StudentID=st.StudentID
	                         WHERE a.BatchID='{1}'
	                         GROUP BY FullName,AssessmentCode,MarksObtained,MarksPercentage
	                         ) AS SRC_TBL
	                        PIVOT
	                        (
	                            MAX(MarksObtained)
	                            FOR AssessmentCode IN ({0})
	                            )AS PIVOT_TABLE", strCols, intBatchID);
            BD.DataBindToGridView(gvBatchAssessments, pvtQuery, "NA");
            }
            else
            {
                lblBatchAcdemicsError.Text = "No Assessments found !!!";

            }
        }

        //Reports  Students Receivables
        public void GetCustomerBalanceReport(object sender, CommandEventArgs e)
        {
            string queryStr, strCmd, strArg;
            strCmd          = e.CommandName.ToString();
            strArg          = e.CommandArgument.ToString();
            string store    = ddlLocation.SelectedValue.ToString();
            switch (strCmd)
            {
                case "Services":
                    lblDashboardAction.Text = "Dashbord ->Student Outstandings";
                    gvCustomerServiceBalance.Visible = true;
                    queryStr = string.Format(@"SELECT c.MemberID,c.FullName AS Name ,c.PhoneOne,TxDate, BalanceAmount 
                                               FROM EduSphere.MemberAccount a 
                                               JOIN EduSphere.Members c ON a.MemberID=c.MemberID 
                                               WHERE TxDate=(SELECT MAX(TxDate) FROM EduSphere.MemberAccount b  WHERE a.MemberID=b.MemberID AND a.BalanceAmount != 0) AND TxLocation='{0}' 
                                              ORDER BY a.BalanceAmount ASC",Convert.ToInt32(store));
                    if (strArg == "exportToExcel")
                    {
                        gvCustomerServiceBalance.AllowPaging = false;
                        BD.DataBindToGridView(gvCustomerServiceBalance, queryStr, "NA");
                        ExportToExcel(gvCustomerServiceBalance);
                    }
                    else
                    {
                        BD.DataBindToGridView(gvCustomerServiceBalance, queryStr, "NA");
                    }
                    lblBalanceTotal.Text = GetColumnTotalDec(gvCustomerServiceBalance, 4);
                    break;
                default:
                    break;
            }
        }

        //Reports for Expenses
        public void GetExpensesReport(object sender, CommandEventArgs e)
        {
            string queryStr, strCmd, strArg;
            strCmd = e.CommandName.ToString();
            strArg = e.CommandArgument.ToString();
            //string format     = "yyyy-mm-dd hh:mm:ss";
            DateTime dtFrom, dtTo;
            DateTime.TryParseExact(txtBoxExpFrom.Text, "yyyy-mm-dd", new CultureInfo("en-US"), DateTimeStyles.None, out dtFrom);
            DateTime.TryParseExact(txtBoxExpTo.Text, "yyyy-mm-dd", new CultureInfo("en-US"), DateTimeStyles.None, out dtTo);

            string querydtFrom = dtFrom.ToString("mm/dd/yyyy");
            string querydtTo = dtTo.ToString("mm/dd/yyyy");

            string strSpender = ddlSpender.SelectedValue.ToString();
            string strPaymentMode = ddlPayMode.SelectedValue.ToString();

            string store = ddlSite.SelectedValue.ToString();


            switch (strCmd)
            {
                case "AllExpensesByDate":
                    if (strPaymentMode == "All")
                        queryStr = string.Format("SELECT  em.FullName,et.ExpenseTitleGroup,et.ExpenseTitle,ex.DebitAmount,ex.ExpenseDate,ex.SalonID,ex.ExpenseDetails,ex.PaymentMode,ex.ConfirmationString FROM EduSphere.Expenses ex JOIN EduSphere.ExpenseTitles et ON ex.ExpenseTitleID=et.ExpenseTitleID JOIN EduSphere.Staff em ON ex.EmployeeID=em.EmployeeID WHERE ex.DebitAmount !={0} AND ex.SalonID='{1}' AND (ex.ExpenseDate BETWEEN '{2}' AND '{3}') ORDER BY ex.ExpenseDate DESC", 0, store, querydtFrom, querydtTo);
                    else
                        queryStr = string.Format("SELECT  em.FullName,et.ExpenseTitleGroup,et.ExpenseTitle,ex.DebitAmount,ex.ExpenseDate,ex.SalonID,ex.ExpenseDetails,ex.PaymentMode,ex.ConfirmationString FROM EduSphere.Expenses ex JOIN EduSphere.ExpenseTitles et ON ex.ExpenseTitleID=et.ExpenseTitleID JOIN EduSphere.Staff em ON ex.EmployeeID=em.EmployeeID WHERE ex.DebitAmount !={0} AND ex.SalonID='{1}' AND (ex.ExpenseDate BETWEEN '{2}' AND '{3}')  AND PaymentMode='{4}' ORDER BY ex.ExpenseDate DESC", 0, store, querydtFrom, querydtTo, strPaymentMode);
                    if (strArg == "exportToExcel")
                    {
                        gvExpensesDashboard.AllowPaging = false;
                    }
                    BD.DataBindToGridView(gvExpensesDashboard, queryStr, "NA");
                    lblTotalExpenses.Text = GetColumnTotal(gvExpensesDashboard, 4);
                    break;
                case "ExpensesByDateByGroupByStore":
                    queryStr = string.Format("SELECT em.FullName,et.ExpenseTitleGroup,et.ExpenseTitle,ex.DebitAmount,ex.ExpenseDate,ex.SalonID,ex.ExpenseDetails,ex.PaymentMode,ex.ConfirmationString FROM EduSphere.Expenses ex JOIN EduSphere.ExpenseTitles et ON ex.ExpenseTitleID=et.ExpenseTitleID JOIN EduSphere.Staff em ON ex.EmployeeID=em.EmployeeID WHERE ex.DebitAmount !={0} AND em.EmployeeID='{1}' AND (ex.ExpenseDate BETWEEN '{2}' AND '{3}')  ORDER BY ex.ExpenseDate DESC", 0, strSpender, querydtFrom, querydtTo);
                    if (strArg == "exportToExcel")
                    {
                        gvExpensesDashboard.AllowPaging = false;
                    }
                    BD.DataBindToGridView(gvExpensesDashboard, queryStr, "NA");
                    lblTotalExpenses.Text = GetColumnTotal(gvExpensesDashboard, 4);
                    break;
                case "InventoryByDate":

                    break;
                default:
                    break;
            }
            if (strArg == "exportToExcel")
            {
                ExportToExcel(gvExpensesDashboard);
            }
        }

        //
        protected void OnExpensesPageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvServicesDashboard.PageIndex = e.NewPageIndex;
            string queryStr = string.Format("SELECT TOP 50 em.FullName,et.ExpenseGroup,et.ExpenseTitle,ex.DebitAmount,ex.ExpenseDate,ex.SalonID,ex.ExpenseDetails FROM EduSphere.Expenses ex JOIN EduSphere.ExpenseTitles et ON ex.ExpenseTitleID=et.ExpenseTitleID JOIN EduSphere.Staff em ON ex.EmployeeID=em.EmployeeID WHERE ex.DebitAmount !={0} ORDER BY ex.ExpenseDate DESC", 0);
            BD.DataBindToGridView(gvServicesDashboard, queryStr, "NA");
        }

    }
}