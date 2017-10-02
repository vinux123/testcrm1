using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.Services;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;

public partial class DailyCallReport : System.Web.UI.Page
{
    private VPCRMSBAL VPCRMSBAL = new VPCRMSBAL();

    protected void Page_Load(object sender, EventArgs e)
    {
        DataTable dtLogin = new DataTable();
        dtLogin = VPCRMSBAL.GetDailyCallReportDetails(Convert.ToDecimal(Session["UserID"]));
        grdDCR.DataSource = dtLogin;
        grdDCR.DataBind();

        DataTable dtTable = new DataTable();
        
        // change alias param of below step .. hardcoded for testing as of now. 
        dtTable = VPCRMSBAL.GetCompanyName(1);
        if (dtTable.Rows.Count > 0)
        {
            lblModalCompanyName.Text = dtTable.Rows[0]["clientname"].ToString();
            lblCompanyName.Text = dtTable.Rows[0]["clientname"].ToString();
            
        }
        else
        {
            lblCompanyName.Text = "Default Name";
        }
    }

    [WebMethod]
    public static void SaveDCR(String clientdate, String company, String firstname, String occupation, String primarycontact, String website, String erevenue, String followupdate,
        String companyadd1, String companyadd2, String addresscity, String addressdist, String addressstate, String addresscountry, String pincode, String remarks, String assignedto,
        String companytype, String lastname, String email, String alternatecontact, String status, String source, String saddress1, String saddress2, String scity, String sdistrict,
        String sstate, String scountry, String spincode)
    {
        VPCRMSDAL.SaveDCR(clientdate, company, firstname, occupation, primarycontact, website, Convert.ToDecimal(erevenue), followupdate,
        companyadd1,  companyadd2,  addresscity,  addressdist,  addressstate,  addresscountry, Convert.ToDecimal(pincode), remarks, Convert.ToDecimal(assignedto),
        companytype,  lastname, email, Convert.ToDecimal(alternatecontact), status, source, saddress1,  saddress2,  scity,  sdistrict,
        sstate,  scountry,  Convert.ToDecimal(spincode));
        
        
        
    }

    [WebMethod]
    public static string EditDCRDetails(String ClientCustomerID)
    {
        DataTable dt = VPCRMSBAL.GetEditDCRDetails(Convert.ToDecimal(ClientCustomerID));
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