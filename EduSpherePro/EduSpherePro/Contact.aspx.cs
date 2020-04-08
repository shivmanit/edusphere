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
    public partial class Contact : Page
    {
        BindData BD = new BindData();
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                //BD.DataBindToDropDownList(ddlState, "SELECT StateID,StateName FROM EduSphere.States");
                ////Check if enquiry is coming from Centre page
                //lblOrgID.Text = Request.QueryString["id"];
                //if(lblOrgID.Text.ToString()!="")
                //{
                    
                //    lblOrgID.Visible = true;

                //}
            }
            
        
        }

        //protected void SubmitEnquiry(object sender, CommandEventArgs e)
        //{
        //    if ((txtBoxFullName.Text == "") || (txtBoxEmail.Text == "") || (txtBoxPhone.Text == ""))
        //    {
        //        ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Please provide details !!!')", true);
        //        return;
        //    }
        //    SqlCommand NewReqCmd = new SqlCommand("spNewRequest", BD.ConStr);
        //    NewReqCmd.CommandType = CommandType.StoredProcedure;
        //    NewReqCmd.Parameters.AddWithValue("@RequesterFullName", txtBoxFullName.Text);
        //    NewReqCmd.Parameters.AddWithValue("@RequesterEmail", txtBoxEmail.Text);
        //    NewReqCmd.Parameters.AddWithValue("@RequesterPhone", txtBoxPhone.Text);
        //    NewReqCmd.Parameters.AddWithValue("@RequesterAddress", txtBoxAddress.Text);
        //    NewReqCmd.Parameters.AddWithValue("@RequesterState", Convert.ToInt32(ddlState.SelectedValue.ToString()));
        //    NewReqCmd.Parameters.AddWithValue("@City", txtBoxCity.Text);
        //    NewReqCmd.Parameters.AddWithValue("@Comments", txtBoxComments.Text);
        //    NewReqCmd.Parameters.AddWithValue("@RaisedOn", DateTime.Now.ToString("MM/dd/yyyy"));
        //    NewReqCmd.Parameters.AddWithValue("@RequestedRoleName", ddlRequestedRole.SelectedValue.ToString());
        //    NewReqCmd.Parameters.AddWithValue("@RequestApprovalStatus", "NEW");
        //    //NewReqCmd.Parameters.AddWithValue("@OrganizationID", Convert.ToInt32(lblOrgID.Text));
        //    NewReqCmd.Parameters.AddWithValue("@OrganizationID", 100);
        //    BD.UpdateParameters(NewReqCmd);
        //    //Alert Sound
        //    //ScriptManager.RegisterStartupScript(this, GetType(), "makeAlertSound", "playSound()", true);
        //    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Request Sent !!!')", true);
        //    //Clear
        //    txtBoxFullName.Text         = "";
        //    txtBoxEmail.Text            = "";
        //    txtBoxPhone.Text            = "";
        //}
    }
}