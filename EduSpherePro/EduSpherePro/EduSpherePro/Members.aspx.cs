
using EduSpherePro.CoreServices;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Web.UI.WebControls;

namespace EduSpherePro.EduSpherePro
{
    public partial class Members : System.Web.UI.Page
    {
            IBindData BD            = new BindData();
            IAnalytics MT           = new Analytics();
            IMailService MS         = new MailService();
            IFileService FS         = new FileService();
            ISMSSender SMS          = new SMSSender();
            IPdfGenerator PG        = new PdfGenerator();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblStaffAction.Text             = "Members";
                pnlViewStaff.Visible            = true;
                pnlAddStaff.Visible             = false;
                pnlUploadStaffDocument.Visible  = false;
                pnlUploadHelpDocument.Visible   = false;
                pnlViewStaffDocuments.Visible   = false;
                pnlEditStaffProfile.Visible     = false;
                pnlViewStaffProfile.Visible     = false;
                pnlAddStaff.Visible             = false;

                //string strCmd = string.Format(@"SELECT TOP 100 org.OrganizationName as OrganizationName,MemberID,FullName,st.PhoneOne as PhoneOne,st.Email as Email 
                //                                FROM EduSphere.Members m 
                //                                JOIN EduSphere.Organizations o ON m.OrganizationID=o.OrganizationID 
                //                                WHERE MemberID>=100 AND MembershipStatus='{0}' AND m.Email='{1}'", "ACTIVE", User.Identity.Name);
                //BD.DataBindToDataList(dlStaff, strCmd);
                //Count
                BD.DataBindToLabel(lblCountActive, string.Format("SELECT COUNT(MemberID) FROM EduSphere.Members WHERE MembershipStatus='{0}'", "ACTIVE"));
                BD.DataBindToLabel(lblCountNotActive, string.Format("SELECT COUNT(MemberID) FROM EduSphere.Members WHERE MembershipStatus='{0}'", "NOTACTIVE"));
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
                    pnlUploadHelpDocument.Visible = false;
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
                    pnlUploadHelpDocument.Visible = false;
                    pnlViewStaffDocuments.Visible = false;
                    pnlEditStaffProfile.Visible = false;
                    pnlViewStaffProfile.Visible = false;
                    pnlNeuroAcademics.Visible = false;
                    pnlNeuroPublications.Visible = false;
                    lblEmployeeId.Text = e.CommandArgument.ToString();
                    break;
                case "UploadHelpDocument":
                    lblStaffAction.Text = "Upload Staff Document";
                    pnlViewStaff.Visible = false;
                    pnlAddStaff.Visible = false;
                    pnlUploadStaffDocument.Visible = false;
                    pnlUploadHelpDocument.Visible = true;
                    pnlViewStaffDocuments.Visible = false;
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
                    pnlUploadHelpDocument.Visible = false;
                    pnlViewStaffDocuments.Visible = true;
                    pnlEditStaffProfile.Visible = false;
                    pnlViewStaffProfile.Visible = false;
                    pnlNeuroAcademics.Visible = false;
                    pnlNeuroPublications.Visible = false;
                    intEmployeeId = Convert.ToInt32(e.CommandArgument.ToString());
                    string docQuery = string.Format("SELECT * FROM EduSphere.MemberDocuments WHERE MemberID='{0}'", intEmployeeId);
                    BD.DataBindToGridView(gvStaffDocuments, docQuery, "NA");
                    break;
                case "AcademicDetails":
                    string acadQuery = string.Format("SELECT * FROM EduSphere.MemberAcademics where MemberID='{0}'", Convert.ToInt32(e.CommandArgument.ToString()));
                    BD.DataBindToDataList(dlAcademicDetails, acadQuery);
                    lblEID.Text = e.CommandArgument.ToString();
                    pnlViewStaff.Visible = false;
                    pnlAddStaff.Visible = false;
                    pnlUploadStaffDocument.Visible = false;
                    pnlUploadHelpDocument.Visible = false;
                    pnlViewStaffDocuments.Visible = false;
                    pnlEditStaffProfile.Visible = false;
                    pnlViewStaffProfile.Visible = false;
                    pnlNeuroAcademics.Visible = true;

