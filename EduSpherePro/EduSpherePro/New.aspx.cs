using EduSpherePro.CoreServices;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EduSpherePro
{
    public partial class New : System.Web.UI.Page
    {
        IBindData BD        = new BindData();
       
        protected void Page_Load(object sender, EventArgs e)
        {
            //http://saketsoftail.com/new.aspx?ProgramId=%100&FranchiseeID=%100&StudentName=%Reena&Key=%SJA@123 
            //string dispnumber       = Request.QueryString["dispnumber"];
            //string caller_id        = Request.QueryString["caller_id"];
            string ProgramId        = Request.Form["ProgramId"];
            string FranchiseeID     = Request.Form["FranchiseeID"];
            string StudentName      = Request.Form["StudentName"];
            string Gender           = Request.Form["Gender"];
            string Education        = Request.Form["Education"];
            string Institute        = Request.Form["Institute"];
            string Stream           = Request.Form["Stream"];
            string Phone            = Request.Form["Phone"];
            string Email            = Request.Form["Email"];
            string City             = Request.Form["City"];
            string State            = Request.Form["State"];
            string PinCode          = Request.Form["PinCode"];
            string EnquiryMessage   = Request.Form["EnquiryMessage"];
            string EnquirySource    = Request.Form["EnquirySource"];
            string RaisedById       = Request.Form["RaisedById"];
            string Key              = Request.Form["Key"];
           
            

            if (Key == "SJA@123")
            {
                SqlCommand ObjCmd  = new SqlCommand("spInsertEnquiry", BD.ConStr);
                ObjCmd.CommandType = System.Data.CommandType.StoredProcedure;
                ObjCmd.Parameters.AddWithValue("@ProgramId", Convert.ToInt32(ProgramId));
                ObjCmd.Parameters.AddWithValue("@FranchiseeID", Convert.ToInt32(FranchiseeID));

                ObjCmd.Parameters.AddWithValue("@StudentName", StudentName);
                ObjCmd.Parameters.AddWithValue("@Gender", Gender);
                ObjCmd.Parameters.AddWithValue("@Education", Education);
                ObjCmd.Parameters.AddWithValue("@Institute", Institute);
                ObjCmd.Parameters.AddWithValue("@Stream", Stream);
                ObjCmd.Parameters.AddWithValue("@Email", Phone);
                ObjCmd.Parameters.AddWithValue("@Phone", Email);
                ObjCmd.Parameters.AddWithValue("@City", City);
                ObjCmd.Parameters.AddWithValue("@State", State);
                ObjCmd.Parameters.AddWithValue("@PinCode", PinCode);
                ObjCmd.Parameters.AddWithValue("@EnquiryMessage", EnquiryMessage);
                ObjCmd.Parameters.AddWithValue("@RaisedById", RaisedById);
                ObjCmd.Parameters.AddWithValue("@EnquirySource", EnquirySource);
                BD.UpdateParameters(ObjCmd);
            }

        }
    }
}