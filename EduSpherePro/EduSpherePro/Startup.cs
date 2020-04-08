using EduSpherePro.Models;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.Owin;
using Owin;
using System;
using System.Web;

[assembly: OwinStartupAttribute(typeof(EduSpherePro.Startup))]
namespace EduSpherePro
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
            //call method to create a default user role and user.
            try
            {
                 CreateDefaultUsersAndRoles();
            }
            catch (Exception e)
            {
                //Server.Transfer("NoFileErrorPage.aspx", true);
            }
           // catch (System.IO.IOException e)
           // {
                //Server.Transfer("IOErrorPage.aspx", true);
           // }

            finally
            {
                 
            }
            }

        // In this method we will create default User roles and Admin user for login   
        private void CreateDefaultUsersAndRoles()
        {
            ApplicationDbContext context = new ApplicationDbContext();
            //Testing Bug Fix for intemittent loging failure shiv 4th June 2019
            //HttpContext.Current.Session["RunSession"] = "1";
            //end Testing Bug Fix for intemittent loging failure shiv 4th June 2019
            var roleManager = new RoleManager<IdentityRole>(new RoleStore<IdentityRole>(context));
            var UserManager = new UserManager<ApplicationUser>(new UserStore<ApplicationUser>(context));


            // In Startup iam creating first Admin Role and creating a default Admin User    
            if (!roleManager.RoleExists("Admin"))
            {
                // first we create Admin role in AspNetRoles   
                var role = new Microsoft.AspNet.Identity.EntityFramework.IdentityRole();
                role.Name = "Admin";
                roleManager.Create(role);
                //Here we create a Admin super user who will maintain the website
                var user = new ApplicationUser();
                user.UserName = "shivmanit@gmail.com";
                user.Email = "shivmanit@gmail.com";
                user.FullName = "Shivmani TRIPATHI";
                //Add Address to preexisitng collection
                user.Addresses.Add(new ApplicationUser.Address { AddressLine = "Mumbai", Country = "INDIA", UserId = user.Id });
                string userPWD = "Saket@123";
                var chkUser = UserManager.Create(user, userPWD);
                //Add default User to Role Admin   
                if (chkUser.Succeeded)
                {
                    var result1 = UserManager.AddToRole(user.Id, "Admin");
                }
            }

            // creating Creating Applicat role    
            //if (!roleManager.RoleExists("Applicant"))
            //{
            //    var role = new Microsoft.AspNet.Identity.EntityFramework.IdentityRole();
            //    role.Name = "Applicant";
            //    roleManager.Create(role);
            //}
            // creating Creating Student role    
            if (!roleManager.RoleExists("Student"))
            {
                var role = new Microsoft.AspNet.Identity.EntityFramework.IdentityRole();
                role.Name = "Student";
                roleManager.Create(role);
            }
            // creating Creating Patient role    
            if (!roleManager.RoleExists("Patient"))
            {
                var role = new Microsoft.AspNet.Identity.EntityFramework.IdentityRole();
                role.Name = "Patient";
                roleManager.Create(role);
            }
            // creating Creating Neurotherapist role    
            if (!roleManager.RoleExists("Neurotherapist"))
            {
                var role = new Microsoft.AspNet.Identity.EntityFramework.IdentityRole();
                role.Name = "Neurotherapist";
                roleManager.Create(role);
            }
            // creating Creating Employee role    
            if (!roleManager.RoleExists("Employee"))
            {
                var role = new Microsoft.AspNet.Identity.EntityFramework.IdentityRole();
                role.Name = "Employee";
                roleManager.Create(role);
            }
            // creating L1 Role    
            if (!roleManager.RoleExists("Faculty"))
            {
                var role = new Microsoft.AspNet.Identity.EntityFramework.IdentityRole();
                role.Name = "Faculty";
                roleManager.Create(role);
            }
            // creating L2 Role    
            if (!roleManager.RoleExists("AcademicIC"))
            {
                var role = new Microsoft.AspNet.Identity.EntityFramework.IdentityRole();
                role.Name = "AcademicIC";
                roleManager.Create(role);
            }

            // creating L3 Role    
            if (!roleManager.RoleExists("AdminIC"))
            {
                var role = new Microsoft.AspNet.Identity.EntityFramework.IdentityRole();
                role.Name = "AdminIC";
                roleManager.Create(role);
            }

            // creating Customer Role    
            if (!roleManager.RoleExists("Admin"))
            {
                var role = new Microsoft.AspNet.Identity.EntityFramework.IdentityRole();
                role.Name = "Admin";
                roleManager.Create(role);
            }
            
        }      
    }
}
