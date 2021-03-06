﻿// Copyright (c) 2017 VP Consultancy Services. 
// 
// Permission to use, copy, modify, and distribute this software for given
// purpose with or without fee is hereby granted, provided that the above
// copyright notice and this permission notice appear in all copies & with 
// written consent of original VP Consultancy Services. 
//


using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UserMaster : System.Web.UI.Page
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

        if ((Session["UserRole"].ToString().Trim()) != "Manager" )
        {
            Response.Redirect("Dashboard.aspx");
        }

        // Get client alias. 
        decimal client_alias = Convert.ToDecimal(Session["UserID"].ToString().Trim().Substring(0, 4));

        // Get company name.
        DataTable dtTable = new DataTable();
        dtTable = VPCRMSBAL.GetCompanyName(client_alias);
        if (dtTable.Rows.Count > 0)
        {
            lblCompanyName.Text = dtTable.Rows[0]["clientname"].ToString();
            lblModalCompanyName.Text = dtTable.Rows[0]["clientname"].ToString();
        }
        else
        {
            lblCompanyName.Text = "Default Name";
            
        }

        
        
    }
    [WebMethod]
    public static string CheckMaxAllowedUsers()
    {
        VPCRMSBAL VPCRMSBAL = new VPCRMSBAL();
        decimal client_alias = Convert.ToDecimal(HttpContext.Current.Session["UserID"].ToString().Trim().Substring(0, 4));
        DataTable dtAllowedUsers = new DataTable();
        dtAllowedUsers = VPCRMSBAL.GetMaxAllowedUsers(client_alias);
        if (Convert.ToDecimal(dtAllowedUsers.Rows[0]["current_user_count"]) >= Convert.ToDecimal(dtAllowedUsers.Rows[0]["allowed_users"]))
        {
            return "Yes";
        }
        else
        {
            return "No";
        }

    }

    [WebMethod]
    public static string GetUserDetails()
    {
        DataTable dtUserDetails = VPCRMSBAL.GetUsersDetails();
        String json = DataTableToJSONWithJavaScriptSerializer(dtUserDetails);
        return json;
    }


    [WebMethod]
    public static void SaveUserData(String username, String password, String repassword, String firstname, String lastname, String doj, String contactno, String emailid, String role, String mode, String userid)
    {
        
        decimal alias = Convert.ToDecimal(HttpContext.Current.Session["UserID"].ToString().Trim().Substring(0, 4));

        string hashedpassword = String.Empty;

        // IN Edit mode, if password is not passed in modal update, do not compute hash and pass password field as blank. 
        // Stored procedure handled blank password condition. 
        if (!String.IsNullOrEmpty(password))
        {
            string sltforpwd = BCrypt.GenerateSalt(10);
            hashedpassword = BCrypt.HashPassword(password, sltforpwd);
        }
                        
        VPCRMSBAL.SaveUserDetails(alias, username, hashedpassword, firstname, lastname, doj, Convert.ToDecimal(contactno), emailid, role, "N", mode, userid);

    }

    [WebMethod]
    public static string CheckUserName(String username)
    {
        DataTable dt = VPCRMSBAL.CheckUserName(username);
        String json = DataTableToJSONWithJavaScriptSerializer(dt);
        return json;
    }

    [WebMethod]
    public static string EditUserData(String userid)
    {
        DataTable dt = VPCRMSBAL.GetUserDetails(Convert.ToDecimal(userid));
        String json = DataTableToJSONWithJavaScriptSerializer(dt);
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