﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.Web.Services;

public partial class Dashboard : System.Web.UI.Page
{
    private VPCRMSBAL VPCRMSBAL = new VPCRMSBAL();
    static DataTable dtCount;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] == null)
        {
            Response.Redirect("Login.aspx");
        }

        dtCount = VPCRMSBAL.GetStatusCount(Convert.ToDecimal(Session["UserID"].ToString()), Convert.ToString(Session["UserRole"]));
    }

    [WebMethod]
    public static string GetMonthlyData()
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("Type", Type.GetType("System.String"));
        dt.Columns.Add("Count", Type.GetType("System.Int32"));

        DataRow drNew = dt.NewRow();
        drNew[0] = "Prospect";
        drNew[1] = dtCount.Rows[0]["ProspectCountMonthly"];
        dt.Rows.Add(drNew);

        DataRow drNew1 = dt.NewRow();
        drNew1[0] = "Qualified";
        drNew1[1] = dtCount.Rows[0]["QualifiedCountMonthly"];
        dt.Rows.Add(drNew1);

        DataRow drNew2 = dt.NewRow();
        drNew2[0] = "Junk";
        drNew2[1] = dtCount.Rows[0]["JunkCountMonthly"];
        dt.Rows.Add(drNew2);
        
        String json = DataTableToJSONWithJavaScriptSerializer(dt);
        return json;
    }

    [WebMethod]
    public static string GetHalfYearlyData()
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("Type", Type.GetType("System.String"));
        dt.Columns.Add("Count", Type.GetType("System.Int32"));

        DataRow drNew = dt.NewRow();
        drNew[0] = "Prospect";
        drNew[1] = dtCount.Rows[0]["ProspectCountHly"];
        dt.Rows.Add(drNew);

        DataRow drNew1 = dt.NewRow();
        drNew1[0] = "Qualified";
        drNew1[1] = dtCount.Rows[0]["QualifiedCountHly"];
        dt.Rows.Add(drNew1);

        DataRow drNew2 = dt.NewRow();
        drNew2[0] = "Junk";
        drNew2[1] = dtCount.Rows[0]["JunkCountHly"];
        dt.Rows.Add(drNew2);

        String json = DataTableToJSONWithJavaScriptSerializer(dt);
        return json;
    }

    [WebMethod]
    public static string GetYearlyData()
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("Type", Type.GetType("System.String"));
        dt.Columns.Add("Count", Type.GetType("System.Int32"));

        DataRow drNew = dt.NewRow();
        drNew[0] = "Prospect";
        drNew[1] = dtCount.Rows[0]["ProspectCountYearly"];
        dt.Rows.Add(drNew);

        DataRow drNew1 = dt.NewRow();
        drNew1[0] = "Qualified";
        drNew1[1] = dtCount.Rows[0]["QualifiedCountYearly"];
        dt.Rows.Add(drNew1);

        DataRow drNew2 = dt.NewRow();
        drNew2[0] = "Junk";
        drNew2[1] = dtCount.Rows[0]["JunkCountYearly"];
        dt.Rows.Add(drNew2);

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