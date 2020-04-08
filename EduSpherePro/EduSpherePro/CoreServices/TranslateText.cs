using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using System.Web;

namespace EduSpherePro.CoreServices
{
    public class TranslateText : ITranslateText
    {
        public string TranslateTextRequest(string to, string inputText)
        {
            //System.Object[] body = new System.Object[] { new { Text = inputText } };
            //var requestBody = JsonConvert.SerializeObject(body);

            //using (var client = new HttpClient())
            //using (var request = new HttpRequestMessage())
            //{
            //    request.Method      = HttpMethod.Post;
            //    request.RequestUri  = new Uri(uri);
            //    request.Content     = new StringContent(requestBody, Encoding.UTF8, "application/json");
            //    request.Headers.Add("Ocp-Apim-Subscription-Key", subscriptionKey);

            //    var response = await client.SendAsync(request);
            //    var responseBody = await response.Content.ReadAsStringAsync();
            //    dynamic result = JsonConvert.SerializeObject(JsonConvert.DeserializeObject(responseBody), Formatting.Indented);
            string parameters= "&to=hi";
            switch (to)
            {
                case "hindi":
                    parameters = "&to=hi";
                    break;
                case "tamil":
                    parameters = "&to=ta";
                    break;
                default:
                    break;
            }
                string result = MakeWebCall(parameters,inputText);
                return result;
            }

        
        private string MakeWebCall(string parameters, string inputText)
        {
            //Build the request
            string subscriptionKey = "eae1d8b0745c4df79cbf8851c43ccdcf";
            using (var client = new HttpClient())
            using (var request = new HttpRequestMessage())
            {
                //Build the request
                request.Method      = HttpMethod.Post;
                //construct URI and add headers
                string baseUri      = "https://api.cognitive.microsofttranslator.com/";
                string route        = "translate?api-version=3.0";
                request.RequestUri  = new Uri(baseUri+route+parameters);

                request.Headers.Add("Ocp-Apim-Subscription-Key", subscriptionKey);

                //add Body
                var body = new object[] { new { Text = inputText } };
                var requestBody = JsonConvert.SerializeObject(body);

                //if its POST then send the request body else null
                request.Content = request.Method==HttpMethod.Post? new StringContent(requestBody, Encoding.UTF8, "application/json"):null;

                var response            = client.SendAsync(request).Result;
                var jsonResponseContent = response.Content.ReadAsStringAsync().Result;
                dynamic result          = JsonConvert.SerializeObject(JsonConvert.DeserializeObject(jsonResponseContent), Formatting.Indented);
                //var data = (JObject)JsonConvert.DeserializeObject(jsonResponseContent);
                //string data = string.Format(@[{"detectedLanguage":{"language":"en","score":1.0},"translations":[{"text":"हिंदी में परीक्षा लिखना आसान","to":"hi"}]}]");
                //return result;
                //string text = data.Value<string>();
                //string temp= "{\"detectedLanguage\":{\"language\":\"en\",\"score\":1.0},\"translations\":{\"text\":\"हिंदी में परीक्षा लिखना आसान\",\"to\":\"hi\"}}";
                dynamic obj     = JsonConvert.DeserializeObject(jsonResponseContent);
                string text     = obj[0].translations[0].text;
                //var rdata = (string)obj["translations"];
                //dynamic stuff = (JObject)JsonConvert.DeserializeObject(temp);
                //string rdata = (string)stuff.translations.text;
                return text;
                //return (FormatJsonForPrinting(jsonResponseContent));
            }


        }
    }
}