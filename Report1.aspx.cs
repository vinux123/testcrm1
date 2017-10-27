// Copyright (c) 2017 VP Consultancy Services. 
// 
// Permission to use, copy, modify, and distribute this software for given
// purpose with or without fee is hereby granted, provided that the above
// copyright notice and this permission notice appear in all copies & with 
// written consent of original VP Consultancy Services. 
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

public partial class Report1 : System.Web.UI.Page
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

        decimal client_alias = Convert.ToDecimal(Session["UserID"].ToString().Trim().Substring(0, 4));

        DataTable dtTable = new DataTable();

        dtTable = VPCRMSBAL.GetCompanyName(client_alias);
        if (dtTable.Rows.Count > 0)
        {
            lblCompanyName.Text = dtTable.Rows[0]["clientname"].ToString();
        }
        else
        {
            lblCompanyName.Text = "Default Name";
        }

    }

    protected void btnGenerate_Click(object sender, EventArgs e)
    {
        string path = Server.MapPath("PDF-Files");
        string filename = path + "/Report1.pdf";
        

        DataTable dt = new DataTable();
        dt = VPCRMSBAL.GetReportData("2017-10-01", "2017-10-30", Convert.ToDecimal(Session["UserID"].ToString().Trim()), Session["UserRole"].ToString().Trim());
        
        ExportToPdf(dt);

        displaypdf.Visible = true;
        displaypdf.FilePath = @"~/PDF-Files/Report1.pdf";

    }

    protected void btnGenerateSalesDetails_Click(object sender, EventArgs e)
    {
        string path1 = Server.MapPath("PDF-Files");
        string filename1 = path1 + "/Report2.pdf";

        DataTable dt = new DataTable();
        dt = VPCRMSBAL.GetReportDataSalesDetails("2017-10-01", "2017-10-30", Convert.ToDecimal(Session["UserID"].ToString().Trim()), Session["UserRole"].ToString().Trim(), "All");

        ExportToPdfSalesDetails(dt);

        displaypdf2.Visible = true;
        displaypdf2.FilePath = @"~/PDF-Files/Report2.pdf";
    }


    protected void btnSend_Click(object sender, EventArgs e)
    {
        string path = Server.MapPath("PDF-Files");
        string filename = path + "/Report1.pdf";

        

        DataTable dt = new DataTable();
        dt = VPCRMSBAL.GetReportData("2017-10-01", "2017-10-30", Convert.ToDecimal(Session["UserID"].ToString().Trim()), Session["UserRole"].ToString().Trim());

        ExportToPdf(dt);

        SendMail();
        

    }

    protected void btnSendSalesDetails_Click(object sender, EventArgs e)
    {
    }


    public void ExportToPdfSalesDetails(DataTable dataTable)
    {
        string path = Server.MapPath("PDF-Files");
        string filename = path + "/Report2.pdf";

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
            dt = VPCRMSBAL.GetCompanyName(Convert.ToDecimal(Session["UserID"].ToString().Trim().Substring(0, 4)));
            if (dt.Rows.Count > 0)
            {
                Paragraph para1 = new Paragraph(dt.Rows[0]["clientname"].ToString().Trim(), f2);
                para1.Alignment = Element.ALIGN_CENTER;
                document.Add(para1);
                para1.SpacingAfter = 50f;
            }
            //Paragraph para1 = new Paragraph("Company Name", f2);


            Paragraph para2 = new Paragraph();
            Phrase phrase1 = new Phrase("SALES DETAILS", f1);

            para2.Alignment = Element.ALIGN_LEFT;
            para2.Add(phrase1);
            document.Add(para2);

            Paragraph para3 = new Paragraph();
            Phrase phrase2 = new Phrase("Sales Person: ");
            Phrase phrase3 = new Phrase(Session["UserFirstName"].ToString().Trim() + ' ' + Session["UserLastName"].ToString().Trim());
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
            Response.Redirect("ErrorPage.aspx");
        }
    }

    public void ExportToPdf(DataTable dataTable)
    {
        string path = Server.MapPath("PDF-Files");
        string filename = path + "/Report1.pdf";

        Document document = new Document(new Rectangle(288f,144f), 30, 20, 20, 20);
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
            dt = VPCRMSBAL.GetCompanyName(Convert.ToDecimal(Session["UserID"].ToString().Trim().Substring(0, 4)));
            if (dt.Rows.Count > 0)
            {
                Paragraph para1 = new Paragraph(dt.Rows[0]["clientname"].ToString().Trim(), f2);
                para1.Alignment = Element.ALIGN_CENTER;
                document.Add(para1);
                para1.SpacingAfter = 50f;
            }
            //Paragraph para1 = new Paragraph("Company Name", f2);


            Paragraph para2 = new Paragraph();
            Phrase phrase1 = new Phrase("DAILY SALES STATISTICS", f1);

            para2.Alignment = Element.ALIGN_LEFT;
            para2.Add(phrase1);
            document.Add(para2);

            Paragraph para3 = new Paragraph();
            Phrase phrase2 = new Phrase("Sales Person: ");
            Phrase phrase3 = new Phrase(Session["UserFirstName"].ToString().Trim() + Session["UserLastName"].ToString().Trim());
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
            Response.Redirect("ErrorPage.aspx");
        }
    }

    public void SendMail()
    {
        string path = Server.MapPath("PDF-Files");
        string filename = path + "/Report1.pdf";

        
        DataTable dtTable = new DataTable();
        decimal client_alias = Convert.ToDecimal(Session["UserID"].ToString().Trim().Substring(0,4));
        
        dtTable = VPCRMSBAL.GetCompanyName(client_alias);
        if (dtTable.Rows.Count > 0)
        {
            string host = dtTable.Rows[0]["clientsmtphost"].ToString().Trim();
            string port = dtTable.Rows[0]["clientsmtpport"].ToString().Trim();
            string sslenabled = dtTable.Rows[0]["clientsmtpenablessl"].ToString().Trim();
            string smtpuname = dtTable.Rows[0]["clientsmtpusername"].ToString().Trim();
            string smtppwd = dtTable.Rows[0]["clientsmtppassword"].ToString().Trim();

            System.Net.Mail.MailMessage mm = new System.Net.Mail.MailMessage();
            mm.To.Add(new System.Net.Mail.MailAddress("kulkarnivd1989@gmail.com", "Vinayak Kulkarni"));
            mm.From = new System.Net.Mail.MailAddress(smtpuname);
            mm.Sender = new System.Net.Mail.MailAddress(smtpuname, "Vinayak Kulkarni");
            mm.Subject = "This is Test Email";
            mm.Body = "<h3>This is Testing SMTP Mail Send By Me</h3>";
            mm.IsBodyHtml = true;
            mm.Priority = System.Net.Mail.MailPriority.High; // Set Priority to sending mail
            mm.Attachments.Add(new Attachment(filename));

            SmtpClient smtCliend = new SmtpClient();
            smtCliend.Host = host;
            smtCliend.Port = Convert.ToInt32(port);
            smtCliend.UseDefaultCredentials = false;
            smtCliend.EnableSsl = true;
            smtCliend.DeliveryMethod = System.Net.Mail.SmtpDeliveryMethod.Network;
                    
            smtCliend.Credentials = new NetworkCredential(smtpuname, smtppwd);

            try
            {
                smtCliend.Send(mm);
            }
            catch (System.Net.Mail.SmtpException ex)
            {
                ILog logger = log4net.LogManager.GetLogger("ErrorLog");
                logger.Error(ex.ToString());
                Response.Redirect("ErrorPage.aspx");
            }
            catch (Exception exe)
            {
                ILog logger = log4net.LogManager.GetLogger("ErrorLog");
                logger.Error(exe.ToString());
                Response.Redirect("ErrorPage.aspx");
            }
        }

    }
}

