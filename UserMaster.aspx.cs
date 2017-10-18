using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UserMaster : System.Web.UI.Page
{
    private VPCRMSBAL VPCRMSBAL = new VPCRMSBAL();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] == null)
        {
            Response.Redirect("Login.aspx");
        }

        decimal client_alias = Convert.ToDecimal(Session["UserID"].ToString().Trim().Substring(0, 4));

        DataTable dtLogin = new DataTable();
        dtLogin = VPCRMSBAL.GetUsersDetails();
        
        grdUserMaster.DataSource = dtLogin;
        grdUserMaster.DataBind();

        DataTable dtTable = new DataTable();
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

        // uncomment this later
        //DataTable dtAllowedUsers = new DataTable();
        //dtAllowedUsers = VPCRMSBAL.GetMaxAllowedUsers(client_alias);
        //if (Convert.ToDecimal(dtLogin.Rows.Count) >= Convert.ToDecimal(dtAllowedUsers.Rows[0]["noofusers"]))
        //{
        //    btnAddUser.Visible = false;
        //}
        
    }

    [WebMethod]
    public static void SaveUserData(String userid, String username, String password, String repassword, String firstname, String lastname, String doj, String contactno, String emailid, String role)
    {
        
        decimal alias = Convert.ToDecimal(HttpContext.Current.Session["UserID"].ToString().Trim().Substring(0, 4)); 
        
        
        string sltforpwd = BCrypt.GenerateSalt(10);
        string hashedpassword = BCrypt.HashPassword(password, sltforpwd);
        
        VPCRMSBAL.SaveUserDetails(alias, Convert.ToDecimal(userid), username, hashedpassword, firstname, lastname, doj, Convert.ToDecimal(contactno), emailid, role, "N");

    }

    [WebMethod]
    public static string CheckUserName(String username)
    {
        DataTable dt = VPCRMSBAL.CheckUserName(username);
        String json = DataTableToJSONWithJavaScriptSerializer(dt);
        return json;
    }

    [WebMethod]
    public static string EditUserData(String userid)
    {
        DataTable dt = VPCRMSBAL.GetUserDetails(Convert.ToDecimal(userid));
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