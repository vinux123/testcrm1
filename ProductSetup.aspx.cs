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

public partial class ProductSetup : System.Web.UI.Page
{
    private VPCRMSBAL VPCRMSBAL = new VPCRMSBAL();
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] == null)
        {
            Response.Redirect("Login.aspx");
        }

        
        //Get Client alias from UserID
        decimal client_alias = Convert.ToDecimal(Session["UserID"].ToString().Trim().Substring(0, 4));

        DataTable dtLogin = new DataTable();
        dtLogin = VPCRMSBAL.GetProductDetails(client_alias);
        grdProduct.DataSource = dtLogin;
        grdProduct.DataBind();

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
            lblModalCompanyName.Text = "Default Name";
        }
    }

    [WebMethod]
    public static void SaveProdData(String prodname, String proddesc, String prodhsn, String prodprice)
    {
        // HttpContext is used here to access non static variable Session inside static method. 
        decimal client_alias = Convert.ToDecimal(HttpContext.Current.Session["UserID"].ToString().Trim().Substring(0,4));
        VPCRMSBAL.SaveProdData(client_alias, prodname, proddesc, prodhsn, prodprice);
    }

    [WebMethod]
    public static string EditProductData(String productname)
    {
        decimal client_alias = Convert.ToDecimal(HttpContext.Current.Session["UserID"].ToString().Trim().Substring(0, 4));
        DataTable dt = VPCRMSBAL.GetEditedProductDetails(client_alias, productname);
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