
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.tool.xml;
using System;
using System.Collections;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Text;
using System.Web;
using System.Web.UI;
using static System.Net.WebRequestMethods;

namespace EduSpherePro.CoreServices
{
    public class PdfGenerator : IPdfGenerator
    {
        BindData BD = new BindData();
        public void CourseInvoice(int intInvoiceID)
        {
            throw new NotImplementedException();
        }
        //Create Enrolment Certificate for Customer
        public void EnrolmentCertificate(int intMemberID)
        {
            //Fetch Store & Cutomer Details
            string qStoreDetails = string.Format(@"SELECT * FROM EduSphere.Staff
                                                           WHERE EmployeeID ={0}", intMemberID);
            SqlCommand cmd = new SqlCommand(qStoreDetails, BD.ObjCn);
            int orderNo = intMemberID;
            DataTable dt = new DataTable();
            dt = BD.GetDataTable(cmd);

            //Fetch Product Transaction Details
            string qInvoiceDetails = string.Format(@"SELECT * FROM EduSphere.Staff
                                                           WHERE EmployeeID ={0}", intMemberID);
            SqlCommand cmdInv = new SqlCommand(qInvoiceDetails, BD.ObjCn);
            //int orderNo = intTaxInvoiceNumber;
            DataTable dtInv = new DataTable();
            dtInv = BD.GetDataTable(cmdInv);

            //Fetch Service Transaction Details
            string qInvoiceService = string.Format(@"SELECT * FROM EduSphere.Staff
                                                           WHERE EmployeeID ={0}", intMemberID);
            SqlCommand cmdServ = new SqlCommand(qInvoiceService, BD.ObjCn);
            //int orderNo = intTaxInvoiceNumber;
            DataTable dtServ = new DataTable();
            dtServ = BD.GetDataTable(cmdServ);
            //Build string
            using (StringWriter sw = new StringWriter())
            {
                string.Format("{0}", "Hello");
                using (HtmlTextWriter hw = new HtmlTextWriter(sw))
                {
                    StringBuilder sb = new StringBuilder();

                    //Generate Membership Certificate.
                    sb.Append("<table style='width:750px;height:600px;padding:20px;text-align:center;border:10px solid #787878' BORDERCOLOR='#0000FF' BORDERCOLORLIGHT='#33CCFF' BORDERCOLORDARK='#0000CC'>");
                    sb.Append("<tr><td>");
                    //Heading
                    sb.Append("<table style='width:700px; height:550px; padding:20px; text-align:center;border:5px solid #F57A33;'>");
                    sb.Append("<tr><td>");
                    sb.Append("<span><img src='" + HttpContext.Current.Server.MapPath("/Content/TemplateApp/images/icons/logo.jpg") + "' width='100' float='left' /></span><span style='font-size:40px; font-weight:bold'>NEUROTHERAPY ACADEMY</span>");
                    sb.Append("</td></tr>");
                    sb.Append("<tr><td>&nbsp;</td></tr>");
                    sb.Append("<tr><td>&nbsp;</td></tr>");

                    sb.Append("<tr><td>");
                    sb.Append("<span style='font-size:25px'><i>This is to certify that ");
                    //sb.Append(dt.Rows[0]["FullName"]);
                    sb.Append("</i></span></td></tr>");
                    sb.Append("<tr><td>&nbsp;</td></tr>");
                    sb.Append("<tr><td>&nbsp;</td></tr>");

                    sb.Append("<tr><td>");
                    sb.Append("<span style='font-size:30px'><i> ");
                    sb.Append(dt.Rows[0]["FullName"]);
                    sb.Append("</i></span></td></tr>");
                    sb.Append("<tr><td>&nbsp;</td></tr>");
                    sb.Append("<tr><td>&nbsp;</td></tr>");

                    sb.Append("<tr><td>");
                    sb.Append("<span style='font-size:25px'><i> has completed the course ");
                    //sb.Append(dt.Rows[0]["FullName"]);
                    sb.Append("</i></span></td></tr>");
                    sb.Append("<tr><td>&nbsp;</td></tr>");
                    sb.Append("<tr><td>&nbsp;</td></tr>");

                    sb.Append("<tr><td>");
                    sb.Append("<span style='font-size:30px'><i> Program Name Here ");
                    //sb.Append(dt.Rows[0]["FullName"]);
                    sb.Append("</i></span></td></tr>");
                    sb.Append("<tr><td>&nbsp;</td></tr>");
                    sb.Append("<tr><td>&nbsp;</td></tr>");

                    sb.Append("<tr><td>");
                    sb.Append("<span style='font-size:25px'><i> Dated ");
                    //sb.Append(dt.Rows[0]["FullName"]);
                    sb.Append("</i></span></td></tr>");
                    sb.Append("<tr><td>&nbsp;</td></tr>");
                    sb.Append("<tr><td>&nbsp;</td></tr>");

                    sb.Append("<tr><td>");
                    sb.Append("<span style='font-size:30px'><i>");
                    sb.Append(dt.Rows[0]["DateOfJoining"]);
                    sb.Append("</i></span></td></tr>");
                    sb.Append("<tr><td>&nbsp;</td></tr>");
                    sb.Append("<tr><td>&nbsp;</td></tr>");

                    sb.Append("</table>");
                    sb.Append("</td></tr>");
                    sb.Append("</table>");

                    //sb.Append("<table width='100%' class='table table-striped table-bordered'  cellspacing='0' cellpadding='2'>");

                    //sb.Append("<img src='" + HttpContext.Current.Server.MapPath("/Content/TemplateApp/images/icons/logo.jpg") + "' width='100' align='right' />");
                    //sb.Append("<table width='100%' style='border: 5px solid #787878'>");
                    //sb.Append("<tr>");
                    //sb.Append("<td style=''>");
                    ////sb.Append("<img src='http://localhost:49446/Content/TemplateApp/images/icons/logo.jpg' />");
                    //sb.Append("<img src='"+ HttpContext.Current.Server.MapPath("/Content/TemplateApp/images/icons/logo.jpg") + "' width='100' float='centre' />");                   
                    //sb.Append("</td>");
                    ////sb.Append("</tr>");
                    //sb.Append("<td><span style='font-size:40px;font-weight:bold;font-family:verdana;font-style:italic;'>NEUROTHERAPY ACADEMY</span></td></tr>");
                    //sb.Append("<tr><td></td></tr>");
                    //sb.Append("<tr><td><span style='font-size:18px;color:orange'>Membership Id   :</span>");
                    //sb.Append(intMemberID);
                    //sb.Append("</td><td><span style='font-size:18px;color:orange'>Date   :</span>");
                    //sb.Append(dt.Rows[0]["DateOfJoining"]);
                    //sb.Append(" </td></tr>");
                    //sb.Append("<tr><td><span style='font-size:18px;color:orange'>Name   :</span>");
                    //sb.Append(dt.Rows[0]["FullName"]);
                    //sb.Append("</td></tr>");
                    //sb.Append("<tr><td><span style='font-size:18px;color:orange'>Centre Id   :</span>");
                    //sb.Append(dt.Rows[0]["OrganizationID"]);
                    //sb.Append("</td></tr>");
                    //sb.Append("<tr><td><span style='font-size:18px;color:orange'>Address   :</span>");
                    //sb.Append(dt.Rows[0]["ContactAddress"]);
                    //sb.Append("</td></tr>");


                    //sb.Append("<tr><td><span style='font-size:18px;color:orange'>State   :</span>");
                    //sb.Append(dt.Rows[0]["State"]);
                    //sb.Append("</td></tr>");

                    //sb.Append("<tr><td><span style='font-size:18px;color:orange'>Email   :</span>");
                    //sb.Append(dt.Rows[0]["Email"]);
                    //sb.Append("</td></tr>");


                    //sb.Append("<tr><td><span style='font-size:18px;color:orange'>Phone   :</span>");
                    //sb.Append(dt.Rows[0]["PhoneOne"]);
                    //sb.Append("</td></tr>");

                    //sb.Append("</table>");
                    //sb.Append("<br />");
                    ////sb.Append("<hr />");

                    //Generate Invoice (Bill) Product Items Grid.
                    //sb.Append("<table border = '1'>");
                    //sb.Append("<tr>");
                    //sb.Append("<th colspan='4' style='color:red'><b>Product Items :</b></th>");
                    //sb.Append("</tr>");
                    //sb.Append("<tr>");
                    //foreach (DataColumn column in dtInv.Columns)
                    //{
                    //    sb.Append("<th>");
                    //    sb.Append(column.ColumnName);
                    //    sb.Append("<hr />");
                    //    sb.Append("</th>");
                    //}
                    //sb.Append("</tr>");
                    //foreach (DataRow row in dtInv.Rows)
                    //{
                    //    sb.Append("<tr>");
                    //    foreach (DataColumn column in dtInv.Columns)
                    //    {
                    //        sb.Append("<td>");
                    //        sb.Append(row[column]);
                    //        sb.Append("<hr />");
                    //        sb.Append("</td>");
                    //    }
                    //    sb.Append("</tr>");
                    //}

                    //sb.Append("<tr><td align = 'right' colspan = '");
                    //sb.Append(dtInv.Columns.Count - 1);
                    //sb.Append("'>Total Savings :</td>");
                    //sb.Append("<td>");
                    ////sb.Append(dtInv.Compute("sum(DISC)", ""));
                    //sb.Append("</td>");

                    //sb.Append("<td colspan='2'>");
                    //sb.Append("Total Bill :</td>");
                    //sb.Append("<td>");
                    ////sb.Append(dtInv.Compute("sum(BILL)", ""));
                    //sb.Append("</td>");
                    //sb.Append("</tr></table>");

                    ////Generate Invoice (Bill) Service Items Grid.
                    //sb.Append("<table border = '1'>");
                    //sb.Append("<tr>");
                    //sb.Append("<th colspan='4' style='color:red'><b>Service Items :</b></th>");
                    //sb.Append("</tr>");
                    //sb.Append("<tr>");
                    //foreach (DataColumn column in dtServ.Columns)
                    //{
                    //    sb.Append("<th>");
                    //    sb.Append(column.ColumnName);
                    //    sb.Append("<hr />");
                    //    sb.Append("</th>");
                    //}
                    //sb.Append("</tr>");
                    //foreach (DataRow row in dtServ.Rows)
                    //{
                    //    sb.Append("<tr>");
                    //    foreach (DataColumn column in dtServ.Columns)
                    //    {
                    //        sb.Append("<td>");
                    //        sb.Append(row[column]);
                    //        sb.Append("<hr />");
                    //        sb.Append("</td>");
                    //    }
                    //    sb.Append("</tr>");
                    //}

                    //sb.Append("<tr><td align = 'right' colspan = '");
                    //sb.Append(dtServ.Columns.Count - 1);
                    //sb.Append("'>Total Savings :</td>");
                    //sb.Append("<td>");
                    ////sb.Append(dtServ.Compute("sum(DISC)", ""));
                    //sb.Append("</td>");

                    //sb.Append("<td colspan='2'>");
                    //sb.Append("Total Bill :</td>");
                    //sb.Append("<td>");
                    ////sb.Append(dtServ.Compute("sum(BILL)", ""));
                    //sb.Append("</td>");
                    //sb.Append("</tr></table>");

                    //Export HTML String as PDF.
                    StringReader sr = new StringReader(sb.ToString());
                    Document pdfDoc = new Document(PageSize.A4, 20f, 20f, 20f, 20f);
                    //HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
                    PdfWriter writer = PdfWriter.GetInstance(pdfDoc, System.Web.HttpContext.Current.Response.OutputStream);
                    pdfDoc.Open();

                    //htmlparser.Parse(sr);
                    XMLWorkerHelper.GetInstance().ParseXHtml(writer, pdfDoc, sr);
                    //QR Code Generation Begin
                    GenerateQRCode(writer, pdfDoc, dt);
                    //GeneratePdfFromPdfTemplate("~/Artificats/Neurotherapists/MembershipTemplate", 110);
                    //QR Code Generation End

                    pdfDoc.Close();
                    System.Web.HttpContext.Current.Response.ContentType = "application/pdf";
                    System.Web.HttpContext.Current.Response.AddHeader("content-disposition", "attachment;filename=Invoice_" + orderNo + ".pdf");
                    System.Web.HttpContext.Current.Response.Cache.SetCacheability(HttpCacheability.NoCache);
                    System.Web.HttpContext.Current.Response.Write(pdfDoc);
                    System.Web.HttpContext.Current.Response.End();
                }
            }
        }

        //QR Code Generator
        private void GenerateQRCode(PdfWriter writer, Document doc, DataTable dt)
        {
            //Document doc = new Document(new iTextSharp.text.Rectangle(4.5f, 5.5f), 0.5f, 0.5f, 0, 0);

            try
            {

                //PdfWriter writer = PdfWriter.GetInstance(doc, new FileStream(
                //  Environment.GetFolderPath(Environment.SpecialFolder.Desktop) + "/codes.pdf", FileMode.Create));
                //doc.Open();

                //DataTable dt = new DataTable();
                //dt.Columns.Add("ID");
                //dt.Columns.Add("Price");
                //for (int i = 0; i < 8; i++)
                //{
                //    DataRow row = dt.NewRow();
                //    row["ID"] = "ZS00000000000000" + i.ToString();
                //    row["Price"] = "100," + i.ToString();
                //    dt.Rows.Add(row);
                //}

                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    if (i != 0)
                        doc.NewPage();

                    iTextSharp.text.pdf.PdfContentByte cb = writer.DirectContent;
                    string strID = "103";// dt.Rows[i]["EmployeeID"].ToString();
                    string strName = dt.Rows[i]["FullName"].ToString();
                    string strPhone = "1234567";// dt.Rows[i]["PhoneOne"].ToString();
                    string strEmail = "shivmanit@yahoo.com";// dt.Rows[i]["Email"].ToString();
                    string strData = string.Format("Id-{0} * Name-{1} * Phone-{2} * Email-{3}", strID, strName, strPhone, strEmail);
                    iTextSharp.text.pdf.BarcodeQRCode Qr = new BarcodeQRCode(strData, 60, 6, null);
                    iTextSharp.text.Image img = Qr.GetImage();
                    cb.SetTextMatrix(-2.0f, 0.0f);
                    //img.ScaleToFit(60, 5);
                    img.ScaleToFit(1200, 100);
                    //img.SetAbsolutePosition(-2.8f, 0.5f);
                    img.SetAbsolutePosition(420f, 400f);
                    //img.Border= Rectangle.TOP_BORDER | Rectangle.RIGHT_BORDER | Rectangle.BOTTOM_BORDER | Rectangle.LEFT_BORDER;

                    //img.BorderWidth = 1f;
                    cb.AddImage(img);

                    //PdfContentByte cb1 = writer.DirectContent;
                    //BaseFont bf = BaseFont.CreateFont(BaseFont.TIMES_BOLDITALIC, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
                    //cb1.SetFontAndSize(bf, 0.5f);
                    //cb1.BeginText();
                    //cb1.SetTextMatrix(0.2f, 5.1f);
                    //cb1.ShowText("Neurotherapy Academy");
                    //cb1.EndText();

                    //PdfContentByte id = writer.DirectContent;
                    //BaseFont bf1 = BaseFont.CreateFont(BaseFont.HELVETICA, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
                    //id.SetFontAndSize(bf1, 0.4f);
                    //id.BeginText();
                    //id.SetTextMatrix(0.2f, 0.6f);
                    //id.ShowText(dt.Rows[i]["FullName"].ToString());
                    //id.EndText();
                }
                // if you want to print it un comment the following two line

                //PdfAction act = new PdfAction(PdfAction.PRINTDIALOG);
                //writer.SetOpenAction(act);

                //doc.Close();

                //System.Diagnostics.Process.Start(Environment.GetFolderPath(
                //          Environment.SpecialFolder.Desktop) + "/codes.pdf");

            }
            catch
            {
            }
            finally
            {
                doc.Close();
            }
        }

        //Create Product Invoice for Customer
        public void ProductInvoice(int intInvoiceID)
        {
            //Fetch Store & Cutomer Details
            string qStoreDetails = string.Format(@"SELECT *,BaseAmount+2*CGSTAmount+DiscountAmount as Amount FROM EduSphere.TaxInvoices i
                                                           JOIN EduSphere.Organizations o ON i.LocationId=o.OrganizationID 
                                                           JOIN EduSphere.Members c ON i.MemberID=c.MemberID
                                                           WHERE TaxInvoiceNumber ={0}", intInvoiceID);
            SqlCommand cmd  = new SqlCommand(qStoreDetails, BD.ObjCn);
            int orderNo     = intInvoiceID;
            DataTable dt    = new DataTable();
            dt              = BD.GetDataTable(cmd);

            //Fetch Product Transaction Details
            //CGSTAmount AS CGST, SGSTAmount AS SGST,CreditAmount AS Total Paid 
            //string qInvoiceDetails = string.Format(@"SELECT ProductTitle AS Products,DiscountAmount AS Saved, DebitAmount AS Bill
            //                                               FROM EduSphere.ProductSaleTransaction a 
            //                                               JOIN EduSphere.Products s ON a.ProductId=s.ProductId 
            //                                               JOIN EduSphere.Members c ON a.MemberID=c.MemberID
            //                                               WHERE TaxInvoiceNumber ={0} AND a.productId != {1}", intInvoiceID, 90); //do not print PAYMENT-RECEIPTS
            //SqlCommand cmdInv = new SqlCommand(qInvoiceDetails, BD.ObjCn);
            ////int orderNo = intTaxInvoiceNumber;
            //DataTable dtInv = new DataTable();
            //dtInv = BD.GetDataTable(cmdInv);

            //Fetch Service Transaction Details
            //CGSTAmount AS CGST, SGSTAmount AS SGST, CreditAmount AS Total Paid
            //Use this in case Rates are inclusive of GST
            //string qInvoiceService = string.Format(@"SELECT SkuTitle AS Services,DiscountAmount AS Saved,DebitAmount AS Bill
            //                                               FROM EduSphere.MemberAccount a 
            //                                               JOIN EduSphere.Sku s ON a.SkuID=s.SkuID 
            //                                               JOIN EduSphere.Members c ON a.MemberID=c.MemberID
            //                                               WHERE TaxInvoiceNumber ={0} AND a.Notes!='{1}'", intInvoiceID,"ItemCancelled");
            //Use this in case Rates are not inclusive of GST
            string qInvoiceService = string.Format(@"SELECT SkuTitle AS Item,DiscountAmount AS Saved,DebitAmount AS Bill
                                                           FROM EduSphere.MemberAccount a 
                                                           JOIN EduSphere.Sku s ON a.SkuID=s.SkuID 
                                                           JOIN EduSphere.Members c ON a.MemberID=c.MemberID
                                                           WHERE TaxInvoiceNumber ={0} AND a.Notes!='{1}' AND a.SkuID!={2}", intInvoiceID, "ItemCancelled", 91);//do not print PAYMENT-RECEIPTS
            SqlCommand cmdServ = new SqlCommand(qInvoiceService, BD.ObjCn);
            //int orderNo = intTaxInvoiceNumber;
            DataTable dtServ = new DataTable();
            //services table
            dtServ = BD.GetDataTable(cmdServ);
            //Build string
            using (StringWriter sw = new StringWriter())
            {
                using (HtmlTextWriter hw = new HtmlTextWriter(sw))
                {
                    StringBuilder sb = new StringBuilder();

                    //Generate Detailed Invoice (Bill) Header.
                    //sb.Append("<table width='100%' class='table table - striped table - bordered'  cellspacing='0' cellpadding='2'>");
                    sb.Append("<table style='width:100%;padding:10px;text-align:center;font-size:10px;font-family:'Calibri';border:1px solid #787878' BORDERCOLOR='#0000FF'>");
                    sb.Append("<tr><td colspan='3'><span style='text-align:center;font-size:12px;font-weight:bold;color:black;'>SPEEDJET AVIATION ACADEMY LLP</span>");
                    sb.Append("</td></tr>");
                    sb.Append("<tr><td colspan='3'><span style='text-align:right,font-size:8px;color:black;'></span>");
                    sb.Append("</td></tr>");

                    sb.Append("<tr><td colspan='3'><span style='font-size:10px;color:black;'>Invoice No: ");
                    sb.Append(intInvoiceID);
                    sb.Append("</span></td></tr><tr><td colspan='3'>Date: ");
                    sb.Append(dt.Rows[0]["InvoiceDate"]);
                    sb.Append(" </td></tr>");

                    sb.Append("<tr><td colspan='3'>Location :");
                    sb.Append(dt.Rows[0]["OrganizationName"]);
                    sb.Append("</td></tr>");

                    //sb.Append("<tr><td colspan='3'>Address:");
                    //sb.Append(dt.Rows[0]["OrgAddress"]);
                    //sb.Append("</td></tr>");

                    sb.Append("<tr><td colspan='3'>GSTIN/UIN :");
                    sb.Append(dt.Rows[0]["GstNumber"]);
                    sb.Append("</td></tr><tr>");
                    sb.Append("<td colspan='3'>State :");
                    sb.Append(dt.Rows[0]["administrative_area_level_1"]);
                    sb.Append("</td></tr>");

                    //sb.Append("<tr>");
                    //sb.Append("<td colspan='3'>CIN : ");
                    //sb.Append(dt.Rows[0]["CIN"]);
                    //sb.Append("</td></tr>");

                    sb.Append("<tr><td colspan='3'>Email : ");
                    sb.Append(dt.Rows[0]["ManagerEmail"]);
                    sb.Append("</td></tr>");
                    sb.Append("<tr><td colspan='3'>PhoneOne :");
                    sb.Append(dt.Rows[0]["PhoneOne"]);
                    sb.Append("</td></tr>");

                    sb.Append("<tr><td colspan='3'>Name:");
                    sb.Append(dt.Rows[0]["FullName"]);
                    sb.Append("</td></tr>");

                    sb.Append("</table>");




                    //Generate Invoice (Bill) Service Items Grid.
                    //sb.Append("<h3><span style='colspan:4;color:black;font-size:10px;'>Services :</span></h3>");
                    sb.Append("<table style='width:100%;padding:8px;text-align:centre;font-size:10px;font-family:'Calibri';border:1px solid #787878' BORDERCOLOR='#0000FF'>");
                    //sb.Append("<tr>");
                    //sb.Append("<th colspan='3' style='color:red'><b>Service Items :</b></th>");
                    //sb.Append("</tr>");
                    sb.Append("<tr>");
                    foreach (DataColumn column in dtServ.Columns)
                    {
                        sb.Append("<th>");
                        sb.Append(column.ColumnName);
                        sb.Append("<hr />");
                        sb.Append("</th>");
                    }
                    sb.Append("</tr>");
                    foreach (DataRow row in dtServ.Rows)
                    {
                        sb.Append("<tr>");
                        foreach (DataColumn column in dtServ.Columns)
                        {
                            sb.Append("<td>");
                            sb.Append(row[column]);
                            sb.Append("<hr />");
                            sb.Append("</td>");
                        }
                        sb.Append("</tr>");
                    }

                    sb.Append("<tr><td colspan = '3'");
                    sb.Append(dtServ.Columns.Count - 1);
                    sb.Append("'>Savings :");
                    sb.Append("");
                    sb.Append(dtServ.Compute("sum(Saved)", ""));
                    sb.Append("</td></tr>");

                    sb.Append("<tr><td colspan='3'>");
                    sb.Append("Total including taxes :");
                    sb.Append("");

                    sb.Append(dtServ.Compute("sum(Bill)", ""));//Amount charged to customer including taxes
                    sb.Append("</td>");
                    sb.Append("</tr></table>");

                    ////Generate Invoice (Bill) Product Items Grid.
                    ////sb.Append("<h3><span style='colspan:4;color:black;font-size:9px;'>Products:</span></h3>");
                    //sb.Append("<table style='width:100%;padding:10px;text-align:center;font-size:10px;border:1px solid #787878' BORDERCOLOR='#0000FF'>");
                    ////sb.Append("<tr>");
                    ////sb.Append("<th colspan='3' style='color:red'><b>Product Items :</b></th>");
                    ////sb.Append("</tr>");
                    //sb.Append("<tr>");
                    //foreach (DataColumn column in dtInv.Columns)
                    //{
                    //    //Header
                    //    sb.Append("<th>");
                    //    sb.Append(column.ColumnName);
                    //    sb.Append("<hr />");
                    //    sb.Append("</th>");
                    //}
                    //sb.Append("</tr>");
                    //foreach (DataRow row in dtInv.Rows)
                    //{
                    //    sb.Append("<tr>");
                    //    foreach (DataColumn column in dtInv.Columns)
                    //    {
                    //        sb.Append("<td>");
                    //        sb.Append(row[column]);
                    //        sb.Append("<hr />");
                    //        sb.Append("</td>");
                    //    }
                    //    sb.Append("</tr>");
                    //}

                    //sb.Append("<tr><td colspan ='3'");
                    //sb.Append(dtInv.Columns.Count - 1);
                    //sb.Append("'>Prod.Savings :</td></tr>");
                    //sb.Append("<tr><td colspan ='3'>");
                    //sb.Append(dtInv.Compute("sum(Saved)", ""));
                    //sb.Append("</td></tr>");

                    //sb.Append("<tr><td colspan='3'>");
                    //sb.Append("Prod.Total including taxes:");
                    //sb.Append(" ");
                    //sb.Append(dtInv.Compute("sum(Bill)", ""));
                    //sb.Append("</td></tr>");
                    //sb.Append("</table>");


                    //Bill Summary
                    sb.Append("<table style='width:100%;padding:8px;text-align:center;font-size:10px;border:1px solid #787878' BORDERCOLOR='#0000FF'>");
                    sb.Append("<tr><td colspan='3'>Sub Total including taxes :");
                    //sb.Append(dt.Rows[0]["SubTotal"]);
                    sb.Append(dt.Rows[0]["Amount"]);//BaseAmount+2*CGSTAmount+Discount (Menu Rate Including Taxes)
                    sb.Append("</td></tr>");

                    sb.Append("<tr><td colspan='3'> Discount : ");
                    sb.Append(dt.Rows[0]["DiscountAmount"]);
                    sb.Append("</td></tr>");
                    sb.Append("<tr><td colspan='3'> SubTotal After Discount(with taxes) : ");
                    sb.Append(dt.Rows[0]["SubTotal"]);//DebitAmount total  in case rate is inclusive og GST
                    //sb.Append(dt.Rows[0]["BaseAmount"]);//DebitAmout-Discount total in case of Rate not including GST
                    sb.Append("</td></tr>");
                    sb.Append("<tr><td colspan='3'>CGST :");
                    sb.Append(dt.Rows[0]["CGSTAmount"]);
                    sb.Append("</td></tr>");
                    sb.Append("<tr><td colspan='3'>SGST :");
                    sb.Append(dt.Rows[0]["SGSTAmount"]);
                    sb.Append("</td></tr>");
                    sb.Append("<tr><td colspan='3'>Base Amount without Taxes: ");
                    sb.Append(dt.Rows[0]["BaseAmount"]);//In case rate is inclusive of GST
                    //sb.Append(dt.Rows[0]["SubTotal"]);//IN CASE RATE IS NOT INCLUSIVE OF gst, BaseAmount+ GST
                    sb.Append("</td></tr>");
                    //sb.Append("<tr><td colspan='3'>Amount Paid : ");//Do not print paid amount
                    //sb.Append(dt.Rows[0]["CreditAmount"]);
                    //sb.Append("</td></tr>");
                    sb.Append("</table>");

                    sb.Append("<h6><span style='colspan:3;font-size:10px;color:black;'>Thank You !!!.</span></h6>");
                    sb.Append("<h6><span style='colspan:3;font-size:10px;color:black;'>Enquire Online http://www.speedjetaviation.in/enquiry </span></h6>");

                    //Export HTML String as PDF.
                    StringReader sr = new StringReader(sb.ToString());
                    //var pgSize = new iTextSharp.text.Rectangle(myWidth, myHeight);
                    //Document pdfDoc = new Document(PageSize.A5, 30f, 10f, 10f, 0f);
                    //Document pdfDoc = new Document(PageSize.A8, 5f, 5f, 5f, 5f);
                    //custom page size
                    float xpointValue = iTextSharp.text.Utilities.MillimetersToPoints(74);
                    float ypointvalue = iTextSharp.text.Utilities.MillimetersToPoints(222);
                    var pgSize = new iTextSharp.text.Rectangle(xpointValue, ypointvalue);
                    Document pdfDoc = new Document(pgSize, 5f, 5f, 5f, 5f);
                    //End Custome Page Size
                    //HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
                    PdfWriter writer = PdfWriter.GetInstance(pdfDoc, System.Web.HttpContext.Current.Response.OutputStream);
                    pdfDoc.Open();
                    //htmlparser.Parse(sr);
                    XMLWorkerHelper.GetInstance().ParseXHtml(writer, pdfDoc, sr);
                    pdfDoc.Close();
                    System.Web.HttpContext.Current.Response.ContentType = "application/pdf";
                    //for downloading--commented
                    //System.Web.HttpContext.Current.Response.AddHeader("content-disposition", "attachment;filename=Invoice_" + orderNo + ".pdf");
                    //for opening in another window--used
                    System.Web.HttpContext.Current.Response.AddHeader("content-disposition", "inline;filename=Invoice_" + orderNo + ".pdf");

                    System.Web.HttpContext.Current.Response.Cache.SetCacheability(HttpCacheability.NoCache);
                    System.Web.HttpContext.Current.Response.Write(pdfDoc);
                    System.Web.HttpContext.Current.Response.End();
                }
            }
        }


        public void ServiceInvoice(int intInvoiceID)
        {
            throw new NotImplementedException();
        }

        public void GeneratePdfFromPdfTemplate(string strPdfTemplateFile, int intMemberID)
        {
            //Pupilate table with required field from db
            string qMember      = string.Format(@"SELECT * FROM EduSphere.Neurotherapists
                                                           WHERE NeurotherapistID ={0}", intMemberID);
            SqlCommand cmd      = new SqlCommand(qMember, BD.ConStr);
            int orderNo         = intMemberID;
            DataTable dtMember  = new DataTable();
            dtMember            = BD.GetDataTable(cmd);

            //Fill the pdfTemplate with fields from table
            var pdfTemplateFile = Path.Combine(HttpContext.Current.Server.MapPath(strPdfTemplateFile));
            string outputFilePath       = HttpContext.Current.Server.MapPath("~/Artifacts/Neurotherapists");
            //var output                = new MemoryStream();
            PdfReader reader = new PdfReader(pdfTemplateFile);
            //PdfStamper stamper = new PdfStamper(reader, output);
            PdfStamper stamper          = new PdfStamper(reader, new FileStream(outputFilePath + "/completed_memcert.pdf", FileMode.Create));
            AcroFields formfields       = stamper.AcroFields;
            formfields.GenerateAppearances = true;//This to make final output not editable
            formfields.SetField("FullName", dtMember.Rows[0]["FullName"].ToString());
            //formfields.SetField("Textfield_Institute", "Neurotherapy Academy");
           // formfields.SetField("Textfield_City", "MUMBAI");
            //formfields.SetField("Textfield_FromDate", "01 JAN 2017");
            //formfields.SetField("Textfield_ToDate", "30 JUN 2017");
            formfields.SetField("DateOfJoining", Convert.ToDateTime(dtMember.Rows[0]["DateOfJoining"]).ToString("dd/MM/yyy"));
            formfields.SetField("MembershipExpiryDate", Convert.ToDateTime(dtMember.Rows[0]["MembershipExpiryDate"]).ToString("dd/MM/yyyy"));
            //formfields.SetField("Textfield_FullName", "Radhemohan Dhyanchand Gupta");

            stamper.FormFlattening = true;
            stamper.Close();
            reader.Close();

            //GET QR CODE START
           // iTextSharp.text.pdf.PdfContentByte cb = writer.DirectContent;
            string strID        = dtMember.Rows[0]["NeurotherapistID"].ToString();
            string strName      = dtMember.Rows[0]["FullName"].ToString();
            string strPhone     = dtMember.Rows[0]["PhoneOne"].ToString();
            string strEmail     = dtMember.Rows[0]["Email"].ToString();
            string strData      = string.Format("Id-{0} * Name-{1} * Phone-{2} * Email-{3}", strID, strName, strPhone, strEmail);
            iTextSharp.text.pdf.BarcodeQRCode Qr = new BarcodeQRCode(strData, 60, 6, null);
            iTextSharp.text.Image img = Qr.GetImage();
            //cb.SetTextMatrix(-2.0f, 0.0f);
            //img.ScaleToFit(60, 5);
            img.ScaleToFit(1200, 100);
            //img.SetAbsolutePosition(-2.8f, 0.5f);
            img.SetAbsolutePosition(420f, 300f);
            //img.Border= Rectangle.TOP_BORDER | Rectangle.RIGHT_BORDER | Rectangle.BOTTOM_BORDER | Rectangle.LEFT_BORDER;

            //img.BorderWidth = 1f;
            //cb.AddImage(img);

            //QR CODE END
             
            using (Stream inputPdfStream = new FileStream(outputFilePath + "/completed_memcert.pdf", FileMode.Open, FileAccess.Read, FileShare.Read))
            using (Stream inputImageStream1 = new FileStream(outputFilePath + "/sign1.png", FileMode.Open, FileAccess.Read, FileShare.Read))
            using (Stream inputImageStream2 = new FileStream(outputFilePath + "/sign2.png", FileMode.Open, FileAccess.Read, FileShare.Read))
            //using (Stream inputImageStream = new FileStream(img, FileMode.Open, FileAccess.Read, FileShare.Read))
            using (Stream outputPdfStream = new FileStream(outputFilePath + "/result.pdf", FileMode.Create, FileAccess.Write, FileShare.None))
            {
                var infputFileReader = new PdfReader(inputPdfStream);
                var imgstamper = new PdfStamper(infputFileReader, outputPdfStream);
                var pdfContentByte = imgstamper.GetOverContent(1);
                //Add QR Code
                iTextSharp.text.Image imageQR = iTextSharp.text.Image.GetInstance(img);
                imageQR.SetAbsolutePosition(30, 600);
                pdfContentByte.AddImage(imageQR);
                //Add other image
                iTextSharp.text.Image imagesign1 = iTextSharp.text.Image.GetInstance(inputImageStream1);
                imagesign1.SetAbsolutePosition(250, 150);
                imagesign1.ScalePercent(7);
                pdfContentByte.AddImage(imagesign1);
                //Add other image
                iTextSharp.text.Image imagesign2 = iTextSharp.text.Image.GetInstance(inputImageStream2);
                imagesign2.SetAbsolutePosition(400, 150);
                imagesign2.ScalePercent(7);
                pdfContentByte.AddImage(imagesign2);
                imgstamper.Close();
            }

           
            //Download ourput file
            System.Web.HttpContext.Current.Response.ContentType = "application/pdf";
            System.Web.HttpContext.Current.Response.AddHeader("content-disposition", "attachment;filename=Membership_" + orderNo + ".pdf");
            System.Web.HttpContext.Current.Response.Cache.SetCacheability(HttpCacheability.NoCache);
            //System.Web.HttpContext.Current.Response.Write(newFile);
            HttpContext.Current.Response.TransmitFile(HttpContext.Current.Server.MapPath("~/Artifacts/Neurotherapists/result.pdf"));
            System.Web.HttpContext.Current.Response.End();

            //HttpContext.Current.Response.AddHeader("Content-Disposition", "attachment; filename=YourCert.pdf");
            //HttpContext.Current.Response.ContentType = "application/pdf";
            //HttpContext.Current.Response.BinaryWrite(output.ToArray());
            //HttpContext.Current.Response.End();

        }

        //Create QR Code
        //Create an instance of PQScan.BarcodeCreator.Barcode object.
      

    }
}