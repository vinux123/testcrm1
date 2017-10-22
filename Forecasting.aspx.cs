using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    private VPCRMSBAL VPCRMSBAL = new VPCRMSBAL();
    protected void Page_Load(object sender, EventArgs e)
    {
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
            ddlassignedto.Items.Insert(0, new ListItem("Select Assign Person", "0"));
            ddlassignedto.SelectedIndex = 0;
        }


        grdForecasting.Visible = false;
        // Get Company Name
        DataTable dtTable = new DataTable();
        dtTable = VPCRMSBAL.GetCompanyName(Convert.ToDecimal(Session["UserID"].ToString().Trim().Substring(0, 4)));
        if (dtTable.Rows.Count > 0)
        {
            lblCompanyName.Text = dtTable.Rows[0]["clientname"].ToString();

        }
    }

    protected void btnShow_Click(object sender, EventArgs e)
    {
        DataTable dtLogin = new DataTable();
        grdForecasting.Visible = true;
        dtLogin = VPCRMSBAL.GetDailyCallReportDetails(Convert.ToDecimal(Session["UserID"]), Convert.ToString(Session["UserRole"].ToString().Trim()));
        grdForecasting.DataSource = dtLogin;
        grdForecasting.DataBind();

    }
}