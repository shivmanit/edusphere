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
    public partial class Expenses : System.Web.UI.Page
    {
        BindData BD = new BindData();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                pnlAccountTxsDashboard.Visible = false;
                pnlAddAccountTxs.Visible = false;
                pnlManageAccountTxTitles.Visible = false;
                //Get user role
                if (User.Identity.IsAuthenticated)
                {
                    string strID = User.Identity.Name;
                    //string strRole  = lnUser.GetUserRole(strID);
                    if (User.IsInRole("Admin"))
                        lblRole.Text = "Admin";
                    if (User.IsInRole("Manager"))
                        lblRole.Text = "Manager";
                    if (User.IsInRole("Accounts"))
                        lblRole.Text = "Accounts";
                }

                //In case the logged in role is Admin then display delete button.
                if (User.IsInRole("Admin"))
                {
                    BD.DataBindToDataGrid(dgExistingAccountTxTitles, "SELECT * FROM EduSphere.AccountTxTitles");
                }
                else
                {
                    BD.DataBindToDataGrid(dgExistingAccountTxTitlesView, "SELECT * FROM EduSphere.AccountTxTitles");
                }

                //Show business Indicators without user intervention
                //ShowIndicatorsDashboard();
            }

        }

        public void ManageDashboardPanels(object sender, CommandEventArgs e)
        {
            string strCmd;
            strCmd = e.CommandName.ToString();
            switch (strCmd)
            {

                case "pnlAccountTxsDashboard":
                    lblDashboardAction.Text = "Account Transactions";
                    pnlAccountTxsDashboard.Visible = true;
                    pnlAddAccountTxs.Visible = false;
                    pnlManageAccountTxTitles.Visible = false;
                    string spender = string.Format("SELECT FullName,EmployeeID  FROM EduSphere.Staff");
                    BD.DataBindToDropDownList(ddlSpender, spender);
                    //Make all stores visible only to admin. The manager can see only his/her store
                    SetSalonVisibility(lblRole.Text, User.Identity.Name, ddlSite, ddlSpender);
                    break;
                case "pnlAddAccountTxs":
                    lblDashboardAction.Text = "Add AccountTx";
                    pnlAccountTxsDashboard.Visible = false;
                    pnlAddAccountTxs.Visible = true;
                    pnlManageAccountTxTitles.Visible = false;
                    BD.DataBindToDropDownList(ddlCostSite, string.Format("SELECT OrganizationName,OrganizationID FROM EduSphere.Organizations"));
                    BD.DataBindToDropDownList(ddlAccountTxTitle, "SELECT AccountTxTitle,AccountTxTitleID FROM EduSphere.AccountTxTitles");
                    BD.DataBindToDropDownList(ddlApprovedBy, "SELECT FullName,EmployeeID FROM EduSphere.Staff");
                    break;
                case "pnlManageAccountTxTitles":
                    lblDashboardAction.Text = "Manage AccountTx Titles";
                    pnlAccountTxsDashboard.Visible = false;
                    pnlAddAccountTxs.Visible = false;
                    pnlManageAccountTxTitles.Visible = true;
                    break;
                case "FromPnlServicesRevenueToNoPanel":
                    pnlAccountTxsDashboard.Visible = false;
                    pnlAddAccountTxs.Visible = false;
                    pnlManageAccountTxTitles.Visible = false;
                    break;

                default:
                    break;
            }
        }

        //Reports for AccountTxs
        public void GetAccountTxsReport(object sender, CommandEventArgs e)
        {
            string queryStr, strCmd, strArg;
            strCmd = e.CommandName.ToString();
            strArg = e.CommandArgument.ToString();
            int strSpender = 0;
            int store = 0;
            //string format     = "yyyy-mm-dd hh:mm:ss";
            DateTime dtFrom, dtTo;
            DateTime.TryParseExact(txtBoxExpFrom.Text, "yyyy-mm-dd", new CultureInfo("en-US"), DateTimeStyles.None, out dtFrom);
            DateTime.TryParseExact(txtBoxExpTo.Text, "yyyy-mm-dd", new CultureInfo("en-US"), DateTimeStyles.None, out dtTo);

            string querydtFrom = dtFrom.ToString("mm/dd/yyyy");
            string querydtTo = dtTo.ToString("mm/dd/yyyy");
            if (ddlSpender.SelectedValue.ToString() != "Select")
            {
                strSpender = Convert.ToInt32(ddlSpender.SelectedValue.ToString());
            }
            string strPaymentMode = ddlPayMode.SelectedValue.ToString();

            if (ddlSite.SelectedValue.ToString() != "Select")
            {
                store = Convert.ToInt32(ddlSite.SelectedValue.ToString());

            }

            switch (strCmd)
            {
                case "AllAccountTxsByDate":
                    if (strPaymentMode == "All")
                        queryStr = string.Format("SELECT  em.FullName,et.AccountTxTitleGroup,et.AccountTxTitle,ex.DebitAmount,ex.CreditAmount,ex.AccountTxDate,ex.OrganizationID,ex.AccountTxDetails,ex.PaymentMode,ex.ConfirmationString,ex.DocPath FROM EduSphere.AccountTxs ex JOIN EduSphere.AccountTxTitles et ON ex.AccountTxTitleID=et.AccountTxTitleID JOIN EduSphere.Staff em ON ex.EmployeeID=em.EmployeeID WHERE (ex.AccountTxDate BETWEEN '{0}' AND '{1}') ORDER BY ex.AccountTxDate DESC", querydtFrom, querydtTo);
                    else
                        queryStr = string.Format("SELECT  em.FullName,et.AccountTxTitleGroup,et.AccountTxTitle,ex.DebitAmount,ex.CreditAmount,ex.AccountTxDate,ex.OrganizationID,ex.AccountTxDetails,ex.PaymentMode,ex.ConfirmationString,ex.DocPath FROM EduSphere.AccountTxs ex JOIN EduSphere.AccountTxTitles et ON ex.AccountTxTitleID=et.AccountTxTitleID JOIN EduSphere.Staff em ON ex.EmployeeID=em.EmployeeID WHERE ex.OrganizationID={0} AND (ex.AccountTxDate BETWEEN '{1}' AND '{2}')  AND PaymentMode='{3}' ORDER BY ex.AccountTxDate DESC", store, querydtFrom, querydtTo, strPaymentMode);
                    if (strArg == "exportToExcel")
                    {
                        gvAccountTxsDashboard.AllowPaging = false;
                    }
                    BD.DataBindToGridView(gvAccountTxsDashboard, queryStr, "NA");

                    break;
                case "AccountTxsByDateByGroupByStore":
                    queryStr = string.Format("SELECT em.FullName,et.AccountTxTitleGroup,et.AccountTxTitle,ex.DebitAmount,ex.CreditAmount,ex.AccountTxDate,ex.OrganizationID,ex.AccountTxDetails,ex.PaymentMode,ex.ConfirmationString,ex.DocPath FROM EduSphere.AccountTxs ex JOIN EduSphere.AccountTxTitles et ON ex.AccountTxTitleID=et.AccountTxTitleID JOIN EduSphere.Staff em ON ex.EmployeeID=em.EmployeeID WHERE  em.EmployeeID='{0}' AND (ex.AccountTxDate BETWEEN '{1}' AND '{2}')  ORDER BY ex.AccountTxDate DESC", strSpender, querydtFrom, querydtTo);
                    if (strArg == "exportToExcel")
                    {
                        gvAccountTxsDashboard.AllowPaging = false;
                    }
                    BD.DataBindToGridView(gvAccountTxsDashboard, queryStr, "NA");

                    break;

                default:
                    break;
            }
            lblTotalAccountTxs.Text = GetColumnTotalDec(gvAccountTxsDashboard, 4);
            lblTotalInflow.Text = GetColumnTotalDec(gvAccountTxsDashboard, 5);
            if (strArg == "exportToExcel")
            {
                ExportToExcel(gvAccountTxsDashboard);
            }
        }



        //Insert new AccountTxTile on Submit
        public void SubmitAccountTx(object sender, EventArgs e)
        {
            int intAccountTxID = Convert.ToInt32(ddlAccountTxTitle.SelectedValue);
            int strOrgID = Convert.ToInt32(ddlCostSite.SelectedValue.ToString());
            int intAccountTxAmount = Convert.ToInt32(txtBoxAccountTxAmount.Text);
            string strAccountTxDetails = txtBoxAccountTxDetails.Text;
            string strEmployeesID = ddlApprovedBy.SelectedValue;
            string strPaymentMode = ddlAccountTxMode.SelectedValue.ToString();
            string strConfirmationString = txtBoxExpConfirmationString.Text;
            DateTime dtAccountTxDate = DateTime.Parse("01/01/1900");
            if (txtBoxAccountTxAmount.Text == "")
            {
                Response.Write("<script>alert('Amount is empty !!!')</script>");
                return;
            }

            SqlCommand ObjCmd = new SqlCommand("spAccountTxStatement", BD.ObjCn);
            ObjCmd.CommandType = CommandType.StoredProcedure;
            ObjCmd.Parameters.AddWithValue("@AccountTxTitleID", intAccountTxID);
            ObjCmd.Parameters.AddWithValue("@OrganizationID", strOrgID);
            ObjCmd.Parameters.AddWithValue("@EmployeeID", strEmployeesID);
            //ObjCmd.Parameters.AddWithValue("@AccountTxDate", dtAccountTxDate);
            ObjCmd.Parameters.AddWithValue("@AccountTxDetails", strAccountTxDetails);
            ObjCmd.Parameters.AddWithValue("@PaymentMode", strPaymentMode);
            ObjCmd.Parameters.AddWithValue("@ConfirmationString", strConfirmationString);
            ObjCmd.Parameters.AddWithValue("@DocPath", lblDocAttachment.Text);
            if (ddlAccountTxType.SelectedValue.ToString() == "CustomerReceipts")
            {
                ObjCmd.Parameters.AddWithValue("@DebitAmount", 0);
                ObjCmd.Parameters.AddWithValue("@CreditAmount", intAccountTxAmount);
            }
            else
            {
                ObjCmd.Parameters.AddWithValue("@DebitAmount", intAccountTxAmount);
                ObjCmd.Parameters.AddWithValue("@CreditAmount", 0);
            }

            BD.UpdateParameters(ObjCmd);
            //Clear
            txtBoxAccountTxAmount.Text = "";
            txtBoxAccountTxDetails.Text = "";
            ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Transaction Added !!!');", true);
            //string strCmd = string.Format("SELECT TOP 10 FROM EduSphere.AccountTxStatement ");
            //BD.DataBindToDataGrid(dgExistingAccountTxTitles, strCmd);
        }

        //Upload documentarty evidence Invoice/CashVoucher
        protected void btnFileUpload_TxDoc(object sender, CommandEventArgs e)
        {
            if (flUploadTxDoc.HasFile)
            {
                //Create a path to save the file
                string filename = Path.Combine(HttpContext.Current.Server.MapPath("~/Artifacts/Accounts"), flUploadTxDoc.FileName);
                //Display File path in text box for record insertion
                lblDocAttachment.Text = string.Format("~/Artifacts/Accounts/" + flUploadTxDoc.FileName);
                flUploadTxDoc.SaveAs(filename);
            }

        }


        protected void ddlAccountTxType_SelectedIndexChanged(object sender, EventArgs e)
        {
            string strQuery = string.Format("SELECT * FROM EduSphere.AccountTxTitles WHERE AccountTxTitleGroup='{0}'", ddlAccountTxType.SelectedValue.ToString());
            BD.DataBindToDropDownList(ddlAccountTxTitle, strQuery);

        }

        //Insert new AccountTxTile on Submit
        public void InsertNewAccountTxTitle(object sender, EventArgs e)
        {
            string strAccountTxGroup = ddlAccountTxGroup.SelectedValue.ToString();
            string strAccountTxTitle = txtBoxAccountTxTitle.Text;
            string strDesc = txtBoxAccountTxTitleDescription.Text;
            if (strAccountTxTitle == "")
            {
                Response.Write("<script>alert('Title is empty !!!')</script>");
                return;
            }

            SqlCommand ObjCmd = new SqlCommand("spManageAccountTxTitles", BD.ObjCn);
            ObjCmd.CommandType = CommandType.StoredProcedure;
            ObjCmd.Parameters.AddWithValue("@cmd", "ADDTITLE");
            ObjCmd.Parameters.AddWithValue("@AccountTxTitleID", 0);
            ObjCmd.Parameters.AddWithValue("@AccountTxTitleGroup", strAccountTxGroup);
            ObjCmd.Parameters.AddWithValue("@AccountTxTitle", strAccountTxTitle);
            ObjCmd.Parameters.AddWithValue("@AccountTxTitleDescription", strDesc);
            BD.UpdateParameters(ObjCmd);
            //Clear
            txtBoxAccountTxTitle.Text = "";
            txtBoxAccountTxTitleDescription.Text = "";

            string strCmd = string.Format("SELECT * FROM EduSphere.AccountTxTitles WHERE AccountTxTitleGroup='{0}'", strAccountTxGroup);
            BD.DataBindToDataGrid(dgExistingAccountTxTitles, strCmd);
        }
        protected void FilterAccountTxTitles(object sender, CommandEventArgs e)
        {
            string strAccountTxGroup;
            strAccountTxGroup = ddlAccountTxGroupFilter.SelectedValue.ToString();
            //
            string strCmd = string.Format("SELECT * FROM EduSphere.AccountTxTitles WHERE AccountTxTitleGroup='{0}'", strAccountTxGroup);
            BD.DataBindToDataGrid(dgExistingAccountTxTitles, strCmd);

        }
        //to edit,update,cancel and delete exisitng expense titles inside datagrid
        protected void dgEditAccountTxTitle(object sender, DataGridCommandEventArgs e)
        {
            dgExistingAccountTxTitles.EditItemIndex = e.Item.ItemIndex;
            string strKey = dgExistingAccountTxTitles.DataKeys[e.Item.ItemIndex].ToString();
            //GetSource();
            string strCmd = string.Format("SELECT * FROM EduSphere.AccountTxTitles where AccountTxTitleID='{0}'", strKey);
            BD.DataBindToDataGrid(dgExistingAccountTxTitles, strCmd);
        }

        //Cancel editing the AccountTxTitle
        protected void dgCancelAccountTxTitle(object sender, DataGridCommandEventArgs e)
        {
            dgExistingAccountTxTitles.EditItemIndex = -1;
            //update view
            string strCmd = string.Format("SELECT * FROM EduSphere.AccountTxTitles ");
            BD.DataBindToDataGrid(dgExistingAccountTxTitles, strCmd);
        }

        //Delete AccountTxTitle
        protected void dgDeleteAccountTxTitle(object sender, DataGridCommandEventArgs e)
        {
            int intKey = Convert.ToInt32(dgExistingAccountTxTitles.DataKeys[e.Item.ItemIndex].ToString());
            SqlCommand ObjCmd = new SqlCommand("spManageAccountTxTitles", BD.ObjCn);
            ObjCmd.CommandType = CommandType.StoredProcedure;
            ObjCmd.Parameters.AddWithValue("@cmd", "DELETETITLE");
            ObjCmd.Parameters.AddWithValue("@AccountTxTitleID", intKey);
            ObjCmd.Parameters.AddWithValue("@AccountTxTitleGroup", "NA");
            ObjCmd.Parameters.AddWithValue("@AccountTxTitle", "NA");
            ObjCmd.Parameters.AddWithValue("@AccountTxTitleDescription", "NA");

            BD.UpdateParameters(ObjCmd);

            string strCmd = string.Format("SELECT * FROM EduSphere.AccountTxTitles where AccountTxTitleGroup='{0}'", "Salary");
            BD.DataBindToDataGrid(dgExistingAccountTxTitles, strCmd);
        }

        //Update AccountTxTitle
        protected void dgUpdateAccountTxTitle(object sender, DataGridCommandEventArgs e)
        {
            int intKeyAccountTxTitleID;
            string strTitle, strDescription;

            intKeyAccountTxTitleID = (int)dgExistingAccountTxTitles.DataKeys[e.Item.ItemIndex];
            strTitle = string.Format(((TextBox)e.Item.Cells[2].Controls[0]).Text);
            strDescription = string.Format(((TextBox)e.Item.Cells[4].Controls[0]).Text);

            SqlCommand ObjCmd = new SqlCommand("spManageAccountTxTitles", BD.ObjCn);
            ObjCmd.CommandType = CommandType.StoredProcedure;
            ObjCmd.Parameters.AddWithValue("@cmd", "UPDATETITLE");
            ObjCmd.Parameters.AddWithValue("@AccountTxTitleID", intKeyAccountTxTitleID);
            ObjCmd.Parameters.AddWithValue("@AccountTxTitle", strTitle);
            ObjCmd.Parameters.AddWithValue("@AccountTxTitleGroup", "NA");
            ObjCmd.Parameters.AddWithValue("@AccountTxTitleDescription", strDescription);

            BD.UpdateParameters(ObjCmd);
            dgExistingAccountTxTitles.EditItemIndex = -1;
            //update view
            string strCmd = string.Format("SELECT * FROM EduSphere.AccountTxTitles");
            BD.DataBindToDataGrid(dgExistingAccountTxTitles, strCmd);
        }

        //Column Total in String 
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


        //Column Total in Decimals
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
                ///string ConsultantOneId = ddlConsultant.SelectedValue.ToString();
                //string queryStr = string.Format("SELECT  c.FullName,s.ServiceGroup,s.ServiceTitle,a.DebitAmount,a.ServiceDate FROM EduSphere.MemberServiceAccount a JOIN EduSphere.Services s ON a.ServiceID=s.ServiceID JOIN EduSphere.Customers c ON a.CustomerID=c.CustomerID WHERE a.DebitAmount !={0} AND a.ConsultantOneId='{1}' AND (a.ServiceDate BETWEEN '{2}' AND '{3}') ORDER BY a.ServiceDate DESC", 0, ConsultantOneId, querydtFrom, querydtTo);
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

        //
        protected void OnAccountTxsPageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvAccountTxsDashboard.PageIndex = e.NewPageIndex;
            string queryStr = "";
            //string queryStr = string.Format("SELECT  a.ServiceDate,c.FullName,c.PhoneOne,s.ServiceGroupID,s.ServiceTitle,a.DebitAmount,a.CreditAmount,a.PaymentMode,a.DigitalPaymentRefCode,a.ServiceLocation FROM EduSphere.MemberServiceAccount a JOIN EduSphere.Services s ON a.ServiceID=s.ServiceID JOIN EduSphere.Customers c ON a.CustomerID=c.CustomerID WHERE a.DebitAmount !={0} OR a.CreditAmount!={1}  ORDER BY a.ServiceDate DESC", 0, 0);
            BD.DataBindToGridView(gvAccountTxsDashboard, queryStr, "NA");
        }

        private void SetSalonVisibility(string strRole, string userID, DropDownList ddlOrg, DropDownList ddlStaff)
        {
            if (strRole == "Admin" || strRole == "Manager" || User.IsInRole("Accounts"))
            {
                BD.DataBindToDropDownList(ddlStaff, string.Format("SELECT FullName,EmployeeID FROM EduSphere.Staff"));
                //Allow manager to choose only his organization
                if (User.IsInRole("Manager"))
                {
                    //string strOrg = lnUser.GetUserLogInOrg(User.Identity.Name);
                    BD.DataBindToDropDownList(ddlOrg, string.Format(@"SELECT OrganizationID,OrganizationName 
                                                         FROM EduSphere.Organizations 
                                                          WHERE OrganizationID=(SELECT OrganizationID FROM EduSphere.Staff WHERE Email='{0}')", User.Identity.Name.ToString()));
                }
                else
                    BD.DataBindToDropDownList(ddlOrg, "SELECT OrganizationID,OrganizationName FROM EduSphere.Organizations");
            }
            else
            {
                BD.DataBindToDropDownList(ddlStaff, string.Format("SELECT FullName,EmployeeID FROM EduSphere.Staff WHERE Email='{0}'", User.Identity.Name));
            }
        }

        public override void VerifyRenderingInServerForm(Control control)
        {
            /* Verifies that the control is rendered */
        }
    }
}