                    break;
                case "PublicationDetails":
                    string pubQuery = string.Format("SELECT * FROM EduSphere.MemberPublications WHERE MemberID='{0}'", Convert.ToInt32(e.CommandArgument.ToString()));
                    BD.DataBindToDataList(dlNeuroPublications, pubQuery);
                    lblPubEID.Text = e.CommandArgument.ToString();
                    pnlViewStaff.Visible = false;
                    pnlAddStaff.Visible = false;
                    pnlUploadStaffDocument.Visible = false;
                    pnlUploadHelpDocument.Visible = false;
                    pnlViewStaffDocuments.Visible = false;
                    pnlEditStaffProfile.Visible = false;
                    pnlViewStaffProfile.Visible = false;
                    pnlNeuroAcademics.Visible = false;
                    pnlNeuroPublications.Visible = true;
                    pnlNeuroAcademics.Visible = false;
                    pnlNeuroPublications.Visible = true;
                    break;
                case "SearchEnquiry":
                case "FilterStaff":
                    lblStaffAction.Text = "Search Member";
                    pnlViewStaff.Visible = true;
                    pnlAddStaff.Visible = false;
                    pnlUploadStaffDocument.Visible = false;
                    pnlUploadHelpDocument.Visible = false;
                    pnlViewStaffDocuments.Visible = false;
                    pnlViewStaffProfile.Visible = false;
                    pnlEditStaffProfile.Visible = false;
                    pnlAddStaff.Visible = false;
                    pnlNeuroAcademics.Visible = false;
                    pnlNeuroPublications.Visible = false;
                    if (cmdName == "FilterStaff")
                    {
                        string strEmploymentStatus = ddlFilterEmploymentStatus.SelectedValue.ToString();
                        string strMemType = ddlMembershipType.SelectedValue.ToString();
                        //Membership will be visible if its in ACTIVE Status, set by ADMIN
                        //string strEmploymentStatus = "ACTIVE";
                        //strCmd = string.Format(@"SELECT OrganizationName,MemberID,FullName,st.PhoneOne,st.Email 
                        //                          FROM EduSphere.Members st 
                        //                          JOIN EduSphere.Organizations org ON st.OrganizationID=org.OrganizationID 
                        //                          WHERE MembershipStatus='{0}' AND st.Email='{1}' ORDER BY st.FullName ASC", strEmploymentStatus,User.Identity.Name.ToString());
                        //if(strMemType=="STUDENT")
                        strCmd = string.Format(@"SELECT OrganizationName,MemberID,FullName,st.PhoneOne,st.Email,st.MembershipStatus,st.AadhaarNumber,st.PanNumber,st.AcademicExamStatus 
                                                 FROM EduSphere.Members st 
                                                 JOIN EduSphere.Organizations org ON st.OrganizationID=org.OrganizationID 
                                                  WHERE MembershipStatus='{0}' AND MembershipType='{1}' 
                                                  ORDER BY st.MemberID DESC", strEmploymentStatus,strMemType);
                        //else
                        //    strCmd = string.Format(@"SELECT OrganizationName,MemberID,FullName,st.PhoneOne,st.Email,st.MembershipStatus,st.AadhaarNumber,st.PanNumber,st.AcademicExamStatus 
                        //                         FROM EduSphere.Members st 
                        //                         JOIN EduSphere.Organizations org ON st.OrganizationID=org.OrganizationID 
                        //                          WHERE MembershipStatus='{0}' AND MembershipType!='{1}' OR MembershipType is null 
                        //                          ORDER BY st.MemberID DESC", strEmploymentStatus, "STUDENT");

                    }
                    if (cmdName == "SearchEnquiry")
                    {
                        string strSerachParam = txtBoxSearchStaff.Text;
                        strCmd = string.Format("SELECT OrganizationName,MemberID,FullName,st.PhoneOne,st.Email,st.MembershipStatus,st.AadhaarNumber,st.PanNumber,st.AcademicExamStatus FROM EduSphere.Members st JOIN EduSphere.Organizations org ON st.OrganizationID=org.OrganizationID WHERE FullName LIKE '%{0}%' OR MemberID LIKE '%{0}%' ORDER BY st.FullName ASC", strSerachParam);
                    }
                    BD.DataBindToDataList(dlStaff, strCmd);
                    break;
                case "ViewProfile":
                    lblStaffAction.Text = "View Profile";
                    pnlViewStaff.Visible = false;
                    pnlAddStaff.Visible = false;
                    pnlUploadStaffDocument.Visible = false;
                    pnlUploadHelpDocument.Visible = false;
                    pnlViewStaffDocuments.Visible = true;//display uploaded documents
                    pnlViewStaffProfile.Visible = true;//display profile
                    pnlEditStaffProfile.Visible = false;
                    pnlAddStaff.Visible = false;
                    pnlNeuroAcademics.Visible = false;
                    pnlNeuroPublications.Visible = false;
                    if (cmdName == "ViewProfile")
                    {
                        intEmployeeId = Convert.ToInt32(e.CommandArgument.ToString());
                        strCmd = string.Format(@"SELECT *,(SELECT FullName FROM EduSphere.Members WHERE MemberID=(SELECT MentorID FROM EduSphere.Members WHERE MemberID='{0}')) AS MentorName 
                                                 FROM EduSphere.Members
                                                 WHERE MemberID='{0}'", intEmployeeId);
                        BD.DataBindToDataList(dlStaffDetails, strCmd);
                        //Display Addresses
                        BD.DataBindToGridView(gvPostalAddresses, string.Format("Select * FROM EduSphere.PostalAddresses WHERE MemberID={0}", intEmployeeId), "NA");
                        //Display Documents too
                        string docQ = string.Format("SELECT * FROM EduSphere.MemberDocuments WHERE MemberID='{0}'", intEmployeeId);
                        BD.DataBindToGridView(gvStaffDocuments, docQ, "NA");

                        //Display Academics
                        string acadQ = string.Format("SELECT * FROM EduSphere.MemberAcademics where MemberID='{0}'", Convert.ToInt32(e.CommandArgument.ToString()));
                        BD.DataBindToGridView(gvViewAcademics, acadQ, "NA");
                        lblEID.Text = e.CommandArgument.ToString();
                    }
                    break;
                case "EditProfile":
                    lblStaffAction.Text             = "Edit Member Details";
                    lblNeutherapistID.Text          = e.CommandArgument.ToString();
                    pnlViewStaff.Visible            = false;
                    pnlAddStaff.Visible             = false;
                    pnlUploadStaffDocument.Visible  = false;
                    pnlUploadHelpDocument.Visible = false;
                    pnlViewStaffDocuments.Visible   = false;
                    pnlViewStaffProfile.Visible     = false;
                    pnlEditStaffProfile.Visible     = true;
                    pnlAddStaff.Visible             = false;
                    pnlNeuroAcademics.Visible       = false;
                    pnlNeuroPublications.Visible    = false;
                    BD.DataBindToDataList(dlEditStaffProfile, string.Format("SELECT * FROM EduSphere.Members WHERE MemberID='{0}'", Convert.ToInt32(e.CommandArgument.ToString())));
                    DropDownList ddlOrg             = new DropDownList();
                    DropDownList ddlManager         = new DropDownList();
                    foreach (DataListItem li in dlEditStaffProfile.Items)
                    {
                        ddlOrg = (DropDownList)li.FindControl("ddlEditOrgId");
                        ddlManager = (DropDownList)li.FindControl("ddlEditManagerId");
                    }
                    BD.DataBindToDropDownList(ddlOrg, string.Format("SELECT OrganizationName, OrganizationID FROM EduSphere.Organizations"));
                    BD.DataBindToDropDownList(ddlManager, string.Format("SELECT MemberID, FullName FROM EduSphere.Members"));
                    break;
                case "ViewEnrolmentCertificate":
                    //PG.EnrolmentCertificate(102);
                    string strTemplate      = "~/Artifacts/Members/MembershipTemplate.pdf";
                    int intMemberID         = Convert.ToInt32(e.CommandArgument.ToString());
                    PG.GeneratePdfFromPdfTemplate(strTemplate, intMemberID);
                    break;
                case "TopnlProfileEditFrompnlUploadStaffDocument":
                    pnlUploadStaffDocument.Visible = false;
                    pnlEditStaffProfile.Visible = true;
                    break;
                case "TopnlProfileEditFrompnlNeuroAcademics":
                    pnlNeuroAcademics.Visible = false;
                    pnlEditStaffProfile.Visible = true;
                    break;
                case "ReturnToViewStaff":
                    Response.Redirect("Members.aspx");
                    break;
                default:
                    break;
            }
        }

