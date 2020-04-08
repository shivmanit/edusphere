
using EduSpherePro.CoreServices;
using iTextSharp.text.pdf;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EduSpherePro.DigiView
{
    public partial class Admission : System.Web.UI.Page
    {
        IBindData BD = new BindData();

        IAnalytics MT = new Analytics();
        IMailService MS = new MailService();
        IFileService FS = new FileService();
        ISMSSender SMS = new SMSSender();
        IPdfGenerator PG = new PdfGenerator();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblStaffAction.Text = "View Staff";
                pnlViewStaff.Visible = true;
                pnlAddStaff.Visible = false;
                pnlUploadStaffDocument.Visible = false;
                pnlViewStaffDocuments.Visible = false;
                pnlEditStaffProfile.Visible = false;
                pnlViewStaffProfile.Visible = false;
                pnlAddStaff.Visible = false;

                string strCmd = string.Format(@"SELECT TOP 100 org.OrganizationName as OrganizationName,MemberID,FullName,st.PhoneOne as PhoneOne,st.Email as Email 
                                                FROM EduSphere.Members st 
                                                JOIN EduSphere.Organizations org ON st.OrganizationID=org.OrganizationID 
                                                WHERE MemberID>=100 AND MembershipStatus='{0}' AND st.Email='{1}'", "ACTIVE",User.Identity.Name.ToString());
                BD.DataBindToDataList(dlStaff, strCmd);
            }
        }

        //Populate City,State.Country based on PinCode
        //protected void FillAddress(object sender, EventArgs e)
        //{
        //    txtBoxCity.Text = hdCity.Value;
        //    txtBoxState.Text = hdState.Value;
        //    txtBoxCountry.Text = hdCountry.Value;
        //}
        //Manage Staff Panel Displays
        protected void ManageStaffVisibility(object sender, CommandEventArgs e)
        {
            string cmdName, strCmd = "";
            int intEmployeeId;
            cmdName = e.CommandName.ToString();

            switch (cmdName)
            {
                case "AddStaff":
                    lblStaffAction.Text = "Add New Staff";
                    pnlViewStaff.Visible = false;
                    pnlAddStaff.Visible = true;
                    pnlUploadStaffDocument.Visible = false;
                    pnlViewStaffDocuments.Visible = false;
                    pnlHelp.Visible = false;
                    pnlViewStaffProfile.Visible = false;
                    pnlEditStaffProfile.Visible = false;
                    pnlNeuroAcademics.Visible = false;
                    pnlNeuroPublications.Visible = false;
                    BD.DataBindToDropDownList(ddlOrgId, string.Format("SELECT OrganizationID,OrganizationName FROM EduSphere.Organizations"));
                    BD.DataBindToDropDownList(ddlManagerId, string.Format("SELECT FUllName,MemberID FROM EduSphere.Members"));
                    break;
                case "UploadStaffDocument":
                    lblStaffAction.Text = "Upload Staff Document";
                    pnlViewStaff.Visible = false;
                    pnlAddStaff.Visible = false;
                    pnlUploadStaffDocument.Visible = true;
                    pnlViewStaffDocuments.Visible = false;
                    pnlHelp.Visible = false;
                    pnlEditStaffProfile.Visible = false;
                    pnlViewStaffProfile.Visible = false;
                    pnlNeuroAcademics.Visible = false;
                    pnlNeuroPublications.Visible = false;
                    lblEmployeeId.Text = e.CommandArgument.ToString();
                    break;
                case "ViewStaffDocument":
                    lblStaffAction.Text = "View Document";
                    pnlViewStaff.Visible = false;
                    pnlAddStaff.Visible = false;
                    pnlUploadStaffDocument.Visible = false;
                    pnlViewStaffDocuments.Visible = true;
                    pnlHelp.Visible = false;
                    pnlEditStaffProfile.Visible = false;
                    pnlViewStaffProfile.Visible = false;
                    pnlNeuroAcademics.Visible = false;
                    pnlNeuroPublications.Visible = false;
                    intEmployeeId = Convert.ToInt32(e.CommandArgument.ToString());
                    string docQuery = string.Format("SELECT * FROM EduSphere.MemberDocuments WHERE MemberID='{0}'", intEmployeeId);
                    BD.DataBindToGridView(gvStaffDocuments, docQuery, "NA");
                    break;
                case "ViewHelp":
                    lblStaffAction.Text = "View Document";
                    pnlViewStaff.Visible = false;
                    pnlAddStaff.Visible = false;
                    pnlUploadStaffDocument.Visible = false;
                    pnlViewStaffDocuments.Visible = false;
                    pnlHelp.Visible = true;
                    pnlEditStaffProfile.Visible = false;
                    pnlViewStaffProfile.Visible = false;
                    pnlNeuroAcademics.Visible = false;
                    pnlNeuroPublications.Visible = false;
                    //intEmployeeId = Convert.ToInt32(e.CommandArgument.ToString());
                    string helpQuery = string.Format("SELECT * FROM EduSphere.HelpDocuments");
                    BD.DataBindToGridView(gvHelpDocuments, helpQuery, "NA");
                    break;
                case "AcademicDetails":
                    string acadQuery = string.Format("SELECT * FROM EduSphere.MemberAcademics where MemberID='{0}'", Convert.ToInt32(e.CommandArgument.ToString()));
                    BD.DataBindToDataList(dlAcademicDetails, acadQuery);
                    lblEID.Text = e.CommandArgument.ToString();
                    pnlViewStaff.Visible            = false;
                    pnlAddStaff.Visible             = false;
                    pnlUploadStaffDocument.Visible  = false;
                    pnlViewStaffDocuments.Visible   = false;
                    pnlHelp.Visible                 = false;
                    pnlEditStaffProfile.Visible     = false;
                    pnlViewStaffProfile.Visible     = false;
                    pnlNeuroAcademics.Visible      = true;
                   
                    break;
                case "PublicationDetails":
                    string pubQuery = string.Format("SELECT * FROM EduSphere.Publications WHERE MemberID='{0}'", Convert.ToInt32(e.CommandArgument.ToString()));
                    BD.DataBindToDataList(dlNeuroPublications, pubQuery);
                    lblPubEID.Text                  = e.CommandArgument.ToString();
                    pnlViewStaff.Visible            = false;
                    pnlAddStaff.Visible             = false;
                    pnlUploadStaffDocument.Visible  = false;
                    pnlViewStaffDocuments.Visible   = false;
                    pnlHelp.Visible = false;
                    pnlEditStaffProfile.Visible     = false;
                    pnlViewStaffProfile.Visible     = false;
                    pnlNeuroAcademics.Visible         = false;
                    pnlNeuroPublications.Visible      = true;
                    pnlNeuroAcademics.Visible = false;
                    pnlNeuroPublications.Visible = true;
                    break;
                case "SearchStaff":
                case "FilterStaff":
                    lblStaffAction.Text = "Search Staff";
                    pnlViewStaff.Visible = true;
                    pnlAddStaff.Visible = false;
                    pnlUploadStaffDocument.Visible = false;
                    pnlViewStaffDocuments.Visible = false;
                    pnlHelp.Visible = false;
                    pnlViewStaffProfile.Visible = false;
                    pnlEditStaffProfile.Visible = false;
                    pnlAddStaff.Visible = false;
                    pnlNeuroAcademics.Visible = false;
                    pnlNeuroPublications.Visible = false;
                    if (cmdName == "FilterStaff")
                    {
                        string strEmploymentStatus = ddlFilterEmploymentStatus.SelectedValue.ToString();
                        //Membership will be visible if its in ACTIVE Status, set by ADMIN
                        //string strEmploymentStatus = "ACTIVE";
                        //strCmd = string.Format(@"SELECT OrganizationName,MemberID,FullName,st.PhoneOne,st.Email 
                        //                          FROM EduSphere.Members st 
                        //                          JOIN EduSphere.Organizations org ON st.OrganizationID=org.OrganizationID 
                        //                          WHERE MembershipStatus='{0}' AND st.Email='{1}' ORDER BY st.FullName ASC", strEmploymentStatus,User.Identity.Name.ToString());
                        strCmd = string.Format(@"SELECT OrganizationName,MemberID,FullName,st.PhoneOne,st.Email,st.MembershipStatus 
                                                 FROM EduSphere.Members st 
                                                 JOIN EduSphere.Organizations org ON st.OrganizationID=org.OrganizationID 
                                                 WHERE MembershipStatus='{0}' AND st.Email='{1}' ORDER BY st.FullName ASC", strEmploymentStatus,User.Identity.Name.ToString());
                    }
                    if (cmdName == "SearchStaff")
                    {
                        string strSerachParam = txtBoxSearchStaff.Text;
                        //strCmd = string.Format("SELECT OrganizationName,MemberID,FullName,PhoneOne,Email FROM EduSphere.Members st JOIN EduSphere.Organizations org ON st.OrganizationID=org.OrganizationID WHERE FullName LIKE '%{0}%' OR MemberID LIKE '%{0}%' ORDER BY st.FullName ASC", strSerachParam);
                    }
                    BD.DataBindToDataList(dlStaff, strCmd);
                    break;
                case "ViewProfile":
                    lblStaffAction.Text             = "Staff Details";
                    pnlViewStaff.Visible            = false;
                    pnlAddStaff.Visible             = false;
                    pnlUploadStaffDocument.Visible  = false; 
                    pnlViewStaffDocuments.Visible   = true; //display document alongwith profile
                    pnlHelp.Visible = false;
                    pnlViewStaffProfile.Visible     = true; //display profile details
                    pnlEditStaffProfile.Visible     = false;
                    pnlAddStaff.Visible             = false;
                    pnlNeuroAcademics.Visible       = false;
                    pnlNeuroPublications.Visible    = false;
                    if (cmdName == "ViewProfile")
                    {
                        intEmployeeId = Convert.ToInt32(e.CommandArgument.ToString());
                        strCmd = string.Format(@"SELECT *,(SELECT FullName FROM EduSphere.Members WHERE MemberID=(SELECT MentorID FROM EduSphere.Members WHERE MemberID='{0}')) AS MentorName 
                                                 FROM EduSphere.Members n
                                                 JOIN EduSphere.Programs p ON n.ProgramID=p.ProgramID
                                                 JOIN EduSphere.Organizations edu ON n.OrganizationID=edu.OrganizationID
                                                 WHERE n.MemberID='{0}' AND n.Email='{1}'", intEmployeeId, User.Identity.Name.ToString());
                        BD.DataBindToDataList(dlStaffDetails, strCmd);
                        BD.DataBindToGridView(gvPostalAddresses,string.Format("Select * FROM EduSphere.PostalAddresses WHERE MemberID={0}",intEmployeeId),"NA");
                        //Display Documents too
                        string docQ = string.Format("SELECT * FROM EduSphere.MemberDocuments WHERE MemberID='{0}'", intEmployeeId);
                        BD.DataBindToGridView(gvStaffDocuments, docQ, "NA");

                        //Display Academics
                        string acadQ = string.Format("SELECT * FROM EduSphere.MemberAcademics where MemberID='{0}'", Convert.ToInt32(e.CommandArgument.ToString()));
                        BD.DataBindToGridView(gvViewAcademics, acadQ,"NA");
                        lblEID.Text = e.CommandArgument.ToString();
                    }
                    break;
                case "EditProfile":
                    lblStaffAction.Text             = "Edit Profile";
                    lblNeutherapistID.Text          = e.CommandArgument.ToString();
                    pnlViewStaff.Visible            = false;
                    pnlAddStaff.Visible             = false;
                    pnlUploadStaffDocument.Visible  = false;
                    pnlHelp.Visible = false;
                    pnlViewStaffDocuments.Visible   = false;
                    pnlViewStaffProfile.Visible     = false;
                    pnlEditStaffProfile.Visible     = true;
                    pnlAddStaff.Visible             = false;
                    pnlNeuroAcademics.Visible       = false;
                    pnlNeuroPublications.Visible    = false;
                    BD.DataBindToDataList(dlEditStaffProfile, string.Format(@"SELECT * FROM EduSphere.Members n 
                                                                                       JOIN EduSphere.Programs p ON n.ProgramID=p.ProgramID
                                                                                       JOIN EduSphere.Organizations o ON n.OrganizationID=o.OrganizationID 
                                                                                       WHERE n.MemberID='{0}'", Convert.ToInt32(e.CommandArgument.ToString())));
                    DropDownList ddlOrg         = new DropDownList();
                    DropDownList ddlEditProgram = new DropDownList();                    
                    DropDownList ddlManager     = new DropDownList();
                    foreach (DataListItem li in dlEditStaffProfile.Items)
                    {
                        ddlOrg = (DropDownList)li.FindControl("ddlEditOrgId");
                        ddlEditProgram = (DropDownList)li.FindControl("ddlEditProgram");                        
                        ddlManager = (DropDownList)li.FindControl("ddlEditManagerId");
                    }
                    BD.DataBindToDropDownList(ddlOrg, string.Format("SELECT OrganizationName, OrganizationID FROM EduSphere.Organizations"));
                    BD.DataBindToDropDownList(ddlEditProgram, string.Format("SELECT ProgramTitle, ProgramID FROM EduSphere.Programs"));
                    BD.DataBindToDropDownList(ddlManager, string.Format("SELECT MemberID, FullName FROM EduSphere.Members"));
                    break;
                case "ViewEnrolmentCertificate":
                    //PG.EnrolmentCertificate(102);
                    string strTemplate = "~/Artifacts/Members/MembershipTemplate.pdf";
                    int intMemberID = Convert.ToInt32(e.CommandArgument.ToString());
                    PG.GeneratePdfFromPdfTemplate(strTemplate, intMemberID);
                    break;
                case "TopnlProfileEditFrompnlUploadStaffDocument":
                    pnlUploadStaffDocument.Visible = false;
                    pnlEditStaffProfile.Visible     = true;
                    break;
                case "TopnlProfileEditFrompnlNeuroAcademics":
                    pnlNeuroAcademics.Visible       = false;
                    pnlEditStaffProfile.Visible     = true;
                    break;
                case "ReturnToViewStaff":
                    Response.Redirect("Admission.aspx");
                    break;
                default:
                    break;
            }
        }

        //Add New Staff
        protected void AddNewStaff(object sender, CommandEventArgs e)
        {
            SqlCommand ObjCmd = new SqlCommand("spInsertStaff", BD.ConStr);
            ObjCmd.CommandType = CommandType.StoredProcedure;

            ObjCmd.Parameters.AddWithValue("@OrganizationID", ddlOrgId.SelectedValue.ToString());
            ObjCmd.Parameters.AddWithValue("@PhotoPath", "~/Artifacts/Emp/Photo/Photo.jpg");
            ObjCmd.Parameters.AddWithValue("@FullName", txtBoxFullName.Text);
            ObjCmd.Parameters.AddWithValue("@Gender", ddlGender.SelectedValue.ToString());
            ObjCmd.Parameters.AddWithValue("@PhoneOne", "+91" + txtBoxPhoneOne.Text);
            ObjCmd.Parameters.AddWithValue("@PhoneTwo", "+91" + txtBoxPhoneTwo.Text);
            ObjCmd.Parameters.AddWithValue("@Email", txtBoxEmail.Text);
            ObjCmd.Parameters.AddWithValue("@ContactAddress", autoaddress.Text);
            //ObjCmd.Parameters.AddWithValue("@City", txtBoxCity.Text);
            //ObjCmd.Parameters.AddWithValue("@District", txtBoxDistrict.Text);//The first servie ID in services
            //ObjCmd.Parameters.AddWithValue("@PinCode", txtBoxPinCode.Text);
            //ObjCmd.Parameters.AddWithValue("@State", txtBoxState.Text);
            //ObjCmd.Parameters.AddWithValue("@Country", txtBoxCountry.Text);
            ObjCmd.Parameters.AddWithValue("@Designation", txtBoxDesignation.Text);
            ObjCmd.Parameters.AddWithValue("@DateOfBirth", DateTime.Parse(txtBoxDateOfBirth.Text));
            int intManagerId = 90;
            string strManagerId = ddlManagerId.SelectedValue.ToString();

            if (strManagerId != "Select")
            {
                ObjCmd.Parameters.AddWithValue("@MentorID", Convert.ToInt32(strManagerId));
            }
            else
            {
                ObjCmd.Parameters.AddWithValue("@MentorID", intManagerId);
            }




            ObjCmd.Parameters.AddWithValue("@DateOfJoining", DateTime.Parse(txtBoxDateOfJoining.Text));
            ObjCmd.Parameters.AddWithValue("@MembershipType", ddlEmploymentType.SelectedValue.ToString());
            ObjCmd.Parameters.AddWithValue("@FathersName", txtBoxFathersName.Text);
            ObjCmd.Parameters.AddWithValue("@MothersName", txtBoxMothersName.Text);
            ObjCmd.Parameters.AddWithValue("@PanNumber", txtBoxPan.Text);
            ObjCmd.Parameters.AddWithValue("@AadhaarNumber", txtBoxAadhaar.Text);
            ObjCmd.Parameters.AddWithValue("@BankName", txtBoxBankName.Text);
            ObjCmd.Parameters.AddWithValue("@BankAccountNumber", txtBoxBankAccount.Text);
            ObjCmd.Parameters.AddWithValue("@BankIFSC", txtBoxBankIFSC.Text);
            ObjCmd.Parameters.AddWithValue("@MembershipStatus", "NOTACTIVE");
            //ObjCmd.Parameters.AddWithValue("@MembershipStatus", ddlEmploymentStatus.SelectedValue.ToString());//The first servie ID in services
            //if (ddlEmploymentStatus.SelectedValue.ToString() == "Active")
            //    txtBoxDateOfLeaving.Text = "01/01/3000";
            ObjCmd.Parameters.AddWithValue("@DateOfLeaving", DateTime.Parse("01/01/3000"));

            BD.UpdateParameters(ObjCmd);
            Response.Write("<script>alert('Membership Request Submitted Successfully')</script>");
            //Refresh View Staff List to display newly added Staff.
            Response.Redirect("Staff.aspx");
            //Display Staff count
            //send Welcome Message to Staff
            //if (strNotify == "YES")
            //{
            //    Connect EC = new Connect();
            //    string strSMSmessage = string.Format("Dear '{0}, Thanks for visiting Purple Salon N Academy !!!", strFirstName);
            //    EC.SendSMS(strPhoneOne, strSMSmessage);
            //    SentMsgLogger("SMS", strSMSmessage, strPhoneOne, strFirstName);
            //}
        }

        //Update Postal Address
        protected void UpdatePostalAddress(object sender, CommandEventArgs e)
        {
            string strAddressType   = ddlAddressType.SelectedValue.ToString();
            int intNeurotherapistID = Convert.ToInt32(lblNeutherapistID.Text);
            string CorresAdrSameAsPermaAdr = "NO";
            if (chkBoxCorresAdrSameAsPermaAdr.Checked)
            {
                CorresAdrSameAsPermaAdr = "YES";
            }

            SqlCommand cmd          = new SqlCommand("spUpdateAddress", BD.ConStr);
            cmd.CommandType         = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@ID",intNeurotherapistID);
            cmd.Parameters.AddWithValue("@AddressType", strAddressType);
            //cmd.Parameters.AddWithValue("@PostalAddress", autopermanent.Text);
            cmd.Parameters.AddWithValue("@PostalAddress",txtBoxAddressLineOne.Text);
            cmd.Parameters.AddWithValue("@City", locality.Text);
            cmd.Parameters.AddWithValue("@PinCode", postal_code.Text);
            cmd.Parameters.AddWithValue("@State", administrative_area_level_1.Text);
            cmd.Parameters.AddWithValue("@Country", country.Text);
            cmd.Parameters.AddWithValue("@CorresAdrSameAsPermaAdr", CorresAdrSameAsPermaAdr);
            BD.UpdateParameters(cmd);
        }

        //Add New Qualification
        protected void AddNewQualification(object sender, CommandEventArgs e)
        {
            int intNeurotherapistID     = Convert.ToInt32(lblEID.Text);
            SqlCommand ObjCmd           = new SqlCommand("spInsertMemberDegree", BD.ConStr);
            ObjCmd.CommandType          = CommandType.StoredProcedure;
            ObjCmd.Parameters.AddWithValue("@MemberID", intNeurotherapistID);
            BD.UpdateParameters(ObjCmd);
            //string queryString = string.Format("SELECT * FROM SalonSphere.NeuroAcademics co JOIN Courses c  ON co.CourseID=c.CourseID WHERE co.CourseID='{0}'", strCourseID);
            string queryString          = string.Format("SELECT * FROM EduSphere.MemberAcademics a  WHERE a.MemberID='{0}'", intNeurotherapistID);
            BD.DataBindToDataList(dlAcademicDetails, queryString);
        }

        //Add New Publiction
        protected void AddNewPublication(object sender, CommandEventArgs e)
        {
            int intNeuroloyeesID = Convert.ToInt32(lblPubEID.Text);
            SqlCommand ObjCmd = new SqlCommand("spMemberPublication", BD.ConStr);
            ObjCmd.CommandType = CommandType.StoredProcedure;
            ObjCmd.Parameters.AddWithValue("@Action", "INSERT");
            ObjCmd.Parameters.AddWithValue("@MemberID", intNeuroloyeesID);
            ObjCmd.Parameters.AddWithValue("@PublicationID", 0);//Just to fulfill the need of param requirement, not used for insert
            ObjCmd.Parameters.AddWithValue("@PublicationType", "");
            ObjCmd.Parameters.AddWithValue("@PublicationCode", "");
            ObjCmd.Parameters.AddWithValue("@PublicationTitle", "");
            ObjCmd.Parameters.AddWithValue("@PublicationDescription", "");
            ObjCmd.Parameters.AddWithValue("@PublishDate", DateTime.Now.ToString("MMM d,yyyy"));
            ObjCmd.Parameters.AddWithValue("@PublisherDetails", "");
            ObjCmd.Parameters.AddWithValue("@Remarks", "");

            BD.UpdateParameters(ObjCmd);
            string queryString = string.Format("SELECT * FROM EduSphere.Publications WHERE MemberID='{0}'", intNeuroloyeesID);
            BD.DataBindToDataList(dlNeuroPublications, queryString);

        }

        //Edit Employees Academic Details
        protected void dlAcademicDetailsEditHandler(object sender, DataListCommandEventArgs e)
        {
            dlAcademicDetails.EditItemIndex = e.Item.ItemIndex;
            int intNeuroAcadID = (int)dlAcademicDetails.DataKeys[e.Item.ItemIndex];
            string queryString = string.Format("SELECT * FROM EduSphere.MemberAcademics where  AcadID={0}", intNeuroAcadID);
            BD.DataBindToDataList(dlAcademicDetails, queryString);

            //pnlEnroll.Visible            = false;
            pnlNeuroAcademics.Visible = true;
            //pnlEmployees.Visible = false;
        }

        //Cancel Editing of Employees Academic Details
        protected void dlAcademicDetailsCancelHandler(object sender, DataListCommandEventArgs e)
        {
            dlAcademicDetails.EditItemIndex = -1;
            int intNeurotherapistID = Convert.ToInt32(lblEID.Text);
            //int intQuestionID = Convert.ToInt32(dlAcademicDetails.DataKeys[e.Item.ItemIndex]);
            string queryString = string.Format("SELECT * FROM EduSphere.MemberAcademics where  MemberID='{0}'", intNeurotherapistID);
            BD.DataBindToDataList(dlAcademicDetails, queryString);
        }

        //Update Employees Academic Details
        protected void dlAcademicDetailsUpdateHandler(object sender, DataListCommandEventArgs e)
        {
            int intNeurotherapistID = Convert.ToInt32(lblEID.Text);
            int intNeuroAcadID      = (int)dlAcademicDetails.DataKeys[e.Item.ItemIndex];
            string strDegree, strInstitute, strUniversity, strGrade, strTest;
            DateTime dtStartDate,dtCompletionYear;
            strDegree = (((TextBox)e.Item.FindControl("txtBoxEmpDegree")).Text).ToString();
            strInstitute = (((TextBox)e.Item.FindControl("txtBoxEmpInstitute")).Text).ToString();
            strUniversity = (((TextBox)e.Item.FindControl("txtBoxEmpUniversity")).Text).ToString();
            dtStartDate = Convert.ToDateTime((((TextBox)e.Item.FindControl("txtBoxStartDate")).Text).ToString());
            dtCompletionYear = Convert.ToDateTime((((TextBox)e.Item.FindControl("txtBoxCompletionYear")).Text).ToString());
            strGrade = (((TextBox)e.Item.FindControl("txtBoxGrade")).Text).ToString();

            SqlCommand ObjCmd = new SqlCommand("spUpdateMemberDegree", BD.ConStr);
            ObjCmd.CommandType = CommandType.StoredProcedure;

            ObjCmd.Parameters.AddWithValue("@AcadID", intNeuroAcadID);
            ObjCmd.Parameters.AddWithValue("@Degree", strDegree);
            ObjCmd.Parameters.AddWithValue("@Institute", strInstitute);
            ObjCmd.Parameters.AddWithValue("@University", strUniversity);
            ObjCmd.Parameters.AddWithValue("@StartDate", dtCompletionYear);
            ObjCmd.Parameters.AddWithValue("@CompletionYear", dtCompletionYear);
            ObjCmd.Parameters.AddWithValue("@Grade", strGrade);

            //Update Degree       
            BD.UpdateParameters(ObjCmd);
            //Revert back from EditItemTemplate
            dlAcademicDetails.EditItemIndex = -1;
            //Bind the datalist with updated values
            string queryString = string.Format("SELECT * FROM EduSphere.MemberAcademics where  MemberID='{0}'", intNeurotherapistID);
            BD.DataBindToDataList(dlAcademicDetails, queryString);
        }

        //Edit Employees Publication Details
        protected void dlNeuroPublicationEditHandler(object sender, DataListCommandEventArgs e)
        {
            dlNeuroPublications.EditItemIndex = e.Item.ItemIndex;
            int intEmpPublicationID = (int)dlNeuroPublications.DataKeys[e.Item.ItemIndex];
            string queryString = string.Format("SELECT * FROM EduSphere.Publications where  EmpPublicationID={0}", intEmpPublicationID);
            BD.DataBindToDataList(dlNeuroPublications, queryString);

            //pnlEnroll.Visible            = false;
            //pnlEmpAcademics.Visible = true;
            //pnlEmployees.Visible = false;
        }

        //Update Employees Publication Details
        protected void dlNeuroPublicationUpdateHandler(object sender, DataListCommandEventArgs e)
        {
            string strEmployeesID = lblPubEID.Text;
            int intNeuroPublicationID = (int)dlNeuroPublications.DataKeys[e.Item.ItemIndex];
            string strPublicationType, strPublicationCode, strPublicationTitle, strPublicationDescription, strPublisherDetails, strRemarks;
            DateTime dtPublishDate;
            strPublicationType = (((DropDownList)e.Item.FindControl("ddlPublicationType")).Text).ToString();
            strPublicationCode = (((TextBox)e.Item.FindControl("txtBoxPublicationCode")).Text).ToString();
            strPublicationTitle = (((TextBox)e.Item.FindControl("txtBoxPublicationTitle")).Text).ToString();
            strPublicationDescription = (((TextBox)e.Item.FindControl("txtBoxPublicationDescription")).Text).ToString();
            dtPublishDate = Convert.ToDateTime((((TextBox)e.Item.FindControl("txtBoxPublishDate")).Text).ToString());
            strPublisherDetails = (((TextBox)e.Item.FindControl("txtBoxPublisherDetails")).Text).ToString();
            strRemarks = (((TextBox)e.Item.FindControl("txtBoxRemarks")).Text).ToString();

            SqlCommand ObjCmd = new SqlCommand("spPublication", BD.ConStr);
            ObjCmd.CommandType = CommandType.StoredProcedure;

            ObjCmd.Parameters.AddWithValue("@Action", "UPDATE");
            ObjCmd.Parameters.AddWithValue("@MemberID", strEmployeesID);
            ObjCmd.Parameters.AddWithValue("@PublicationType", strPublicationType);
            ObjCmd.Parameters.AddWithValue("@PublicationCode", strPublicationCode);
            ObjCmd.Parameters.AddWithValue("@PublicationID", intNeuroPublicationID);

            ObjCmd.Parameters.AddWithValue("@PublicationTitle", strPublicationTitle);
            ObjCmd.Parameters.AddWithValue("@PublicationDescription", strPublicationDescription);
            ObjCmd.Parameters.AddWithValue("@PublishDate", dtPublishDate);
            ObjCmd.Parameters.AddWithValue("@PublisherDetails", strPublisherDetails);
            ObjCmd.Parameters.AddWithValue("@Remarks", strRemarks);

            //Update Publication      
            BD.UpdateParameters(ObjCmd);
            //Revert back from EditItemTemplate
            dlNeuroPublications.EditItemIndex = -1;
            //Bind the datalist with updated values
            string queryString = string.Format("SELECT * FROM EduSphere.Publications where  MemberID='{0}'", strEmployeesID);
            BD.DataBindToDataList(dlNeuroPublications, queryString);
        }

        //Cancel Editing of Employees Publication Details
        protected void dlNeuroPublicationCancelHandler(object sender, DataListCommandEventArgs e)
        {
            dlNeuroPublications.EditItemIndex = -1;
            string strEmployeesID = lblPubEID.Text;
            string queryString = string.Format("SELECT * FROM EduSphere.Publications where  MemberID='{0}'", strEmployeesID);
            BD.DataBindToDataList(dlNeuroPublications, queryString);
        }


        //Add New Staff Document
        protected void SaveStaffDocument(object sender, CommandEventArgs e)
        {
            string docTitle, docPath;
            string cmdName = e.CommandName.ToString();
            switch (cmdName)
            {
                case "docOne":
                    docTitle = txtBoxStaffDocumentTitleOne.Text;
                    docPath = lblStaffDocumentPathOne.Text;
                    break;
                case "docTwo":
                    docTitle = txtBoxStaffDocumentTitleTwo.Text;
                    docPath = lblStaffDocumentPathTwo.Text;
                    break;
                case "docThree":
                    docTitle = txtBoxStaffDocumentTitleThree.Text;
                    docPath = lblStaffDocumentPathThree.Text;
                    break;
                case "docFour":
                    docTitle = txtBoxStaffDocumentTitleFour.Text;
                    docPath = lblStaffDocumentPathFour.Text;
                    break;
                case "docFive":
                    docTitle = txtBoxStaffDocumentTitleFive.Text;
                    docPath = lblStaffDocumentPathFive.Text;
                    break;
                case "docSix":
                    docTitle = txtBoxStaffDocumentTitleSix.Text;
                    docPath = lblStaffDocumentPathSix.Text;
                    break;
                default:
                    docTitle = "";
                    docPath = "";
                    break;
            }
            SqlCommand ObjCmd = new SqlCommand("spInsertMemberDocument", BD.ConStr);
            ObjCmd.CommandType = CommandType.StoredProcedure;
            int intEmployeeId = Convert.ToInt32(lblEmployeeId.Text);

            ObjCmd.Parameters.AddWithValue("@UploadDate", DateTime.Now);
            ObjCmd.Parameters.AddWithValue("@MemberID", intEmployeeId);
            ObjCmd.Parameters.AddWithValue("@DocumentTitle", docTitle);
            ObjCmd.Parameters.AddWithValue("@DocumentPath", docPath);
            BD.UpdateParameters(ObjCmd);
            //Response.Write("<script>alert('Staff Document Uploaded successfully')</script>");
            //Refresh View Staff List to display newly added Staff.
            //Response.Redirect("Staff.aspx");
        }

        //Update Staff Profile
        protected void UpdateStaffProfile(object sender, DataListCommandEventArgs e)
        {
            SqlCommand ObjCmd = new SqlCommand("spUpdateMember", BD.ConStr);
            ObjCmd.CommandType = CommandType.StoredProcedure;
            ObjCmd.Parameters.AddWithValue("@MemberID", Convert.ToInt32(dlEditStaffProfile.DataKeys[e.Item.ItemIndex]));

            int intOrgID = 90;
            string strOrgID= ((DropDownList)e.Item.FindControl("ddlEditOrgId")).SelectedValue.ToString();
            if(strOrgID!="Select")
            {
                intOrgID = Convert.ToInt32(strOrgID);
            }

            int intProgID = 90;
            string strProgID = ((DropDownList)e.Item.FindControl("ddlEditProgram")).SelectedValue.ToString();
            if (strProgID != "Select")
            {
                intProgID = Convert.ToInt32(strProgID);
            }

            ObjCmd.Parameters.AddWithValue("@OrganizationID", intOrgID);// ((DropDownList)e.Item.FindControl("ddlEditOrgId")).SelectedValue.ToString());
            ObjCmd.Parameters.AddWithValue("@ProgramID", intProgID);
            ObjCmd.Parameters.AddWithValue("@PhotoPath", ((Label)e.Item.FindControl("lblEmpPhotoPath")).Text);
            ObjCmd.Parameters.AddWithValue("@FullName", ((TextBox)e.Item.FindControl("txtBoxEditFullName")).Text);
            ObjCmd.Parameters.AddWithValue("@PhoneOne", ((TextBox)e.Item.FindControl("txtBoxEditPhoneOne")).Text);
            ObjCmd.Parameters.AddWithValue("@PhoneTwo", ((TextBox)e.Item.FindControl("txtBoxEditPhoneTwo")).Text);
            ObjCmd.Parameters.AddWithValue("@Email", ((Label)e.Item.FindControl("lblEmail")).Text);            
            ObjCmd.Parameters.AddWithValue("@Designation", ((TextBox)e.Item.FindControl("txtBoxEditDesignation")).Text);

            string strBirthDt = ((TextBox)e.Item.FindControl("txtBoxEditDateOfBirth")).Text.ToString();
            ObjCmd.Parameters.AddWithValue("@DateOfBirth", DateTime.ParseExact(strBirthDt, "dd/MM/yyyy", CultureInfo.InvariantCulture));

            ObjCmd.Parameters.AddWithValue("@MentorID", 90);// Convert.ToInt32(((DropDownList)e.Item.FindControl("ddlEditManagerId")).SelectedValue.ToString()));
            ObjCmd.Parameters.AddWithValue("@MaritalStatus", ((DropDownList)e.Item.FindControl("ddlEditMaritalStatus")).SelectedValue.ToString());
            ObjCmd.Parameters.AddWithValue("@FathersName", ((TextBox)e.Item.FindControl("txtBoxEditFathersName")).Text);
            ObjCmd.Parameters.AddWithValue("@MothersName", ((TextBox)e.Item.FindControl("txtBoxEditMothersName")).Text);
            ObjCmd.Parameters.AddWithValue("@PanNumber", ((TextBox)e.Item.FindControl("txtBoxEditPan")).Text);
            ObjCmd.Parameters.AddWithValue("@AadhaarNumber", ((TextBox)e.Item.FindControl("txtBoxEditAadhaar")).Text);
            ObjCmd.Parameters.AddWithValue("@BankName", ((TextBox)e.Item.FindControl("txtBoxEditBankName")).Text);
            ObjCmd.Parameters.AddWithValue("@BankAccountNumber", ((TextBox)e.Item.FindControl("txtBoxEditBankAccount")).Text);
            ObjCmd.Parameters.AddWithValue("@BankIFSC", ((TextBox)e.Item.FindControl("txtBoxEditBankIFSC")).Text);
            ObjCmd.Parameters.AddWithValue("@AcademicExamStatus", ((DropDownList)e.Item.FindControl("ddlNeurotherapyExamStatus")).SelectedValue.ToString());
            //string strJoiningDt = ((TextBox)e.Item.FindControl("txtBoxEditDateOfJoining")).Text.ToString();
            // ObjCmd.Parameters.AddWithValue("@DateOfJoining", "");// DateTime.Today.ToString("dd/MM/yyyy"));// DateTime.ParseExact(strJoiningDt, "dd/MM/yyyy", CultureInfo.InvariantCulture));
            int intMembershipYears = 1;
            if(((TextBox)e.Item.FindControl("txtBoxMembershipValidForYears")).Text.ToString()!="")
            {
                intMembershipYears = Convert.ToInt32(((TextBox)e.Item.FindControl("txtBoxMembershipValidForYears")).Text);
            }
            
            ObjCmd.Parameters.AddWithValue("@MembershipValidForYears", intMembershipYears);
            ObjCmd.Parameters.AddWithValue("@MembershipType", ((DropDownList)e.Item.FindControl("ddlEditEmploymentType")).SelectedValue.ToString());

            //string strEmploymentStatus = ((DropDownList)e.Item.FindControl("ddlEditEmploymentStatus")).SelectedValue.ToString();

            ObjCmd.Parameters.AddWithValue("@MembershipStatus", "NOTACTIVE");
            //string strLeavingDt = ((TextBox)e.Item.FindControl("txtBoxEditDateOfLeaving")).Text.ToString();

            //if (strEmploymentStatus == "Active")
            //{
                ObjCmd.Parameters.AddWithValue("@DateOfLeaving", "");
            //}
            //else
            //{
            //    ObjCmd.Parameters.AddWithValue("@DateOfLeaving", DateTime.ParseExact(strLeavingDt, "dd/MM/yyyy", CultureInfo.InvariantCulture));
            //}

            BD.UpdateParameters(ObjCmd);
            Response.Write("<script>alert('Profile updated successfully')</script>");
            //Refresh View Staff List to display newly added Staff.
            //Save Pan and Aadhaar Paths to Neurotherapist Document table
            //its done inside spUpdateMember procedure 

            Response.Redirect("Admission.aspx");

        }


        //File upload inside datalist control
        protected void btnFileUpload_StaffPhoto(object sender, CommandEventArgs e)
        {
            FS.UploadFileFromDataListControl(dlEditStaffProfile, "flUploadStaffPhoto", "~/Artifacts/Members/", "lblEmpPhotoPath");
        }

        //Enable/Disable certain field based on ProfieType
        protected void dlEditProfile_OnItemDataBound(object sender, DataListItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                //Label lblDate = (Label)e.Item.FindControl("lblDate");
                //DateTime dtDateTime = Convert.ToDateTime(lblDate.Text);
                //DateTime dtCurrentDatetime = Convert.ToDateTime(System.DateTime.Now);
                ////int result = DateTime.Compare(dtDateTime, dtCurrentDatetime);
                //int result = string.Compare(dtDateTi, dtCurrentDatetime);
                //if (result == -1)
                //{
                //    lblDate.Style.Add("text-decoration", "line-through");
                //}
                //int result
            }
        }

        ////File upload inside datalist control
        //protected void btnFileUpload_NeurotherapistPAN(object sender, CommandEventArgs e)
        //{
        //    FS.UploadFileFromDataListControl(dlEditStaffProfile, "FileUpload_Pan", "~/Artifacts/Members/", "lblNeuroPanPath");
        //}

        ////File upload inside datalist control
        //protected void btnFileUpload_NeurotherapistAadhaar(object sender, CommandEventArgs e)
        //{
        //    FS.UploadFileFromDataListControl(dlEditStaffProfile, "FileUpload_Aadhaar", "~/Artifacts/Members/", "lblNeuroPanPath");
        //}



        //File upload out side control
        protected void btnFileUpload_StaffDocument(object sender, CommandEventArgs e)
        {
            string flCmdName = e.CommandName.ToString();
            switch (flCmdName)
            {
                case "flOne":
                    FS.UploadFileFromOutsideControl(flStaffDocumentOne, "~/Artifacts/Members/", lblStaffDocumentPathOne);
                    break;
                case "flTwo":
                    FS.UploadFileFromOutsideControl(flStaffDocumentTwo, "~/Artifacts/Members/", lblStaffDocumentPathTwo);
                    break;
                case "flThree":
                    FS.UploadFileFromOutsideControl(flStaffDocumentThree, "~/Artifacts/Members/", lblStaffDocumentPathThree);
                    break;
                case "flFour":
                    FS.UploadFileFromOutsideControl(flStaffDocumentFour, "~/Artifacts/Members/", lblStaffDocumentPathFour);
                    break;
                case "flFive":
                    FS.UploadFileFromOutsideControl(flStaffDocumentFive, "~/Artifacts/Members/", lblStaffDocumentPathFive);
                    break;
                case "flSix":
                    FS.UploadFileFromOutsideControl(flStaffDocumentSix, "~/Artifacts/Members/", lblStaffDocumentPathSix);
                    break;
                default:
                    break;

            }
        }

        //Using PDF Template for Certificate
        protected void btnCreate_Click(object sender, EventArgs e)
        {
            try
            {
                string filename = string.Concat(Guid.NewGuid().ToString(), ".pdf");
                PdfReader pdfReader = new PdfReader(Server.MapPath("~/Artifacts/Members/Cert.pdf"));

                using (FileStream stream = new FileStream(string.Concat(Server.MapPath("~/export/"), filename), FileMode.Create))
                {
                    PdfStamper pdfStamper = new PdfStamper(pdfReader, stream);

                    AcroFields formFields = pdfStamper.AcroFields;
                    formFields.SetField("txtForename", "Shivmani");//txtForename.Text.Trim());
                    formFields.SetField("txtSurname", "Tripathi");// txtSurname.Text.Trim());

                    pdfStamper.FormFlattening = true;
                    pdfStamper.Close();

                    string script = string.Format("window.open('{0}');", string.Concat("/export/", filename));
                    ClientScript.RegisterClientScriptBlock(this.GetType(), "newPDF", script, true);
                }
            }
            catch (Exception ex)
            {
                //lblMessage.Text = ex.Message;
            }
        }

        protected void btnGenerate_Click(object sender, EventArgs e)
        {
            try
            {
                string filename = string.Concat(Guid.NewGuid().ToString(), ".pdf");
                PdfReader pdfReader = new PdfReader(Server.MapPath("~/Artifacts/Members/Cert.pdf"));

                using (MemoryStream stream = new MemoryStream())
                {
                    PdfStamper pdfStamper = new PdfStamper(pdfReader, stream);

                    AcroFields formFields = pdfStamper.AcroFields;
                    formFields.SetField("txtForename", "Rajesh");// txtForename.Text.Trim());
                    formFields.SetField("txtSurname", "Dube");// txtSurname.Text.Trim());

                    pdfStamper.FormFlattening = true;
                    pdfStamper.Writer.CloseStream = false;
                    pdfStamper.Close();

                    Response.ContentType = "application/pdf";
                    Response.AddHeader("Content-disposition", string.Format("attachment; filename={0};", filename));
                    stream.WriteTo(Response.OutputStream);
                }
            }
            catch (Exception ex)
            {
                //lblMessage.Text = ex.Message;
            }
        }
    }
}