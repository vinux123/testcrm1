using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UserMasterTest : System.Web.UI.Page
{
    private VPCRMSBAL VPCRMSBAL = new VPCRMSBAL();

    protected void Page_Load(object sender, EventArgs e)
    {
        DataTable dtLogin = new DataTable();
        dtLogin = VPCRMSBAL.GetUsersDetails();

        grdUserMaster.DataSource = dtLogin;
        grdUserMaster.DataBind();

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

    //Handles Add record button click in main form
    protected void btnAddUser_Click(object sender, EventArgs e)
    {
        System.Text.StringBuilder sb = new System.Text.StringBuilder();
        sb.Append(@"<script type='text/javascript'>");
        sb.Append("$('#addModal').modal('show');");
        sb.Append(@"</script>");
        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "AddShowModalScript", sb.ToString(), false);

    }

    [WebMethod]
    public static void SaveUserData(String userid, String username, String password, String repassword, String firstname, String lastname, String doj, String contactno, String emailid, String role)
    {
        decimal alias = 1;

        //string sltforpwd = username.Substring(0, 2) + doj.Substring(8,2);
        string sltforpwd = BCrypt.GenerateSalt(10);
        string hashedpassword = BCrypt.HashPassword(password, sltforpwd);

        //VPCRMSBAL.SaveUserDetails(alias, Convert.ToDecimal(userid), username, password, firstname, lastname, doj, Convert.ToDecimal(contactno), emailid, role);
        VPCRMSBAL.SaveUserDetails(alias, Convert.ToDecimal(userid), username, hashedpassword, firstname, lastname, doj, Convert.ToDecimal(contactno), emailid, role);

    }




}