        //Communication
        protected void SendMessage(object send,CommandEventArgs e)
        {
            string cmdName = e.CommandName.ToString();
            switch(cmdName)
            {
                case "Email":
                    string ToEmail = e.CommandArgument.ToString();
                    MS.SendAsync("neurotherapymamber@gmail.com", ToEmail, "", txtBoxMsg.Text);
                    break;
                case "Sms":
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
        //protected void UpdatePostalAddress(object sender, CommandEventArgs e)
        //{
        //    string strAddressType = ddlAddressType.SelectedValue.ToString();
        //    int intMemberID = Convert.ToInt32(lblNeutherapistID.Text);
        //    SqlCommand cmd = new SqlCommand("spUpdateAddress", BD.ConStr);
        //    cmd.CommandType = CommandType.StoredProcedure;
        //    cmd.Parameters.AddWithValue("@ID", intMemberID);
        //    cmd.Parameters.AddWithValue("@AddressType", strAddressType);
        //    cmd.Parameters.AddWithValue("@PostalAddress", autopermanent.Text);
        //    cmd.Parameters.AddWithValue("@City", locality.Text);
        //    cmd.Parameters.AddWithValue("@PinCode", postal_code.Text);
        //    cmd.Parameters.AddWithValue("@State", administrative_area_level_1.Text);
        //    cmd.Parameters.AddWithValue("@Country", country.Text);
        //    BD.UpdateParameters(cmd);
        //}

        //Add New Qualification
        protected void AddNewQualification(object sender, CommandEventArgs e)
        {
            int intMemberID = Convert.ToInt32(lblEID.Text);
            SqlCommand ObjCmd = new SqlCommand("spInsertMemberDegree", BD.ConStr);
            ObjCmd.CommandType = CommandType.StoredProcedure;
            ObjCmd.Parameters.AddWithValue("@MemberID", intMemberID);
            BD.UpdateParameters(ObjCmd);
            //string queryString = string.Format("SELECT * FROM SalonSphere.NeuroAcademics co JOIN Courses c  ON co.CourseID=c.CourseID WHERE co.CourseID='{0}'", strCourseID);
            string queryString = string.Format("SELECT * FROM EduSphere.MemberAcademics a  WHERE a.MemberID='{0}'", intMemberID);
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
            string queryString = string.Format("SELECT * FROM EduSphere.MemberPublications WHERE MemberID='{0}'", intNeuroloyeesID);
            BD.DataBindToDataList(dlNeuroPublications, queryString);

        }

        //Edit Employees Academic Details
        protected void dlAcademicDetailsEditHandler(object sender, DataListCommandEventArgs e)
        {
            dlAcademicDetails.EditItemIndex = e.Item.ItemIndex;
            int intMemberAcadID = (int)dlAcademicDetails.DataKeys[e.Item.ItemIndex];
            string queryString = string.Format("SELECT * FROM EduSphere.MemberAcademics where  NeuroAcadID={0}", intMemberAcadID);
            BD.DataBindToDataList(dlAcademicDetails, queryString);

            //pnlEnroll.Visible            = false;
            pnlNeuroAcademics.Visible = true;
            //pnlEmployees.Visible = false;
        }

        //Cancel Editing of Employees Academic Details
        protected void dlAcademicDetailsCancelHandler(object sender, DataListCommandEventArgs e)
        {
            dlAcademicDetails.EditItemIndex = -1;
            int intMemberID = Convert.ToInt32(lblEID.Text);
            //int intQuestionID = Convert.ToInt32(dlAcademicDetails.DataKeys[e.Item.ItemIndex]);
            string queryString = string.Format("SELECT * FROM EduSphere.MemberAcademics where  MemberID='{0}'", intMemberID);
            BD.DataBindToDataList(dlAcademicDetails, queryString);
        }

        //Update Employees Academic Details
        protected void dlAcademicDetailsUpdateHandler(object sender, DataListCommandEventArgs e)
        {
            int intMemberID = Convert.ToInt32(lblEID.Text);
            int intMemberAcadID = (int)dlAcademicDetails.DataKeys[e.Item.ItemIndex];
            string strDegree, strInstitute, strUniversity, strGrade, strTest;
            DateTime dtCompletionYear;
            strDegree = (((TextBox)e.Item.FindControl("txtBoxEmpDegree")).Text).ToString();
            strInstitute = (((TextBox)e.Item.FindControl("txtBoxEmpInstitute")).Text).ToString();
            strUniversity = (((TextBox)e.Item.FindControl("txtBoxEmpUniversity")).Text).ToString();
            dtCompletionYear = Convert.ToDateTime((((TextBox)e.Item.FindControl("txtBoxCompletionYear")).Text).ToString());
            strGrade = (((TextBox)e.Item.FindControl("txtBoxGrade")).Text).ToString();

            SqlCommand ObjCmd = new SqlCommand("spUpdateNeuroDegree", BD.ConStr);
            ObjCmd.CommandType = CommandType.StoredProcedure;

            ObjCmd.Parameters.AddWithValue("@NeuroAcadID", intMemberAcadID);
            ObjCmd.Parameters.AddWithValue("@Degree", strDegree);
            ObjCmd.Parameters.AddWithValue("@Institute", strInstitute);
            ObjCmd.Parameters.AddWithValue("@University", strUniversity);
            ObjCmd.Parameters.AddWithValue("@CompletionYear", dtCompletionYear);
            ObjCmd.Parameters.AddWithValue("@Grade", strGrade);

            //Update Degree       
            BD.UpdateParameters(ObjCmd);
            //Revert back from EditItemTemplate
            dlAcademicDetails.EditItemIndex = -1;
            //Bind the datalist with updated values
            string queryString = string.Format("SELECT * FROM EduSphere.MemberAcademics where  MemberID='{0}'", intMemberID);
            BD.DataBindToDataList(dlAcademicDetails, queryString);
        }

        //Edit Employees Publication Details
        protected void dlNeuroPublicationEditHandler(object sender, DataListCommandEventArgs e)
        {
            dlNeuroPublications.EditItemIndex = e.Item.ItemIndex;
            int intEmpPublicationID = (int)dlNeuroPublications.DataKeys[e.Item.ItemIndex];
            string queryString = string.Format("SELECT * FROM EduSphere.MemberPublications where  EmpPublicationID={0}", intEmpPublicationID);
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

            SqlCommand ObjCmd = new SqlCommand("spMemberPublication", BD.ConStr);
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
            string queryString = string.Format("SELECT * FROM EduSphere.MemberPublications where  MemberID='{0}'", strEmployeesID);
            BD.DataBindToDataList(dlNeuroPublications, queryString);
        }

        //Cancel Editing of Employees Publication Details
        protected void dlNeuroPublicationCancelHandler(object sender, DataListCommandEventArgs e)
        {
            dlNeuroPublications.EditItemIndex = -1;
            string strEmployeesID = lblPubEID.Text;
            string queryString = string.Format("SELECT * FROM EduSphere.MemberPublications where  MemberID='{0}'", strEmployeesID);
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
            SqlCommand ObjCmd = new SqlCommand("spUpdateMembership", BD.ConStr);
            ObjCmd.CommandType = CommandType.StoredProcedure;

            ObjCmd.Parameters.AddWithValue("@MemberID", Convert.ToInt32(dlEditStaffProfile.DataKeys[e.Item.ItemIndex]));
            //ObjCmd.Parameters.AddWithValue("@OrganizationID", ((DropDownList)e.Item.FindControl("ddlEditOrgId")).SelectedValue.ToString());
            //ObjCmd.Parameters.AddWithValue("@PhotoPath", ((Label)e.Item.FindControl("lblEmpPhotoPath")).Text);
            //ObjCmd.Parameters.AddWithValue("@FullName", ((TextBox)e.Item.FindControl("txtBoxEditFullName")).Text);
            //ObjCmd.Parameters.AddWithValue("@PhoneOne", ((TextBox)e.Item.FindControl("txtBoxEditPhoneOne")).Text);
            //ObjCmd.Parameters.AddWithValue("@PhoneTwo", ((TextBox)e.Item.FindControl("txtBoxEditPhoneTwo")).Text);
            //ObjCmd.Parameters.AddWithValue("@Email", ((TextBox)e.Item.FindControl("txtBoxEditEmail")).Text);
            //ObjCmd.Parameters.AddWithValue("@ContactAddress", ((TextBox)e.Item.FindControl("txtBoxEditContactAddress")).Text);
            //ObjCmd.Parameters.AddWithValue("@City", ((TextBox)e.Item.FindControl("txtBoxEditCity")).Text);
            //ObjCmd.Parameters.AddWithValue("@District", ((TextBox)e.Item.FindControl("txtBoxEditDistrict")).Text);
            //ObjCmd.Parameters.AddWithValue("@PinCode", ((TextBox)e.Item.FindControl("txtBoxEditPinCode")).Text);
            //ObjCmd.Parameters.AddWithValue("@State", ((TextBox)e.Item.FindControl("txtBoxEditState")).Text);
            //ObjCmd.Parameters.AddWithValue("@Country", ((TextBox)e.Item.FindControl("txtBoxEditCountry")).Text);
            ObjCmd.Parameters.AddWithValue("@Designation", ((TextBox)e.Item.FindControl("txtBoxEditDesignation")).Text);

            //string strBirthDt = ((TextBox)e.Item.FindControl("txtBoxEditDateOfBirth")).Text.ToString();
            //ObjCmd.Parameters.AddWithValue("@DateOfBirth", DateTime.ParseExact(strBirthDt, "dd/MM/yyyy", CultureInfo.InvariantCulture));

            //ObjCmd.Parameters.AddWithValue("@MentorID", Convert.ToInt32(((DropDownList)e.Item.FindControl("ddlEditManagerId")).SelectedValue.ToString()));

            //ObjCmd.Parameters.AddWithValue("@FathersName", ((TextBox)e.Item.FindControl("txtBoxEditFathersName")).Text);
            //ObjCmd.Parameters.AddWithValue("@MothersName", ((TextBox)e.Item.FindControl("txtBoxEditMothersName")).Text);
            //ObjCmd.Parameters.AddWithValue("@PanNumber", ((TextBox)e.Item.FindControl("txtBoxEditPan")).Text);
            //ObjCmd.Parameters.AddWithValue("@AadhaarNumber", ((TextBox)e.Item.FindControl("txtBoxEditAadhaar")).Text);
            //ObjCmd.Parameters.AddWithValue("@BankName", ((TextBox)e.Item.FindControl("txtBoxEditBankName")).Text);
            //ObjCmd.Parameters.AddWithValue("@BankAccountNumber", ((TextBox)e.Item.FindControl("txtBoxEditBankAccount")).Text);
            //ObjCmd.Parameters.AddWithValue("@BankIFSC", ((TextBox)e.Item.FindControl("txtBoxEditBankIFSC")).Text);

            //string strJoiningDt = ((TextBox)e.Item.FindControl("txtBoxEditDateOfJoining")).Text.ToString();
            //string strDateOfJoining = DateTime.Today.ToString("dd/MM/yyyy");
            //ObjCmd.Parameters.AddWithValue("@DateOfJoining",DateTime.ParseExact(strDateOfJoining, "dd/MM/yyyy", CultureInfo.InvariantCulture));
            //ObjCmd.Parameters.AddWithValue("@DateOfJoining", "");//mamanged in sp
            int intValidYears = Convert.ToInt32(((TextBox)e.Item.FindControl("txtBoxMembershipValidForYears")).Text);
            ObjCmd.Parameters.AddWithValue("@MembershipValidForYears", intValidYears);

            //string strMembershipExpiryDate = DateTime.Today.AddYears(intValidYears).ToString("dd/MM/yyyy");
            //ObjCmd.Parameters.AddWithValue("@MembershipExpiryDate", DateTime.ParseExact(strMembershipExpiryDate, "dd/MM/yyyy", CultureInfo.InvariantCulture));
            ObjCmd.Parameters.AddWithValue("@MembershipType", ((DropDownList)e.Item.FindControl("ddlEditEmploymentType")).SelectedValue.ToString());

            string strMembershipStatus = ((DropDownList)e.Item.FindControl("ddlEditEmploymentStatus")).SelectedValue.ToString();

            ObjCmd.Parameters.AddWithValue("@MembershipStatus", strMembershipStatus);


           //The dateofleaving is not used. ITs here just as a place holder

            if (strMembershipStatus == "ACTIVE")
            {
            //ObjCmd.Parameters.AddWithValue("@DateOfLeaving", DateTime.ParseExact(strMembershipExpiryDate, "dd/MM/yyyy", CultureInfo.InvariantCulture));
            }
            else
            {
                //ObjCmd.Parameters.AddWithValue("@DateOfLeaving", DateTime.ParseExact("01/01/1900", "dd/MM/yyyy", CultureInfo.InvariantCulture));
            }

            BD.UpdateParameters(ObjCmd);
            Response.Write("<script>alert('Membership updated successfully')</script>");
            //Refresh View Staff List to display newly added Staff.
            Response.Redirect("Members.aspx");

        }

        protected void ddlEditMembershipStatus_SelectedIndexChanged(object sender, EventArgs e)
        {

            DropDownList ddlEditEmploymentStatus = new DropDownList();
            Label lblEditDateOfLeaving = new Label();
            TextBox txtBoxEditDateOfLeaving = new TextBox();

            foreach (DataListItem dlItem in dlEditStaffProfile.Items)
            {
                ddlEditEmploymentStatus = (DropDownList)dlItem.FindControl("ddlEditEmploymentStatus");
                lblEditDateOfLeaving = (Label)dlItem.FindControl("lblEditDateOfLeaving");
                txtBoxEditDateOfLeaving = (TextBox)dlItem.FindControl("txtBoxEditDateOfLeaving");
            }


            string status = ddlEditEmploymentStatus.SelectedValue.ToString();
            if (status == "NOTACTIVE")
            {
                txtBoxEditDateOfLeaving.Visible = true;
                lblEditDateOfLeaving.Visible = true;
            }
            if (status == "ACTIVE")
            {
                txtBoxEditDateOfLeaving.Visible = false;
                lblEditDateOfLeaving.Visible = false;
            }
        }


        protected void btnFileUpload_StaffPhoto(object sender, CommandEventArgs e)
        {
            FS.UploadFileFromDataListControl(dlEditStaffProfile, "flUploadStaffPhoto", "~/Artifacts/Members/", "lblEmpPhotoPath");
        }

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

        //File upload out side control, Help Documents
        protected void btnFileUpload_HelpDocument(object sender, CommandEventArgs e)
        {
            string flCmdName = e.CommandName.ToString();
            switch (flCmdName)
            {
                case "flOne":
                    FS.UploadFileFromOutsideControl(flHelpDocumentOne, "~/Artifacts/Help/", lblHelpDocumentPathOne);
                    break;                
                default:
                    break;
            }
        }

        //Add New Staff Document
        protected void SaveHelpDocument(object sender, CommandEventArgs e)
        {
            string docTitle, docPath;
            string cmdName = e.CommandName.ToString();
            switch (cmdName)
            {
                case "docOne":
                    docTitle = txtBoxHelpDocumentTitleOne.Text;
                    docPath = lblHelpDocumentPathOne.Text;
                    break;               
                default:
                    docTitle = "";
                    docPath = "";
                    break;
            }
            SqlCommand ObjCmd = new SqlCommand("spInsertHelpDocument", BD.ConStr);
            ObjCmd.CommandType = CommandType.StoredProcedure;
            ObjCmd.Parameters.AddWithValue("@UploadDate", DateTime.Now);          
            ObjCmd.Parameters.AddWithValue("@DocumentTitle", docTitle);
            ObjCmd.Parameters.AddWithValue("@DocumentPath", docPath);
            BD.UpdateParameters(ObjCmd);
            Response.Write("<script>alert('Help Document Uploaded successfully')</script>");
            //Refresh View Staff List to display newly added Staff.
            //Response.Redirect("Staff.aspx");
        }


    }
}
