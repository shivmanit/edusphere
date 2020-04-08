using EduSpherePro.CoreServices;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EduSpherePro
{
    public partial class Programs : System.Web.UI.Page
    {
        BindData BD = new BindData();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string queryPrograms = string.Format(@"SELECT * FROM EduSphere.Programs p
                                                                    JOIN EduSphere.ProgramGroups g ON p.ProgramGroupID=g.ProgramGroupID
                                                                    WHERE ProgramID>=100");
                BD.DataBindToDataList(dlPrograms, queryPrograms);
            }

        }
    }
}