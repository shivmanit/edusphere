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
    public partial class Centres : System.Web.UI.Page
    {
        BindData BD         = new BindData();
        ITranslateText TT   = new TranslateText();
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                string qCentres = string.Format(@"SELECT * FROM EduSphere.Organizations WHERE OrganizationID>104");
                BD.DataBindToDataList(dlCentres, qCentres);
            }
        }

        //Manage Contact Page
        protected void ContactCentre(object sender, CommandEventArgs e)
        {
            int OrgID = Convert.ToInt32(e.CommandArgument.ToString());
            Response.Redirect("Contact.aspx?Id="+OrgID);

        }

        //Manage CENTRE Visibility
        protected void ManageCentreVisibility(object sender,CommandEventArgs e)
        {
            string cmdName = e.CommandName.ToString();
            string q="";
            switch (cmdName)
            {
                case "SearchCentre":
                    lblCentreAction.Text = "Search Result";
                    q = string.Format(@"SELECT * FROM EduSphere.Organizations WHERE OrganizationID>104 AND (OrganizationName LIKE '%{0}%' OR ManagerName LIKE '%{0}%' OR locality LIKE '%{0}%')", txtBoxSearchCentre.Text.ToString());

                    break;
                default:
                    break;
            }
            BD.DataBindToDataList(dlCentres,q);

        }
        //Send enquiry
        protected void SubmitEnquiry(object sender, CommandEventArgs e)
        {
            //if ((txtBoxFullName.Text == "") || (txtBoxEmail.Text == "") || (txtBoxPhone.Text == ""))
            //{
            //    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Please provide details !!!')", true);
            //    return;
            //}
            //SqlCommand NewReqCmd = new SqlCommand("spNewRequest", BD.ConStr);
            //NewReqCmd.CommandType = CommandType.StoredProcedure;
            //NewReqCmd.Parameters.AddWithValue("RequesterFullName", txtBoxFullName.Text);
            //NewReqCmd.Parameters.AddWithValue("RequesterEmail", txtBoxEmail.Text);
            //NewReqCmd.Parameters.AddWithValue("RequesterPhone", txtBoxPhone.Text);
            //NewReqCmd.Parameters.AddWithValue("RequesterAddress", txtBoxAddress.Text);
            //NewReqCmd.Parameters.AddWithValue("RequesterState", Convert.ToInt32(ddlState.SelectedValue.ToString()));
            //NewReqCmd.Parameters.AddWithValue("Comments", txtBoxComments.Text);
            //NewReqCmd.Parameters.AddWithValue("RaisedOn", DateTime.Now.ToString());
            //NewReqCmd.Parameters.AddWithValue("RequestedRoleName", ddlRequestedRole.SelectedValue.ToString());
            //NewReqCmd.Parameters.AddWithValue("RequestApprovalStatus", "NEW");
            //BD.UpdateParameters(NewReqCmd);
            //Alert Sound
            //ScriptManager.RegisterStartupScript(this, GetType(), "makeAlertSound", "playSound()", true);
            ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Request Sent !!!')", true);
            //Clear
            //txtBoxFullName.Text = "";
            //txtBoxEmail.Text = "";
            //txtBoxPhone.Text = "";
        }

        protected void lnkBtnContact_Command(object sender, CommandEventArgs e)
        {
            string strOrgID= e.CommandArgument.ToString();
            Response.Redirect("Contact.aspx?Id=" + strOrgID);

        }

        //Translate
        protected void Translate(object sender,CommandEventArgs e)
        {
            string cmdName = e.CommandName.ToString();
            string uri= "&to=hi";
            //string key = "eae1d8b0745c4df79cbf8851c43ccdcf";
            lblCentreAction.Text = (TT.TranslateTextRequest(uri, "Its Easy to write exam in Hindi")).ToString();
            


        }
    }
}