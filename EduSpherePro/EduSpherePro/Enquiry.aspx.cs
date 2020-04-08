using EduSpherePro.CoreServices;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EduSpherePro
{
    public partial class Enquiry : System.Web.UI.Page
    {
        BindData BD = new BindData();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string query = string.Format("SELECT ProgramTitle,ProgramId FROM EduSphere.Programs");
                BD.DataBindToDropDownList(ddlProgramId, query);
                //BD.DataBindToDropDownList(ddlFranchiseeID, string.Format("SELECT OrganizationName,OrganizationId FROM EduSphere.Organizations WHERE OrganizationType='{0}'", "FRANCHISEE"));
                BD.DataBindToDropDownList(ddlState, string.Format(@"SELECT *  FROM EduSphere.States"));
            }

        }

        protected void SubmitEnquiry(object sender, CommandEventArgs e)
        {
            if (txtVerificationCode.Text.ToLower() == Session["CaptchaVerify"].ToString())
            {
                if ((txtBoxFullName.Text == "") || (txtBoxEmail.Text == "") || (txtBoxPhone.Text == ""))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Please provide details !!!')", true);
                    return;
                }
                SqlCommand ObjCmd = new SqlCommand("spInsertEnquiry", BD.ConStr);
                ObjCmd.CommandType = CommandType.StoredProcedure;
                ObjCmd.Parameters.AddWithValue("@ProgramId", Convert.ToInt32(ddlProgramId.SelectedValue.ToString()));
                //ObjCmd.Parameters.AddWithValue("@FranchiseeID", Convert.ToInt32(ddlFranchiseeID.SelectedValue.ToString()));
                ObjCmd.Parameters.AddWithValue("@FranchiseeID", Convert.ToInt32("90"));
                ObjCmd.Parameters.AddWithValue("@StudentName", txtBoxFullName.Text);
                ObjCmd.Parameters.AddWithValue("@Gender", "MALE"); //ddlGender.SelectedValue.ToString());
                ObjCmd.Parameters.AddWithValue("@Education", ddlEducation.SelectedValue.ToString());// txtBoxEducation.Text);
                ObjCmd.Parameters.AddWithValue("@Institute", "NA");// txtBoxInstitute.Text);
                ObjCmd.Parameters.AddWithValue("@Stream", "NA");
                ObjCmd.Parameters.AddWithValue("@Email", txtBoxEmail.Text);
                ObjCmd.Parameters.AddWithValue("@Phone", txtBoxPhone.Text);
                ObjCmd.Parameters.AddWithValue("@City", "NA");// txtBoxCity.Text);
                ObjCmd.Parameters.AddWithValue("@State", ddlState.SelectedValue.ToString());
                ObjCmd.Parameters.AddWithValue("@PinCode", txtBoxPinCode.Text);
                ObjCmd.Parameters.AddWithValue("@EnquiryMessage", txtBoxComments.Text);
                ObjCmd.Parameters.AddWithValue("@RaisedById", "90");
                ObjCmd.Parameters.AddWithValue("@EnquirySource", "WEB");

                BD.UpdateParameters(ObjCmd);
                //SP.Speak("Request Registered Successfully");
                //Response.Write("<script>alert('Request Registered Successfully')</script>");
                //Alert Sound
                ScriptManager.RegisterStartupScript(this, GetType(), "makeAlertSound", "playSound()", true);
                //Refresh View Enquiry List to display newly added Enquiry.
                //Response.Redirect("Enquiries.aspx");
                txtBoxFullName.Text = "";
                txtBoxEmail.Text = "";
                //txtBoxCity.Text = "";
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
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Please enter valid code');", true);
                lblCaptchaMessage.Text = "Please enter correct code !";
                lblCaptchaMessage.ForeColor = System.Drawing.Color.Red;
            }
        }

        protected void ddlProgramGroup_SelectedIndexChanged(object sender, EventArgs e)
        {
            //string query = string.Format("SELECT ProgramTitle,ProgramId FROM EduSphere.Programs WHERE ProgramGroupId={0}", Convert.ToInt32(ddlProgramGroup.SelectedValue.ToString()));
            //BD.DataBindToDropDownList(ddlProgramId, query);
        }

    }
}