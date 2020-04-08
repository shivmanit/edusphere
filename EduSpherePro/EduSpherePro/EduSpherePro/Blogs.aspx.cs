using EduSpherePro.CoreServices;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EduSpherePro.EduSpherePro
{
    public partial class Blogs : System.Web.UI.Page
    {
        BindData BD = new BindData();
        ITranslateText TT = new TranslateText();

        protected void Page_Load(object sender, EventArgs e)
        {
            //pnlViewBlogs.Visible    = false;
            //pnlAddBlog.Visible      = false;

        }

        //Set Panel Visibility to manage Blogs
        protected void ManageBlogPanelVisibility(object sender, CommandEventArgs e)
        {
            string blogQ;
            string cmdName = e.CommandName.ToString();
            switch (cmdName)
            {
                case "pnlViewBlogs":
                    pnlViewBlogs.Visible = true;
                    pnlAddBlog.Visible = false;
                    if (User.IsInRole("Admin"))
                    {
                        blogQ = string.Format(@"SELECT * FROM Blog b");
                        BD.DataBindToDataList(dlBlogsGallery, blogQ);
                    }
                    else
                    {

                    }
                    break;
                case "pnlCreateBlog":
                    pnlViewBlogs.Visible = false;
                    pnlAddBlog.Visible = true;
                    break;
                case "ReturnToMyBlog":
                    Response.Redirect("myblog");
                    break;
                default:
                    break;
            }

        }

        //On Gallary Data Bound, Provide produt edit option only to Admin and Accounts
        protected void dlBlogsGallery_ItemDataBound(object sender, DataListItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item ||
             e.Item.ItemType == ListItemType.AlternatingItem)
            {
                LinkButton lbkBtnApprove = (LinkButton)e.Item.FindControl("lnkBtnApprove");
                LinkButton lbkBtnReject = (LinkButton)e.Item.FindControl("lnkBtnReject");
                Label lblParaOne = (Label)e.Item.FindControl("lblParaOne");
                // Retrieve the PublishStatus 

                //string strPublishStatus = (((DataRowView)e.Item.DataItem).Row[4]).ToString();
                string strPublishStatus = (DataBinder.Eval(e.Item.DataItem, "PublishStatus").ToString());

                if (strPublishStatus == "NEW")
                {
                    lbkBtnApprove.Visible = true;
                    lbkBtnReject.Visible = true;

                }
                if (strPublishStatus == "APPROVED")
                {
                    lbkBtnApprove.Visible = false;
                    lbkBtnReject.Visible = true;
                    string uri = "&to=hi";
                    //string key = "eae1d8b0745c4df79cbf8851c43ccdcf";
                    //string p1 = (DataBinder.Eval(e.Item.DataItem, "lblParaOne").ToString());
                    lblParaOne.Text = (TT.TranslateTextRequest(uri, lblParaOne.Text)).ToString();

                }
                if (strPublishStatus == "REJECTED")
                {
                    lbkBtnApprove.Visible = true;
                    lbkBtnReject.Visible = false;

                }
            }
        }
        //Edit Blog Details
        protected void dlBlogsGalleryEditHandler(object sender, DataListCommandEventArgs e)
        {

        }
        //Cancel Editing Blog Details
        protected void dlBlogsGalleryCancelHandler(object sender, DataListCommandEventArgs e)
        {
        }
        //Update Blog Details.
        protected void dlBlogsGalleryUpdateHandler(object sender, DataListCommandEventArgs e)
        {
        }
        //Delete a product
        protected void dlBlogsGalleryDeleteHandler(object sender, DataListCommandEventArgs e)
        {
        }


        //Insert New Blog
        public void CreateBlog(object sender, CommandEventArgs e)
        {
            string cmdName, cmdArg, spName;
            cmdName = e.CommandName.ToString();
            cmdArg = e.CommandArgument.ToString();
            spName = "spCreateBlog";
            SqlCommand ObjCmd = new SqlCommand(spName, BD.ObjCn);
            ObjCmd.CommandType = CommandType.StoredProcedure;
            string strSubmittedById = User.Identity.Name.ToString();
            switch (cmdName)
            {
                case "SubmitNewBlog":
                    ObjCmd.Parameters.AddWithValue("@SubmittedById", strSubmittedById);
                    ObjCmd.Parameters.AddWithValue("@SubmissionDate", "01/01/1900");//Not Used
                    ObjCmd.Parameters.AddWithValue("@operationCode", "INSERT");
                    ObjCmd.Parameters.AddWithValue("@PublishStatus", "NEW");
                    ObjCmd.Parameters.AddWithValue("@ApprovedById", "");
                    ObjCmd.Parameters.AddWithValue("@ApprovalDate", "01/01/1900");//Not used
                    ObjCmd.Parameters.AddWithValue("@BlogGroup", ddlBlogGroup.SelectedValue);
                    ObjCmd.Parameters.AddWithValue("@BlogID", -99);//Not used
                    ObjCmd.Parameters.AddWithValue("@Title", txtBoxBlogTitle.Text);

                    ObjCmd.Parameters.AddWithValue("@ParaOne", txtBoxParaOne.Text);
                    ObjCmd.Parameters.AddWithValue("@ParaTwo", txtBoxParaTwo.Text);
                    ObjCmd.Parameters.AddWithValue("@ParaThree", txtBoxParaThree.Text);
                    ObjCmd.Parameters.AddWithValue("@PhotoOnePath", txtBoxImageOnePath.Text);
                    ObjCmd.Parameters.AddWithValue("@PhotoTwoPath", txtBoxImageTwoPath.Text);
                    ObjCmd.Parameters.AddWithValue("@PhotoThreePath", txtBoxImageThreePath.Text);
                    ObjCmd.Parameters.AddWithValue("@VideoOnePath", "");
                    BD.UpdateParameters(ObjCmd);
                    //Response.Write("<script>alert('Blog Added')</script>")
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Blog Added !!!')", true);
                    //clear 
                    txtBoxBlogTitle.Text = "";
                    txtBoxParaOne.Text = "";
                    txtBoxParaTwo.Text = "";
                    txtBoxParaThree.Text = "";
                    txtBoxImageOnePath.Text = "";
                    txtBoxImageTwoPath.Text = "";
                    txtBoxImageThreePath.Text = "";
                    break;
                case "UploadBlogImage":
                    if ((cmdArg == "flOne") && (flOne.HasFile))
                    {
                        //Create a path to save the file
                        string filename = Path.Combine(HttpContext.Current.Server.MapPath("~/Artifacts/Blogs"), flOne.FileName);
                        //Display File path in text box for record insertion
                        txtBoxImageOnePath.Text = string.Format("/Artifacts/Blogs/" + flOne.FileName);
                        flOne.SaveAs(filename);
                    }
                    if ((cmdArg == "flTwo") && (flTwo.HasFile))
                    {
                        //Create a path to save the file
                        string filename = Path.Combine(HttpContext.Current.Server.MapPath("~/Artifacts/Blogs"), flTwo.FileName);
                        //Display File path in text box for record insertion
                        txtBoxImageTwoPath.Text = string.Format("/Artifacts/Blogs/" + flTwo.FileName);
                        flTwo.SaveAs(filename);
                    }
                    if ((cmdArg == "flThree") && (flThree.HasFile))
                    {
                        string filename = Path.Combine(HttpContext.Current.Server.MapPath("~/Artifacts/Blogs"), flThree.FileName);
                        txtBoxImageThreePath.Text = string.Format("/Artifacts/Blogs/" + flThree.FileName);
                        //Display File path in text box for record insertion

                        flThree.SaveAs(filename);
                    }
                    //Edit
                    //if ((cmdArg == "flOneEdit") || (cmdArg == "flTwoEdit") || (cmdArg == "flThreeEdit"))
                    //{
                    //    string strfl = cmdArg;
                    //    string txtBoxID = "";
                    //    FileUpload fl = (FileUpload)dlBlogsGallery.Items[dlBlogsGallery.EditItemIndex].FindControl(strfl);
                    //    if (cmdArg == "flOneEdit") txtBoxID = "txtBoxImageOnePathEdit";
                    //    if (cmdArg == "flTwoEdit") txtBoxID = "txtBoxImageTwoPathEdit";
                    //    if (cmdArg == "flThreeEdit") txtBoxID = "txtBoxImageThreePathEdit";
                    //    TextBox tb = (TextBox)dlBlogsGallery.Items[dlBlogsGallery.EditItemIndex].FindControl(txtBoxID);
                    //    if (fl.HasFile)
                    //    {
                    //        string filename = Path.Combine(HttpContext.Current.Server.MapPath("~/Artifacts/Blogs"), fl.FileName);
                    //        fl.SaveAs(filename);
                    //        tb.Text = string.Format("~/Artifacts/Blogs/" + fl.FileName);

                    //    }
                    //}
                    break;
                default:
                    break;
            }
        }
        
        //Manage Blogs
        public void ManageBlogs(object sender,CommandEventArgs e)
        {
            string cmdName          = e.CommandName.ToString();
            int intBlogID           = Convert.ToInt32(e.CommandArgument.ToString());

            SqlCommand cmd      = new SqlCommand("spUpdateBlog",BD.ObjCn);
            cmd.CommandType     = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@BlogID",intBlogID );
            cmd.Parameters.AddWithValue("@ApprovedByID",User.Identity.Name.ToString());
            cmd.Parameters.AddWithValue("@PublishStatus", cmdName);
            BD.UpdateParameters(cmd);
            string Q = string.Format(@"SELECT * FROM Blog WHERE BlogID={0}",intBlogID);
            BD.DataBindToDataList(dlBlogsGallery,Q );
        }

        //Translate
        protected void Translate(object sender, CommandEventArgs e)
        {
            string cmdName = e.CommandName.ToString();
            string uri = "https://api.cognitive.microsofttranslator.com/translate?api-version=3.0&to=hi";
            string key = "eae1d8b0745c4df79cbf8851c43ccdcf";
            //lblCentreAction.Text = (TT.TranslateTextRequest(key, uri, "Its Easy to write exam in Hindi")).ToString();

        }
    }
}