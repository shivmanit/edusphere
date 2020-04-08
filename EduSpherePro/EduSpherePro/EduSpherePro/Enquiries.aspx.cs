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
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EduSpherePro.EduSpherePro
{
    public partial class Enquiries : System.Web.UI.Page
    {
        IBindData BD      = new BindData();
        IAnalytics MS     = new Analytics();
        ISpeechService SP = new SpeechService();
        string stdEnquiry = @"SELECT  *, o.FullName as Owner,a.FullName as Assigned, (SELECT TOP 1 ModificationComments FROM EduSphere.EnquiryStatusModifications m WHERE m.EnquiryId=e.EnquiryId ORDER BY ModificationId DESC) AS Comments
                                                    FROM EduSphere.Enquiries e JOIN EduSphere.Organizations org ON e.FranchiseeID=org.OrganizationId 
                                                                                JOIN EduSphere.Staff o ON e.OwnerEmployeeId=o.EmployeeId
                                                                                JOIN EduSphere.Staff a ON e.AssignedEmployeeId=a.EmployeeId
                                                                                JOIN eduSphere.Programs p ON e.ProgramID=p.ProgramID";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                User.ToString();
                //SP.Speak("Welcome to lead management");
                

                lblEnquiryAction.Text                   = "View Leads";
                pnlViewEnquiry.Visible                  = true;
                pnlViewEnquiryProfile.Visible           = false;
                pnlEditEnquiryProfile.Visible           = false;
                pnlEnquiryStatusModifications.Visible   = false;
                pnlAddEnquiry.Visible = false;

                BD.DataBindToDropDownList(ddlFilterOrganizationName, string.Format("SELECT OrganizationName,OrganizationId FROM EduSphere.Organizations WHERE OrganizationType='{0}'", "FRANCHISEE"));
                string EnquiryViewSelect;
                //if (User.IsInRole("L1"))
                //    EnquiryViewSelect = string.Format("SELECT TOP 100 *, po.OrganizationName as Principle,co.OrganizationName as Customer,vo.OrganizationName as Vendor FROM EduSphere.Enquiries Enquiry JOIN EduSphere.Organizations po ON Enquiry.FranchiseeID=po.OrganizationId JOIN EduSphere.Organizations co ON Enquiry.CustomerId=co.OrganizationId JOIN EduSphere.Organizations vo ON Enquiry.VendorId=vo.OrganizationId WHERE Enquiry.RaisedById='{0}' ORDER BY RaisedOn DESC", User.Identity.Name);
                //else
                EnquiryViewSelect = string.Format(@"SELECT TOP 1000 *, o.FullName as Owner,a.FullName as Assigned, (SELECT TOP 1 ModificationComments FROM EduSphere.EnquiryStatusModifications m WHERE m.EnquiryId=e.EnquiryId ORDER BY ModificationId DESC) AS Comments
                                                    FROM EduSphere.Enquiries e JOIN EduSphere.Organizations org ON e.FranchiseeID=org.OrganizationId 
                                                                                JOIN EduSphere.Staff o ON e.OwnerEmployeeId=o.EmployeeId
                                                                                JOIN EduSphere.Staff a ON e.AssignedEmployeeId=a.EmployeeId
                                                                                JOIN eduSphere.Programs p ON e.ProgramID=p.ProgramID 
                                                    ORDER BY RaisedOn DESC");
                BD.DataBindToGridView(gvEnquiry, EnquiryViewSelect,"NA");
                BD.DataBindToLabel(lblCountEnquiries, string.Format("SELECT COUNT(EnquiryId) FROM EduSphere.Enquiries WHERE EnquiryStatus='{0}'","NEW"));
            }
        }

        //Manage Enquiry Panel Displays
        protected void ManageEnquiryVisibility(object sender, CommandEventArgs e)
        {
            string cmdName, strCmd = "";
            int intEnquiryId;
            cmdName = e.CommandName.ToString();
            string[] commandArgs = new string[3];
            
            switch (cmdName)
            {
                case "AddEnquiry":
                    lblEnquiryAction.Text                   = "New Enquiry";
                    pnlViewEnquiry.Visible                  = false;
                    pnlViewEnquiryProfile.Visible           = false;
                    pnlEditEnquiryProfile.Visible           = false;
                    pnlEnquiryStatusModifications.Visible   = false;
                    pnlAddEnquiry.Visible                   = true;
                    BD.DataBindToDropDownList(ddlProgramGroup, string.Format("SELECT ProgramGroupId,ProgramGroup FROM EduSphere.ProgramGroups"));
                    BD.DataBindToDropDownList(ddlFranchiseeID, string.Format("SELECT OrganizationName,OrganizationId FROM EduSphere.Organizations WHERE OrganizationType='{0}'", "FRANCHISEE"));
                    //BD.DataBindToDropDownList(ddlCustomerId, string.Format("SELECT OrganizationName,OrganizationId FROM EduSphere.Organizations WHERE OrganizationType='{0}'", "CUSTOMER"));
                    //BD.DataBindToDropDownList(ddlRaisedByProxyEmployeeId, string.Format("SELECT EmployeeId,FullName FROM EduSphere.Staff"));
                    lblRaisedById.Text = Context.User.Identity.Name.ToString();

                    break;
                
                
                case "SearchEnquiry":
                case "FilterEnquiry":
                    lblEnquiryAction.Text                   = "Filter Enquiries";
                    pnlViewEnquiry.Visible                  = true;
                    pnlViewEnquiryProfile.Visible           = false;
                    pnlEditEnquiryProfile.Visible           = false;
                    pnlEnquiryStatusModifications.Visible   = false;
                    pnlAddEnquiry.Visible                   = false;

                    if (cmdName == "SearchEnquiry")
                    {
                        string strSearchParam = txtBoxSearchEnquiry.Text.ToString();
                        if (User.IsInRole("Manager"))
                            strCmd = string.Format(@"{0} WHERE e.Phone LIKE '%{1}%'OR e.StudentName LIKE '%{1}%' ", stdEnquiry, strSearchParam);
                        else
                            strCmd = string.Format(@"{0}  WHERE e.Phone LIKE '%{1}%' OR e.StudentName LIKE '%{1}%' ", stdEnquiry, strSearchParam);

                    }
                    if (cmdName == "FilterEnquiry")
                    {
                        DateTime dtFrom = DateTime.ParseExact(txtBoxFromDate.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture);
                        DateTime dtTo = DateTime.ParseExact(txtBoxToDate.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture);
                        int intFranchiseeID = 0;
                        string strFranchiseeID = ddlFilterOrganizationName.SelectedValue.ToString();
                        string strEnquiryStatus = ddlFilterEnquiryStatus.SelectedValue.ToString();
                        //All for selected date
                        if ((strFranchiseeID == "Select") && (strEnquiryStatus == "Select"))
                        {
                            strCmd = string.Format(@"{0} WHERE e.RaisedOn BETWEEN '{1}' AND '{2}' ORDER BY e.EnquiryID DESC ",
                                                              stdEnquiry, dtFrom.ToString("MM/dd/yyyy"), dtTo.ToString("MM/dd/yyyy"));

                        }
                        if ((strFranchiseeID != "Select") && (strEnquiryStatus!="Select"))
                        {
                            intFranchiseeID = Convert.ToInt32(strFranchiseeID);
                            strCmd = string.Format(@"{0} WHERE e.RaisedOn BETWEEN '{1}' AND '{2}' AND e.FranchiseeID={3} AND EnquiryStatus='{4}' ORDER BY e.EnquiryID DESC ",
                                                              stdEnquiry,dtFrom.ToString("MM/dd/yyyy"), dtTo.ToString("MM/dd/yyyy"), intFranchiseeID,strEnquiryStatus);

                        }
                        //All Status for selected centre
                        if ((strFranchiseeID != "Select") && (strEnquiryStatus == "Select"))
                        {
                            intFranchiseeID = Convert.ToInt32(strFranchiseeID);
                            strCmd = string.Format(@"{0} WHERE e.RaisedOn BETWEEN '{1}' AND '{2}'AND e.FranchiseeID={3} ORDER BY e.EnquiryID ",
                                                              stdEnquiry, dtFrom.ToString("MM/dd/yyyy"), dtTo.ToString("MM/dd/yyyy"), intFranchiseeID);
                        }
                        //All Centres for selected status
                        if ((strFranchiseeID == "Select") && (strEnquiryStatus != "Select"))
                        {
                            strCmd = string.Format(@"{0} WHERE e.RaisedOn BETWEEN '{1}' AND '{2}' AND EnquiryStatus='{3}' ORDER BY e.EnquiryID ",
                                                              stdEnquiry, dtFrom.ToString("MM/dd/yyyy"), dtTo.ToString("MM/dd/yyyy"), strEnquiryStatus);
                        }
                    }

                    //BD.DataBindToDataList(dlEnquiry, strCmd);
                    BD.DataBindToGridView(gvEnquiry, strCmd, "NA");
                    break;
                case "StatusFilter":
                    string cStatus                          = e.CommandArgument.ToString();
                    lblEnquiryAction.Text                   = cStatus;
                    pnlViewEnquiry.Visible                  = true;
                    pnlViewEnquiryProfile.Visible           = false;
                    pnlEditEnquiryProfile.Visible           = false;
                    pnlEnquiryStatusModifications.Visible   = false;
                    pnlAddEnquiry.Visible                   = false;
                    if(cStatus=="ALL")
                        strCmd = string.Format(@"{0} ORDER BY e.EnquiryID DESC ", stdEnquiry);
                    else
                       strCmd = string.Format(@"{0} WHERE EnquiryStatus='{1}' ORDER BY e.EnquiryID DESC ",stdEnquiry, cStatus);

                    BD.DataBindToGridView(gvEnquiry, strCmd, "NA");
                    break;
                case "ReturnToViewEnquiry":
                    Response.Redirect("Enquiries.aspx");
                    break;
                default:
                    break;
            }
        }

        //Add New Enquiry
        protected void AddNewEnquiry(object sender, CommandEventArgs e)
        {
            SqlCommand ObjCmd = new SqlCommand("spInsertEnquiry", BD.ConStr);
            ObjCmd.CommandType = CommandType.StoredProcedure;
            ObjCmd.Parameters.AddWithValue("@ProgramId", Convert.ToInt32(ddlProgramId.SelectedValue.ToString()));
            ObjCmd.Parameters.AddWithValue("@FranchiseeID", Convert.ToInt32(ddlFranchiseeID.SelectedValue.ToString()));
            
            ObjCmd.Parameters.AddWithValue("@StudentName", txtBoxStudentName.Text);
            ObjCmd.Parameters.AddWithValue("@Gender", ddlGender.SelectedValue.ToString());
            ObjCmd.Parameters.AddWithValue("@Education", txtBoxEducation.Text);
            ObjCmd.Parameters.AddWithValue("@Institute", txtBoxInstitute.Text);
            ObjCmd.Parameters.AddWithValue("@Stream", txtBoxStream.Text);
            ObjCmd.Parameters.AddWithValue("@Email", txtBoxEmail.Text);
            ObjCmd.Parameters.AddWithValue("@Phone", txtBoxPhone.Text);
            ObjCmd.Parameters.AddWithValue("@City", txtBoxCity.Text);
            ObjCmd.Parameters.AddWithValue("@State", txtBoxState.Text);
            ObjCmd.Parameters.AddWithValue("@PinCode", txtBoxPinCode.Text);
            ObjCmd.Parameters.AddWithValue("@EnquiryMessage", txtBoxEnquiryMessage.Text);
            ObjCmd.Parameters.AddWithValue("@RaisedById", lblRaisedById.Text);
            ObjCmd.Parameters.AddWithValue("@EnquirySource", txtBoxSource.Text);

            BD.UpdateParameters(ObjCmd);
            //SP.Speak("Request Registered Successfully");
            //Response.Write("<script>alert('Request Registered Successfully')</script>");
            //Alert Sound
            ScriptManager.RegisterStartupScript(this, GetType(), "makeAlertSound", "playSound()", true);
            //Refresh View Enquiry List to display newly added Enquiry.
            //Response.Redirect("Enquiries.aspx");
            txtBoxStudentName.Text = "";
            txtBoxEmail.Text = "";
            txtBoxCity.Text = "";
            //Display Enquiry count
            //send Welcome Message to Enquiry
            //if (strNotify == "YES")
            //{
            //    Connect EC = new Connect();
            //    string strSMSmessage = string.Format("Dear '{0}, Thanks for visiting Purple Salon N Academy !!!", strFirstName);
            //    EC.SendSMS(strPhoneOne, strSMSmessage);
            //    SentMsgLogger("SMS", strSMSmessage, strPhoneOne, strFirstName);
            //}
        }

        //Higlight Enquiry Status
        protected void gvEnquiry_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                TableCell cell = e.Row.Cells[4];
                //int quantity = int.Parse(cell.Text);
                string EnquiryStatus = cell.Text;
                if (EnquiryStatus == "NEW")
                {
                    cell.BackColor = Color.HotPink;
                }
                if (EnquiryStatus == "PROSPECTS")
                {
                    cell.BackColor = Color.Yellow;
                }
                if (EnquiryStatus == "TELECALL")
                {
                    cell.BackColor = Color.LightGreen;
                }
                if (EnquiryStatus == "COUNSELLING")
                {
                    cell.BackColor = Color.GreenYellow;
                }
                if (EnquiryStatus == "FOLLOWUP")
                {
                    cell.BackColor = Color.Magenta;
                }
                if (EnquiryStatus == "CONVERTED")
                {
                    cell.BackColor = Color.LightSkyBlue;
                }
                if (EnquiryStatus == "COLD")
                {
                    cell.BackColor = Color.LightGray;
                }
            }


        }
        //Buttone Clicks on list of leads ViewDetails,Edit,ViewEditHistory
        protected void gvEnquiry_RowCommand(object sender,GridViewCommandEventArgs e)
        {
            string cmdName = e.CommandName.ToString();
            int intEnquiryId;
            switch (cmdName)
            {
                case "ViewProfile":
                    lblEnquiryAction.Text                   = "Enquiry Details";
                    pnlViewEnquiry.Visible                  = false;
                    pnlViewEnquiryProfile.Visible           = true;
                    pnlEditEnquiryProfile.Visible           = false;
                    pnlEnquiryStatusModifications.Visible   = false;
                    pnlAddEnquiry.Visible = false;
                    if (cmdName == "ViewProfile")
                    {
                        string[] commandArgs = new string[3];
                        commandArgs = e.CommandArgument.ToString().Split(';');
                        intEnquiryId = Convert.ToInt32(commandArgs[0].ToString());
                        string strCmd = string.Format(@"{0} WHERE EnquiryId={1}", stdEnquiry, intEnquiryId);
                        BD.DataBindToDataList(dlEnquiryDetails, strCmd);
                        //Display Age
                        List<int> list = MS.GetAge(commandArgs[1].ToString(), "spGetAge");
                        EnquiryAgeYears.Text = list[0].ToString();
                        EnquiryAgeMonths.Text = list[1].ToString();
                        EnquiryAgeDays.Text = list[2].ToString();
                    }
                    //Play Sound
                   
                    break;
                case "EditProfile":
                    lblEnquiryAction.Text = "Update Enquiry Status";
                    pnlViewEnquiry.Visible = false;
                    pnlViewEnquiryProfile.Visible = false;
                    pnlEditEnquiryProfile.Visible = true;
                    pnlEnquiryStatusModifications.Visible = false;
                    pnlAddEnquiry.Visible = false;
                    //
                    BD.DataBindToDataList(dlEditEnquiryProfile, string.Format(@"SELECT  * ,f.OrganizationName as Centre,a.FullName AS Assigned,o.FullName AS Owner 
                                                                               FROM EduSphere.Enquiries e JOIN EduSphere.Staff a ON e.AssignedEmployeeId=a.EmployeeId
                                                                                                          JOIN EduSphere.Organizations f ON e.FranchiseeId=f.OrganizationId 
                                                                                                          JOIN EduSphere.Staff o ON e.OwnerEmployeeId=o.EmployeeId WHERE EnquiryId='{0}'", Convert.ToInt32(e.CommandArgument.ToString())));
                    DropDownList ddlEditOwnerEmployeeId = new DropDownList();
                    DropDownList ddlEditAssignedEmployeeId = new DropDownList();
                    DropDownList ddlEditFranchiseeId = new DropDownList();
                    DropDownList ddlEditModifiedByEmployeeId = new DropDownList();
                    foreach (DataListItem li in dlEditEnquiryProfile.Items)
                    {
                        ddlEditOwnerEmployeeId = (DropDownList)li.FindControl("ddlEditOwnerEmployeeId");
                        ddlEditAssignedEmployeeId = (DropDownList)li.FindControl("ddlEditAssignedEmployeeId");
                        ddlEditFranchiseeId = (DropDownList)li.FindControl("ddlEditFranchiseeId");
                        ddlEditModifiedByEmployeeId = (DropDownList)li.FindControl("ddlEditModifiedByEmployeeId");

                    }
                    BD.DataBindToDropDownList(ddlEditOwnerEmployeeId, string.Format("SELECT FullName, EmployeeId FROM EduSphere.Staff"));

                    BD.DataBindToDropDownList(ddlEditAssignedEmployeeId, string.Format("SELECT EmployeeId, FullName FROM EduSphere.Staff"));
                    BD.DataBindToDropDownList(ddlEditFranchiseeId, string.Format("SELECT OrganizationId,OrganizationName FROM EduSphere.Organizations WHERE OrganizationType='{0}'", "FRANCHISEE"));
                    BD.DataBindToDropDownList(ddlEditModifiedByEmployeeId, string.Format("SELECT FullName, EmployeeId FROM EduSphere.Staff"));
                    break;
                case "ViewEnquiryStatusModifications":
                    lblEnquiryAction.Text = "Enquiry Modifications History";
                    pnlViewEnquiry.Visible = false;
                    pnlViewEnquiryProfile.Visible = false;
                    pnlEditEnquiryProfile.Visible = true;
                    pnlEnquiryStatusModifications.Visible = true;
                    pnlAddEnquiry.Visible = false;
                    //Display EnquiryStatusModifications History
                    intEnquiryId = Convert.ToInt32(e.CommandArgument.ToString());
                    string cmdStr = string.Format(@"SELECT *,a.FullName Assigned,own.FullName AS Owner FROM EduSphere.EnquiryStatusModifications mod 
                                                             JOIN EduSphere.Organizations org ON mod.FranchiseeId=org.OrganizationId 
                                                             JOIN EduSphere.Staff a ON mod.AssignedEmployeeId=a.EmployeeId
                                                             JOIN EduSphere.Staff own ON mod.AssignedEmployeeId=own.EmployeeId 
                                                    WHERE EnquiryId={0}", intEnquiryId);
                    BD.DataBindToGridView(gvEnquiryStatusModifications, cmdStr, "NA");
                   
                    break;

                default:
                    break;
            }

        }


        //Update Enquiry Profile
        protected void UpdateEnquiryProfile(object sender, DataListCommandEventArgs e)
        {
            
            int intNewFranchiseeId, intNewOwnerEmployeeId, intNewAssignedEmployeeId;
            SqlCommand ObjCmd = new SqlCommand("spEnquiryModification", BD.ConStr);
            ObjCmd.CommandType = CommandType.StoredProcedure;

            ObjCmd.Parameters.AddWithValue("@EnquiryId", Convert.ToInt32(dlEditEnquiryProfile.DataKeys[e.Item.ItemIndex]));
            //In case ddl contain Select=> no change. Pick up the existing Ids.
            //Owner change
            string strNewOwnerId = ((DropDownList)e.Item.FindControl("ddlEditOwnerEmployeeId")).SelectedValue.ToString();
            if (strNewOwnerId == "Select")
                intNewOwnerEmployeeId = Convert.ToInt32(((Label)e.Item.FindControl("lblCurrentOwnerId")).Text);
            else
                intNewOwnerEmployeeId = Convert.ToInt32(strNewOwnerId);

            //For Frnachisee change
            string strNewFranchiseeId = ((DropDownList)e.Item.FindControl("ddlEditFranchiseeId")).SelectedValue.ToString();
            if (strNewFranchiseeId == "Select")
                intNewFranchiseeId = Convert.ToInt32(((Label)e.Item.FindControl("lblCurrentFranchiseeId")).Text);
            else
                intNewFranchiseeId = Convert.ToInt32(strNewFranchiseeId);

            //For Assigned Employee Change
            string strNewAssignedId = ((DropDownList)e.Item.FindControl("ddlEditAssignedEmployeeId")).SelectedValue.ToString();
            if (strNewAssignedId == "Select")
                intNewAssignedEmployeeId = Convert.ToInt32(((Label)e.Item.FindControl("lblCurrentAssignedId")).Text);
            else
                intNewAssignedEmployeeId = Convert.ToInt32(strNewAssignedId);

            ObjCmd.Parameters.AddWithValue("@OwnerEmployeeId", intNewOwnerEmployeeId);
            ObjCmd.Parameters.AddWithValue("@FranchiseeId", intNewFranchiseeId);
            ObjCmd.Parameters.AddWithValue("@AssignedEmployeeId", intNewAssignedEmployeeId);

            
            //ObjCmd.Parameters.AddWithValue("@ModificationDate", DateTime.Parse(((Label)e.Item.FindControl("lblModificationDate")).Text));
            //Check if status is CLOSED.
            var strEnquiryStatus = ((DropDownList)e.Item.FindControl("ddlEditEnquiryStatus")).SelectedValue.ToString();
            ObjCmd.Parameters.AddWithValue("@EnquiryStatus", strEnquiryStatus);

            
            ObjCmd.Parameters.AddWithValue("@ModificationComments", ((TextBox)e.Item.FindControl("txtBoxEditMoficationComments")).Text);
            ObjCmd.Parameters.AddWithValue("@ModifiedById", Context.User.Identity.Name.ToString());
            int intModifiedByEmployeeId = Convert.ToInt32(((DropDownList)e.Item.FindControl("ddlEditModifiedByEmployeeId")).SelectedValue.ToString());
            ObjCmd.Parameters.AddWithValue("@ModifiedByEmployeeId", intModifiedByEmployeeId);
            ObjCmd.Parameters.AddWithValue("@ModificationArtifactTitle", ((TextBox)e.Item.FindControl("txtBoxEditAttachmentTitle")).Text);

            //Attachment mandatory  if Enquiry getting closed
            var lblModificationAttachment = (Label)e.Item.FindControl("lblModificationAttachment");
            ObjCmd.Parameters.AddWithValue("@ModificationAttachment", ((Label)e.Item.FindControl("lblModificationAttachment")).Text);
            if ((strEnquiryStatus == "CLOSED") && (lblModificationAttachment.Text == string.Empty))
            {
                Response.Write("<script>alert('Call Report must be attached for CLOSING. Modification failed')</script>");

            }
            else
            {
                BD.UpdateParameters(ObjCmd);
                //Response.Write("<script>alert('Modification done successfully !!!')</script>");
                
                //Go back displying all CSRs
               Response.Redirect("Enquiries.aspx");
            }
        }

        protected void ddlProgramGroup_SelectedIndexChanged(object sender, EventArgs e)
        {
            string query = string.Format("SELECT ProgramTitle,ProgramId FROM EduSphere.Programs WHERE ProgramGroupId={0}", Convert.ToInt32(ddlProgramGroup.SelectedValue.ToString()));
            BD.DataBindToDropDownList(ddlProgramId, query);
        }

       

        protected void btnFileUpload_EnquiryModification_Command(object sender, CommandEventArgs e)
        {
            FileUpload fu = new FileUpload();
            Label lblModificationAttachment = new Label();
            foreach (DataListItem dlitem in dlEditEnquiryProfile.Items)
            {
                fu = (FileUpload)dlitem.FindControl("flEnquiryModification");
                lblModificationAttachment = (Label)dlitem.FindControl("lblModificationAttachment");
            }

            //FileUpload fl   = (FileUpload)dlEditEnquiryProfile.FindControl("flEnquiryModification");
            if (fu.HasFile)
            {
                //Create a path to save the file
                string filename = Path.Combine(HttpContext.Current.Server.MapPath("~/Artifacts/Enquirys"), fu.FileName);
                //Display File path in text box for record insertion
                //lblModificationAttachment = (Label)dlEditEnquiryProfile.FindControl("lblModificationAttachment");
                lblModificationAttachment.Text = string.Format("~/Artifacts/Enquirys/" + fu.FileName);
                fu.SaveAs(filename);
                //allow Save if file

            }
        }

        protected void ddlEditCallOutsourceStatus_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList ddlEditCallOutsourceStatus = new DropDownList();
            DropDownList ddlEditVendorId = new DropDownList();
            DropDownList ddlEditAssignedEmployeeId = new DropDownList();
            TextBox txtBoxEditVendorCallCharges = new TextBox();
            TextBox txtBoxEditVendorSpareCharges = new TextBox();
            TextBox txtBoxEditAssignedEmployeeCallCharges = new TextBox();
            TextBox txtBoxEditAssignedEmployeeSpareCharges = new TextBox();
            foreach (DataListItem li in dlEditEnquiryProfile.Items)
            {
                ddlEditCallOutsourceStatus = (DropDownList)li.FindControl("ddlEditCallOutsourceStatus");
                ddlEditVendorId = (DropDownList)li.FindControl("ddlEditVendorId");
                ddlEditAssignedEmployeeId = (DropDownList)li.FindControl("ddlEditAssignedEmployeeId");
                txtBoxEditVendorCallCharges = (TextBox)li.FindControl("txtBoxEditVendorCallCharges");
                txtBoxEditVendorSpareCharges = (TextBox)li.FindControl("txtBoxEditVendorSpareCharges");
                txtBoxEditAssignedEmployeeCallCharges = (TextBox)li.FindControl("txtBoxEditAssignedEmployeeCallCharges");
                txtBoxEditAssignedEmployeeSpareCharges = (TextBox)li.FindControl("txtBoxEditAssignedEmployeeSpareCharges");
            }

            string option = ddlEditCallOutsourceStatus.SelectedValue.ToString();
            if (option == "VENDOR")
            {
                ddlEditAssignedEmployeeId.Visible = false;
                txtBoxEditAssignedEmployeeCallCharges.Visible = false;
                txtBoxEditAssignedEmployeeSpareCharges.Visible = false;
                txtBoxEditAssignedEmployeeCallCharges.Text = "0";
                txtBoxEditAssignedEmployeeSpareCharges.Text = "0";

                ddlEditVendorId.Visible = true;
                txtBoxEditVendorCallCharges.Visible = true;
                txtBoxEditVendorSpareCharges.Visible = true;
            }
            if (option == "EMPLOYEE")
            {
                ddlEditVendorId.Visible = false;
                txtBoxEditVendorCallCharges.Visible = false;
                txtBoxEditVendorSpareCharges.Visible = false;
                txtBoxEditVendorCallCharges.Text = "0";
                txtBoxEditVendorSpareCharges.Text = "0";

                ddlEditAssignedEmployeeId.Visible = true;
                txtBoxEditAssignedEmployeeCallCharges.Visible = true;
                txtBoxEditAssignedEmployeeSpareCharges.Visible = true;
            }
        }

        protected void OnEnquiryStatus_Changed(object sender, EventArgs e)
        {
            DropDownList ddlEditEnquiryStatus = new DropDownList();
            //LinkButton lnkBtnUpdateEnquiryProfile   = new LinkButton(); 
            Label lblCloseWarning = new Label();
            foreach (DataListItem dlItem in dlEditEnquiryProfile.Items)
            {
                ddlEditEnquiryStatus = (DropDownList)dlItem.FindControl("ddlEditEnquiryStatus");
                //lnkBtnUpdateEnquiryProfile  = (LinkButton)dlItem.FindControl("lnkBtnUpdateEnquiryProfile");
                lblCloseWarning = (Label)dlItem.FindControl("lblCloseWarning");
            }

            string strEnquiryStatus = ddlEditEnquiryStatus.SelectedValue.ToString();
            if (strEnquiryStatus == "CLOSED")
            {
                lblCloseWarning.Text = "Modification will FAIL without Call Report Upload";
                //lnkBtnUpdateEnquiryProfile.Visible = false;
                //Response.Write("<script>alert('Call Report is MUST for  CLOSING')</script>");
            }
            else
            {
                lblCloseWarning.Text = "";
            }

        }
    }
}