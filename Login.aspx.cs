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
                if (BCrypt.CheckPassword(enteredpwd,dtLogin.Rows[0]["clientpassword"].ToString().Trim()).Equals(true))
                {
                    // Check Client whose user logged in is Active or Not. 
                    //DataTable dtLogin1 = new DataTable();
                    //dtLogin1 = VPCRMSBAL.CheckClientActiveOrNot(Convert.ToDecimal(dtLogin.Rows[0]["clientuserid"].ToString().Trim().Substring(0,4)));
                    //DateTime dateTimeToday = DateTime.Today;
                    //DateTime clientDateTime = Convert.ToDateTime(dtLogin1.Rows[0]["enddate"]);
                    //if (clientDateTime <= dateTimeToday)
                    //{
                        Session["UserID"] = dtLogin.Rows[0]["clientuserid"].ToString();
                        Session["UserName"] = dtLogin.Rows[0]["clientusername"].ToString();
                        Session["UserFirstName"] = dtLogin.Rows[0]["clientuserfirstname"].ToString();
                        Session["UserLastName"] = dtLogin.Rows[0]["clientuserlastname"].ToString();
                        Session["UserRole"] = dtLogin.Rows[0]["clientuserrole"].ToString();
                        Response.Redirect("/Dashboard.aspx");
                    //}
                    //else
                    //{
                    //    lblErrorMesage.Text = "Client Not Active, Contact Administrator";
                    //    lblErrorMesage.ForeColor = System.Drawing.Color.Red;
                    //}

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