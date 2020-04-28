using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Data.OleDb;
using System.Data.Common;
using EduSpherePro.CoreServices;
using System.IO;
using System.Web.UI.WebControls;
using static EduSpherePro.CoreServices.FileService;
using System.Collections.Generic;

namespace EduSpherePro.EduSpherePro
{
    public partial class BulkData : System.Web.UI.Page
    {
        BindData BD = new BindData();
        FileService FS = new FileService();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //BindGridview();
            }
        }

        //Reading into 
        protected void ManageDataImportVisibility(object sender, CommandEventArgs e)
        {
            string filePath             = string.Concat(Server.MapPath("~/Artifacts/Help/" + "CountryPopulation.csv"));
            //Array Collection
            Country[] countries         = FS.ReadFirtNCountries(4, filePath);
            Country[] ar                = countries;
            //List Collection
            List<Country> countryList   = new List<Country>();
            countryList = FS.ReadAllCountries(filePath);
            //Dictionary Collection
            Dictionary<string, Country> countriesDict = new Dictionary<string, Country>();
            countriesDict = FS.ReadCountriesWithKey(filePath);
            //foreach(Country cn in countries)
            //{
            //    countryList.Add(cn);
            //}
            string firstCountryName = countryList[0].Name;
            string givenCode = "IND";
            string givenName;
            Country givenCn = null;
            //Country givenCn = countriesDict[givenCode];
            //string givenName = givenCn.Name;
            bool exists = countriesDict.TryGetValue(givenCode, out givenCn);
            if (exists)
                givenName = givenCn.Name;

        }
        
        private void BindGridview()
        {
            string CS = ConfigurationManager.ConnectionStrings["NTA"].ConnectionString;
            //BD.DataBindToGridView(GridView1, "SELECT * FrOM Evaluations.TestObjQuestions", "NA");
            //using (SqlConnection con = new SqlConnection(CS))
            //{
            //    SqlCommand cmd = new SqlCommand("spGetAllEmployee", con);
            //    cmd.CommandType = CommandType.StoredProcedure;
            //    con.Open();
            //    GridView1.DataSource = cmd.ExecuteReader();
            //    GridView1.DataBind();

                
            //}
        }
        //protected void btnUpload_Click(object sender, EventArgs e)
        //{
        //    if (FileUpload1.PostedFile != null)
        //    {

        //            string path = string.Concat(Server.MapPath("~/Artifacts/Help/" + FileUpload1.FileName));
        //            FileUpload1.SaveAs(path);
        //        // Connection String to Excel Workbook 
        //        string conString = string.Empty;
        //        string extension = Path.GetExtension(FileUpload1.PostedFile.FileName);
        //        switch (extension)
        //        {
        //            case ".xls": //Excel 97-03
        //                conString = string.Format(@"Provider = Microsoft.Jet.OLEDB.4.0; Data Source = { 0 }; Extended Properties = 'Excel 8.0;HDR=YES'", path);
        //                break;
        //            case ".xlsx": //Excel 07 or higher
        //                conString = string.Format(@"Provider=Microsoft.ACE.OLEDB.12.0;Data Source={0};Extended Properties='Excel 12.0';HDR='YES'", path);
        //                break;

        //        }


        //        try
        //        {
        //                //string excelCS = string.Format("Provider=Microsoft.ACE.OLEDB.12.0;Data Source={0};Extended Properties=Excel 12.0;", path);
        //                //"Provider=Microsoft.ACE.OLEDB.12.0;Data Source={0};Extended Properties=Excel 12.0;",
        //                //"Provider=Microsoft.Jet.OLEDB.4.0;Data source={0};Extended Properties=Excel 8.0;"

        //                using (OleDbConnection con = new OleDbConnection(conString))
        //                {
        //                    OleDbCommand cmd = new OleDbCommand("select * from [Sheet1$]", con);
        //                    con.Open();
        //                    // Create DbDataReader to Data Worksheet  
        //                    DbDataReader dr = cmd.ExecuteReader();
        //                    // SQL Server Connection String  
        //                    string CS = ConfigurationManager.ConnectionStrings["NTA"].ConnectionString;
        //                    // Bulk Copy to SQL Server   
        //                    SqlBulkCopy bulkInsert = new SqlBulkCopy(CS);
        //                    bulkInsert.DestinationTableName = "Evaluations.TestObjQuestions";
        //                    bulkInsert.WriteToServer(dr);
        //                    //BindGridview();
        //                    lblMessage.Text = "Your file uploaded successfully";
        //                    lblMessage.ForeColor = System.Drawing.Color.Green;
        //                    return;
        //                }
        //            }
        //            catch (Exception ex)
        //            {
        //                lblMessage.Text = "Your file not uploaded";
        //                lblMessage.ForeColor = System.Drawing.Color.Red;
        //            }

        //}
        //}

        protected void btnUpload_Click(object sender, EventArgs e)
        {
            //Upload and save the file
            //string excelPath = Server.MapPath("~/Artifacts/Help/") + Path.GetFileName(FileUpload1.PostedFile.FileName);
            string excelPath = string.Concat(Server.MapPath("~/Artifacts/Help/" + FileUpload1.FileName));
            FileUpload1.SaveAs(excelPath);
            
            string conString = string.Empty;
            string extension = Path.GetExtension(FileUpload1.PostedFile.FileName);
            switch (extension)
            {
                case ".xls": //Excel 97-03
                    conString = ConfigurationManager.ConnectionStrings["Excel03ConString"].ConnectionString;
                    break;
                case ".xlsx": //Excel 07 or higher
                    conString = ConfigurationManager.ConnectionStrings["Excel07+ConString"].ConnectionString;
                    break;

            }
            conString = string.Format(conString, excelPath);
            //try
            //{
                    using (OleDbConnection excel_con = new OleDbConnection(conString))
                    {
                        excel_con.Open();
                        string sheet1 = excel_con.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null).Rows[0]["TABLE_NAME"].ToString();
                        DataTable dtExcelData = new DataTable();

                        //[OPTIONAL]: It is recommended as otherwise the data will be considered as String by default.
                        dtExcelData.Columns.AddRange(new DataColumn[4] { new DataColumn("SessionId", typeof(int)),
                        new DataColumn("CourseID", typeof(int)),
                        new DataColumn("Question", typeof(string)),
                        new DataColumn("Question", typeof(string)) });

                        using (OleDbDataAdapter oda = new OleDbDataAdapter("SELECT * FROM [" + sheet1 + "]", excel_con))
                        {
                            oda.Fill(dtExcelData);
                        }
                        excel_con.Close();

                        string consString = ConfigurationManager.ConnectionStrings["NTA"].ConnectionString;
                        using (SqlConnection con = new SqlConnection(consString))
                        {
                            using (SqlBulkCopy sqlBulkCopy = new SqlBulkCopy(con))
                            {
                                //Set the database table name
                                sqlBulkCopy.DestinationTableName = "Evaluations.TestObjQuestions";

                                //[OPTIONAL]: Map the Excel columns with that of the database table
                                sqlBulkCopy.ColumnMappings.Add("Id", "PersonId");
                                sqlBulkCopy.ColumnMappings.Add("Name", "Name");
                                sqlBulkCopy.ColumnMappings.Add("Salary", "Salary");
                                con.Open();
                                sqlBulkCopy.WriteToServer(dtExcelData);
                                con.Close();
                                lblMessage.Text = "Your file uploaded successfully";
                                lblMessage.ForeColor = System.Drawing.Color.Green;
                            }
                        }
                    }
                //}
                //catch (Exception ex)
                //{
                //    lblMessage.Text = "Your file not uploaded";
                //    lblMessage.ForeColor = System.Drawing.Color.Red;
                //}
        }

        }
}