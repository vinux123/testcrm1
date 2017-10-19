using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using iTextSharp.text.pdf;
using iTextSharp;
using iTextSharp.text;
using System.IO;
using System.Web.Services;

public partial class Quotation : System.Web.UI.Page
{
    private VPCRMSBAL VPCRMSBAL = new VPCRMSBAL();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] == null)
        {
            Response.Redirect("Login.aspx");
        }

        DataTable dtLogin = new DataTable();
        dtLogin = VPCRMSBAL.GetQuotationDetails(Convert.ToDecimal(Session["UserID"]));
        grdQuotation.DataSource = dtLogin;
        grdQuotation.DataBind();

        DataTable dtTable = new DataTable();
        dtTable = VPCRMSBAL.GetCompanyName(Convert.ToDecimal(Session["UserID"].ToString().Trim().Substring(0, 4)));
        if (dtTable.Rows.Count > 0)
        {
            lblCompanyName.Text = dtTable.Rows[0]["clientname"].ToString();
        }
        else
        {
            lblCompanyName.Text = "Default Name";
        }
    }

    [WebMethod]
    public static void GenerateQuotationPDF(String customerquoteid)
    {
        VPCRMSBAL VPCRMSBAL = new VPCRMSBAL();

        string path = HttpContext.Current.Server.MapPath("PDF-Files");  // due to static web method Httpcontext is used. 
        string filename = path + "/Quotation_" + customerquoteid + ".pdf";

        Document document = new Document(PageSize.A4, 12.5f, 12.5f, 12.5f, 12.5f);

        PdfWriter.GetInstance(document, new FileStream(filename, FileMode.Create));
        document.Open();

        FontSelector selector = new FontSelector();
        Font f1 = FontFactory.GetFont(FontFactory.TIMES_BOLD, 12);
        f1.Color = BaseColor.MAGENTA;

        Font f2 = FontFactory.GetFont(FontFactory.HELVETICA_BOLD, 16);
        f1.Color = BaseColor.RED;

        DataTable dt = new DataTable();
        dt = VPCRMSBAL.GetCompanyName(Convert.ToDecimal(HttpContext.Current.Session["UserID"].ToString().Trim().Substring(0, 4)));
        if (dt.Rows.Count > 0)
        {
            Paragraph para1 = new Paragraph(dt.Rows[0]["clientname"].ToString().Trim(), f2);
            para1.Alignment = Element.ALIGN_CENTER;
            document.Add(para1);
            para1.SpacingAfter = 50f;
        }

        Paragraph para2 = new Paragraph();
        Phrase phrase1 = new Phrase("Product Quotation", f1);

        para2.Alignment = Element.ALIGN_LEFT;
        para2.Add(phrase1);
        para2.SpacingAfter = 50f;
        document.Add(para2);

        DataTable dataTable = new DataTable();
        dataTable = VPCRMSBAL.GetQuotationDetailsbyID(Convert.ToDecimal(customerquoteid));
        if (dataTable.Rows.Count > 0)
        {

            PdfPTable table = new PdfPTable(dataTable.Columns.Count);
            table.WidthPercentage = 100;

            //Set columns names in the pdf file
            for (int k = 0; k < dataTable.Columns.Count; k++)
            {
                PdfPCell cell = new PdfPCell(new Phrase(dataTable.Columns[k].ColumnName));

                cell.HorizontalAlignment = PdfPCell.ALIGN_CENTER;
                cell.VerticalAlignment = PdfPCell.ALIGN_CENTER;
                cell.BackgroundColor = new iTextSharp.text.BaseColor(51, 102, 102);

                table.AddCell(cell);
            }

            //Add values of DataTable in pdf file
            for (int i = 0; i < dataTable.Rows.Count; i++)
            {
                for (int j = 0; j < dataTable.Columns.Count; j++)
                {
                    PdfPCell cell = new PdfPCell(new Phrase(dataTable.Rows[i][j].ToString()));

                    //Align the cell in the center
                    cell.HorizontalAlignment = PdfPCell.ALIGN_CENTER;
                    cell.VerticalAlignment = PdfPCell.ALIGN_CENTER;

                    table.AddCell(cell);
                }
            }
            document.Add(table);
        }

        

        document.Close();
        //HttpContext.Current.Response.ContentType = "application/pdf";
        //HttpContext.Current.Response.AddHeader("content-disposition", "attachment;filename=Quotation.pdf");

        //HttpContext.Current.Response.Write(document);
        //HttpContext.Current.Response.End();
    }
}
