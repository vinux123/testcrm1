using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Quotation : System.Web.UI.Page
{
    private VPCRMSBAL VPCRMSBAL = new VPCRMSBAL();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] == null)
        {
            Response.Redirect("Login.aspx");
        }

        DataTable dtLogin = new DataTable();
        dtLogin = VPCRMSBAL.GetQuotationDetails(Convert.ToDecimal(Session["UserID"]));
        grdQuotation.DataSource = dtLogin;
        grdQuotation.DataBind();

        DataTable dtTable = new DataTable();
        dtTable = VPCRMSBAL.GetCompanyName(Convert.ToDecimal(Session["UserID"].ToString().Trim().Substring(0, 4)));
        if (dtTable.Rows.Count > 0)
        {
            lblCompanyName.Text = dtTable.Rows[0]["clientname"].ToString();
        }
        else
        {
            lblCompanyName.Text = "Default Name";
        }
    }
}