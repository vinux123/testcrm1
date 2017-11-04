using System;
using System.Collections.Generic;
// Copyright (c) 2017 VP Consultancy Services. 
// 
// Permission to use, copy, modify, and distribute this software for given
// purpose with or without fee is hereby granted, provided that the above
// copyright notice and this permission notice appear in all copies & with 
// written consent of original VP Consultancy Services. 
//



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
using log4net;
using System.Web.Script.Serialization;

public partial class Quotation : System.Web.UI.Page
{
    private VPCRMSBAL VPCRMSBAL = new VPCRMSBAL();

    protected void Page_Load(object sender, EventArgs e)
    {
        // Set page cache to NO
        HttpContext.Current.Response.Cache.SetCacheability(HttpCacheability.NoCache);
        HttpContext.Current.Response.Cache.SetNoServerCaching();
        HttpContext.Current.Response.Cache.SetNoStore();

        if (Session["UserID"] == null)
        {
            Response.Redirect("Login.aspx");
        }

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
    public static string GenerateQuotationPDF(String customerquoteid)
    {
        VPCRMSBAL VPCRMSBAL = new VPCRMSBAL();

        string path = HttpContext.Current.Server.MapPath("PDF-Files");  // due to static web method Httpcontext is used.
        string client_alias = HttpContext.Current.Session["UserID"].ToString().Trim().Substring(0, 4);
        string filename = path + "/Quotation_" + client_alias + "_" + customerquoteid + ".pdf";

        // Check file exists on path or not, if exists delete existing instance and create new one always. 
        if (File.Exists(filename))
        {
            File.Delete(filename);
        }

        
        Document document = new Document(PageSize.A4, 12.5f, 12.5f, 12.5f, 12.5f);

        try
            {
                PdfWriter.GetInstance(document, new FileStream(filename, FileMode.Create));
                document.Open();

                FontSelector selector = new FontSelector();
                Font f1 = FontFactory.GetFont(FontFactory.TIMES_BOLD, 12);
                f1.Color = BaseColor.DARK_GRAY;

                // Header Content font. 
                Font f2 = FontFactory.GetFont(FontFactory.HELVETICA_BOLD, 16);
                f1.Color = BaseColor.BLACK;

                // General Text font. 
                Font f3 = FontFactory.GetFont(FontFactory.TIMES, 12);
                f3.Color = BaseColor.DARK_GRAY;


                Paragraph quotelabel = new Paragraph("Sales Quotation", f2);
                quotelabel.Alignment = Element.ALIGN_RIGHT;
                document.Add(quotelabel);

                Paragraph linebreak = new Paragraph(new Chunk(new iTextSharp.text.pdf.draw.LineSeparator(0.0F, 100.0F, BaseColor.BLACK, Element.ALIGN_LEFT, 1)));
                document.Add(linebreak);

                Paragraph quotedate = new Paragraph("Date: " + DateTime.Today.ToString("dd-MM-yyyy"), f3);
                quotedate.Alignment = Element.ALIGN_RIGHT;
                document.Add(quotedate);

                Paragraph quotenum = new Paragraph("Quotation Number: " + customerquoteid, f3);
                quotenum.Alignment = Element.ALIGN_RIGHT;
                document.Add(quotenum);

                

                DataTable dt = new DataTable();
                dt = VPCRMSBAL.GetCompanyName(Convert.ToDecimal(HttpContext.Current.Session["UserID"].ToString().Trim().Substring(0, 4)));
                if (dt.Rows.Count > 0)
                {
                    Paragraph para1 = new Paragraph(dt.Rows[0]["clientname"].ToString().Trim(), f1);
                    para1.Alignment = Element.ALIGN_LEFT;
                    document.Add(para1);
                    Paragraph para1a = new Paragraph(dt.Rows[0]["clientaddress1"].ToString().Trim(), f3);
                    para1.Alignment = Element.ALIGN_LEFT;
                    document.Add(para1a);
                    Paragraph para1b = new Paragraph(dt.Rows[0]["clientcontactno1"].ToString().Trim(), f3);
                    para1b.Alignment = Element.ALIGN_LEFT;
                    document.Add(para1b);
                    para1b.SpacingAfter = 50f;
                }

                Paragraph para5 = new Paragraph();
                Phrase phrase51 = new Phrase("To, ", f3);
                para5.SpacingBefore = 50f;
                para5.Add(phrase51);
                document.Add(para5);

                DataTable dataTable = new DataTable();
                dataTable = VPCRMSBAL.GetQuotationDetailsbyID(Convert.ToDecimal(customerquoteid));
                if (dataTable.Rows.Count > 0)
                {
                    Paragraph phrase52 = new Paragraph(dataTable.Rows[0]["Customer Name"].ToString().Trim() + ",", f1);
                    document.Add(phrase52);

                    Paragraph phrase53 = new Paragraph(dataTable.Rows[0]["Customer Address Line 1"].ToString().Trim() + ",", f3);
                    document.Add(phrase53);
                    Paragraph phrase54 = new Paragraph(dataTable.Rows[0]["Customer Address Line 2"].ToString().Trim() + ",", f3);
                    document.Add(phrase54);
                    Paragraph phrase55 = new Paragraph(dataTable.Rows[0]["Customer City"].ToString().Trim() + " " + dataTable.Rows[0]["Customer District"].ToString().Trim() + ",", f3);
                    document.Add(phrase55);
                    Paragraph phrase56 = new Paragraph(dataTable.Rows[0]["Customer State"].ToString().Trim() + " " + dataTable.Rows[0]["Customer Country"].ToString().Trim() + ",", f3);
                    document.Add(phrase56);
                    Paragraph phrase57 = new Paragraph(dataTable.Rows[0]["Customer Pincode"].ToString().Trim(), f3);
                    document.Add(phrase57);
                    
                    Paragraph phrase41 = new Paragraph("Dear Sir/Madam,", f3);
                    phrase41.SpacingBefore = 50f;
                    document.Add(phrase41);
                    Paragraph phrase42 = new Paragraph("Please see requested quotation details as per below.", f3);
                    phrase42.SpacingAfter = 50f;
                    document.Add(phrase42);
            
                    //PdfPTable table = new PdfPTable(dataTable.Columns.Count);
                    PdfPTable table = new PdfPTable(4);
                    table.WidthPercentage = 100;

                    //Set columns names in the pdf file
                    //for (int k = 0; k < dataTable.Columns.Count; k++)
                    for (int k = 12; k < dataTable.Columns.Count; k++)
                    {
                        PdfPCell cell = new PdfPCell(new Phrase(dataTable.Columns[k].ColumnName));

                        cell.HorizontalAlignment = PdfPCell.ALIGN_CENTER;
                        cell.VerticalAlignment = PdfPCell.ALIGN_CENTER;
                        //cell.BackgroundColor = new iTextSharp.text.BaseColor(51, 102, 102);
                    
                        table.AddCell(cell);
                    }

                    //Add values of DataTable in pdf file
                    for (int i = 0; i < dataTable.Rows.Count; i++)
                    {
                        //for (int j = 0; j < dataTable.Columns.Count; j++)
                        for (int j = 12; j < dataTable.Columns.Count; j++)
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

                document.AddAuthor("VPCRMS");
                document.AddCreator("VP Consultancy Services");
                document.AddTitle("Quotation");
                
                document.Close();
            }
            catch (Exception ex)
            {
                ILog logger = log4net.LogManager.GetLogger("ErrorLog");
                logger.Error(ex.ToString());
            }
        return client_alias;
    }


    [WebMethod]
    public static string GetQuotationDetails()
    {
        // HttpContext is used here to access non static variable Session inside static method. 
        DataTable dtQuotationDetails = new DataTable();
        decimal client_alias = Convert.ToDecimal(HttpContext.Current.Session["UserID"].ToString().Trim().Substring(0, 4));
        dtQuotationDetails = VPCRMSBAL.GetQuotationDetails(Convert.ToDecimal(HttpContext.Current.Session["UserID"]), Convert.ToString(HttpContext.Current.Session["UserRole"]));
        String json = DataTableToJSONWithJavaScriptSerializer(dtQuotationDetails);

        return json;
    }

    public static string DataTableToJSONWithJavaScriptSerializer(DataTable table)
    {
        JavaScriptSerializer jsSerializer = new JavaScriptSerializer();
        List<Dictionary<string, object>> parentRow = new List<Dictionary<string, object>>();
        Dictionary<string, object> childRow;
        foreach (DataRow row in table.Rows)
        {
            childRow = new Dictionary<string, object>();
            foreach (DataColumn col in table.Columns)
            {
                childRow.Add(col.ColumnName, row[col]);
            }
            parentRow.Add(childRow);
        }
        return jsSerializer.Serialize(parentRow);
    }
}
