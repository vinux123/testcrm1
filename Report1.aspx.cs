
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
    private ReportDAL ReportDAL = new ReportDAL();

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
        string filename = path + "/Report1_" + HttpContext.Current.Session["UserID"].ToString().Trim().Substring(0,4) + ".pdf";

        if ( File.Exists(filename) ) // if file exists
        {
            File.Delete(filename); // delete file
        }
        DataTable dt = new DataTable();

        // get daterange values from form. 
        string dates = Convert.ToString(drreportdate.Text);
        string[] fromdate = dates.Substring(0, 10).Split('/');
        string fromdate1 = (DateTime.Parse(string.Format("{0}/{1}/{2}", fromdate[1], fromdate[0], fromdate[2]))).ToString("yyyy-MM-dd"); // convert to database date format. 

        string[] todate = dates.Substring(13, 10).Split('/');
        string todate1 = (DateTime.Parse(string.Format("{0}/{1}/{2}", todate[1], todate[0], todate[2]))).ToString("yyyy-MM-dd"); // convert to database date format. 
        
        dt = VPCRMSBAL.GetReportData(fromdate1, todate1, Convert.ToDecimal(Session["UserID"].ToString().Trim()), Session["UserRole"].ToString().Trim());
        
        ReportDAL.Report1ExportToPdf(dt);  // Generate PDF first. 

        displaypdf.Visible = true;
        displaypdf2.Visible = false;
        displaypdf.FilePath = @"~/PDF-Files/Report1_" + HttpContext.Current.Session["UserID"].ToString().Trim().Substring(0,4) + ".pdf";
    }

    protected void btnGenerateSalesDetails_Click(object sender, EventArgs e)
    {
        string path1 = Server.MapPath("PDF-Files");
        string filename1 = path1 + "/Report2_" + HttpContext.Current.Session["UserID"].ToString().Trim().Substring(0,4) + ".pdf";

        // if file exists delete old report first. 
        if (File.Exists(filename1))
        {
            File.Delete(filename1);
        }

        DataTable dt = new DataTable();
        string dates = Convert.ToString(drreportdate1.Text);

        string[] fromdate = dates.Substring(0, 10).Split('/');
        string fromdate1 = (DateTime.Parse(string.Format("{0}/{1}/{2}", fromdate[1], fromdate[0], fromdate[2]))).ToString("yyyy-MM-dd"); // convert to database date format. 

        string[] todate = dates.Substring(13, 10).Split('/');
        string todate1 = (DateTime.Parse(string.Format("{0}/{1}/{2}", todate[1], todate[0], todate[2]))).ToString("yyyy-MM-dd"); // convert to database date format. 
        dt = VPCRMSBAL.GetReportDataSalesDetails(fromdate1, todate1, Convert.ToDecimal(Session["UserID"].ToString().Trim()), Session["UserRole"].ToString().Trim(), "All");

        ReportDAL.Report2ExportToPdf(dt);

        displaypdf2.Visible = true;
        displaypdf.Visible = false;
        displaypdf2.FilePath = @"~/PDF-Files/Report2_" + HttpContext.Current.Session["UserID"].ToString().Trim().Substring(0,4) + ".pdf";
    }

    protected void btnSend_Click(object sender, EventArgs e)
    {
        string path = Server.MapPath("PDF-Files");
        string filename = path + "/Report1_" + HttpContext.Current.Session["UserID"].ToString().Trim().Substring(0,4) + ".pdf";

        DataTable dt = new DataTable();

        string dates = Convert.ToString(drreportdate.Text);
        string[] fromdate = dates.Substring(0, 10).Split('/');
        string fromdate1 = (DateTime.Parse(string.Format("{0}/{1}/{2}", fromdate[1], fromdate[0], fromdate[2]))).ToString("yyyy-MM-dd"); // convert to database date format. 

        string[] todate = dates.Substring(13, 10).Split('/');
        string todate1 = (DateTime.Parse(string.Format("{0}/{1}/{2}", todate[1], todate[0], todate[2]))).ToString("yyyy-MM-dd"); // convert to database date format. 
        
        dt = VPCRMSBAL.GetReportData(fromdate1, todate1, Convert.ToDecimal(Session["UserID"].ToString().Trim()), Session["UserRole"].ToString().Trim());
        ReportDAL.Report1ExportToPdf(dt);
        if (File.Exists(filename))
        {
            SendMail();
        }
    }

    protected void btnSendSalesDetails_Click(object sender, EventArgs e)
    {
        string path1 = Server.MapPath("PDF-Files");
        string filename1 = path1 + "/Report2_" + HttpContext.Current.Session["UserID"].ToString().Trim().Substring(0, 4) + ".pdf";

        // if file exists delete old report first. 
        if (File.Exists(filename1))
        {
            File.Delete(filename1);
        }

        DataTable dt = new DataTable();
        string dates = Convert.ToString(drreportdate1.Text);

        string[] fromdate = dates.Substring(0, 10).Split('/');
        string fromdate1 = (DateTime.Parse(string.Format("{0}/{1}/{2}", fromdate[1], fromdate[0], fromdate[2]))).ToString("yyyy-MM-dd"); // convert to database date format. 

        string[] todate = dates.Substring(13, 10).Split('/');
        string todate1 = (DateTime.Parse(string.Format("{0}/{1}/{2}", todate[1], todate[0], todate[2]))).ToString("yyyy-MM-dd"); // convert to database date format. 
        dt = VPCRMSBAL.GetReportDataSalesDetails(fromdate1, todate1, Convert.ToDecimal(Session["UserID"].ToString().Trim()), Session["UserRole"].ToString().Trim(), "All");

        ReportDAL.Report2ExportToPdf(dt);  // Generate PDF First. 
        
        SendDetailsMail();
    }

    public void SendMail()
    {
        string path = Server.MapPath("PDF-Files");
        string filename = path + "/Report1_" + HttpContext.Current.Session["UserID"].ToString().Trim().Substring(0, 4) + ".pdf";

        
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

    public void SendDetailsMail()
    {
        string path = Server.MapPath("PDF-Files");
        string filename = path + "/Report2_" + HttpContext.Current.Session["UserID"].ToString().Trim().Substring(0, 4) + ".pdf";


        DataTable dtTable = new DataTable();
        decimal client_alias = Convert.ToDecimal(Session["UserID"].ToString().Trim().Substring(0, 4));

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

