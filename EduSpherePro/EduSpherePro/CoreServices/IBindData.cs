using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.UI.WebControls;

namespace EduSpherePro.CoreServices
{
    interface IBindData
    {
        //Return Connection String
        SqlConnection ConStr { get; set; }

        //Binds Data to dropdownlist
        void DataBindToDropDownList(DropDownList ddl, string cmdstring);

        //Binds Data to DataGrid
        void DataBindToDataGrid(DataGrid dg, string cmdstring);

        //Binds Data to DataList
        void DataBindToDataList(DataList dl, string cmdstring);

        //Binds Data To Label
        void DataBindToLabel(Label lbl, string cmdString);

        //BindData to datagrid
        void DataBindToDataGridDC(DataGrid dg, string cmdstring, string srcTable);

        //BindData to GridView
        void DataBindToGridView(GridView gv, string cmdstring, string srcTable);

        //Updates table values using SqlCommand
        void UpdateParameters(SqlCommand ObjCmd);

        //Return Table for slqcmd
         DataTable GetDataTable(SqlCommand cmd);

        //Return a datarow
        DataRow GetDataRow(string strCmd);

        //Return dataset for slqcmd
        DataSet GetDataSet(SqlCommand cmd);
    }
}
