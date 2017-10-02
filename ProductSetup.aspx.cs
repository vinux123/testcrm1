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
        DataTable dtLogin = new DataTable();
        // change param of below method pass customer alias
        dtLogin = VPCRMSBAL.GetProductDetails(1);
        grdProduct.DataSource = dtLogin;
        grdProduct.DataBind();

        DataTable dtTable = new DataTable();
        // change alias param of below step .. hardcoded for testing as of now. 
        dtTable = VPCRMSBAL.GetCompanyName(1);
        if (dtTable.Rows.Count > 0)
        {
            lblCompanyName.Text = dtTable.Rows[0]["clientname"].ToString();
        }
        else
        {
            lblCompanyName.Text = "Default Name";
        }
    }

    [WebMethod]
    public static void SaveProdData(String prodname, String proddesc, String prodhsn, String prodprice)
    {
        decimal alias = 1;

        VPCRMSBAL.SaveProdData(alias, prodname, proddesc, prodhsn, prodprice);

    }

    [WebMethod]
    public static string EditProductData(String productname)
    {
        string userid = "1";
        DataTable dt = VPCRMSBAL.GetEditedProductDetails(Convert.ToDecimal(userid), productname);
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