using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class testdcr : System.Web.UI.Page
{
    private VPCRMSBAL VPCRMSBAL = new VPCRMSBAL();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] == null)
        {
            Response.Redirect("Login.aspx");
        }

        decimal client_alias = Convert.ToDecimal(Convert.ToDecimal(Session["UserID"].ToString().Trim().Substring(0, 4)));

        DataTable dtLogin = new DataTable();
        dtLogin = VPCRMSBAL.GetDailyCallReportDetails(Convert.ToDecimal(Session["UserID"]), Convert.ToString(Session["UserRole"].ToString().Trim()));
        grdDCR.DataSource = dtLogin;
        grdDCR.DataBind();

        // Get Company Name
        DataTable dtTable = new DataTable();
        dtTable = VPCRMSBAL.GetCompanyName(Convert.ToDecimal(Session["UserID"].ToString().Trim().Substring(0, 4)));
        if (dtTable.Rows.Count > 0)
        {
            lblModalCompanyName.Text = dtTable.Rows[0]["clientname"].ToString();
            lblQuotModalCompanyName.Text = dtTable.Rows[0]["clientname"].ToString();
            lblCompanyName.Text = dtTable.Rows[0]["clientname"].ToString();

        }
        else
        {
            lblCompanyName.Text = "Default Name";
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

            
        }

        // Populate Assigned to dropdown on modal. 
        DataTable dtUserTable = new DataTable();
        dtUserTable = VPCRMSBAL.GetUserList(client_alias);
        if (dtUserTable.Rows.Count > 0)
        {
            ddlassignedto.DataSource = dtUserTable;
            ddlassignedto.DataTextField = "clientuserfirstname";
            ddlassignedto.DataValueField = "clientuserid";
            ddlassignedto.DataBind();
            ddlassignedto.Items.Insert(0, new ListItem("Select Assign Person", "0"));
            ddlassignedto.SelectedIndex = 0;

            ddlcustomeruser.DataSource = dtUserTable;
            ddlcustomeruser.DataTextField = "clientuserfirstname";
            ddlcustomeruser.DataValueField = "clientuserid";
            ddlcustomeruser.DataBind();
            ddlcustomeruser.Items.Insert(0, new ListItem("Select Customer", "0"));
            ddlcustomeruser.SelectedIndex = 0;
        }

        
    }

    protected void calculate_gst(object sender, EventArgs e)
    {

        decimal quotedamt = Convert.ToDecimal(Convert.ToString(txtquoteamt.Text));
        decimal totalamt = (quotedamt * 18 / 100) + quotedamt;
        txttotalamount.Text = Convert.ToString(totalamt);
        //txttotalamt.Text = Convert.ToString(totalamt);
        //txttotalamt.Text = "testing";
        //txttotalamount.Text = "testing";
    }

    [WebMethod]
    public static void SaveDCR(String clientdate, String company, String firstname, String occupation, String primarycontact, String website, String erevenue, String followupdate,
        String companyadd1, String companyadd2, String addresscity, String addressdist, String addressstate, String addresscountry, String pincode, String remarks, String assignedto,
        String companytype, String lastname, String email, String alternatecontact, String status, String source, String saddress1, String saddress2, String scity, String sdistrict,
        String sstate, String scountry, String spincode, String Mode, String clientcustomerid)
    {
        VPCRMSBAL.SaveDCR(clientdate, company, firstname, occupation, primarycontact, website, Convert.ToDecimal(erevenue), followupdate,
        companyadd1, companyadd2, addresscity, addressdist, addressstate, addresscountry, Convert.ToDecimal(pincode), remarks, Convert.ToDecimal(assignedto),
        companytype, lastname, email, Convert.ToDecimal(alternatecontact), status, source, saddress1, saddress2, scity, sdistrict,
        sstate, scountry, Convert.ToDecimal(spincode), Mode, Convert.ToDecimal(clientcustomerid));
        
    }

    [WebMethod]
    public static void SaveQuotationDetails(String clientcustid, String customeruser, String quotedprod, String quoteqty, String quoteprice, String quoteamt)
    {
        VPCRMSBAL.SaveQuotationData(Convert.ToDecimal(clientcustid), VPCRMSDAL.AssignQuoteID(), Convert.ToDecimal(customeruser), quotedprod, Convert.ToDecimal(quoteqty), Convert.ToDecimal(quoteprice), Convert.ToDecimal(quoteamt));
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