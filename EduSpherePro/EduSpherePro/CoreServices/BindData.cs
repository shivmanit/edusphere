
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI.WebControls;

namespace EduSpherePro.CoreServices
{
    public class BindData : IBindData
    {
        public SqlDataAdapter ObjDA;
        public DataSet ObjDS;
        public SqlConnection ObjCn;
        private string _constr { get; set; }

        private SqlConnection constr;
        public SqlConnection ConStr
        {
            get {return new SqlConnection(WebConfigurationManager.ConnectionStrings["NTA"].ConnectionString);}
            set { constr = value;}
        }
        //
        public BindData()
        {
            ObjCn = new SqlConnection(WebConfigurationManager.ConnectionStrings["NTA"].ConnectionString);
            _constr = "";
            ConStr= new SqlConnection(WebConfigurationManager.ConnectionStrings["NTA"].ConnectionString);
        }

        //
        public BindData(string ConStr)
        {
            _constr = ConStr;
            if (_constr == "NTA")
                ObjCn = new SqlConnection(WebConfigurationManager.ConnectionStrings["NTA"].ConnectionString);
        }

       
        //DataList
        public void DataBindToDataList(DataList dl, string cmdstring)
        {
            //SqlCommand ObjCmd = new SqlCommand(cmdstring, ObjCn);
            SqlCommand ObjCmd = new SqlCommand(cmdstring, ConStr);
            try
            {
                //ObjCn.Open();
                if (ObjCmd.Connection.State == ConnectionState.Closed)
                {
                    ObjCmd.Connection.Open();
                }
                SqlDataReader ObjRdr=ObjCmd.ExecuteReader();
                dl.DataSource = ObjRdr;
                dl.DataBind();
                ObjRdr.Close();
                ObjCmd.Connection.Close();
            }
            catch (Exception ex)
            {

            }
        }

        //Bind Data to DataGrid
        public void DataBindToDataGrid(DataGrid dg, string cmdstring)
        {
            //SqlCommand ObjCmd = new SqlCommand(cmdstring, ObjCn);
            SqlCommand ObjCmd = new SqlCommand(cmdstring, ConStr);
            //ObjCn.Open();
            if (ObjCmd.Connection.State == ConnectionState.Closed)
            {
                ObjCmd.Connection.Open();
            }
            SqlDataReader ObjRdr;
            ObjRdr = ObjCmd.ExecuteReader();
            dg.DataSource = ObjRdr;
            dg.DataBind();
            ObjRdr.Close();
            ObjCn.Close();
        }

        //BindData to datagrid
        public void DataBindToDataGridDC(DataGrid dg, string cmdstring, string srcTable)
        {
            ObjDA       = new SqlDataAdapter(cmdstring, ConStr);
            ObjDS       = new DataSet();
            ObjDA.Fill(ObjDS, srcTable);
            DataView ObjDV  = new DataView();
            ObjDV = ObjDS.Tables[srcTable].DefaultView;
            dg.DataSource   = ObjDV;
            dg.DataBind();
            ObjCn.Close();
        }
        //DropDownList
        public void DataBindToDropDownList(DropDownList ddl, string cmdstring)
        {
            //SqlCommand ObjCmd = new SqlCommand(cmdstring, ObjCn);
            SqlCommand ObjCmd = new SqlCommand(cmdstring, ConStr);
            try
            {
                //ObjCn.Open();
                if(ObjCmd.Connection.State==ConnectionState.Closed)
                {
                    ObjCmd.Connection.Open();
                }
                
                SqlDataReader ObjRdr=ObjCmd.ExecuteReader();
                ddl.DataSource = ObjRdr;
                ddl.DataBind();
                ObjRdr.Close();
                ObjCmd.Connection.Close();
                //Add blank item at index 0.
                ddl.Items.Insert(0, new ListItem("Select", "Select"));
            }
            catch (Exception ex) { }
        }

        //Label
        public void DataBindToLabel(Label lbl, string cmdString)
        {
            SqlCommand ObjCmd = new SqlCommand(cmdString, ObjCn);
            ObjCn.Open();
            SqlDataReader ObjRdr = ObjCmd.ExecuteReader();
            while (ObjRdr.Read())
            {
                lbl.Text = ObjRdr[0].ToString();

            }
            //lbl.DataBind();
            ObjRdr.Close();
            ObjCn.Close();

        }

        //GridView
        public void DataBindToGridView(GridView gv, string cmdstring, string srcTable)
        {
            ObjDS = new DataSet();
            ObjDA = new SqlDataAdapter(cmdstring, ObjCn);
            // Fill the DataTable named "srcTable" in DataSet with the rows 
            // returned by the query
            ObjDA.Fill(ObjDS, srcTable);
            // Get the DataView from  DataTable. 
            DataView ObjDV = new DataView();
            ObjDV = ObjDS.Tables[srcTable].DefaultView;
            gv.DataSource = ObjDV;
            gv.DataBind();
            ObjCn.Close();
            //ConStr.Close();
        }

        //Update Prameters using SqlCommand
        public void UpdateParameters(SqlCommand ObjCmd)
        {
            if(ObjCmd.Connection.State==ConnectionState.Closed)
               {
                ObjCmd.Connection.Open();
               }
                ObjCmd.ExecuteNonQuery();
                ObjCmd.Connection.Close();
        }

        //Return a datarow
        public DataRow GetDataRow(string strCmd) 
        {
            string dummyTblName = "tblName";
            ObjDA = new SqlDataAdapter(strCmd,ConStr);

            ObjDS = new DataSet();
            ObjDA.Fill(ObjDS);
            //DataSet ObjDS = GetDataSet(strCmd, dummyTblName);

            DataTable dt = ObjDS.Tables[dummyTblName];
            DataRow dr = dt.Rows[0];
            return dr;

        }

        //Return Table for slqcmd
        public DataTable GetDataTable(SqlCommand cmd)
        {
            ObjDA = new SqlDataAdapter(cmd);

            DataTable dt = new DataTable();
            ObjDA.Fill(dt);

            return dt;
            //dl.DataSource = ObjDS;
            //dl.DataBind();

        }

        //Return dataset for slqcmd
        public DataSet GetDataSet(SqlCommand cmd)
        {
            ObjDA = new SqlDataAdapter(cmd);

            ObjDS = new DataSet();
            ObjDA.Fill(ObjDS);

            return ObjDS;

        }
    }
}