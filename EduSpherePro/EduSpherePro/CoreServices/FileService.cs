using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EduSpherePro.CoreServices
{
    public class FileService :IFileService
    {
        public bool DownLoadFile(string fileName)
        {
            try
            {
                //Get the path details
                string path = HttpContext.Current.Server.MapPath(fileName);
                //Get file name
                string name = Path.GetFileName(path);
                //get file extension
                string ext = Path.GetExtension(path);

                string type = "";
                //set known types based on extension
                switch (ext)
                {
                    case ".pdf":
                        type = "Application/pdf";
                        break;
                    case ".docx":
                        type = "Application/msword";
                        break;
                    case ".xls":
                        type = "application/vnd.ms-excel";
                        break;
                    case ".ppt":
                        type = "application/vnd.ms-powerpoint";
                        break;
                    case ".jpg":
                    case ".jpeg":
                        type = "image/jpeg";
                        break;
                    case ".gif":
                        type = "image/gif";
                        break;
                    case ".zip":
                        type = "application/zip";
                        break;

                }
                //Set the appropriate ContentType.
                HttpContext.Current.Response.ContentType = type;
                HttpContext.Current.Response.AppendHeader("Content-Disposition", "attachment; filename=name");
                //Response.TransmitFile(Server.MapPath("~/docs/test.doc"));
                HttpContext.Current.Response.WriteFile(HttpContext.Current.Server.MapPath(fileName));
                HttpContext.Current.Response.Flush();
                HttpContext.Current.Response.End();
            }
            catch (Exception ex)
            {
                //add logging
                return false;

            }
            return true;
        }

        public void UploadFileFromDataListControl(DataList dl, string strFileUpload, string strServerPath, string lblDbPath)
        {
            FileUpload fu = new FileUpload();
            Label lblPath = new Label();
            foreach (DataListItem item in dl.Items)
            {
                fu = (FileUpload)item.FindControl(strFileUpload);
                lblPath = (Label)item.FindControl(lblDbPath);
            }
            if (fu.HasFile)
            {
                //Create a path to save the file
                string filename = Path.Combine(HttpContext.Current.Server.MapPath(strServerPath), fu.FileName);
                //Display File path in label for record insertion
                lblPath.Text = string.Format(strServerPath + fu.FileName);
                fu.SaveAs(filename);
            }
        }

        public void UploadFileFromOutsideControl(FileUpload fu, string strServerPath, Label lblDbPath)
        {
            if (fu.HasFile)
            {
                //Create a path to save the file
                string filename = Path.Combine(HttpContext.Current.Server.MapPath(strServerPath), fu.FileName);
                //Display File path in label for record insertion
                lblDbPath.Text = string.Format(strServerPath + fu.FileName);
                fu.SaveAs(filename);
            }
        }

       //Delete File
      

        public void ExportToExcel(GridView gv)
        {
            System.Web.HttpContext.Current.Response.Clear();
            System.Web.HttpContext.Current.Response.Buffer = true;
            System.Web.HttpContext.Current.Response.AddHeader("content-disposition", "attachment;filename=GridViewExport.xls");
            System.Web.HttpContext.Current.Response.Charset = "";
            System.Web.HttpContext.Current.Response.ContentType = "application/vnd.ms-excel";
            using (StringWriter sw = new StringWriter())
            {
                HtmlTextWriter hw = new HtmlTextWriter(sw);

                //To Export all pages
                gv.AllowPaging = false;
                
                gv.HeaderRow.BackColor = Color.White;
                foreach (TableCell cell in gv.HeaderRow.Cells)
                {
                    cell.BackColor = gv.HeaderStyle.BackColor;
                }
                foreach (GridViewRow row in gv.Rows)
                {
                    row.BackColor = Color.White;
                    foreach (TableCell cell in row.Cells)
                    {
                        if (row.RowIndex % 2 == 0)
                        {
                            cell.BackColor = gv.AlternatingRowStyle.BackColor;
                        }
                        else
                        {
                            cell.BackColor = gv.RowStyle.BackColor;
                        }
                        cell.CssClass = "textmode";
                    }
                }

                gv.RenderControl(hw);

                //style to format numbers to string
                string style = @"<style> .textmode { } </style>";
                System.Web.HttpContext.Current.Response.Write(style);
                System.Web.HttpContext.Current.Response.Output.Write(sw.ToString());
                System.Web.HttpContext.Current.Response.Flush();
                System.Web.HttpContext.Current.Response.End();
            }
        }
        
        //TEST CODE--Shiv The code below is only of learning and testing pupose
        //doesn't blogn to project Delete it
       //Read Firt N Countries using collection Array
       public Country[] ReadFirtNCountries(int N,string filePath)
        {
            Country[] countries = new Country[N];
            using (StreamReader sr = new StreamReader(filePath))
            {
                //read header
                sr.ReadLine();
                for (int i = 0; i < N; i++)
                {
                    //sr.ReadLine();
                    countries[i] = ReadLineFromCsv(sr.ReadLine());
                }
                
            }
            return countries;

        }
        
        //Read AllCountries using collection List<T>
        public List<Country> ReadAllCountries(string filePath)
        {
            List<Country> countries = new List<Country>();
            using (StreamReader sr = new StreamReader(filePath))
            {
                //read header line
                sr.ReadLine();
                string csvLine;
                while((csvLine=sr.ReadLine()) != null)//read till end of file
                {
                    countries.Add(ReadLineFromCsv(csvLine));
                }
            } 
            return countries;
        }

        //read all countries into Dictionary
        public Dictionary<string,Country> ReadCountriesWithKey(string filePath)
        {
            Dictionary<string, Country> countryDict = new Dictionary<string, Country>();
            using(StreamReader sr=new StreamReader(filePath))
            {
                //read header
                sr.ReadLine();
                string csvLine;
                while ((csvLine = sr.ReadLine()) != null)
                {
                    Country country = ReadLineFromCsv(csvLine);
                    countryDict.Add(country.Code, country);
                }

            }
                return countryDict;
        }
        public Country ReadLineFromCsv(string csvLine)
        {
            string[] items      = csvLine.Split(',');
            string name         = items[0];
            string code         = items[1];
            string region       = items[2];
            int population      = int.Parse(items[3]);
            return new Country(name, code, region, population);
        }

        public class Country
        {
            public string Name { get; set; }
            public string Code { get; set; }
            public string Region { get; set; }
            public int Population { get; set; }
            public Country(string name, string code, string region, int population)
            {
                Name        = name;
                Code        = code;
                Region      = region;
                Population  = population;
            }
        }
        //End TestCode-- Shiv
    }
}