using System;
using System.IO;
using System.Net;
using System.Text;

namespace EduSpherePro.EduSpherePro
{
    public partial class Promotions : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        //SMSGATEWAYHUB
        protected void btnSend_Click(object sender, EventArgs e)
        {
            //string sAPIKey = "0i5KGu1cB066SgAthcj7kw";
            string sAPIKey = "45E2F34CD506EC";//KUTILITY API PURVAS
            //string sSenderID = "KAPOOR";
            string sSenderID = "PSIMSI";
            //string sChannel = "1"; //1-Promotional, 2-Transactional
            //string sDCS = "0";
            //string sFlashsms = "0";
            string sNumber = txtRecepientNumber.Text;
            string sText = txtMessage.Text;
            string sType = "text";
            string sRoute = "416";//415-Transactional, 416-Promotional 

            //string sURL = "http://login.smsgatewayhub.com/api/mt/SendSMS?APIKey=" + sAPIKey + "&senderid=" + sSenderID + "&channel=" + sChannel + "&DCS=" + sDCS + "&flashsms=" + sFlashsms + "&number=" + sNumber + "&text=" + sText + "&route=" + sRoute;

            string sURL = "http://kutility.in/app/smsapi/index.php?key=" + sAPIKey + "&routeid=" + sRoute + "&type=" + sType + "&contacts=" + sNumber + "&senderid=" + sSenderID + "&msg=" + sText;

            string sResponse = GetResponse(sURL);
            Response.Write(sResponse);

        }

        //
        public static string GetResponse(string sURL)
        {
            HttpWebRequest request =
            (HttpWebRequest)WebRequest
            .Create(sURL);
            request.MaximumAutomaticRedirections = 4;
            request.Credentials = CredentialCache.DefaultCredentials;
            try
            {
                HttpWebResponse response = (HttpWebResponse)request
                .GetResponse();
                Stream receiveStream = response.GetResponseStream();
                StreamReader readStream = new StreamReader(receiveStream, Encoding.UTF8);
                string sResponse = readStream.ReadToEnd();
                response.Close();
                readStream.Close();
                return sResponse;
            }
            catch (Exception ex)
            {
                return "";
            }
        }
    }
}