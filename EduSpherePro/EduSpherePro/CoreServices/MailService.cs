using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Threading.Tasks;
using System.Web;

namespace EduSpherePro.CoreServices
{
    public class MailService :IMailService
    {
        public bool SendMail(string from, string to, string subject, string body)
        {
            try
            {
                var msg = new MailMessage(from, to, subject, body);

                //Create smtp client for sending mail
                var client = new SmtpClient();
                client.Host = "smtp.gmail.com";
                client.Port = 587;
                client.UseDefaultCredentials = true;
                //client.Credentials = new System.Net.NetworkCredential("unix123us@gmail.com", "testtask");
                client.Credentials = new System.Net.NetworkCredential("edusphere.alert@gmail.com", "edusphere");
                //client.Credentials = new System.Net.NetworkCredential("neurotherapymember@gmail.com", "Neur@9322");
                client.EnableSsl = true;

                client.Send(msg);
            }
            catch (Exception ex)
            {
                //add logging
                return false;
            }
            return true;
        }

        public bool SendMailHtml(string from, string to, string subject, string body)
        {
            try
            {
                var msg = new MailMessage(from, to, subject, body);
                msg.IsBodyHtml = true;
                //Create smtp client for sending mail
                var client = new SmtpClient();
                client.Host = "smtp.gmail.com";
                client.Port = 587;
                client.UseDefaultCredentials = true;
                //client.Credentials = new System.Net.NetworkCredential("unix123us@gmail.com", "testtask");
                client.Credentials = new System.Net.NetworkCredential("edusphere.alert@gmail.com", "edusphere");
                client.EnableSsl = true;

                client.Send(msg);
            }
            catch (Exception ex)
            {
                //add logging
                return false;
            }
            return true;
        }

        public Task SendAsync(string from, string to, string subject, string body)
        {
            // Plug in your email service here to send an email.
            //eduSphere
            SendMail(from, to,  subject,  body);
            //end eduSphere
            return Task.FromResult(0);
        }
    }
}