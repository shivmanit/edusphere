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

namespace EduSpherePro.DigiView
{
    public partial class MyBlog : System.Web.UI.Page
    {
        BindData BD = new BindData();

        protected void Page_Load(object sender, EventArgs e)
        {
            //pnlViewBlogs.Visible    = false;
            //pnlAddBlog.Visible      = false;

        }

        //Set Panel Visibility to manage Blogs
        protected void ManageBlogPanelVisibility(object sender, CommandEventArgs e)
        {
            string cmdName = e.CommandName.ToString();
            switch (cmdName)
            {
                case "pnlViewBlogs":
                    pnlViewBlogs.Visible = true;
                    pnlAddBlog.Visible = false;
                    string blogQ = string.Format(@"SELECT * FROM Blog b 
                                    JOIN EduSphere.Neurotherapists n ON b.SubmittedByID=n.Email 
                                    WHERE Email='{0}'", User.Identity.Name.ToString());
                    BD.DataBindToDataList(dlBlogsGallery, blogQ);
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
            //ImageButton lb = e.Item.FindControl("imgBtnEditProduct") as ImageButton;
            //if (lb != null)
            //{
            //    if (User.IsInRole("Accounts") || User.IsInRole("Admin") || User.IsInRole("Manager"))
            //    {
            //        lb.Visible = true;
            //    }
            //}
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
    }
}