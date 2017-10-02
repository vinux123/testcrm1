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

    [WebMethod]
    public static void SaveUserData(String userid, String username, String password, String repassword, String firstname, String lastname, String doj, String contactno, String emailid, String role)
    {
        // change this alias logic, fetch it from userid 
        decimal alias = 1;

        //string sltforpwd = username.Substring(0, 2) + doj.Substring(8,2);
        string sltforpwd = BCrypt.GenerateSalt(10);
        string hashedpassword = BCrypt.HashPassword(password, sltforpwd);
        
        //VPCRMSBAL.SaveUserDetails(alias, Convert.ToDecimal(userid), username, password, firstname, lastname, doj, Convert.ToDecimal(contactno), emailid, role);
        VPCRMSBAL.SaveUserDetails(alias, Convert.ToDecimal(userid), username, hashedpassword, firstname, lastname, doj, Convert.ToDecimal(contactno), emailid, role);

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