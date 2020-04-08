
using EduSpherePro.CoreServices;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace EduSpherePro.EduSpherePro
{
    public partial class Services : System.Web.UI.Page
    {
        BindData BD = new BindData();
        //LoggedInUsers lnUser = new LoggedInUsers("PURPLESALON");
        DataSet ObjDS = new DataSet();
        DataView ObjDV = new DataView();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {

                pnlServices.Visible = true;
                pnlAddService.Visible = false;

                //Get user role
                if (User.Identity.IsAuthenticated)
                {
                    string strID = User.Identity.Name;
                    //string strRole  = lnUser.GetUserRole(strID);
                    if (User.IsInRole("Admin"))
                        lblRole.Text = "Admin";
                    if (User.IsInRole("Manager"))
                        lblRole.Text = "Manager";
                }
                //Bind Sku Groups
                BD.DataBindToDropDownList(ddlServiceGroupFilter, "SELECT SkuGroupID,SkuGroup FROM EduSphere.SkuGroups WHERE SkuGroupID>=100");
                //In case the logged in role is Admin then display delete button.
                if (User.IsInRole("Admin"))
                {
                    BD.DataBindToGridView(dgServices, "SELECT * FROM EduSphere.Sku WHERE SkuId>=100", "NA");
                }
                else
                {
                    BD.DataBindToGridView(dgServicesView, "SELECT * FROM EduSphere.Sku WHERE SkuId>=100", "NA");
                }
            }
        }

        //Display list of Sku belonging to a SkuGroup
        protected void DisplayServices(object sender, CommandEventArgs e)
        {
            string strServiceGroup = e.CommandArgument.ToString();
            //Find lblServiceGroup in DataList and assign the text to SkuGroup
            //lblServiceGroup.Text = strServiceGroup;
            //FilterServices(sender, e);
        }

        //
        protected void ddlServiceGroupFilter_SelectedIndexChanged(Object sender, EventArgs e)
        {
            string strServiceGroup = ddlServiceGroupFilter.SelectedValue.ToString();
            string strCmd;
            if (strServiceGroup != "Select")
                strCmd = string.Format("SELECT * from EduSphere.Sku where SkuGroupID={0} ", Convert.ToInt32(strServiceGroup));
            else
                strCmd = string.Format("SELECT * from EduSphere.Sku");

            if ((lblRole.Text == "Manager") || (lblRole.Text == "Admin"))
                BD.DataBindToGridView(dgServices, strCmd, "NA");
            else
                BD.DataBindToGridView(dgServicesView, strCmd, "NA");

        }


        //To return back to main panel
        protected void ReturnToPanel(object sender, CommandEventArgs e)
        {
            string cmdName = e.CommandName.ToString();
            switch (cmdName)
            {
                case "FromPnlAddServiceToPnlServices":
                    pnlAddService.Visible = false;
                    pnlServices.Visible = true;
                    //pnlServiceButtons.Visible = true;
                    break;
                case "FromPnlCoToPnlServices":
                    pnlServices.Visible = true;
                    break;
                case "FromPnlServiceDocsToPnlServices":

                    pnlServices.Visible = true;
                    break;
                case "FromPnlCOPOMapToPnlCo":

                    break;
                default:
                    break;
            }
        }


        //Display Sku based on filter parameters
        //protected void FilterServices(Object sender, CommandEventArgs e)
        //{
        //    string strCmd;
        //    string strServiceGroup = lblServiceGroup.Text;
        //    if (strServiceGroup != "ALL")
        //        strCmd = string.Format("SELECT * from EduSphere.Sku where SkuGroup='{0}' ", strServiceGroup);
        //    else
        //        strCmd = string.Format("SELECT * from EduSphere.Sku");

        //    if ((lblRole.Text == "Manager") || (lblRole.Text == "Admin"))
        //        BD.DataBindToDataGrid(dgServices, strCmd);
        //    else
        //        BD.DataBindToDataGrid(dgServicesView, strCmd);
        //}

        //Sku datagrid edit function
        protected void dgEditService(object sender, GridViewEditEventArgs e)
        {
            //Make dgCompetenciesEdit dayalist visible for editing
            dgServices.EditIndex = e.NewEditIndex;
            string strKey = dgServices.DataKeys[e.NewEditIndex].Value.ToString();
            //GetSource();
            string strCmd = string.Format("SELECT * FROM EduSphere.Sku where SkuId='{0}'", Convert.ToInt32(strKey));
            BD.DataBindToGridView(dgServices, strCmd, "NA");
        }

        //Cancel editing the Sku
        protected void dgCancelService(object sender, GridViewCancelEditEventArgs e)
        {
            dgServices.EditIndex = -1;
            //GetSource();
            Response.Redirect("Sku.aspx");
        }

        //Delete Sku
        protected void dgDeleteService(object sender, GridViewDeleteEventArgs e)
        {
            string strKey = dgServices.DataKeys[e.RowIndex].Value.ToString();
            SqlCommand ObjCmd = new SqlCommand("spDeleteFromTable", BD.ObjCn);
            ObjCmd.CommandType = CommandType.StoredProcedure;

            ObjCmd.Parameters.AddWithValue("@KeyID", strKey);
            ObjCmd.Parameters.AddWithValue("@SourceTable", "EduSphere.Sku");
            BD.UpdateParameters(ObjCmd);
            //GetSource();
            Response.Redirect("Sku.aspx");
            //BD.DeleteSelectedRecord(dgServices, key, "Sku");
        }

        //Update Sku
        protected void dgUpdateService(object sender, GridViewUpdateEventArgs e)
        {
            int intKeyServiceID;
            decimal decUnitRate;
            string strServiceDuration, strServiceTitle, strServiceDescription;
            GridViewRow row = dgServices.Rows[e.RowIndex];
            intKeyServiceID = (int)dgServices.DataKeys[e.RowIndex].Value;
            //strServiceID          = string.Format(e.Item.Cells[2].Text);
            strServiceTitle = string.Format(((TextBox)row.Cells[2].Controls[0]).Text);
            strServiceDescription = string.Format(((TextBox)row.Cells[3].Controls[0]).Text);
            strServiceDuration = string.Format(((TextBox)row.Cells[4].Controls[0]).Text);
            decUnitRate = Convert.ToDecimal(((TextBox)row.Cells[5].Controls[0]).Text);
            // intRepeatAfter          = Convert.ToInt32(((TextBox)e.Item.Cells[6].Controls[0]).Text);

            //intUnitRate = 99;

            SqlCommand ObjCmd = new SqlCommand("spUpdateSku", BD.ObjCn);
            ObjCmd.CommandType = CommandType.StoredProcedure;

            ObjCmd.Parameters.AddWithValue("@SkuId", intKeyServiceID);
            ObjCmd.Parameters.AddWithValue("@SkuType", "SERVICE");

            ObjCmd.Parameters.AddWithValue("@SkuTitle", strServiceTitle);
            ObjCmd.Parameters.AddWithValue("@SkuDescription", strServiceDescription);
            ObjCmd.Parameters.AddWithValue("@SkuDuration", strServiceDuration);
            ObjCmd.Parameters.AddWithValue("@UnitRate", decUnitRate);
            //ObjCmd.Parameters.AddWithValue("@RepeatAfter", intRepeatAfter);
            BD.UpdateParameters(ObjCmd);

            dgServices.EditIndex = -1;
            //GetSource();
            Response.Redirect("Services.aspx");
        }

        //Get Datasource
        protected void GetSource()
        {
            SqlCommand ObjCmd = new SqlCommand("spSelectServices", BD.ObjCn);
            ObjCmd.CommandType = CommandType.StoredProcedure;

            //DataSet ObjDS = new DataSet();
            SqlDataAdapter ObjDA = new SqlDataAdapter(ObjCmd);
            ObjDA.Fill(ObjDS, "EduSphere.Sku");
            ObjDS = BD.GetDataSet(ObjCmd);

            dgServices.DataSource = ObjDS;
            dgServices.DataBind();

        }

        //Page Index Changed
        protected void dgServices_PageIndexChanged(object sender, GridViewPageEventArgs e)
        {
            dgServices.PageIndex = e.NewPageIndex;
            GetSource();
        }


        //Panel to add new Sku
        protected void DisplayPnlAddService(object sender, CommandEventArgs e)
        {
            pnlServices.Visible = false;
            //pnlServiceButtons.Visible   = true;
            pnlAddService.Visible = true;
            BD.DataBindToDropDownList(ddlServiceGroup, "SELECT SkuGroupID,SkuGroup FROM EduSphere.SkuGroups WHERE SkuGroupID>=100");
            BD.DataBindToDropDownList(ddlTaxCode, "SELECT TaxCode, TaxCodeDescription FROM EduSphere.TaxCodes");
        }
        //
        protected void ddlServiceGroup_SelectedIndexChanged(Object sender, EventArgs e)
        {
            int intServiceGroupID = Convert.ToInt32(ddlServiceGroup.SelectedValue.ToString());
            string strCmd = string.Format("SELECT SkuSubGroupID,SkuSubGroup FROM EduSphere.SkuSubGroups WHERE SkuGroupID={0}", intServiceGroupID);
            BD.DataBindToDropDownList(ddlServiceSubGroup, strCmd);

        }


        //Inserts a new Sku in Sku Table
        protected void InsertNewService(object sender, EventArgs e)
        {
            // string CmdName = e.CommandName.ToString();

            string strServiceTitle          = txtBoxServiceTitle.Text;
            decimal decUnitRate             = Convert.ToDecimal(txtBoxUnitRate.Text);
            int intServiceGroupID           = Convert.ToInt32(ddlServiceGroup.SelectedValue.ToString());
            int intServiceSubGroupID        = Convert.ToInt32(ddlServiceSubGroup.SelectedValue.ToString());
            string strServiceDuration       = txtBoxServiceDuration.Text;
            string strServiceDescription    = txtBoxServiceDescription.Text;
            //int intRepeatAfter              = Convert.ToInt32(txtBoxRepeatAfter.Text);
            int intTaxCode = Convert.ToInt32(ddlTaxCode.SelectedValue.ToString());

            SqlCommand ObjCmd = new SqlCommand("spAddSku", BD.ObjCn);
            ObjCmd.CommandType = CommandType.StoredProcedure;
            //ObjCmd.Parameters.AddWithValue("@SkuId", strServiceID);
            ObjCmd.Parameters.AddWithValue("@SkuType", "SERVICE");
            ObjCmd.Parameters.AddWithValue("@SkuTitle", strServiceTitle);
            ObjCmd.Parameters.AddWithValue("@UnitRate", decUnitRate);
            ObjCmd.Parameters.AddWithValue("@SkuGroupID", intServiceGroupID);
            ObjCmd.Parameters.AddWithValue("@SkuSubGroupID", intServiceSubGroupID);
            ObjCmd.Parameters.AddWithValue("@SkuDuration", strServiceDuration);
            ObjCmd.Parameters.AddWithValue("@SkuDescription", strServiceDescription);
            //ObjCmd.Parameters.AddWithValue("@RepeatAfter", intRepeatAfter);
            ObjCmd.Parameters.AddWithValue("@TaxCode", intTaxCode);
            try
            {
                BD.UpdateParameters(ObjCmd);
                //Response.Write("<script>alert('Sku Added Successfully !')</script>");
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Sku Added Successfully :-)')", true);
            }
            catch (Exception ex)
            {
                Console.WriteLine("An error occurred: '{0}'", ex);
                //Response.Write("<script>alert('Sku Addition Failed !')</script>");
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Sku Addition Failed :-(')", true);
            }

            txtBoxServiceTitle.Text = "";
            txtBoxUnitRate.Text = "";
            txtBoxServiceDuration.Text = "";
            txtBoxServiceDescription.Text = "";

        }


    }
}