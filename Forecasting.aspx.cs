// Copyright (c) 2017 VP Consultancy Services. 
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
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Forecasting : System.Web.UI.Page
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
        decimal client_alias = Convert.ToDecimal(Convert.ToDecimal(Session["UserID"].ToString().Trim().Substring(0, 4)));
        // Populate Assigned to dropdown on modal. 
        DataTable dtUserTable = new DataTable();
        dtUserTable = VPCRMSBAL.GetUserList(client_alias);
        if (dtUserTable.Rows.Count > 0)
        {
            ddlassignedto.DataSource = dtUserTable;
            ddlassignedto.DataTextField = "clientuserfirstname";
            ddlassignedto.DataValueField = "clientuserid";
            ddlassignedto.DataBind();
            ddlassignedto.Items.Insert(0, new ListItem("Select Assign Person", ""));
            ddlassignedto.SelectedIndex = 0;
        }


        //grdForecasting.Visible = false;
        // Get Company Name
        DataTable dtTable = new DataTable();
        dtTable = VPCRMSBAL.GetCompanyName(Convert.ToDecimal(Session["UserID"].ToString().Trim().Substring(0, 4)));
        if (dtTable.Rows.Count > 0)
        {
            lblCompanyName.Text = dtTable.Rows[0]["clientname"].ToString();

        }
        else
        {
            lblCompanyName.Text = "Default Company";
        }
    }

    [WebMethod]
    public static string GetForecastingReportDetails(String status, String assignedto)
    
    {
        Decimal client_alias = Convert.ToDecimal(HttpContext.Current.Session["UserID"].ToString().Trim().Substring(0, 4));
        assignedto = (String.IsNullOrEmpty(assignedto) ? "0" : assignedto);
        
        DataTable dt = VPCRMSBAL.GetForecastingReportDetails(client_alias, status, Convert.ToDecimal(assignedto));
        String json = DataTableToJSONWithJavaScriptSerializer(dt);
        return json;
    }

    [WebMethod]
    public static string GetForecastingChartDetails(String status, String assignedto)
    {
        Decimal client_alias = Convert.ToDecimal(HttpContext.Current.Session["UserID"].ToString().Trim().Substring(0, 4));
        assignedto = (String.IsNullOrEmpty(assignedto) ? "0" : assignedto);
        DataTable dt = VPCRMSBAL.GetForecastingChartDetails(client_alias, status, Convert.ToDecimal(assignedto));
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