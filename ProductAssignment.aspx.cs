using log4net;
using System;
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
        if (Session["UserID"] == null)
        {
            Response.Redirect("Login.aspx");
        }

        //Get Client alias from UserID
        decimal client_alias = Convert.ToDecimal(Session["UserID"].ToString().Substring(0, 4));

        DataTable dtLogin = new DataTable();
        // Since this is admin specific page, not client alias is required to pass to below method. 
        dtLogin = VPCRMSBAL.GetProductAssignment();
        grdProductAssignment.DataSource = dtLogin;
        grdProductAssignment.DataBind();

        // Populate Assigned to dropdown on modal. 
        DataTable dtUserTable = new DataTable();
        dtUserTable = VPCRMSBAL.GetUserList(client_alias);
        if (dtUserTable.Rows.Count > 0)
        {
            ddlusername.DataSource = dtUserTable;
            ddlusername.DataTextField = "clientuserfirstname";
            ddlusername.DataValueField = "clientuserid";
            ddlusername.DataBind();
            ddlusername.Items.Insert(0, new ListItem("Select Assign Person", "0"));
            ddlusername.SelectedIndex = 0;
        }

        // Populate Product Name to dropdown on modal. 
        DataTable dtProdTable = new DataTable();
        dtProdTable = VPCRMSBAL.GetProductList(client_alias);
        if (dtProdTable.Rows.Count > 0)
        {
            ddlProductName.DataSource = dtProdTable;
            ddlProductName.DataValueField = "productname";
            ddlProductName.DataValueField = "productname";
            ddlProductName.DataBind();
            ddlProductName.Items.Insert(0, new ListItem("Select Product", "0"));
            ddlProductName.SelectedIndex = 0;
        }


        DataTable dtTable = new DataTable();
        // change alias param of below step .. hardcoded for testing as of now. 
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
    public static void SaveProdAssignment(String username, String prodname, String prodamttgt, String prodqtytgt, String prodtgtmth, String prodtgtyr)
    {
        try
        {
            VPCRMSBAL.SaveProdAssignment(Convert.ToDecimal(username), prodname, Convert.ToDecimal(prodamttgt), Convert.ToDecimal(prodqtytgt), prodtgtmth, prodtgtyr);
        }
        catch (Exception ex)
        {
            ILog logger = log4net.LogManager.GetLogger("ErrorLog");
            logger.Error(ex.ToString());
            HttpContext.Current.Response.Redirect("ErrorPage.aspx");
        }

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