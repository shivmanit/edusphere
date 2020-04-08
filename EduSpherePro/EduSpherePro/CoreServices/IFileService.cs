using System.Web.UI.WebControls;

namespace EduSpherePro.CoreServices
{
    interface IFileService
    {
        bool DownLoadFile(string fileName);
        void ExportToExcel(GridView gv);
        void UploadFileFromDataListControl(DataList dl, string strFileUpload, string strServerPath, string lblDbPath);
        void UploadFileFromOutsideControl(FileUpload fu, string strServerPath, Label lblDbPath);
    }
}
