using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;

namespace EduSpherePro.CoreServices
{
    public class SMSSender :ISMSSender
    {
        public string SendSms(string To, string Msg)
        {
            WebClient client = new WebClient();
            // Add a user agent header in case the requested URI contains a query.
            client.Headers.Add("user-agent", "Mozilla/4.0(compatible; MSIE 6.0; Windows NT 5.2; .NET CLR1.0.3705;)");
            client.QueryString.Add("user", "edusphere");
            client.QueryString.Add("password", "OgbWJIKZMWCFFX");
            client.QueryString.Add("api_id", "3484101");
            client.QueryString.Add("to", To);
            client.QueryString.Add("text", Msg);
            string baseurl = "http://api.clickatell.com/http/sendmsg";
            Stream data = client.OpenRead(baseurl);
            StreamReader reader = new StreamReader(data);
            string s = reader.ReadToEnd();
            data.Close();
            reader.Close();
            return (s);
        }

        public string SendSmsUsingProvider(string provider, string To, string Msg)
        {
            string sResponse = "";
            string sAPIKey;
            string sSenderID;
            string sChannel; //1-Promotional, 2-Transactional
            string sDCS;
            string sFlashsms;
            //string sNumber = txtRecepientNumber.Text;
            string sNumber;
            //string sText ;
            string sText;
            string sRoute;
            string sURL;
            string sType;
            switch (provider)
            {
                case "CLICKATELL":
                    WebClient client = new WebClient();
                    // Add a user agent header in case the requested URI contains a query.
                    client.Headers.Add("user-agent", "Mozilla/4.0(compatible; MSIE 6.0; Windows NT 5.2; .NET CLR1.0.3705;)");
                    client.QueryString.Add("user", "edusphere");
                    client.QueryString.Add("password", "OgbWJIKZMWCFFX");
                    client.QueryString.Add("api_id", "3484101");
                    client.QueryString.Add("to", To);
                    client.QueryString.Add("text", Msg);
                    string baseurl = "http://api.clickatell.com/http/sendmsg";
                    Stream data = client.OpenRead(baseurl);
                    StreamReader reader = new StreamReader(data);
                    string reposne = reader.ReadToEnd();
                    data.Close();
                    reader.Close();
                    //return (sResponse);
                    break;
                case "SMSGATEWAYHUB":
                    sAPIKey = "0i5KGu1cB066SgAthcj7kw";//Provide valid sAPIKey for Lamour. THis one not not valid
                    //string sAPIKey = "eatrcM9xlkSnTXCTiFQnZQ";
                    sSenderID = "LAMOUR";
                    sChannel = "2"; //1-Promotional, 2-Transactional
                    sDCS = "0";
                    sFlashsms = "0";
                    //string sNumber = txtRecepientNumber.Text;
                    sNumber = To;
                    //string sText = txtMessage.Text;
                    sText = Msg;
                    sRoute = "1";

                    sURL = "http://login.smsgatewayhub.com/api/mt/SendSMS?APIKey=" + sAPIKey + "&senderid=" + sSenderID + "&channel=" + sChannel + "&DCS=" + sDCS + "&flashsms=" + sFlashsms + "&number=" + sNumber + "&text=" + sText + "&route=" + sRoute;
                    sResponse = GetResponse(sURL);
                    System.Web.HttpContext.Current.Response.Write(sResponse);
                    break;
                case "KUTILITY":
                    //string sAPIKey = "0i5KGu1cB066SgAthcj7kw";
                    //sAPIKey = "45B7BDE70482B5";//KAPOOR.
                    //sAPIKey = "45D5284CF6D32E"; //SAKETS
                    sAPIKey = "45E2F34CD506EC"; //YAMINI SALON & ACADEMY
                    //sSenderID = "KAPOOR";
                    sSenderID = "PSIMSI";
                    //string sChannel   = "1"; //1-Promotional, 2-Transactional
                    //string sDCS = "0";
                    //string sFlashsms = "0";
                    sNumber = To;
                    sText = Msg;
                    sType = "text";
                    sRoute = "415"; //416 DND Promotional, 415 Transactional

                    //string sURL = "http://login.smsgatewayhub.com/api/mt/SendSMS?APIKey=" + sAPIKey + "&senderid=" + sSenderID + "&channel=" + sChannel + "&DCS=" + sDCS + "&flashsms=" + sFlashsms + "&number=" + sNumber + "&text=" + sText + "&route=" + sRoute;
                    sURL = "http://kutility.in/app/smsapi/index.php?key=" + sAPIKey + "&routeid=" + sRoute + "&type=" + sType + "&contacts=" + sNumber + "&senderid=" + sSenderID + "&msg=" + sText;
                    sResponse = GetResponse(sURL);
                    System.Web.HttpContext.Current.Response.Write(sResponse);
                    break;
                default:
                    break;
            }
            return sResponse;
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