using EduSpherePro.CoreServices;
using EduSpherePro.Models;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
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
    public partial class Roles : System.Web.UI.Page
    {
        IBindData BD = new BindData();
        IAnalytics MS = new Analytics();
        ISpeechService SP = new SpeechService();
        string stdRoleRequests = @"SELECT  * FROM EduSphere.RoleRequests r JOIN EduSphere.States p ON r.RequesterState=p.StateID JOIN EduSphere.Organizations o ON r.OrganizationID=o.OrganizationID";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                User.ToString();
                //SP.Speak("Welcome to lead management");


                lblRoleRequestsAction.Text                  = "View Requests";
                pnlViewRoleRequests.Visible                 = true;
                pnlViewRoleRequestsProfile.Visible          = false;
                pnlEditRoleRequestsProfile.Visible          = false;
                pnlRoleRequestsStatusModifications.Visible  = false;
                pnlAddRoleRequests.Visible                  = false;

                BD.DataBindToDropDownList(ddlFilterOrganizationName, string.Format("SELECT OrganizationName,OrganizationId FROM EduSphere.Organizations WHERE OrganizationType='{0}'", "FRANCHISEE"));
                string queryRoleRequests;
                //Allow Manager to view the role request of her/his Organization only ONLY...shivmani 8th April 2020.
                if (User.IsInRole("Manager"))
                    queryRoleRequests = string.Format(@"SELECT TOP 1000 * FROM EduSphere.RoleRequests r
                                                                          JOIN EduSphere.States p ON r.RequesterState=p.StateID 
                                                                          JOIN EduSphere.Organizations o on r.OrganizationID=o.OrganizationID
                                                                          WHERE r.OrganizationID=(SELECT OrganizationID FROM EduSphere.Staff WHERE Email='{0}')  
                                                                          ORDER BY RequestID DESC", User.Identity.Name.ToString());
                else
                    queryRoleRequests = string.Format(@"SELECT TOP 1000 * FROM EduSphere.RoleRequests r 
                                                                            JOIN EduSphere.States p ON r.RequesterState=p.StateID 
                                                                            JOIN EduSphere.Organizations o on r.OrganizationID=o.OrganizationID  ORDER BY RequestID DESC");
                BD.DataBindToGridView(gvRoleRequests, queryRoleRequests, "NA");

                //Displya Count
                BD.DataBindToLabel(lblCountRequests, string.Format("SELECT COUNT(RequestID) FROM EduSphere.RoleRequests WHERE RequestApprovalStatus='{0}'", "NEW"));
                BD.DataBindToLabel(lblCountRequestsApproved, string.Format("SELECT COUNT(RequestID) FROM EduSphere.RoleRequests WHERE RequestApprovalStatus='{0}'", "APPROVED"));
            }
        }

        //Manage RoleRequests Panel Displays
        protected void ManageRoleRequestsVisibility(object sender, CommandEventArgs e)
        {
            string cmdName, strCmd = "";
            int intRequestID;
            cmdName = e.CommandName.ToString();
            string[] commandArgs = new string[3];

            switch (cmdName)
            {
                case "AddRoleRequests":
                    lblRoleRequestsAction.Text          = "New RoleRequests";
                    pnlViewRoleRequests.Visible         = false;
                    pnlViewRoleRequestsProfile.Visible  = false;
                    pnlEditRoleRequestsProfile.Visible  = false;
                    pnlRoleRequestsStatusModifications.Visible = false;
                    pnlAddRoleRequests.Visible = true;
                    BD.DataBindToDropDownList(ddlProgramGroup, string.Format("SELECT ProgramGroupId,ProgramGroup FROM EduSphere.ProgramGroups"));
                    BD.DataBindToDropDownList(ddlFranchiseeID, string.Format("SELECT OrganizationName,OrganizationId FROM EduSphere.Organizations WHERE OrganizationType='{0}'", "EDUCATION-CENTRE"));
                    //BD.DataBindToDropDownList(ddlCustomerId, string.Format("SELECT OrganizationName,OrganizationId FROM EduSphere.Organizations WHERE OrganizationType='{0}'", "CUSTOMER"));
                    //BD.DataBindToDropDownList(ddlRaisedByProxyEmployeeId, string.Format("SELECT EmployeeId,FullName FROM EduSphere.Staff"));
                    lblRaisedById.Text = Context.User.Identity.Name.ToString();

                    break;


                case "SearchRoleRequests":
                case "FilterRoleRequests":
                    lblRoleRequestsAction.Text = "Filter Requests";
                    pnlViewRoleRequests.Visible = true;
                    pnlViewRoleRequestsProfile.Visible = false;
                    pnlEditRoleRequestsProfile.Visible = false;
                    pnlRoleRequestsStatusModifications.Visible = false;
                    pnlAddRoleRequests.Visible = false;

                    if (cmdName == "SearchRoleRequests")
                    {
                        string strSearchParam = txtBoxSearchRoleRequests.Text.ToString();
                        if (User.IsInRole("Manager"))
                            strCmd = string.Format(@"SELECT * FROM EduSphere.RoleRequests r JOIN EduSphere.States p ON r.RequesterState=p.StateID 
                                                        JOIN EduSphere.Organizations o ON r.OrganizationID=o.OrganizationID
                                                    WHERE RequesterPhone LIKE '%{0}%' OR RequesterFullName LIKE '%{0}%' AND r.OrganizationID=(SELECT OrganizationID FROM EduSphere.Staff WHERE Email='{1}') ",strSearchParam,User.Identity.Name.ToString());
                        else
                            strCmd = string.Format(@"SELECT * FROM EduSphere.RoleRequests r JOIN EduSphere.States p ON r.RequesterState=p.StateID  
                                                        JOIN EduSphere.Organizations o ON r.OrganizationID=o.OrganizationID
                                                    WHERE RequesterPhone LIKE '%{0}%' OR RequesterFullName LIKE '%{0}%' ", strSearchParam);

                    }
                    if (cmdName == "FilterRoleRequests")
                    {
                        DateTime dtFrom     = DateTime.ParseExact(txtBoxFromDate.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture);
                        DateTime dtTo       = DateTime.ParseExact(txtBoxToDate.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture);
                        //int intFranchiseeID = 0;
                        //string strRequestApprovalStatus = ddlFilterOrganizationName.SelectedValue.ToString();
                        string strRoleRequestsStatus = ddlFilterRoleRequestsStatus.SelectedValue.ToString();
                        //All for selected date
                        if ((strRoleRequestsStatus == "Select") && (strRoleRequestsStatus == "Select"))
                        {
                            strCmd = string.Format(@"SELECT * FROM EduSphere.RoleRequests r JOIN EduSphere.States p ON r.RequesterState=p.StateID
                                                               JOIN EduSphere.Organizations o ON r.OrganizationID=o.OrganizationID 
                                                                WHERE RaisedOn BETWEEN '{0}' AND '{1}' ORDER BY RequestID DESC ",
                                                              dtFrom.ToString("MM/dd/yyyy"), dtTo.ToString("MM/dd/yyyy"));

                        }
                        if ((strRoleRequestsStatus != "Select") && (strRoleRequestsStatus != "Select"))
                        {
                            //intFranchiseeID = Convert.ToInt32(strFranchiseeID);
                            strCmd = string.Format(@"SELECT * FROM EduSphere.RoleRequests r 
                                                            JOIN EduSphere.States p ON r.RequesterState=p.StateID
                                                            JOIN EduSphere.Organizations o ON r.OrganizationID=o.OrganizationID 
                                                            WHERE RaisedOn BETWEEN '{0}' AND '{1}'  AND RequestApprovalStatus='{2}' ORDER BY RequestID DESC ",
                                                               dtFrom.ToString("MM/dd/yyyy"), dtTo.ToString("MM/dd/yyyy"), strRoleRequestsStatus);

                        }
                        ////All Status for selected centre
                        //if ((strRoleRequestsStatus != "Select") && (strRoleRequestsStatus == "Select"))
                        //{
                        //    //intFranchiseeID = Convert.ToInt32(strFranchiseeID);
                        //    strCmd = string.Format(@"{0}SELECT * FROM EduSphere.RoleRequests WHERE e.RaisedOn BETWEEN '{1}' AND '{2}'AND e.FranchiseeID={3} ORDER BY e.RoleRequestsID ",
                        //                                      stdRoleRequests, dtFrom.ToString("MM/dd/yyyy"), dtTo.ToString("MM/dd/yyyy"), intFranchiseeID);
                        //}
                        //All Centres for selected status
                        //if ((strRoleRequestsStatus == "Select") && (strRoleRequestsStatus != "Select"))
                        //{
                        //    strCmd = string.Format(@"SELECT * FROM EduSphere.RoleRequests WHERE e.RaisedOn BETWEEN '{1}' AND '{2}' AND RequestApprovalStatus='{3}' ORDER BY e.RoleRequestsID ",
                        //                                      stdRoleRequests, dtFrom.ToString("MM/dd/yyyy"), dtTo.ToString("MM/dd/yyyy"), strRoleRequestsStatus);
                        //}
                    }

                    //BD.DataBindToDataList(dlRoleRequests, strCmd);
                    BD.DataBindToGridView(gvRoleRequests, strCmd, "NA");
                    break;
                case "StatusFilter":
                    string cStatus                              = e.CommandArgument.ToString();
                    lblRoleRequestsAction.Text                  = cStatus;
                    pnlViewRoleRequests.Visible                 = true;
                    pnlViewRoleRequestsProfile.Visible          = false;
                    pnlEditRoleRequestsProfile.Visible          = false;
                    pnlRoleRequestsStatusModifications.Visible  = false;
                    pnlAddRoleRequests.Visible = false;
                    if (cStatus == "ALL")
                    {
                        strCmd = string.Format(@"{0} ", stdRoleRequests);
                        //Count Requests
                        BD.DataBindToLabel(lblCountRequests, string.Format("SELECT COUNT(RequestID) FROM EduSphere.RoleRequests WHERE RequestApprovalStatus='{0}'", "NEW"));
                        BD.DataBindToLabel(lblCountRequestsApproved, string.Format("SELECT COUNT(RequestID) FROM EduSphere.RoleRequests WHERE RequestApprovalStatus='{0}'", "APPROVED"));
                    }
                    else
                    { 
                        //strCmd = string.Format(@"{0} WHERE RequestApprovalStatus='{1}'", stdRoleRequests, cStatus);
                        strCmd = string.Format(@"{0} WHERE RequestedRoleName='{1}'", stdRoleRequests, cStatus);
                        // Count Requests
                        BD.DataBindToLabel(lblCountRequests, string.Format("SELECT COUNT(RequestID) FROM EduSphere.RoleRequests WHERE RequestApprovalStatus='{0}' AND RequestedRoleName='{1}'", "NEW",cStatus));
                        BD.DataBindToLabel(lblCountRequestsApproved, string.Format("SELECT COUNT(RequestID) FROM EduSphere.RoleRequests WHERE RequestApprovalStatus='{0}' AND RequestedRoleName='{1}'", "APPROVED", cStatus));
                    }
                    BD.DataBindToGridView(gvRoleRequests, strCmd, "NA");
                    break;
                case "ReturnToViewRoleRequests":
                    Response.Redirect("Roles.aspx");
                    break;
                default:
                    break;
            }
        }

        //Add New RoleRequests
        protected void AddNewRoleRequests(object sender, CommandEventArgs e)
        {
            SqlCommand ObjCmd = new SqlCommand("spInsertRoleRequests", BD.ConStr);
            ObjCmd.CommandType = CommandType.StoredProcedure;
            ObjCmd.Parameters.AddWithValue("@ProgramId", Convert.ToInt32(ddlProgramId.SelectedValue.ToString()));
            ObjCmd.Parameters.AddWithValue("@FranchiseeID", Convert.ToInt32(ddlFranchiseeID.SelectedValue.ToString()));

            ObjCmd.Parameters.AddWithValue("@RequesterFullName", txtBoxStudentName.Text);
            ObjCmd.Parameters.AddWithValue("@Gender", ddlGender.SelectedValue.ToString());
            ObjCmd.Parameters.AddWithValue("@Education", txtBoxEducation.Text);
            ObjCmd.Parameters.AddWithValue("@Institute", txtBoxInstitute.Text);
            ObjCmd.Parameters.AddWithValue("@Stream", txtBoxStream.Text);
            ObjCmd.Parameters.AddWithValue("@RequesterEmail", txtBoxEmail.Text);
            ObjCmd.Parameters.AddWithValue("@RequesterPhone", txtBoxPhone.Text);
            ObjCmd.Parameters.AddWithValue("@RequesterState", txtBoxCity.Text);
            ObjCmd.Parameters.AddWithValue("@RequesterAddress", txtBoxState.Text);
            ObjCmd.Parameters.AddWithValue("@PinCode", txtBoxPinCode.Text);
            ObjCmd.Parameters.AddWithValue("@RoleRequestsMessage", txtBoxRoleRequestsMessage.Text);
            ObjCmd.Parameters.AddWithValue("@RaisedById", lblRaisedById.Text);
            ObjCmd.Parameters.AddWithValue("@RoleRequestsSource", txtBoxSource.Text);

            BD.UpdateParameters(ObjCmd);
            //SP.Speak("Request Registered Successfully");
            //Response.Write("<script>alert('Request Registered Successfully')</script>");
            //Alert Sound
            ScriptManager.RegisterStartupScript(this, GetType(), "makeAlertSound", "playSound()", true);
            //Refresh View RoleRequests List to display newly added RoleRequests.
            //Response.Redirect("Requests.aspx");
            txtBoxStudentName.Text = "";
            txtBoxEmail.Text = "";
            txtBoxCity.Text = "";
            //Display RoleRequests count
            //send Welcome Message to RoleRequests
            //if (strNotify == "YES")
            //{
            //    Connect EC = new Connect();
            //    string strSMSmessage = string.Format("Dear '{0}, Thanks for visiting Purple Salon N Academy !!!", strFirstName);
            //    EC.SendSMS(strPhoneOne, strSMSmessage);
            //    SentMsgLogger("SMS", strSMSmessage, strPhoneOne, strFirstName);
            //}
        }

        //Higlight RoleRequests Status
        protected void gvRoleRequests_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                TableCell cell = e.Row.Cells[4];
                //int quantity = int.Parse(cell.Text);
                string RequestApprovalStatus = cell.Text;
                if (RequestApprovalStatus == "NEW")
                {
                    cell.BackColor = Color.HotPink;
                }
                if (RequestApprovalStatus == "PROSPECTS")
                {
                    cell.BackColor = Color.Yellow;
                }
                if (RequestApprovalStatus == "TELECALL")
                {
                    cell.BackColor = Color.LightGreen;
                }
                if (RequestApprovalStatus == "COUNSELLING")
                {
                    cell.BackColor = Color.GreenYellow;
                }
                if (RequestApprovalStatus == "FOLLOWUP")
                {
                    cell.BackColor = Color.Magenta;
                }
                if (RequestApprovalStatus == "CONVERTED")
                {
                    cell.BackColor = Color.LightSkyBlue;
                }
                if (RequestApprovalStatus == "COLD")
                {
                    cell.BackColor = Color.LightGray;
                }
            }


        }
        //Buttone Clicks on list of leads ViewDetails,Edit,ViewEditHistory
        protected void gvRoleRequests_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string cmdName = e.CommandName.ToString();
            string[] commandArgs = new string[3];
            int intRequestID;
            switch (cmdName)
            {
                case "ViewProfile":
                    lblRoleRequestsAction.Text = "RoleRequests Details";
                    pnlViewRoleRequests.Visible = false;
                    pnlViewRoleRequestsProfile.Visible = true;
                    pnlEditRoleRequestsProfile.Visible = false;
                    pnlRoleRequestsStatusModifications.Visible = false;
                    pnlAddRoleRequests.Visible = false;
                    if (cmdName == "ViewProfile")
                    { 
                        commandArgs = e.CommandArgument.ToString().Split(';');
                        intRequestID = Convert.ToInt32(commandArgs[0].ToString());
                        string strCmd = string.Format(@"SELECT * FROM EduSphere.RoleRequests r 
                                                                JOIN EduSphere.Organizations o ON r.OrgnanizationID=o.OrganizationID
                                                                WHERE RequestID={0}", intRequestID);
                        BD.DataBindToDataList(dlRoleRequestsDetails, strCmd);
                        //Display Age
                        List<int> list = MS.GetAge(commandArgs[1].ToString(), "spGetAge");
                        RoleRequestsAgeYears.Text = list[0].ToString();
                        RoleRequestsAgeMonths.Text = list[1].ToString();
                        RoleRequestsAgeDays.Text = list[2].ToString();
                    }
                    //Play Sound

                    break;
                case "DeleteRequest":
                    commandArgs = e.CommandArgument.ToString().Split(';');
                    intRequestID = Convert.ToInt32(commandArgs[0].ToString());
                    string strDelCmd = string.Format("DELETE FROM EduSphere.RoleRequests WHERE RequestID={0}", intRequestID);
                    SqlCommand delCmd = new SqlCommand(strDelCmd, BD.ConStr);
                    BD.UpdateParameters(delCmd);
                    BD.DataBindToGridView(gvRoleRequests, string.Format(@"SELECT * FROM EduSphere.RoleRequests r 
                                                                JOIN EduSphere.Organizations o ON r.OrgnanizationID = o.OrganizationID WHERE RequestApprovalStatus='NEW'"),"NA");
                    break;
                case "EditProfile":
                    lblRoleRequestsAction.Text          = "Approve Deny Access";
                    pnlViewRoleRequests.Visible         = false;
                    pnlViewRoleRequestsProfile.Visible  = false;
                    pnlEditRoleRequestsProfile.Visible          = true;
                    pnlRoleRequestsStatusModifications.Visible = false;
                    pnlAddRoleRequests.Visible = false;
                    //
                    BD.DataBindToDataList(dlEditRoleRequestsProfile, string.Format(@"SELECT  * FROM EduSphere.RoleRequests r JOIN EduSphere.States p ON r.RequesterState=p.StateID
                                                                JOIN EduSphere.Organizations o ON r.OrganizationID=o.OrganizationID
                                                                WHERE RequestID='{0}'", Convert.ToInt32(e.CommandArgument.ToString())));
                    //DropDownList ddlEditRequestApprovalStatus = new DropDownList();
                    //DropDownList ddlEditRole = new DropDownList();
                    
                    //foreach (DataListItem li in dlEditRoleRequestsProfile.Items)
                    //{
                    //    ddlEditRequestApprovalStatus = (DropDownList)li.FindControl("ddlEditRequestApprovalStatus");
                    //    ddlEditRole                  = (DropDownList)li.FindControl("ddlEditRole");                        
                    //}
                    
                    break;
                case "ViewRoleRequestsStatusModifications":
                    lblRoleRequestsAction.Text = "RoleRequests Modifications History";
                    pnlViewRoleRequests.Visible = false;
                    pnlViewRoleRequestsProfile.Visible = false;
                    pnlEditRoleRequestsProfile.Visible = true;
                    pnlRoleRequestsStatusModifications.Visible = true;
                    pnlAddRoleRequests.Visible = false;
                    //Display RoleRequestsStatusModifications History
                    intRequestID = Convert.ToInt32(e.CommandArgument.ToString());
                    string cmdStr = string.Format(@"SELECT *,a.FullName Assigned,own.FullName AS Owner FROM EduSphere.RoleRequestsStatusModifications mod 
                                                             JOIN EduSphere.Organizations org ON mod.FranchiseeId=org.OrganizationId 
                                                             JOIN EduSphere.Staff a ON mod.AssignedEmployeeId=a.EmployeeId
                                                             JOIN EduSphere.Staff own ON mod.AssignedEmployeeId=own.EmployeeId 
                                                    WHERE RequestID={0}", intRequestID);
                    BD.DataBindToGridView(gvRoleRequestsStatusModifications, cmdStr, "NA");

                    break;

                default:
                    break;
            }

        }
        
        //Create New User
        protected string CreateNewUser(int RequestID,string FullName, string Email,string Phone,string Role, string Country, string Address,string Password)
        {
            string status = "";
            var manager         = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
            var signInManager   = Context.GetOwinContext().Get<ApplicationSignInManager>();
            var user            = new ApplicationUser() { FullName = FullName, UserName = Email, Email = Email };
            //Add Address to preexisitng collection
            user.Addresses.Add(new ApplicationUser.Address { AddressLine = Address, Country = Country, UserId = user.Id });
            //Pass this user into registeration method
            IdentityResult result = manager.Create(user, Password);
            if (result.Succeeded)
            {
                //Assign user role
                var result1 = manager.AddToRole(user.Id, Role);
                // For more information on how to enable account confirmation and password reset please visit http://go.microsoft.com/fwlink/?LinkID=320771
                string code = manager.GenerateEmailConfirmationToken(user.Id);
                string callbackUrl = IdentityHelper.GetUserConfirmationRedirectUrl(code, user.Id, Request);
                manager.SendEmail(user.Id, "Confirm your Neurotherapy Academy Account.", "Please confirm your account by clicking <a href=\"" + callbackUrl + "\">here</a>. Your email is your user id and Password is first four letters of your Name followed by @First four digits of your phone number. e.g Raje@7892.Its case sensitive, only first letter is capital");


                //if created successfully, update request table
                status = "SUCCESS";
                
                //Commented below line to keep admin remain logged in for further user creation
                //signInManager.SignIn(user, isPersistent: false, rememberBrowser: false);
                //IdentityHelper.RedirectToReturnUrl(Request.QueryString["ReturnUrl"], Response);

            }
            else
            {
                ErrorMessage.Text = result.Errors.FirstOrDefault();
                status = "ERROR";
            }
            return status;
        }

        //Update RoleRequests Profile
        protected void UpdateRoleRequestsProfile(object sender, DataListCommandEventArgs e)
        {
            int RequestID       = Convert.ToInt32(((Label)e.Item.FindControl("RequestID")).Text);
            string FullName     = ((TextBox)e.Item.FindControl("FullName")).Text;
            string OrgID        = ((Label)e.Item.FindControl("OrgnaizationID")).Text;
            string Address      = ((TextBox)e.Item.FindControl("State")).Text;
            string Country      = ((TextBox)e.Item.FindControl("State")).Text;
            string Role         = ((DropDownList)e.Item.FindControl("ddlRole")).SelectedValue.ToString();
            string Email        = ((TextBox)e.Item.FindControl("Email")).Text;
            string Phone        = ((TextBox)e.Item.FindControl("Phone")).Text;
            //string Password = ((TextBox)e.Item.FindControl("Password")).Text;
            string Password = string.Format(FullName.Substring(0, 1).ToUpper()+ FullName.Substring(1, 3).ToLower()+ "@" + Phone.Substring(0, 4));
            string ApprovalStatus = ((DropDownList)e.Item.FindControl("ddlRequestApprovalStatus")).SelectedValue.ToString();
            if(ApprovalStatus=="APPROVED")
            {
                //Create new user and grant login role.
                string UserCreationStatus = CreateNewUser(RequestID, FullName, Email, Phone, Role, Country, Address, Password);
                if (UserCreationStatus == "SUCCESS")
                {
                    //spUpdateRequestStatus also insert the data to Members by executing another procedure on SQL server
                    SqlCommand ObjCmd = new SqlCommand("spUpdateRequestStatus", BD.ConStr);
                    ObjCmd.CommandType = CommandType.StoredProcedure;
                    ObjCmd.Parameters.AddWithValue("@RequestID", RequestID);
                    ObjCmd.Parameters.AddWithValue("@RequesterFullName", FullName);
                    ObjCmd.Parameters.AddWithValue("@OrganizationID", Convert.ToInt32(OrgID));//needed for inserting into Members table
                    //ObjCmd.Parameters.AddWithValue("RequesterState", Country);
                    ObjCmd.Parameters.AddWithValue("@RequesterPhone", Phone);
                    ObjCmd.Parameters.AddWithValue("@RequestedRoleName", Role);
                    ObjCmd.Parameters.AddWithValue("@RequesterEmail", Email);
                    ObjCmd.Parameters.AddWithValue("@RequestApprovalStatus", "APPROVED");
                    BD.UpdateParameters(ObjCmd);
                    //Ad a new Member in Therapist or Student
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('User Created !!!')", true);


                }
            }
            if(ApprovalStatus=="EDITROLE")
            {
                
            }
              
            if(ApprovalStatus == "BLOCKED")
            {

            }
        }

        protected void ddlProgramGroup_SelectedIndexChanged(object sender, EventArgs e)
        {
            string query = string.Format("SELECT ProgramTitle,ProgramId FROM EduSphere.Programs WHERE ProgramGroupId={0}", Convert.ToInt32(ddlProgramGroup.SelectedValue.ToString()));
            BD.DataBindToDropDownList(ddlProgramId, query);
        }



        protected void btnFileUpload_RoleRequestsModification_Command(object sender, CommandEventArgs e)
        {
            FileUpload fu = new FileUpload();
            Label lblModificationAttachment = new Label();
            foreach (DataListItem dlitem in dlEditRoleRequestsProfile.Items)
            {
                fu = (FileUpload)dlitem.FindControl("flRoleRequestsModification");
                lblModificationAttachment = (Label)dlitem.FindControl("lblModificationAttachment");
            }

            //FileUpload fl   = (FileUpload)dlEditRoleRequestsProfile.FindControl("flRoleRequestsModification");
            if (fu.HasFile)
            {
                //Create a path to save the file
                string filename = Path.Combine(HttpContext.Current.Server.MapPath("~/Artifacts/RoleRequestss"), fu.FileName);
                //Display File path in text box for record insertion
                //lblModificationAttachment = (Label)dlEditRoleRequestsProfile.FindControl("lblModificationAttachment");
                lblModificationAttachment.Text = string.Format("~/Artifacts/RoleRequestss/" + fu.FileName);
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
            foreach (DataListItem li in dlEditRoleRequestsProfile.Items)
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

        protected void OnRoleRequestsStatus_Changed(object sender, EventArgs e)
        {
            DropDownList ddlEditRoleRequestsStatus = new DropDownList();
            //LinkButton lnkBtnUpdateRoleRequestsProfile   = new LinkButton(); 
            Label lblCloseWarning = new Label();
            foreach (DataListItem dlItem in dlEditRoleRequestsProfile.Items)
            {
                ddlEditRoleRequestsStatus = (DropDownList)dlItem.FindControl("ddlEditRoleRequestsStatus");
                //lnkBtnUpdateRoleRequestsProfile  = (LinkButton)dlItem.FindControl("lnkBtnUpdateRoleRequestsProfile");
                lblCloseWarning = (Label)dlItem.FindControl("lblCloseWarning");
            }

            string strRoleRequestsStatus = ddlEditRoleRequestsStatus.SelectedValue.ToString();
            if (strRoleRequestsStatus == "CLOSED")
            {
                lblCloseWarning.Text = "Modification will FAIL without Call Report Upload";
                //lnkBtnUpdateRoleRequestsProfile.Visible = false;
                //Response.Write("<script>alert('Call Report is MUST for  CLOSING')</script>");
            }
            else
            {
                lblCloseWarning.Text = "";
            }

        }
    }
}