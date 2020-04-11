using System;
using System.Linq;
using System.Web;
using System.Web.UI;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using Owin;
using EduSpherePro.Models;
using System.Data.SqlClient;
using EduSpherePro.CoreServices;

namespace EduSpherePro.Account
{
    public partial class Register : Page
    {
        BindData BD = new BindData();
        protected void CreateUser_Click(object sender, EventArgs e)
        {
            var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
            var signInManager = Context.GetOwinContext().Get<ApplicationSignInManager>();
            var user = new ApplicationUser() { FullName = FullName.Text, UserName = Email.Text, Email = Email.Text };
            //Add Address to preexisitng collection
            user.Addresses.Add(new ApplicationUser.Address { AddressLine = Address.Text, Country = Country.Text, UserId = user.Id });
            //Pass this user into registeration method
            IdentityResult result = manager.Create(user, Password.Text);
            if (result.Succeeded)
            {
                //Assign user role
                var result1 = manager.AddToRole(user.Id, ddlRole.SelectedValue.ToString());
                // For more information on how to enable account confirmation and password reset please visit http://go.microsoft.com/fwlink/?LinkID=320771
                string code = manager.GenerateEmailConfirmationToken(user.Id);
                string callbackUrl = IdentityHelper.GetUserConfirmationRedirectUrl(code, user.Id, Request);
                manager.SendEmail(user.Id, "Confirm your account", "Please confirm your account by clicking <a href=\"" + callbackUrl + "\">here</a>.");

                signInManager.SignIn( user, isPersistent: false, rememberBrowser: false);
                IdentityHelper.RedirectToReturnUrl(Request.QueryString["ReturnUrl"], Response);
            }
            else 
            {
                ErrorMessage.Text = result.Errors.FirstOrDefault();
            }
        }

        //New Method Added by Shivmani-Change Role of Existing User
        protected void ChangeRole_Click(object sender, EventArgs e)
        {
            SqlCommand CmdObj = new SqlCommand("spChangeRole", BD.ConStr);
            CmdObj.CommandType = System.Data.CommandType.StoredProcedure;
            CmdObj.Parameters.AddWithValue("@Email",Email.Text);
            CmdObj.Parameters.AddWithValue("@NewRole", ddlRole.SelectedValue.ToString());
            try
            {
                BD.UpdateParameters(CmdObj);
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Role Changed !!!')", true);
            }
            catch(Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Role Change Failed !!!')", true);

            }
           

        }
    }
}