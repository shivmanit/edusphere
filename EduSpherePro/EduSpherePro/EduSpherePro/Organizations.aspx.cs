using EduSpherePro.CoreServices;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EduSpherePro.EduSpherePro
{
    public partial class Organizations : System.Web.UI.Page
    {
        IBindData BD = new BindData();
        IAnalytics MT = new Analytics();


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblOrganizationAction.Text = "View Organizations";
                pnlViewOrganizations.Visible = true;
                pnlAddOrganization.Visible = false;
                pnlEditOrganizationProfile.Visible = false;
                pnlViewOrganizationProfile.Visible = false;
                pnlOrganizationBankDetails.Visible = false;

                string strCmd = string.Format("SELECT TOP 100 * FROM EduSphere.Organizations WHERE OrganizationId>={0} ORDER BY OrganizationId DESC", 104);
                BD.DataBindToDataList(dlOrganizations, strCmd);
                //Display Count for Principle,Customer & Vendor
                lblCountCustomers.Text = (MT.Count("spEduCentreCount")).ToString();
                lblCountCustomersHelp.Text = lblCountCustomers.Text;
                
                lblCountVendors.Text = (MT.Count("spVendorsCount")).ToString();
                lblCountVendorsHelp.Text = lblCountCustomers.Text;
            }
        }

        //Manage Organization Panel Displays
        protected void ManageOrganizationVisibility(object sender, CommandEventArgs e)
        {
            string cmdName, strCmd = "";
            int intOrganizationId;
            cmdName = e.CommandName.ToString();

            switch (cmdName)
            {
                case "AddOrganization":
                    lblOrganizationAction.Text = "Enroll New Organization";
                    pnlViewOrganizations.Visible = false;
                    pnlViewOrganizationProfile.Visible = false;
                    pnlOrganizationBankDetails.Visible = false;
                    pnlEditOrganizationProfile.Visible = false;
                    pnlAddOrganization.Visible = true;
                    break;
                case "ViewProfile":
                    lblOrganizationAction.Text = "Organization Details";
                    pnlViewOrganizations.Visible = false;
                    pnlViewOrganizationProfile.Visible = true;
                    pnlOrganizationBankDetails.Visible = false;
                    pnlEditOrganizationProfile.Visible = false;
                    pnlAddOrganization.Visible = false;
                    if (cmdName == "ViewProfile")
                    {
                        intOrganizationId = Convert.ToInt32(e.CommandArgument.ToString());
                        strCmd = string.Format("SELECT * FROM EduSphere.Organizations WHERE OrganizationId='{0}'", intOrganizationId);
                    }
                    BD.DataBindToDataList(dlOrganizationDetails, strCmd);
                    break;
                case "OrganizationBankDetails":
                    lblOrganizationAction.Text = "Organization Bank Details";
                    pnlViewOrganizations.Visible = false;
                    pnlViewOrganizationProfile.Visible = false;
                    pnlOrganizationBankDetails.Visible = true;
                    pnlEditOrganizationProfile.Visible = false;
                    pnlAddOrganization.Visible = false;
                    intOrganizationId = Convert.ToInt32(e.CommandArgument.ToString());
                    BD.DataBindToDataList(dlOrganizationBankDetails, string.Format("SELECT * FROM EduSphere.FinAccountDetails f JOIN EduSphere.Organizations o ON f.OrganizationId=o.OrganizationId WHERE f.OrganizationId={0}", intOrganizationId));
                    break;
                case "FilterOrganizationType":
                case "SearchOrganization":
                    lblOrganizationAction.Text = "Filtered Organizations";
                    pnlViewOrganizations.Visible = true;
                    pnlViewOrganizationProfile.Visible = false;
                    pnlOrganizationBankDetails.Visible = false;
                    pnlEditOrganizationProfile.Visible = false;
                    pnlAddOrganization.Visible = false;
                    if (cmdName == "FilterOrganizationType")
                    {
                        string strOrganizationType = ddlFilterOrganizationType.SelectedValue.ToString();
                        strCmd = string.Format("SELECT * FROM EduSphere.Organizations WHERE OrganizationType='{0}' AND OrganizationId>='{1}' ORDER BY OrganizationId DESC", strOrganizationType, 100);
                    }
                    if (cmdName == "SearchOrganization")
                    {
                        string strSerachParam = txtBoxSearchOrganization.Text;
                        strCmd = string.Format("SELECT * FROM EduSphere.Organizations WHERE OrganizationID>104 AND (OrganizationName LIKE '%{0}%' OR ManagerName LIKE '%{0}%' OR locality LIKE '%{0}%')", strSerachParam);
                    }

                    BD.DataBindToDataList(dlOrganizations, strCmd);
                    break;

                case "EditProfile":
                    lblOrganizationAction.Text = "Edit Organization Details";
                    pnlViewOrganizations.Visible = false;
                    pnlViewOrganizationProfile.Visible = false;
                    pnlEditOrganizationProfile.Visible = true;
                    pnlAddOrganization.Visible = false;
                    BD.DataBindToDataList(dlEditOrganizationProfile, string.Format("SELECT * FROM EduSphere.Organizations WHERE OrganizationId='{0}'", Convert.ToInt32(e.CommandArgument.ToString())));
                    break;
                //case "ViewOrganizationCsr":
                //    Response.Redirect(string.Format("Csr.aspx?{0}", Convert.ToInt32(e.CommandArgument.ToString())));
                //    break;
                //case "GoToStudentGallery":
                //    int intEmployerID           = Convert.ToInt32(e.CommandArgument.ToString());
                //    Response.Redirect(string.Format("Students.aspx?id={0}", intEmployerID));
                //    break;
                case "ReturnToViewOrganizations":
                    Response.Redirect("Organizations.aspx");
                    break;
                default:
                    break;
            }
        }

        //Add New Organization
        protected void AddNewOrganization(object sender, CommandEventArgs e)
        {
            SqlCommand ObjCmd = new SqlCommand("spInsertOrganization", BD.ConStr);
            ObjCmd.CommandType = CommandType.StoredProcedure;
            string strNotify = "NO";
            //if (chkBoxNotify.Checked)
            //    strNotify = "YES";
            ObjCmd.Parameters.AddWithValue("@OrganizationName", txtBoxOrganizationName.Text);
            ObjCmd.Parameters.AddWithValue("@OrganizationType", ddlOrganizationType.SelectedValue.ToString());
            ObjCmd.Parameters.AddWithValue("@ManagerName", txtBoxManagerName.Text);
            ObjCmd.Parameters.AddWithValue("@ManagerEmail", txtBoxManagerEmail.Text);
            ObjCmd.Parameters.AddWithValue("@ManagerPhone", "+91" + txtBoxManagerPhone.Text);
            ObjCmd.Parameters.AddWithValue("@ContactPerson", txtBoxContactPerson.Text);

            ObjCmd.Parameters.AddWithValue("@PhoneOne", "+91" + txtBoxPhoneTwo.Text);
            ObjCmd.Parameters.AddWithValue("@PhoneTwo", "+91" + txtBoxPhoneTwo.Text);
            ObjCmd.Parameters.AddWithValue("@Email", txtBoxEmail.Text);
            ObjCmd.Parameters.AddWithValue("@OfficeAddress", txtBoxOfficeAddress.Text);

            ObjCmd.Parameters.AddWithValue("@EnrolmentDate", DateTime.Parse(txtBoxEnrolmentDate.Text));//The first servie ID in services
            ObjCmd.Parameters.AddWithValue("@MemberPhoto", "");
            ObjCmd.Parameters.AddWithValue("@Remarks", txtBoxRemarks.Text);
            ObjCmd.Parameters.AddWithValue("@Notify", strNotify);
            ObjCmd.Parameters.AddWithValue("@street_number", street_number.Text);
            ObjCmd.Parameters.AddWithValue("@route", route.Text);
            ObjCmd.Parameters.AddWithValue("@locality", locality.Text);
            ObjCmd.Parameters.AddWithValue("@administrative_area_level_1", administrative_area_level_1.Text);
            ObjCmd.Parameters.AddWithValue("@postal_code", postal_code.Text);
            ObjCmd.Parameters.AddWithValue("@country", country.Text);
            BD.UpdateParameters(ObjCmd);
            //Response.Write("<script>alert('Member enrolled successfully')</script>");
            ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Organization Added !!!')", true);
            //Refresh View Organization List to display newly added customer.
            Response.Redirect("Organizations.aspx");
            //Display customer count
            //send Welcome Message to Organization
            //if (strNotify == "YES")
            //{
            //    Connect EC = new Connect();
            //    string strSMSmessage = string.Format("Dear '{0}, Thanks for visiting Purple Salon N Academy !!!", strFirstName);
            //    EC.SendSMS(strPhoneOne, strSMSmessage);
            //    SentMsgLogger("SMS", strSMSmessage, strPhoneOne, strFirstName);
            //}
        }

        //Update Organization Profile
        protected void UpdateOrganizationProfile(object sender, DataListCommandEventArgs e)
        {
            SqlCommand ObjCmd = new SqlCommand("spUpdateOrganization", BD.ConStr);
            ObjCmd.CommandType = CommandType.StoredProcedure;

            ObjCmd.Parameters.AddWithValue("@OrganizationId", Convert.ToInt32(dlEditOrganizationProfile.DataKeys[e.Item.ItemIndex]));
            ObjCmd.Parameters.AddWithValue("@OrganizationName", ((TextBox)e.Item.FindControl("txtBoxEditOrgName")).Text);
            //ObjCmd.Parameters.AddWithValue("@OrganizationType", ((DropDownList)e.Item.FindControl("ddlEditOrganizationType")).SelectedValue.ToString());
            ObjCmd.Parameters.AddWithValue("@ManagerName", ((TextBox)e.Item.FindControl("txtBoxEditManagerName")).Text);
            ObjCmd.Parameters.AddWithValue("@ManagerEmail", ((TextBox)e.Item.FindControl("txtBoxEditManagerEmail")).Text);
            ObjCmd.Parameters.AddWithValue("@ManagerPhone", ((TextBox)e.Item.FindControl("txtBoxEditManagerPhone")).Text);
            ObjCmd.Parameters.AddWithValue("@ContactPerson", ((TextBox)e.Item.FindControl("txtBoxEditContactPerson")).Text);

            ObjCmd.Parameters.AddWithValue("@PhoneOne", ((TextBox)e.Item.FindControl("txtBoxEditPhoneTwo")).Text);
            ObjCmd.Parameters.AddWithValue("@PhoneTwo", ((TextBox)e.Item.FindControl("txtBoxEditPhoneTwo")).Text);
            ObjCmd.Parameters.AddWithValue("@Email", ((TextBox)e.Item.FindControl("txtBoxEditEmail")).Text);
            ObjCmd.Parameters.AddWithValue("@OfficeAddress", ((TextBox)e.Item.FindControl("txtBoxEditOfficeAddress")).Text);

            //ObjCmd.Parameters.AddWithValue("@EnrolmentDate", DateTime.Parse(txtBoxEnrolmentDate.Text));//The first servie ID in services
            ObjCmd.Parameters.AddWithValue("@MemberPhoto", ((TextBox)e.Item.FindControl("txtBoxEditMemberPhoto")).Text);
            ObjCmd.Parameters.AddWithValue("@Remarks", ((TextBox)e.Item.FindControl("txtBoxEditRemarks")).Text);
            ObjCmd.Parameters.AddWithValue("@Notify", ((TextBox)e.Item.FindControl("txtBoxEditNotify")).Text);
            BD.UpdateParameters(ObjCmd);
            Response.Write("<script>alert('Profile updatedsuccessfully')</script>");
            //Refresh View Organization List to display newly added customer.
            Response.Redirect("Organizations.aspx");

        }

        //
        protected void dlOrganizationBankDetailsEditHandler(object sender, DataListCommandEventArgs e)
        {
            dlOrganizationBankDetails.EditItemIndex = e.Item.ItemIndex;
            int intOrganizationId = Convert.ToInt32(dlOrganizationBankDetails.DataKeys[e.Item.ItemIndex]);
            string queryString = string.Format("SELECT * FROM EduSphere.FinAccountDetails f JOIN EduSphere.Organizations o ON f.OrganizationId=o.OrganizationId WHERE f.OrganizationId={0}", intOrganizationId);
            BD.DataBindToDataList(dlOrganizationBankDetails, queryString);

        }

        //
        protected void dlOrganizationBankDetailsUpdateHandler(object sender, DataListCommandEventArgs e)
        {
            int intOrganizationId = Convert.ToInt32(dlOrganizationBankDetails.DataKeys[e.Item.ItemIndex]);
            SqlCommand ObjCmd = new SqlCommand("spUpdateFinAccountDetails", BD.ConStr);
            ObjCmd.CommandType = CommandType.StoredProcedure;

            //Update Contact Details
            ObjCmd.Parameters.AddWithValue("@OrganizationId", intOrganizationId);
            ObjCmd.Parameters.AddWithValue("@GoodsAndServicesTaxCode", ((TextBox)(e.Item.FindControl("txtBoxEditGSTCode"))).Text);
            ObjCmd.Parameters.AddWithValue("@ServiceTaxCode", ((TextBox)(e.Item.FindControl("txtBoxEditServiceTaxCode"))).Text);
            ObjCmd.Parameters.AddWithValue("@ValueAddedTaxCode", ((TextBox)(e.Item.FindControl("txtBoxEditVATCode"))).Text);
            ObjCmd.Parameters.AddWithValue("@PermanentAccountNumber", ((TextBox)(e.Item.FindControl("txtBoxEditPANNumber"))).Text);
            ObjCmd.Parameters.AddWithValue("@BankName", ((TextBox)(e.Item.FindControl("txtBoxEditBnkName"))).Text);
            ObjCmd.Parameters.AddWithValue("@BankAccountNumber", ((TextBox)(e.Item.FindControl("txtBoxEditBankAccountNumber"))).Text);
            ObjCmd.Parameters.AddWithValue("@BankIFSCCode", ((TextBox)(e.Item.FindControl("txtBoxEditBankIFSCCode"))).Text);

            BD.UpdateParameters(ObjCmd);

        }
        //
        protected void dlOrganizationBankDetailsCancelHandler(object sender, DataListCommandEventArgs e)
        {
            dlOrganizationBankDetails.EditItemIndex = -1;
            Response.Redirect("Organizations.aspx");
        }
    }
}