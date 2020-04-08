using EduSpherePro.CoreServices;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Web.UI.WebControls;

namespace EduSpherePro.EduSpherePro
{
    public partial class Staff : System.Web.UI.Page
    {
        IBindData BD = new BindData();
     
        IAnalytics MT = new Analytics();
        IMailService MS = new MailService();
        IFileService FS = new FileService();
        ISMSSender SMS = new SMSSender();
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

                string strCmd = string.Format("SELECT TOP 100 org.OrganizationName as OrganizationName,EmployeeId,FullName,st.PhoneOne as PhoneOne,st.Email as Email FROM EduSphere.Staff st JOIN EduSphere.Organizations org ON st.OrganizationID=org.OrganizationID WHERE EmployeeId>=100 AND EmploymentStatus='{0}' ORDER BY st.FullName ASC", "ACTIVE");
                BD.DataBindToDataList(dlStaff, strCmd);
            }
        }

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
                    pnlViewStaffProfile.Visible = false;
                    pnlEditStaffProfile.Visible = false;
                    BD.DataBindToDropDownList(ddlOrgId, string.Format("SELECT OrganizationID,OrganizationName FROM EduSphere.Organizations"));
                    BD.DataBindToDropDownList(ddlManagerId, string.Format("SELECT FUllName,EmployeeId FROM EduSphere.Staff"));
                    break;
                case "UploadStaffDocument":
                    lblStaffAction.Text = "Upload Staff Document";
                    pnlViewStaff.Visible = false;
                    pnlAddStaff.Visible = false;
                    pnlUploadStaffDocument.Visible = true;
                    pnlViewStaffDocuments.Visible = false;
                    pnlEditStaffProfile.Visible = false;
                    pnlViewStaffProfile.Visible = false;
                    lblEmployeeId.Text = e.CommandArgument.ToString();
                    break;
                case "ViewStaffDocument":
                    lblStaffAction.Text = "View Staff Document";
                    pnlViewStaff.Visible = false;
                    pnlAddStaff.Visible = false;
                    pnlUploadStaffDocument.Visible = false;
                    pnlViewStaffDocuments.Visible = true;
                    pnlEditStaffProfile.Visible = false;
                    pnlViewStaffProfile.Visible = false;
                    intEmployeeId = Convert.ToInt32(e.CommandArgument.ToString());
                    string docQuery = string.Format("SELECT * FROM EduSphere.StaffDocuments WHERE EmployeeId='{0}'", intEmployeeId);
                    BD.DataBindToGridView(gvStaffDocuments, docQuery, "NA");
                    break;
                case "SearchStaff":
                case "FilterStaff":
                    lblStaffAction.Text             = "Search Staff";
                    pnlViewStaff.Visible            = true;
                    pnlAddStaff.Visible             = false;
                    pnlUploadStaffDocument.Visible  = false;
                    pnlViewStaffDocuments.Visible   = false;
                    pnlViewStaffProfile.Visible     = false;
                    pnlEditStaffProfile.Visible     = false;
                    pnlAddStaff.Visible             = false;
                    if (cmdName == "FilterStaff")
                    {
                        string strEmploymentStatus = ddlFilterEmploymentStatus.SelectedValue.ToString();
                        strCmd = string.Format("SELECT OrganizationName,EmployeeId,FullName,st.PhoneOne,st.Email FROM EduSphere.Staff st JOIN EduSphere.Organizations org ON st.OrganizationID=org.OrganizationID WHERE EmploymentStatus='{0}' ORDER BY st.FullName ASC", strEmploymentStatus);

                    }
                    if (cmdName == "SearchStaff")
                    {
                        string strSerachParam = txtBoxSearchStaff.Text;
                        strCmd = string.Format("SELECT OrganizationName,EmployeeId,FullName,PhoneOne,Email FROM EduSphere.Staff st JOIN EduSphere.Organizations org ON st.OrganizationID=org.OrganizationID WHERE FullName LIKE '%{0}%' OR EmployeeId LIKE '%{0}%' ORDER BY st.FullName ASC", strSerachParam);
                    }
                    BD.DataBindToDataList(dlStaff, strCmd);
                    break;
                case "ViewProfile":
                    lblStaffAction.Text             = "Staff Details";
                    pnlViewStaff.Visible            = false;
                    pnlAddStaff.Visible             = false;
                    pnlUploadStaffDocument.Visible  = false;
                    pnlViewStaffDocuments.Visible   = false;
                    pnlViewStaffProfile.Visible     = true;
                    pnlEditStaffProfile.Visible     = false;
                    pnlAddStaff.Visible             = false;
                    if (cmdName == "ViewProfile")
                    {
                        intEmployeeId = Convert.ToInt32(e.CommandArgument.ToString());
                        strCmd = string.Format("SELECT *,(SELECT FullName FROM EduSphere.Staff WHERE EmployeeId=(SELECT ManagerID FROM EduSphere.Staff WHERE EmployeeId='{0}')) AS ManagerName FROM EduSphere.Staff WHERE EmployeeId='{0}'", intEmployeeId, "ManagerName");
                        BD.DataBindToDataList(dlStaffDetails, strCmd);
                    }
                    break;
                case "EditProfile":
                    lblStaffAction.Text             = "Edit Staff Details";
                    pnlViewStaff.Visible            = false;
                    pnlAddStaff.Visible             = false;
                    pnlUploadStaffDocument.Visible  = false;
                    pnlViewStaffDocuments.Visible   = false;
                    pnlViewStaffProfile.Visible     = false;
                    pnlEditStaffProfile.Visible     = true;
                    pnlAddStaff.Visible             = false;
                    BD.DataBindToDataList(dlEditStaffProfile, string.Format("SELECT * FROM EduSphere.Staff WHERE EmployeeId='{0}'", Convert.ToInt32(e.CommandArgument.ToString())));
                    DropDownList ddlOrg = new DropDownList();
                    DropDownList ddlManager = new DropDownList();
                    foreach (DataListItem li in dlEditStaffProfile.Items)
                    {
                        ddlOrg = (DropDownList)li.FindControl("ddlEditOrgId");
                        ddlManager = (DropDownList)li.FindControl("ddlEditManagerId");
                    }
                    BD.DataBindToDropDownList(ddlOrg, string.Format("SELECT OrganizationName, OrganizationID FROM EduSphere.Organizations"));
                    BD.DataBindToDropDownList(ddlManager, string.Format("SELECT EmployeeId, FullName FROM EduSphere.Staff"));
                    break;
                case "ReturnToViewStaff":
                    Response.Redirect("Staff.aspx");
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
            ObjCmd.Parameters.AddWithValue("@EmpPhotoPath", "~/Artifacts/Emp/Photo/Photo.jpg");
            ObjCmd.Parameters.AddWithValue("@FullName", txtBoxFullName.Text);
            ObjCmd.Parameters.AddWithValue("@Gender", ddlGender.SelectedValue.ToString());
            ObjCmd.Parameters.AddWithValue("@PhoneOne", "+91" + txtBoxPhoneOne.Text);
            ObjCmd.Parameters.AddWithValue("@PhoneTwo", "+91" + txtBoxPhoneTwo.Text);
            ObjCmd.Parameters.AddWithValue("@Email", txtBoxEmail.Text);
            ObjCmd.Parameters.AddWithValue("@ContactAddress", txtBoxContactAddress.Text);
            ObjCmd.Parameters.AddWithValue("@City", txtBoxCity.Text);
            ObjCmd.Parameters.AddWithValue("@District", txtBoxDistrict.Text);//The first servie ID in services
            ObjCmd.Parameters.AddWithValue("@PinCode", txtBoxPinCode.Text);
            ObjCmd.Parameters.AddWithValue("@State", txtBoxState.Text);
            ObjCmd.Parameters.AddWithValue("@Country", txtBoxCountry.Text);
            ObjCmd.Parameters.AddWithValue("@Designation", txtBoxDesignation.Text);
            ObjCmd.Parameters.AddWithValue("@DateOfBirth", DateTime.Parse(txtBoxDateOfBirth.Text));
            int intManagerId = 99;
            string strManagerId = ddlManagerId.SelectedValue.ToString();

            if (strManagerId != "Select")
            {
                ObjCmd.Parameters.AddWithValue("@ManagerId", Convert.ToInt32(strManagerId));
            }
            else
            {
                ObjCmd.Parameters.AddWithValue("@ManagerId", intManagerId);
            }




            ObjCmd.Parameters.AddWithValue("@DateOfJoining", DateTime.Parse(txtBoxDateOfJoining.Text));
            ObjCmd.Parameters.AddWithValue("@EmploymentType", ddlEmploymentType.SelectedValue.ToString());
            ObjCmd.Parameters.AddWithValue("@FathersName", txtBoxFathersName.Text);
            ObjCmd.Parameters.AddWithValue("@MothersName", txtBoxMothersName.Text);
            ObjCmd.Parameters.AddWithValue("@PanNumber", txtBoxPan.Text);
            ObjCmd.Parameters.AddWithValue("@AadhaarNumber", txtBoxAadhaar.Text);
            ObjCmd.Parameters.AddWithValue("@BankName", txtBoxBankName.Text);
            ObjCmd.Parameters.AddWithValue("@BankAccountNumber", txtBoxBankAccount.Text);
            ObjCmd.Parameters.AddWithValue("@BankIFSC", txtBoxBankIFSC.Text);

            ObjCmd.Parameters.AddWithValue("@EmploymentStatus", ddlEmploymentStatus.SelectedValue.ToString());//The first servie ID in services
            if (ddlEmploymentStatus.SelectedValue.ToString() == "ACTIVE")
                txtBoxDateOfLeaving.Text = "01/01/3000";
            ObjCmd.Parameters.AddWithValue("@DateOfLeaving", DateTime.Parse(txtBoxDateOfLeaving.Text));

            BD.UpdateParameters(ObjCmd);
            Response.Write("<script>alert('Member enrolled successfully')</script>");
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
            SqlCommand ObjCmd = new SqlCommand("spInsertStaffDocument", BD.ConStr);
            ObjCmd.CommandType = CommandType.StoredProcedure;
            int intEmployeeId = Convert.ToInt32(lblEmployeeId.Text);

            ObjCmd.Parameters.AddWithValue("@UploadDate", DateTime.Now);
            ObjCmd.Parameters.AddWithValue("@EmployeeId", intEmployeeId);
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
            SqlCommand ObjCmd = new SqlCommand("spUpdateStaff", BD.ConStr);
            ObjCmd.CommandType = CommandType.StoredProcedure;

            ObjCmd.Parameters.AddWithValue("@EmployeeId", Convert.ToInt32(dlEditStaffProfile.DataKeys[e.Item.ItemIndex]));
            ObjCmd.Parameters.AddWithValue("@OrganizationID", ((DropDownList)e.Item.FindControl("ddlEditOrgId")).SelectedValue.ToString());
            ObjCmd.Parameters.AddWithValue("@EmpPhotoPath", ((Label)e.Item.FindControl("lblEmpPhotoPath")).Text);
            ObjCmd.Parameters.AddWithValue("@FullName", ((TextBox)e.Item.FindControl("txtBoxEditFullName")).Text);
            ObjCmd.Parameters.AddWithValue("@PhoneOne", ((TextBox)e.Item.FindControl("txtBoxEditPhoneOne")).Text);
            ObjCmd.Parameters.AddWithValue("@PhoneTwo", ((TextBox)e.Item.FindControl("txtBoxEditPhoneTwo")).Text);
            ObjCmd.Parameters.AddWithValue("@Email", ((TextBox)e.Item.FindControl("txtBoxEditEmail")).Text);
            ObjCmd.Parameters.AddWithValue("@ContactAddress", ((TextBox)e.Item.FindControl("txtBoxEditContactAddress")).Text);
            ObjCmd.Parameters.AddWithValue("@City", ((TextBox)e.Item.FindControl("txtBoxEditCity")).Text);
            ObjCmd.Parameters.AddWithValue("@District", ((TextBox)e.Item.FindControl("txtBoxEditDistrict")).Text);
            ObjCmd.Parameters.AddWithValue("@PinCode", ((TextBox)e.Item.FindControl("txtBoxEditPinCode")).Text);
            ObjCmd.Parameters.AddWithValue("@State", ((TextBox)e.Item.FindControl("txtBoxEditState")).Text);
            ObjCmd.Parameters.AddWithValue("@Country", ((TextBox)e.Item.FindControl("txtBoxEditCountry")).Text);
            ObjCmd.Parameters.AddWithValue("@Designation", ((TextBox)e.Item.FindControl("txtBoxEditDesignation")).Text);

            string strBirthDt = ((TextBox)e.Item.FindControl("txtBoxEditDateOfBirth")).Text.ToString();
            ObjCmd.Parameters.AddWithValue("@DateOfBirth", DateTime.ParseExact(strBirthDt, "dd/MM/yyyy", CultureInfo.InvariantCulture));

            ObjCmd.Parameters.AddWithValue("@ManagerId", Convert.ToInt32(((DropDownList)e.Item.FindControl("ddlEditManagerId")).SelectedValue.ToString()));

            ObjCmd.Parameters.AddWithValue("@FathersName", ((TextBox)e.Item.FindControl("txtBoxEditFathersName")).Text);
            ObjCmd.Parameters.AddWithValue("@MothersName", ((TextBox)e.Item.FindControl("txtBoxEditMothersName")).Text);
            ObjCmd.Parameters.AddWithValue("@PanNumber", ((TextBox)e.Item.FindControl("txtBoxEditPan")).Text);
            ObjCmd.Parameters.AddWithValue("@AadhaarNumber", ((TextBox)e.Item.FindControl("txtBoxEditAadhaar")).Text);
            ObjCmd.Parameters.AddWithValue("@BankName", ((TextBox)e.Item.FindControl("txtBoxEditBankName")).Text);
            ObjCmd.Parameters.AddWithValue("@BankAccountNumber", ((TextBox)e.Item.FindControl("txtBoxEditBankAccount")).Text);
            ObjCmd.Parameters.AddWithValue("@BankIFSC", ((TextBox)e.Item.FindControl("txtBoxEditBankIFSC")).Text);

            string strJoiningDt = ((TextBox)e.Item.FindControl("txtBoxEditDateOfJoining")).Text.ToString();
            ObjCmd.Parameters.AddWithValue("@DateOfJoining", DateTime.ParseExact(strJoiningDt, "dd/MM/yyyy", CultureInfo.InvariantCulture));
            ObjCmd.Parameters.AddWithValue("@EmploymentType", ((DropDownList)e.Item.FindControl("ddlEditEmploymentType")).SelectedValue.ToString());

            string strEmploymentStatus = ((DropDownList)e.Item.FindControl("ddlEditEmploymentStatus")).SelectedValue.ToString();

            ObjCmd.Parameters.AddWithValue("@EmploymentStatus", strEmploymentStatus);
            string strLeavingDt = ((TextBox)e.Item.FindControl("txtBoxEditDateOfLeaving")).Text.ToString();

            if (strEmploymentStatus=="ACTIVE")
            {
                ObjCmd.Parameters.AddWithValue("@DateOfLeaving", "");
            }
            else
            {
                ObjCmd.Parameters.AddWithValue("@DateOfLeaving", DateTime.ParseExact(strLeavingDt, "dd/MM/yyyy", CultureInfo.InvariantCulture));
            }
            
            BD.UpdateParameters(ObjCmd);
            Response.Write("<script>alert('Profile updated successfully')</script>");
            //Refresh View Staff List to display newly added Staff.
            Response.Redirect("Staff.aspx");

        }

        protected void ddlEmploymentStatus_SelectedIndexChanged(object sender, EventArgs e)
        {
            string status = ddlEmploymentStatus.SelectedValue.ToString();
            if (status == "NOTACTIVE")
            {
                txtBoxDateOfLeaving.Visible = true;
                lblDtOfLeaving.Visible = true;
            }
            if (status == "ACTIVE")
            {
                txtBoxDateOfLeaving.Visible = false;
                lblDtOfLeaving.Visible = false;
            }
        }

        protected void ddlEditEmploymentStatus_SelectedIndexChanged(object sender, EventArgs e)
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
                txtBoxDateOfLeaving.Visible = false;
                lblEditDateOfLeaving.Visible = false;
            }
        }

        protected void btnFileUpload_StaffPhoto(object sender, CommandEventArgs e)
        {
            FS.UploadFileFromDataListControl(dlEditStaffProfile, "flUploadStaffPhoto", "~/Artifacts/Staff/", "lblEmpPhotoPath");
        }

        //File upload out side control
        protected void btnFileUpload_StaffDocument(object sender, CommandEventArgs e)
        {
            string flCmdName = e.CommandName.ToString();
            switch (flCmdName)
            {
                case "flOne":
                    FS.UploadFileFromOutsideControl(flStaffDocumentOne, "~/Artifacts/Staff/", lblStaffDocumentPathOne);
                    break;
                case "flTwo":
                    FS.UploadFileFromOutsideControl(flStaffDocumentTwo, "~/Artifacts/Staff/", lblStaffDocumentPathTwo);
                    break;
                case "flThree":
                    FS.UploadFileFromOutsideControl(flStaffDocumentThree, "~/Artifacts/Staff/", lblStaffDocumentPathThree);
                    break;
                case "flFour":
                    FS.UploadFileFromOutsideControl(flStaffDocumentFour, "~/Artifacts/Staff/", lblStaffDocumentPathFour);
                    break;
                case "flFive":
                    FS.UploadFileFromOutsideControl(flStaffDocumentFive, "~/Artifacts/Emp/Docs/", lblStaffDocumentPathFive);
                    break;
                case "flSix":
                    FS.UploadFileFromOutsideControl(flStaffDocumentSix, "~/Artifacts/Staff/", lblStaffDocumentPathSix);
                    break;
                default:
                    break;

            }
        }



    }
}