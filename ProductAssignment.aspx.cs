﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ProductAssignment : System.Web.UI.Page
{
    private VPCRMSBAL VPCRMSBAL = new VPCRMSBAL();

    protected void Page_Load(object sender, EventArgs e)
    {
        DataTable dtLogin = new DataTable();
        // change param of below method pass customer alias
        dtLogin = VPCRMSBAL.GetProductAssignment();
        grdProductAssignment.DataSource = dtLogin;
        grdProductAssignment.DataBind();

        // Populate Assigned to dropdown on modal. 
        DataTable dtUserTable = new DataTable();
        dtUserTable = VPCRMSBAL.GetUserList(1);
        if (dtUserTable.Rows.Count > 0)
        {
            ddlusername.DataSource = dtUserTable;
            ddlusername.DataTextField = "clientuserfirstname";
            ddlusername.DataValueField = "clientuserid";
            ddlusername.DataBind();
        }

        // Populate Product Name to dropdown on modal. 
        DataTable dtProdTable = new DataTable();
        dtProdTable = VPCRMSBAL.GetProductList(1);
        if (dtProdTable.Rows.Count > 0)
        {
            ddlProductName.DataSource = dtProdTable;
            ddlProductName.DataValueField = "productname";
            ddlProductName.DataValueField = "productname";
            ddlProductName.DataBind();
        }


        DataTable dtTable = new DataTable();
        // change alias param of below step .. hardcoded for testing as of now. 
        dtTable = VPCRMSBAL.GetCompanyName(1);
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
    public static void SaveProdAssignment(String username, String prodname, String prodamttgt, String prodqtytgt, String prodtgtmth, String prodtgtyr)
    {
        VPCRMSBAL.SaveProdAssignment(Convert.ToDecimal(username), prodname, Convert.ToDecimal(prodamttgt), Convert.ToDecimal(prodqtytgt), prodtgtmth, prodtgtyr);

    }

    [WebMethod]
    public static string EditProductAssignment(String ProdAssignedTo,String productname, String target_month, String target_year)
    {
        DataTable dt = VPCRMSBAL.GetEditedProdAssignments(Convert.ToDecimal(ProdAssignedTo), productname, target_month, target_year);
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