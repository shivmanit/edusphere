using EduSpherePro.CoreServices;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EduSpherePro
{
    public partial class _Default : Page
    {
        ITranslateText TT = new TranslateText();
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        //Translate
        protected void Translate(object sender, CommandEventArgs e)
        {
            string cmdName = e.CommandName.ToString();
            string uri = "&to=hi";
            //string key = "eae1d8b0745c4df79cbf8851c43ccdcf";
            // inputText = lblDescription.Text;
            //lblDescription.Text = (TT.TranslateTextRequest(uri, inputText)).ToString();
            //lblCollaborate.Text= (TT.TranslateTextRequest(uri, lblCollaborate.Text)).ToString();


        }
    }
}