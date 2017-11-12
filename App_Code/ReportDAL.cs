
// Copyright (c) 2017 VP Consultancy Services. 
// 
// Permission to use, copy, modify, and distribute this software for given
// purpose with or without fee is hereby granted, provided that the above
// copyright notice and this permission notice appear in all copies & with 
// written approval of original VP Consultancy Services. 
//


using iTextSharp.text;
using iTextSharp.text.pdf;
using log4net;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

/// <summary>
/// PDF Formatting & Generation.  
/// </summary>
public class ReportDAL
{
    #region Private Member Functions

    private VPCRMSBAL VPCRMSBAL = new VPCRMSBAL();

    #endregion

    #region Public Member Functions

    public ReportDAL()
	{
		//
		// TODO: Add constructor logic here
		//
    }

    public void Report1ExportToPdf(DataTable dataTable)
    {
        string path = HttpContext.Current.Server.MapPath("PDF-Files");
        string filename = path + "/Report1_" + HttpContext.Current.Session["UserID"].ToString().Trim().Substring(0, 4) + ".pdf";

        Document document = new Document(new Rectangle(288f, 144f), 30, 20, 20, 20);
        document.SetPageSize(iTextSharp.text.PageSize.A4.Rotate());

        try
        {
            PdfWriter writer = PdfWriter.GetInstance(document, new FileStream(filename, FileMode.Create));
            document.Open();

            BaseFont header = iTextSharp.text.pdf.BaseFont.CreateFont("C:\\windows\\fonts\\timesbd.ttf", BaseFont.IDENTITY_H, BaseFont.EMBEDDED);

            FontSelector selector = new FontSelector();
            Font f1 = FontFactory.GetFont(FontFactory.TIMES_BOLD, 12);
            f1.Color = BaseColor.MAGENTA;

            Font f2 = FontFactory.GetFont(FontFactory.HELVETICA_BOLD, 16);
            f1.Color = BaseColor.RED;

            iTextSharp.text.Font fontHeader = new iTextSharp.text.Font(header, 18, iTextSharp.text.Font.BOLD);

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
            Phrase phrase1 = new Phrase("DAILY SALES STATISTICS", f1);

            para2.Alignment = Element.ALIGN_LEFT;
            para2.Add(phrase1);
            document.Add(para2);

            Paragraph para3 = new Paragraph();
            Phrase phrase2 = new Phrase("Sales Person: ");
            Phrase phrase3 = new Phrase(HttpContext.Current.Session["UserFirstName"].ToString().Trim() + HttpContext.Current.Session["UserLastName"].ToString().Trim());
            para3.Add(phrase2);
            para3.Add(phrase3);
            para3.Alignment = Element.ALIGN_RIGHT;
            para3.SpacingAfter = 50f;
            document.Add(para3);


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
            document.Close();
        }
        catch (Exception ex)
        {
            ILog logger = log4net.LogManager.GetLogger("ErrorLog");
            logger.Error(ex.ToString());
            HttpContext.Current.Response.Redirect("ErrorPage.aspx");
        }
    }

    public void Report2ExportToPdf(DataTable dataTable)
    {
        string path = HttpContext.Current.Server.MapPath("PDF-Files");
        string filename = path + "/Report2_" + HttpContext.Current.Session["UserID"].ToString().Trim().Substring(0, 4) + ".pdf";

        Document document = new Document(new Rectangle(288f, 144f), 30, 20, 20, 20);
        document.SetPageSize(iTextSharp.text.PageSize.A4.Rotate());
        try
        {
            PdfWriter writer = PdfWriter.GetInstance(document, new FileStream(filename, FileMode.Create));
            document.Open();

            BaseFont header = iTextSharp.text.pdf.BaseFont.CreateFont("C:\\windows\\fonts\\timesbd.ttf", BaseFont.IDENTITY_H, BaseFont.EMBEDDED);

            FontSelector selector = new FontSelector();
            Font f1 = FontFactory.GetFont(FontFactory.TIMES_BOLD, 12);
            f1.Color = BaseColor.MAGENTA;

            Font f2 = FontFactory.GetFont(FontFactory.HELVETICA_BOLD, 16);
            f1.Color = BaseColor.RED;

            iTextSharp.text.Font fontHeader = new iTextSharp.text.Font(header, 18, iTextSharp.text.Font.BOLD);

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
            Phrase phrase1 = new Phrase("SALES DETAILS", f1);

            para2.Alignment = Element.ALIGN_LEFT;
            para2.Add(phrase1);
            document.Add(para2);

            Paragraph para3 = new Paragraph();
            Phrase phrase2 = new Phrase("Sales Person: ");
            Phrase phrase3 = new Phrase(HttpContext.Current.Session["UserFirstName"].ToString().Trim() + ' ' + HttpContext.Current.Session["UserLastName"].ToString().Trim());
            para3.Add(phrase2);
            para3.Add(phrase3);
            para3.Alignment = Element.ALIGN_RIGHT;
            para3.SpacingAfter = 50f;
            document.Add(para3);

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
            document.Close();
        }
        catch (Exception ex)
        {
            ILog logger = log4net.LogManager.GetLogger("ErrorLog");
            logger.Error(ex.ToString());
            HttpContext.Current.Response.Redirect("ErrorPage.aspx");
        }
    }

    #endregion
}