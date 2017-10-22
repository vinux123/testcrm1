using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Globalization;


public partial class Login : System.Web.UI.Page
{
    private VPCRMSBAL VPCRMSBAL = new VPCRMSBAL();
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }

    protected void btnlogin_Click(object sender, EventArgs e)
    {
 
        lblErrorMesage.Text = "";
        string strPassword = string.Empty;
                
        try
        {
            // Check User Name exists in database. 
            DataTable dtLogin = new DataTable();
            dtLogin = VPCRMSBAL.GetUserPassword(txtusername.Text.Trim());
            if (dtLogin.Rows.Count > 0)
            {
                string enteredpwd = txtpasswd.Text.Trim();              
                // Check Password. 
                if (BCrypt.CheckPassword(enteredpwd,dtLogin.Rows[0]["clientpassword"].ToString().Trim()).Equals(true))  // check entered password with hashed value from database. 
                {
                    // Check Client whose user logged in is Active or Not. 
                    DataTable dtLogin1 = new DataTable();
                    dtLogin1 = VPCRMSBAL.CheckClientActiveOrNot(Convert.ToDecimal(dtLogin.Rows[0]["clientuserid"].ToString().Trim().Substring(0,4)));
                    DateTime dateTimeToday = DateTime.Today;
                    DateTime clientDateTime;
                    DateTime.TryParse(dtLogin1.Rows[0]["enddate"].ToString().Trim(), out clientDateTime);  // parse string date to DateTime. 

                    if (clientDateTime.Date > dateTimeToday.Date)    // Compare dates, if client expiry date greater than today's date do not allow login. 
                    {
                        if (dtLogin.Rows[0]["clientpwddefault"].ToString().Trim() == "Y")
                        {
                            Session["UserID"] = dtLogin.Rows[0]["clientuserid"].ToString();
                            Response.Redirect("ChangePassword.aspx");
                        }
                        else
                        {
                            Session["UserID"] = dtLogin.Rows[0]["clientuserid"].ToString();
                            Session["UserName"] = dtLogin.Rows[0]["clientusername"].ToString();
                            Session["UserFirstName"] = dtLogin.Rows[0]["clientuserfirstname"].ToString();
                            Session["UserLastName"] = dtLogin.Rows[0]["clientuserlastname"].ToString();
                            Session["UserRole"] = dtLogin.Rows[0]["clientuserrole"].ToString();
                            
                            Response.Redirect("/Dashboard.aspx");
                        }
                    }
                    else
                    {
                        lblErrorMesage.Text = "Client Not Active, Contact Administrator";
                        lblErrorMesage.ForeColor = System.Drawing.Color.Red;
                    }

                }
                else
                {
                    lblErrorMesage.Text = "Invalid Password!";
                    lblErrorMesage.ForeColor = System.Drawing.Color.Red;
                }
            }
            else
            {
                lblErrorMesage.Text = "UserID not found!!!";
                lblErrorMesage.ForeColor = System.Drawing.Color.Red;
            }

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
}