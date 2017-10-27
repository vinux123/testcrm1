// Copyright (c) 2017 VP Consultancy Services. 
// 
// Permission to use, copy, modify, and distribute this software for given
// purpose with or without fee is hereby granted, provided that the above
// copyright notice and this permission notice appear in all copies & with 
// written consent of original VP Consultancy Services. 
//


using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
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

    }
    protected void btnchgpwd_Click(object sender, EventArgs e)
    {
        lblErrorMesage.Text = "";

        if (txtpassword1.Text.ToString().Trim() == txtpassword2.Text.ToString().Trim())
        {
            decimal alias = Convert.ToDecimal(HttpContext.Current.Session["UserID"].ToString().Trim().Substring(0, 4));

            string sltforpwd = BCrypt.GenerateSalt(10);
            string hashedpassword = BCrypt.HashPassword(txtpassword1.Text.ToString().Trim(), sltforpwd);

            decimal userid = Convert.ToDecimal(Session["UserID"].ToString().Trim());

            try
            {
                VPCRMSBAL.UdpateUserPassword(alias, userid, hashedpassword);
                lblErrorMesage.Text = "Success. You will be redirected to Login.";
                Response.Redirect("Login.aspx");
            }

            catch
            {

            }

    
        }
    }
}