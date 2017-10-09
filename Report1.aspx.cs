
using iTextSharp.text;
using iTextSharp.text.pdf;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Report1 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnGenerate_Click(object sender, EventArgs e)
    {
        string FilePath = Server.MapPath("OfferLetter.pdf");
        WebClient User = new WebClient();

        Byte[] FileBuffer = User.DownloadData(FilePath);
        if (FileBuffer != null)
        {
            //Response.ContentType = "application/pdf";
            //Response.AddHeader("content-length", FileBuffer.Length.ToString());
            //Response.BinaryWrite(FileBuffer);
            //Response.TransmitFile(FilePath);

            //Response.Redirect(FilePath);
            Response.Write("<script>");
            Response.Write("window.open('" + FilePath + "','_blank', ' fullscreen=yes')");
            Response.Write("</script>");

        }

    }

    //[WebMethod]
    //public static string GetReportData()
    //{
    //    System.Data.DataTable dt = VPCRMSBAL.GetReportData();
    //    String json = DataTableToJSONWithJavaScriptSerializer(dt);
    //    return json;
    //}

    //public static string DataTableToJSONWithJavaScriptSerializer(System.Data.DataTable table)
    //{
    //    JavaScriptSerializer jsSerializer = new JavaScriptSerializer();
    //    List<Dictionary<string, object>> parentRow = new List<Dictionary<string, object>>();
    //    Dictionary<string, object> childRow;
    //    foreach (DataRow row in table.Rows)
    //    {
    //        childRow = new Dictionary<string, object>();
    //        foreach (DataColumn col in table.Columns)
    //        {
    //            childRow.Add(col.ColumnName, row[col]);
    //        }
    //        parentRow.Add(childRow);
    //    }
    //    return jsSerializer.Serialize(parentRow);
    //}
    ////protected void btnGenerate_Click(object sender, EventArgs e)
    ////{

    ////    String a = CreateCustomReport();

    ////}

    //public string CreateCustomReport()
    //{
    //    var doc = new Document();
    //    MemoryStream m = new MemoryStream();
    //    try
    //    {
    //        PdfWriter.GetInstance(doc, m).CloseStream = false;
    //        DataTable dt = VPCRMSBAL.GetReportData();
    //        doc.Open();
    //        //PdfPTable table = new PdfPTable(4);
    //        //PdfPCell cell = new PdfPCell(new Phrase("Title"));
    //        Phrase P1 = new Phrase("Testing");
    //        doc.Add(P1);
    //        doc.Close();

    //    }
    //    catch
    //    {

    //    }

    //    return System.Convert.ToBase64String(m.ToArray());
    //}
    
}