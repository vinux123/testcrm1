using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class FollowUp : System.Web.UI.Page
{
    private VPCRMSBAL VPCRMSBAL = new VPCRMSBAL();

    protected void Page_Load(object sender, EventArgs e)
    {
        DataTable dtLogin = new DataTable();
        dtLogin = VPCRMSBAL.GetFollowupDetails(Convert.ToDecimal(Session["UserID"]));
        grdFollowUp.DataSource = dtLogin;
        grdFollowUp.DataBind();

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
}