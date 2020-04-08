using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EduSpherePro.Test
{
    public partial class Test_WebHook : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        //Response Redirect
        protected void SendUrl1(object sender, EventArgs e)
        {
            //string strdisplaynumber = txtBoxNumber.Text;
            //Response.Redirect(string.Format(@"http://www.digitalkalp.com/missedcall?dispnumber={0}&call_id={1}&caller_id={2}", strdisplaynumber, "2", "146"));
        }
        //Post
        protected void SendUrl(object sender, EventArgs e)
        {
            string remoteUrl = "http://www.saketsoftail.com/new?";
            //string remoteUrl = "http://localhost:49446/new?";
            ASCIIEncoding encoding = new ASCIIEncoding();
            //string data = string.Format(@"who={0}&ChannelID={1}&Circle={2}&Operator={3}&CallTime={4}", strdisplaynumber, "TollFreeNumber", "circle", "airtel", DateTime.Now.ToString());
            string data = string.Format(@"ProgramId={0}&FranchiseeID={1}&StudentName={2}&Gender={3}&Education={4}&Institute={5}&Stream={6}&Phone={7}&Email={8}&City={9}&State={10}&PinCode={11}&EnquiryMessage={12}&RaisedById={13}&EnquirySource={14}&Key={15}",
                                            Convert.ToInt32(ddlProgramId.SelectedValue.ToString()),
                                            Convert.ToInt32(ddlFranchiseeID.SelectedValue.ToString()),
                                            txtBoxStudentName.Text,
                                            ddlGender.SelectedValue.ToString(),
                                            txtBoxEducation.Text,
                                            txtBoxInstitute.Text,
                                            txtBoxStream.Text,
                                            txtBoxPhone.Text,
                                            txtBoxEmail.Text,
                                            txtBoxCity.Text,
                                            txtBoxState.Text,
                                            txtBoxPinCode.Text,
                                            txtBoxEnquiryMessage.Text,
                                             "WEB",
                                            txtBoxSource.Text,
                                            "SJA@123");

            byte[] bytes                = encoding.GetBytes(data);
            HttpWebRequest httpRequest  = (HttpWebRequest)WebRequest.Create(remoteUrl);
            httpRequest.Method          = "POST";
            httpRequest.ContentType     = "application/x-www-form-urlencoded";
            httpRequest.ContentLength   = bytes.Length;
            using (Stream stream = httpRequest.GetRequestStream())
            {
                stream.Write(bytes, 0, bytes.Length);
                stream.Close();
            }
        }

    }
}