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
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class VPCRMSMaster : System.Web.UI.MasterPage
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

        lblUserName.Text = Session["UserFirstName"].ToString().TrimEnd() + ' ' + Session["UserLastName"].ToString().TrimEnd();

        string userrole = Session["UserRole"].ToString().Trim();
                
        if ( userrole.Equals("Manager") )
        {
            mnuadmin.Visible = true;
        }
        else
        {
            mnuadmin.Visible = false;
        }
        
    }

    protected void lnkBtnLogout_Click(object sender, EventArgs e)
    {
        Response.Redirect("Login.aspx");
        Session["UserName"] = null;
        Session["UserID"] = null;
        Session["UserFirstName"] = null;
        Session["UserLastName"] = null;
        Session["UserRole"] = null;
        Session["ConnectionStringCRMS"] = null;
        Session.RemoveAll();
        Session.Abandon();
    }
}
